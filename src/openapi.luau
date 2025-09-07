export type Definition = {
	servers: { { url: string } },
	paths: { [string]: PathInfo },
	components: { schemas: { [string]: Schema } },
}

export type PathMethod = "delete"

export type PathMethodParameter = {
	["in"]: string,
	name: string,
	description: string,
	required: boolean,
	schema: Schema,
}

export type PathMethodResponse = {
	description: string,
	content: { [string]: { schema: Schema } }?,
}

export type PathMethodInfo = {
	tags: { string },
	summary: string,
	parameters: { PathMethodParameter },
	requestBody: { content: { [string]: { schema: Schema } } }?,
	responses: { [string]: PathMethodResponse },
	servers: { { url: string } }?,
	security: { { [string]: unknown } }?,
}

export type PathInfo = {
	[PathMethod]: PathMethodInfo,
}

export type Schema = { description: string?, enum: { any }?, ["$ref"]: string? } & ({
	type: "integer" | "number",
	format: string,
} | {
	type: "boolean",
} | {
	type: "string",
} | {
	type: "object",
	properties: { [string]: Schema },
} | {
	type: "array",
	items: Schema,
})

local function get_endpoint(def: Definition, path: string): PathInfo?
	for p, info in def.paths do
		if p == path then
			return info
		end
	end
	return nil
end

local function get_schema(def: Definition, name: string): Schema?
	local parts = string.split(name, "/")
	local parent = def

	for i = 2, #parts do
		local part = parts[i]
		parent = parent[part]
		if not parent then
			return nil
		end
	end

	return parent :: any
end

local function solve_schema(def: Definition, schema: Schema): Schema
	if schema.allOf then
		return solve_schema(def, schema.allOf[1])
	end

	if schema["$ref"] then
		local solved = get_schema(def, schema["$ref"])
		if solved then
			return solved
		else
			error(`Failed to solve schema "{schema["$ref"]}"`)
		end
	else
		return schema
	end
end

return {
	get_endpoint = get_endpoint,
	get_schema = get_schema,
	solve_schema = solve_schema,
}
