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

type TransformCasingFn = ((x: string) -> string) & (<K, V>(x: { [K]: V }) -> { [K]: V })

local MAPPINGS = serde.decode("json", fs.readFile("json/mappings.json")) :: Mappings
local OUT_DIR = "dist"
local FORMAT = true

local snake_to_camel: TransformCasingFn
local camel_to_snake: TransformCasingFn
local pascal_to_kebab: TransformCasingFn

do
	local function transform(x: any, processor: (string) -> string): any
		if typeof(x) == "string" then
			return processor(x)
		elseif typeof(x) == "table" then
			local clone = {}

			for key, value in x do
				if typeof(value) == "table" then
					value = transform(value, processor)
				end
				clone[transform(key, processor)] = value
			end

			return clone
		else
			return x
		end
	end

	function snake_to_camel(x: any): any
		return transform(x, function(str)
			return str:gsub("_(%l)", function(char)
				return char:upper()
			end)
		end)
	end

	function camel_to_snake(x: any): any
		return transform(x, function(str)
			return str:gsub("(%u+)(%u%l)", "%1_%2"):gsub("([a-z%d])(%u)", "%1_%2"):lower()
		end)
	end

	function pascal_to_kebab(x: any): any
		return transform(x, function(str)
			return str:gsub("(%u+)(%u%l)", "%1-%2")
				:gsub("(%l)(%u)", "%1-%2")
				:gsub("%-", "%%")
				:gsub("([A-Z]+)", function(word)
					return word:lower()
				end)
				:gsub("%%", "-")
		end)
	end
end

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
			object ..= `{camel_to_snake(name)}: {translate(type)},`
		end

		return object .. "}"
	end

	if raw.type == "file" then
		return "buffer"
	end

	return tostring(raw.type)
end

local function traverse_ref(raw: { [string]: any }, documentation: OpenApiDefinition)
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

local function request_documentation(namespace: string, version: number): OpenApiDefinition?
	local response =
		net.request(`https://prod.docsiteassets.roblox.com/assets/en-us/cloud/legacy/{namespace}/v{version}.json`)
	if response.statusCode == 403 then
		return nil
	end
	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body) :: OpenApiDefinition
end

local function stylua(file: string): string
	local formatted = process.spawn("stylua", { "-" }, { stdin = file, shell = true })
	assert(formatted.ok, formatted.stderr)
	return formatted.stdout
end

local function comment(text: string): string
	return text:gsub("([^\n]+)", "--- %1"):gsub("</?p>", "")
end

local function single_key<K, V>(t: { [K]: V }): (K?, V?)
	local first, value = next(t)
	if first == nil then
		return nil
	end

	if next(t, first) == nil then
		return first, value
	end

	return nil
end

local function write_namespace(
	namespace: string,
	endpoints: { [string]: { get: string?, post: string?, patch: string?, delete: string? } }
): string
	local documentations = {}

	for version = 1, 3 do
		local documentation = request_documentation(namespace, version)

		if documentation == nil then
			continue
		end

		table.insert(documentations, documentation)
	end

	local file = ""

	file ..= 'local serde = require("@lune/serde")\n'
	file ..= 'local request_with_csrf_token = require("./utils/request-with-csrf-token")\n'
	file ..= 'local casing = require("./utils/casing")'
	file ..= 'local Result = require("../lune_packages/result")\n\n'

	file ..= "type Response<T> = Result.Result<T, request_with_csrf_token.Error>\n\n"

	for _, documentation in documentations do
		if documentation.definitions == nil then
			continue
		end

		for raw_name, model in documentation.definitions do
			local name = reference(raw_name)
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
					local remove_parameters: { [number]: true } = {}

					for index, parameter in route.parameters do
						if parameter["in"] == "body" then
							body = parameter
							remove_parameters[index] = true
						elseif parameter["in"] == "header" then
							remove_parameters[index] = true
						end
					end

					for index in remove_parameters do
						route.parameters[index] = nil
					end
				end

				local ok_response = route.responses["200"]
				local cookie_required = route.responses["401"] ~= nil or route.responses["403"] ~= nil

				local takes = "nil"
				local returns = "%s"
				local request = nil
				local request_name = "request"
				local response = translate(ok_response.schema)
				local construct = false

				local function default_request()
					local has_body = body ~= nil
					local has_parameters = next(route.parameters) ~= nil

					if has_body then
						request = request or ""
						request ..= `{translate(body.schema)}`

						if has_parameters then
							request ..= "&"
						end
					end

					if has_parameters then
						request = request or ""
						request ..= "{"

						for _, parameter in route.parameters do
							local optional = if not parameter.required then "?" else ""
							request ..= `{camel_to_snake(parameter.name)}: {translate(parameter)}{optional},`
						end

						request ..= "}"
					end

					request_name = "request"
					takes = "request.%s"
				end

				if next(route.parameters) == nil and body ~= nil then
					local model = traverse_ref(body.schema, documentation)

					if model.type == "object" then
						local key, property = single_key(model.properties or {})
						if key ~= nil then
							request = translate(property)
							request_name = camel_to_snake(key)
							takes = "%s"
							construct = true
						else
							request = translate(model)
							request_name = "request"
							takes = `{request_name}.%s`
						end
					else
						request = translate(model)
						request_name = body.name
						takes = "%s"
					end
				elseif next(route.parameters) ~= nil and body == nil then
					local key, parameter = single_key(route.parameters)
					if key ~= nil then
						request = translate(parameter)
						request_name = camel_to_snake(parameter.name)
						takes = "%s"
					else
						default_request()
					end
				else
					default_request()
				end

				if route.produces[1] == "application/json" then
					returns = 'serde.decode("json", %s)'
				end

				if ok_response.schema ~= nil then
					local okModel = traverse_ref(ok_response.schema, documentation)
					if okModel.type == "object" and okModel.properties ~= nil then
						local key, property = single_key(okModel.properties)
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

				local cookie = if cookie_required then "string" else "string?"
				if request ~= nil then
					file ..= `local function {alias}({request_name}: {request}, cookie: {cookie}): Response<{response}>\n`
				else
					file ..= `local function {alias}(cookie: {cookie}): Response<{response}>\n`
				end

				file ..= `return request_with_csrf_token(\{\n`

				file ..= `method = "{method:upper()}",\n`

				local takes_endpoint = endpoint:gsub("{(.-)}", function(parameter)
					return `\{{takes:format(camel_to_snake(parameter))}\}`
				end)
				local path_separator = "?"

				for _, parameter in route.parameters do
					if parameter["in"] ~= "query" and parameter["in"] ~= "formData" then
						continue
					end

					local name = camel_to_snake(parameter.name)
					local value = if parameter.type == "array"
						then `table.concat({takes:format(name)} {if parameter.required then "" else "or {}"}, "&{name}=")`
						else `{takes:format(name)} {if parameter.required then "" else 'or ""'}`

					takes_endpoint ..= `{path_separator}{name}=\{{value}\}`
					path_separator = "&"
				end

				file ..= `url = \`https://{documentation.host}{takes_endpoint}\`,\n`

				file ..= "headers = {"

				if route.produces[1] == "application/json" then
					file ..= '["Content-Type"] = "application/json",'
				end

				file ..= `Cookie = \`.ROBLOSECURITY=\{cookie {if cookie_required then "" else 'or ""'}\}\`,`

				file ..= "},\n"

				if route.consumes[1] == "application/json" then
					if construct then
						file ..= `body = serde.encode("json", casing.snake_to_camel(\{ {request_name} = {request_name} \})),\n`
					else
						file ..= `body = serde.encode("json", casing.snake_to_camel({request_name})),\n`
					end
				end

				file ..= "})"

				file ..= ":map(function(response)\n"
				if route.produces[1] == "application/json" then
					file ..= `return casing.camel_to_snake({returns:format("response.body")})\n`
				else
					file ..= `return {returns:format("response.body")}\n`
				end
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

local function write_root(mappings: Mappings): string
	local file = ""

	for namespace in mappings do
		file ..= `local {namespace} = require("./{namespace:gsub("_", "-")}")\n`
	end

	file ..= "\nreturn {"

	for namespace, _ in mappings do
		file ..= `{namespace} = {namespace},`
	end

	file ..= "}\n"

	return if FORMAT then stylua(file) else file
end

local function build_package(mappings: Mappings, out_dir: string)
	if fs.isDir(out_dir) then
		fs.removeDir(out_dir)
	end
	fs.writeDir(out_dir)

	fs.copy("src/utils", `{out_dir}/utils`)

	for namespace, endpoints in mappings do
		local file = write_namespace(namespace:gsub("_", ""), endpoints)
		fs.writeFile(`{out_dir}/{namespace:gsub("_", "-")}.luau`, file)
	end

	local root_file = write_root(mappings)
	fs.writeFile(`{out_dir}/init.luau`, root_file)
end

build_package(MAPPINGS, OUT_DIR)
