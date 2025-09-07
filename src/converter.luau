local net = require("@lune/net")
local serde = require("@lune/serde")
local fs = require("@lune/fs")
local process = require("@lune/process")

local openapi = require("./openapi")
local mappings = require("./mappings")
local array = require("./util/array")
local dictionary = require("./util/dictionary")
local casing = require("./util/casing")

local NO_FORMAT_FLAG = "--no-format"

local definition = serde.decode("json", fs.readFile("json/openapi.json")) :: openapi.Definition

local function format_with_stylua(input: string): string
	local child = process.create("stylua", { "-" }, { shell = true })
	child.stdin:write(input)
	child.stdin:close()

	local output = child.stdout:readToEnd()

	local status = child:status()
	if not status.ok then
		error("Failed to format input with StyLua")
	end

	return output
end

local function label_schema(model: string): string
	local name = string.match(model, "([^/%.]+)$") :: string
	if string.find(model, "Page") then
		name = string.sub(name, 1, -2) .. "Page"
	end
	return name
end

local function build_namespace(namespace: "legacy" | "cloud"): string
	local client_ty = if namespace == "legacy" then "LegacyClient" else "CloudClient"

	local dependencies = {}
	local exports = {}

	local export_ty_members = {}
	if namespace == "legacy" then
		table.insert(export_ty_members, "_cookie: string")
		table.insert(export_ty_members, "_csrf_token_cache: string?")
		table.insert(
			export_ty_members,
			`fetch_with_csrf_token: (client: {client_ty}, config: net.FetchParams) -> Response<net.FetchResponse>`
		)
	else
		table.insert(export_ty_members, "_api_key: string")
	end

	local function depend_on_schema(schema: openapi.Schema)
		local ref = schema["$ref"]
		if ref then
			dependencies[ref] = true
		end
	end

	local function convert_schema_ty(schema: openapi.Schema, ignore_refs: boolean?): string
		if schema["$ref"] and not ignore_refs then
			depend_on_schema(schema)
			return label_schema(schema["$ref"])
		end

		schema = openapi.solve_schema(definition, schema)

		if schema.enum then
			local enum = {}

			for _, item in schema.enum do
				if schema.description then
					item = string.match(schema.description, `'([^']-)' = {item}`) or item
				end

				if typeof(item) == "string" then
					item = `"{item}"`
				elseif typeof(item) == "number" then
					item = "number"
				end

				if table.find(enum, item) ~= nil then
					continue
				end

				table.insert(enum, item)
			end

			return table.concat(enum, " | ")
		end

		if schema.type == "integer" or schema.type == "number" then
			return "number"
		elseif schema.type == "boolean" then
			return "boolean"
		elseif schema.type == "string" then
			return "string"
		elseif schema.type == "array" then
			if not schema.items then
				return "{}"
			end

			return "{" .. convert_schema_ty(schema.items, ignore_refs) .. "}"
		elseif schema.type == "object" then
			if not schema.properties then
				return "{}"
			end

			local properties = {}

			for key, sub_schema in schema.properties do
				if string.find(key, "@") then
					key = `["{key}"]`
				end

				local ty = convert_schema_ty(sub_schema, ignore_refs)
				table.insert(properties, `{casing.camel_to_snake(key)}: {ty}`)
			end

			return "{" .. table.concat(properties, ",") .. "}"
		end

		print(schema)
		warn(`Unknown schema type: {schema.type}`)
		return "unknown"
	end

	local function normalize_request_parameters(method_info: openapi.PathMethodInfo): {
		use: string,
		ty: string,
		is_array: boolean,
		access: {
			{
				source: "path" | "query" | "body",
				name: string,
				use: string,
				schema: openapi.Schema,
				required: boolean,
			}
		},
	}
		local parameter_access = {}

		local parameters = method_info.parameters
		if parameters then
			for _, parameter in parameters do
				local source = parameter["in"]
				if source == "header" then
					-- TODO: Headers
					continue
				end

				-- We need to account for query parameters
				-- like idempotencyKey.key or idempotencyKey.firstSent
				local fixed_name = string.gsub(parameter.name, "%.(.)", string.upper)

				table.insert(parameter_access, {
					source = source,
					name = parameter.name,
					use = `request.{casing.camel_to_snake(fixed_name)}`,
					schema = parameter.schema,
					required = parameter.required,
				})
			end
		end

		local request_body = method_info.requestBody
		if request_body then
			local consumes, request_body_ty = next(request_body.content)
			local request_body_schema = openapi.solve_schema(definition, request_body_ty.schema)
			if request_body_schema.type == "object" and request_body_schema.properties then
				for name, property in request_body_schema.properties do
					local source = if consumes == "application/json" then "body" else "query"

					table.insert(parameter_access, {
						source = source,
						name = name,
						use = `request.{casing.camel_to_snake(name)}`,
						schema = property,
						required = request_body.required,
					})
				end
			elseif request_body_schema.type == "array" and request_body_schema.items then
				table.insert(parameter_access, {
					source = "body",
					name = "requests",
					use = "requests",
					schema = request_body_ty.schema,
					required = request_body.required,
				})
			end
		end

		if #parameter_access == 1 then
			local only_parameter = parameter_access[1]
			local snake_case_name = casing.camel_to_snake(only_parameter.name)
			local ty = convert_schema_ty(only_parameter.schema)
			local only_parameter_schema = openapi.solve_schema(definition, only_parameter.schema)

			return {
				use = snake_case_name,
				ty = if only_parameter.required then ty else `{ty}?`,
				is_array = only_parameter_schema.type == "array",
				access = {
					{
						source = only_parameter.source,
						name = only_parameter.name,
						use = snake_case_name,
						schema = only_parameter.schema,
						required = only_parameter.required,
					},
				},
			}
		end

		local request_types = {}
		local is_array = false

		if parameters then
			local members = {}
			for _, parameter in parameters do
				local fixed_name = string.gsub(parameter.name, "%.(.)", string.upper)

				local ty = convert_schema_ty(parameter.schema)
				table.insert(
					members,
					`{casing.camel_to_snake(fixed_name)}: {if parameter.required then ty else `{ty}?`}`
				)
			end

			local ty = "{" .. table.concat(members, ", ") .. "}"
			table.insert(request_types, ty)
		end

		if request_body then
			local _, request_body_ty = next(request_body.content)
			if request_body.required then
				local ty = convert_schema_ty(request_body_ty.schema)
				table.insert(request_types, ty)
			else
				local schema = openapi.solve_schema(definition, request_body_ty.schema)
				local properties = {}

				if schema.type == "object" and schema.properties then
					for name, property in schema.properties do
						local ty = convert_schema_ty(property)
						table.insert(properties, `{casing.camel_to_snake(name)}: {ty}?`)
					end

					table.insert(request_types, "{" .. table.concat(properties, ", ") .. "}")
				end

				is_array = schema.type == "array"
			end
		end

		return {
			use = "request",
			ty = table.concat(request_types, " & "),
			is_array = is_array,
			access = parameter_access,
		}
	end

	local function normalize_response(response: openapi.PathMethodResponse): {
		use: string,
		ty: string,
	}
		if not response.content then
			return { use = "", ty = "unknown" }
		end

		local _, response_body_ty = next(response.content)
		if not response_body_ty then
			return {
				use = "",
				ty = "nil",
			}
		end

		local response_body_schema = openapi.solve_schema(definition, response_body_ty.schema)
		if response_body_schema.type == "object" and response_body_schema.properties then
			local first_key = next(response_body_schema.properties)
			local second_key = next(response_body_schema.properties, first_key)

			if first_key and not second_key then
				local name, only_property = next(response_body_schema.properties)
				return {
					use = `.{casing.camel_to_snake(name)}`,
					ty = convert_schema_ty(only_property),
				}
			end
		end

		return {
			use = "",
			ty = convert_schema_ty(response_body_ty.schema),
		}
	end

	local output = ""

	for _, mapping in mappings do
		local endpoint = openapi.get_endpoint(definition, mapping.path)
		if not endpoint then
			error(`Failed to resolve endpoint from "{mapping.path}"`)
		end

		for method, alias in mapping.methods do
			local method_info = endpoint[method :: any]
			if not method_info then
				error(`{string.upper(method)} is not a supported method for endpoint {mapping.path}`)
			end

			local is_cloud_method = false
			local method_security_layers = method_info.security
			if method_security_layers then
				for _, layer in method_security_layers do
					if layer["roblox-api-key"] then
						is_cloud_method = true
						break
					end
				end
			end

			if is_cloud_method and namespace == "legacy" then
				continue
			elseif not is_cloud_method and namespace == "cloud" then
				continue
			end

			exports[alias] = true

			local normalized_request = normalize_request_parameters(method_info)
			local n_url_parameters = 0
			local n_body_parameters = 0

			for _, parameter in normalized_request.access do
				if parameter.source == "path" or parameter.source == "query" then
					n_url_parameters += 1
				elseif parameter.source == "body" then
					n_body_parameters += 1
				end
			end

			local ok_response = method_info.responses["200"]
			if not ok_response.content then
				error(`{mapping.path} is not implemented by Roblox`)
			end

			local normalized_response = normalize_response(ok_response)
			local summary_doc_comment = if method_info.summary
				then `--- {string.gsub(method_info.summary, "\n", "\n---")}\n`
				else ""

			if #normalized_request.access == 0 then
				output ..= `local function {alias}(client: {client_ty}): Response<{normalized_response.ty}>\n`
				table.insert(
					export_ty_members,
					`{summary_doc_comment}{alias}: (client: {client_ty}) -> Response<{normalized_response.ty}>`
				)
			else
				output ..= `local function {alias}(client: {client_ty}, {normalized_request.use}: {normalized_request.ty}): Response<{normalized_response.ty}>\n`
				table.insert(
					export_ty_members,
					`{summary_doc_comment}{alias}: (client: {client_ty}, {normalized_request.use}: {normalized_request.ty}) -> Response<{normalized_response.ty}>`
				)
			end

			local server = if method_info.servers then method_info.servers[1] else definition.servers[1]

			local net_request_parameters = {}

			table.insert(net_request_parameters, `method = "{string.upper(method)}"`)

			if n_url_parameters ~= 0 then
				local path_with_patch = string.gsub(mapping.path, "{(.-)}", function(parameter_name)
					local use: string?
					for _, parameter in normalized_request.access do
						if parameter.source == "path" and parameter.name == parameter_name then
							use = parameter.use
							break
						end
					end

					if not use then
						error(`Failed to find value for parameter "{parameter_name}"`)
					end

					return "{" .. use .. "}"
				end)

				local query_parameters = {}
				for _, parameter in normalized_request.access do
					if parameter.source ~= "query" then
						continue
					end

					local parameter_use_with_patch = if parameter.schema.type == "array"
						then `table.concat({parameter.use}, ",")`
						else parameter.use

					if parameter.required then
						table.insert(query_parameters, `{parameter.name}=\{{parameter_use_with_patch}\}`)
					else
						table.insert(
							query_parameters,
							`{parameter.name}=\{if {parameter.use} then {parameter_use_with_patch} else ""\}`
						)
					end
				end

				if #query_parameters == 0 then
					table.insert(net_request_parameters, `url = \`{server.url}{path_with_patch}\``)
				else
					table.insert(
						net_request_parameters,
						`url = \`{server.url}{path_with_patch}?{table.concat(query_parameters, "&")}\``
					)
				end
			else
				table.insert(net_request_parameters, `url = "{server.url}{mapping.path}"`)
			end

			local headers = {}
			if namespace == "legacy" then
				table.insert(headers, "Cookie = client._cookie")
			else
				table.insert(headers, '["X-Api-Key"] = client._api_key')
			end

			if n_body_parameters ~= 0 then
				local request_body = method_info.requestBody
				local consumes = next(request_body.content)
				table.insert(headers, `["Content-Type"] = "{consumes}"`)
			end

			table.insert(net_request_parameters, `headers = \{ {table.concat(headers, ", ")} \}`)

			if n_url_parameters == 0 and n_body_parameters ~= 0 then
				if normalized_request.is_array or n_body_parameters > 1 then
					table.insert(
						net_request_parameters,
						`body = serde.encode("json", casing.snake_to_camel({normalized_request.use}))`
					)
				else
					local parameter = normalized_request.access[1]
					table.insert(
						net_request_parameters,
						`body = serde.encode("json", \{ {parameter.name} = {parameter.use} \})`
					)
				end
			elseif n_body_parameters ~= 0 then
				local body_parameters = {}
				for _, parameter in normalized_request.access do
					if parameter.source == "body" then
						table.insert(body_parameters, `{parameter.name} = {parameter.use}`)
					end
				end

				table.insert(
					net_request_parameters,
					`body = serde.encode("json", \{ {table.concat(body_parameters, ", ")} \})`
				)
			end

			local net_request_method = if namespace == "legacy" then "client:fetch_with_csrf_token" else "fetch"
			output ..= `local result = {net_request_method} \{ {table.concat(net_request_parameters, ", ")} \}\n`

			output ..= "return result:map(function(response)\n"

			local produces = next(ok_response.content)
			if not produces then
				output ..= "return nil\n"
			elseif produces == "application/json" then
				output ..= 'local body = serde.decode("json", response.body)\n'
				output ..= `return casing.camel_to_snake(body){normalized_response.use}\n`
			else
				output ..= "return response.body\n"
			end

			output ..= "end)\n"

			output ..= "end\n\n"
		end
	end

	if namespace == "legacy" then
		output ..= `local function fetch_with_csrf_token(client: {client_ty}, config: net.FetchParams): Response<net.FetchResponse>\n`
		output ..= [[
		local headers = if config.headers then table.clone(config.headers) else {} :: net.HttpHeaderMap
		headers["x-csrf-token"] = client._csrf_token_cache :: string

		config = table.clone(config)
		config.headers = headers

		local response, err = fetch(config):unpack()
		if err then
			if err.headers["x-csrf-token"] then
				client._csrf_token_cache = err.headers["x-csrf-token"] :: string
				return client:fetch_with_csrf_token(config)
			end

			return Result.Err(err)
		end

		return Result.Ok(response)
		]]
		output ..= "end\n\n"
	end

	if namespace == "legacy" then
		output ..= `local function create(roblosecurity: string?): {client_ty}\n`
	else
		output ..= `local function create(api_key: string): {client_ty}\n`
	end

	local export_members = {}
	if namespace == "legacy" then
		table.insert(export_members, '_cookie = if roblosecurity then `.ROBLOSECURITY={roblosecurity}` else ""')
		table.insert(export_members, "fetch_with_csrf_token = fetch_with_csrf_token")
	else
		table.insert(export_members, "_api_key = api_key")
	end

	for export in exports do
		table.insert(export_members, `{export} = {export}`)
	end
	output ..= `return \{ {table.concat(export_members, ", ")} \}\n`

	output ..= "end\n\n"

	output ..= "return { create = create }\n"

	output = "\n" .. output

	for dependency in dependencies do
		local schema = openapi.get_schema(definition, dependency)
		if not schema then
			continue
		end

		local name = label_schema(dependency)
		output = `export type {name} = {convert_schema_ty(schema, true)}\n` .. output
	end

	output = `export type {client_ty} = \{\n {table.concat(export_ty_members, ",\n")} \n\}\n` .. output

	output = "type Response<T> = fetch.Response<T>\n\n" .. output

	output = "\n" .. output
	if namespace == "legacy" then
		output = 'local Result = require("../lune_packages/result")\n' .. output
	end
	output = 'local fetch = require("./include/fetch")\n' .. output
	output = '\nlocal casing = require("./include/casing")\n' .. output
	output = 'local serde = require("@lune/serde")\n' .. output
	if namespace == "legacy" then
		output = 'local net = require("@lune/net")\n' .. output
	end

	return output
end

local function build(output_dir: string)
	local legacy_output = build_namespace("legacy")
	local cloud_output = build_namespace("cloud")
	local root_output = [[
	local legacy = require("@self/legacy")
	local cloud = require("@self/cloud")

	export type LegacyClient = legacy.LegacyClient
	export type CloudClient = cloud.CloudClient

	return {
		legacy = legacy.create,
		cloud = cloud.create,
	}
	]]

	if not table.find(process.args, NO_FORMAT_FLAG) then
		legacy_output = format_with_stylua(legacy_output)
		cloud_output = format_with_stylua(cloud_output)
		root_output = format_with_stylua(root_output)
	end

	if fs.isDir(output_dir) then
		fs.removeDir(output_dir)
	end

	fs.writeDir(output_dir)
	fs.writeFile(`{output_dir}/legacy.luau`, legacy_output)
	fs.writeFile(`{output_dir}/cloud.luau`, cloud_output)
	fs.writeFile(`{output_dir}/init.luau`, root_output)

	fs.copy("src/include", `{output_dir}/include`)
end

return {
	build = build,
}
