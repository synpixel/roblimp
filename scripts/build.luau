local serde = require("@lune/serde")
local net = require("@lune/net")
local process = require("@lune/process")
local fs = require("@lune/fs")
local stdio = require("@lune/stdio")

type Mappings = {
	[string]: { [string]: { get: string?, post: string?, patch: string?, delete: string? } },
}

type OpenApiDefinition = {
	host: string,
	definitions: { [string]: { [string]: any } },
	paths: { [string]: { [string]: { [string]: any } } },
}

local DEPLOYMENT = "203AYidpISfppRfYMTY9D"
local MAPPINGS = serde.decode("json", fs.readFile("json/mappings.json")) :: Mappings
local OUT_DIR = "build"
local FORMAT = true

local function reference(ref: string): string
	local isPages = ref:match("%[(.+)%]") ~= nil
	local name = assert(ref:gsub("[%[%]]", ""):match("([^.]+)$"))

	if isPages then
		name ..= "Pages"
	end

	return name
end

local function translate(raw: { [string]: any }?): string
	if raw == nil then
		return "nil"
	end

	if raw["$ref"] ~= nil then
		return reference(raw["$ref"])
	end

	if raw.enum ~= nil then
		local enum = {}

		for _, item in raw.enum do
			-- Patch undocumented enums
			if raw.description ~= nil then
				item = raw.description:match(`'([^']-)' = {item}`) or item
			end

			if typeof(item) == "string" then
				item = `"{item}"`
			end

			if typeof(item) == "number" then
				item = "number"
			end

			if table.find(enum, item) ~= nil then
				continue
			end

			table.insert(enum, item)
		end

		return `{table.concat(enum, " | ")}`
	end

	if raw.type == "integer" then
		return "number"
	end

	if raw.type == "array" then
		if raw.items == nil then
			return "{}"
		end

		return `\{ {translate(raw.items)} \}`
	end

	if raw.type == "object" then
		if raw.properties == nil then
			return "{}"
		end

		local object = "{"

		for name, type in raw.properties do
			object ..= `{name}: {translate(type)},`
		end

		return object .. "}"
	end

	if raw.type == "file" then
		return "buffer"
	end

	return tostring(raw.type)
end

local function traverseRef(raw: { [string]: any }, documentation: OpenApiDefinition)
	if raw["$ref"] == nil then
		return raw
	end

	local segments = raw["$ref"]:split("/")
	local current = documentation

	for i = 2, #segments do
		local segment = segments[i]
		current = current[segment]
	end

	return current
end

local function requestDocumentation(namespace: string, version: number): OpenApiDefinition?
	local response =
		net.request(`https://create.roblox.com/docs/_next/data/{DEPLOYMENT}/cloud/legacy/{namespace}/v{version}.json`)
	if response.statusCode == 404 then
		return nil
	end

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	local body = serde.decode("json", response.body) :: { pageProps: { data: { content: OpenApiDefinition } } }
	local documentation = body.pageProps.data.content

	return documentation
end

local function stylua(file: string): string
	local formatted = process.spawn("stylua", { "-" }, { stdin = file, shell = true })
	assert(formatted.ok, formatted.stderr)
	return formatted.stdout
end

local function comment(text: string): string
	return text:gsub("([^\n]+)", "--- %1"):gsub("</?p>", "")
end

local function singleKey<K, V>(t: { [K]: V }): (K?, V?)
	local first, value = next(t)
	if first == nil then
		return nil
	end

	if next(t, first) == nil then
		return first, value
	end

	return nil
end

local function writeNamespace(
	namespace: string,
	endpoints: { [string]: { get: string?, post: string?, patch: string?, delete: string? } }
): string
	local documentations = {}

	for version = 1, 3 do
		local documentation = requestDocumentation(namespace, version)

		if documentation == nil then
			continue
		end

		table.insert(documentations, documentation)
	end

	local file = ""

	file ..= 'local serde = require("@lune/serde")\n'
	file ..= 'local requestWithCsrfToken = require("./utils/request-with-csrf-token")\n'
	file ..= 'local Result = require("../lune_packages/result")\n\n'

	file ..= "type Response<T> = Result.Result<T, requestWithCsrfToken.Error>\n\n"

	for _, documentation in documentations do
		if documentation.definitions == nil then
			continue
		end

		for rawName, model in documentation.definitions do
			local name = reference(rawName)
			if file:match(`export type {name} =`) ~= nil then
				continue
			end

			if model.description ~= nil then
				file ..= comment(model.description) .. "\n"
			end

			file ..= `export type {name} = {translate(model)}\n\n`
		end
	end

	for _, documentation in documentations do
		if documentation.paths == nil then
			continue
		end

		for endpoint, methods in endpoints do
			for method, alias in methods :: { [string]: string } do
				if documentation.paths[endpoint] == nil then
					-- The endpoint's not a part of this documentation version
					continue
				end

				assert(
					documentation.paths[endpoint][method] ~= nil,
					`invalid method for {documentation.host}{endpoint}: {method}`
				)

				local route = documentation.paths[endpoint][method]
				if route.deprecated then
					print(
						`{stdio.color("yellow")}{stdio.style("bold")} {string.upper(method)} {documentation.host}{endpoint} is deprecated{stdio.color(
							"reset"
						)}`
					)
				end

				if route.consumes == nil then
					route.consumes = {}
				end

				if route.produces == nil then
					route.produces = {}
				end

				if route.parameters == nil then
					route.parameters = {}
				end

				local body = nil

				do
					local removeParameters: { [number]: true } = {}

					for index, parameter in route.parameters do
						parameter.name = parameter.name:sub(1, 1):lower() .. parameter.name:sub(2)

						if parameter["in"] == "body" then
							body = parameter
							removeParameters[index] = true
						elseif parameter["in"] == "header" then
							removeParameters[index] = true
						end
					end

					for index in removeParameters do
						route.parameters[index] = nil
					end

					-- It just looks nicer
					if body ~= nil and body.name == "requestModel" then
						body.name = "request"
					end
				end

				local okResponse = route.responses["200"]
				local cookieRequired = route.responses["401"] ~= nil or route.responses["403"] ~= nil

				local takes = "nil"
				local returns = "%s"
				local request = nil
				local requestName = "request"
				local response = translate(okResponse.schema)
				local construct = false

				local function defaultRequest()
					local hasBody = body ~= nil
					local hasParameters = next(route.parameters) ~= nil

					if hasBody then
						request = request or ""
						request ..= `{translate(body.schema)}`

						if hasParameters then
							request ..= "&"
						end
					end

					if hasParameters then
						request = request or ""
						request ..= "{"

						for _, parameter in route.parameters do
							local optional = if not parameter.required then "?" else ""
							request ..= `{parameter.name}: {translate(parameter)}{optional},`
						end

						request ..= "}"
					end

					requestName = "request"
					takes = "request.%s"
				end

				if next(route.parameters) == nil and body ~= nil then
					local model = traverseRef(body.schema, documentation)

					if model.type == "object" then
						local key, property = singleKey(model.properties or {})
						if key ~= nil then
							request = translate(property)
							requestName = key
							takes = "%s"
							construct = true
						else
							request = translate(model)
							requestName = body.name
							takes = `{requestName}.%s`
						end
					else
						request = translate(model)
						requestName = body.name
						takes = "%s"
					end
				elseif next(route.parameters) ~= nil and body == nil then
					local key, parameter = singleKey(route.parameters)
					if key ~= nil then
						request = translate(parameter)
						requestName = parameter.name
						takes = "%s"
					else
						defaultRequest()
					end
				else
					defaultRequest()
				end

				if route.produces[1] == "application/json" then
					returns = 'serde.decode("json", %s)'
				end

				if okResponse.schema ~= nil then
					local okModel = traverseRef(okResponse.schema, documentation)
					if okModel.type == "object" and okModel.properties ~= nil then
						local key, property = singleKey(okModel.properties)
						if key ~= nil then
							returns ..= `.{key}`
							response = translate(property)
						end
					end
				else
					returns = "nil"
				end

				if route.summary ~= nil then
					file ..= comment(route.summary) .. "\n"
				end

				local cookie = if cookieRequired then "string" else "string?"
				if request ~= nil then
					file ..= `local function {alias}({requestName}: {request}, cookie: {cookie}): Response<{response}>\n`
				else
					file ..= `local function {alias}(cookie: {cookie}): Response<{response}>\n`
				end

				file ..= `return requestWithCsrfToken(\{\n`

				file ..= `method = "{method:upper()}",\n`

				local takesEndpoint = endpoint:gsub("{(.-)}", `\{{takes:format("%1")}\}`)
				local pathSeparator = "?"

				for _, parameter in route.parameters do
					if parameter["in"] ~= "query" and parameter["in"] ~= "formData" then
						continue
					end

					local name = parameter.name
					local value = if parameter.type == "array"
						then `table.concat({takes:format(name)} {if parameter.required then "" else "or {}"}, "&{name}=")`
						else `{takes:format(name)} {if parameter.required then "" else 'or ""'}`

					takesEndpoint ..= `{pathSeparator}{name}=\{{value}\}`
					pathSeparator = "&"
				end

				file ..= `url = \`https://{documentation.host}{takesEndpoint}\`,\n`

				file ..= "headers = {"

				if route.produces[1] == "application/json" then
					file ..= '["Content-Type"] = "application/json",'
				end

				file ..= `Cookie = \`.ROBLOSECURITY=\{cookie {if cookieRequired then "" else 'or ""'}\}\`,`

				file ..= "},\n"

				if route.consumes[1] == "application/json" then
					if construct then
						file ..= `body = serde.encode("json", \{ {requestName} = {requestName} \}),\n`
					else
						file ..= `body = serde.encode("json", {requestName}),\n`
					end
				end

				file ..= "})"

				file ..= ":map(function(response)\n"
				file ..= `return {returns:format("response.body")}\n`
				file ..= "end)\n"

				file ..= "end\n\n"
			end
		end
	end

	file ..= "return {\n"

	for _, methods in endpoints do
		for _, alias in methods do
			file ..= `{alias} = {alias},\n`
		end
	end

	file ..= "}\n"

	return if FORMAT then stylua(file) else file
end

local function writeRoot(mappings: Mappings): string
	local file = ""

	for namespace in mappings do
		file ..= `local {namespace} = require("./{namespace}")\n`
	end

	file ..= "\nreturn {"

	for namespace, _ in mappings do
		file ..= `{namespace} = {namespace},`
	end

	file ..= "}\n"

	return if FORMAT then stylua(file) else file
end

local function buildPackage(mappings: Mappings, outDir: string)
	if fs.isDir(outDir) then
		fs.removeDir(outDir)
	end

	fs.writeDir(outDir)

	fs.copy("src/utils", `{outDir}/utils`)

	for namespace, endpoints in mappings do
		local file = writeNamespace(namespace, endpoints)
		fs.writeFile(`{outDir}/{namespace}.luau`, file)
	end

	local rootFile = writeRoot(mappings)
	fs.writeFile(`{outDir}/init.luau`, rootFile)
end

buildPackage(MAPPINGS, OUT_DIR)
