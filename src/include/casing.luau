export type TransformCasingFn = ((x: string) -> string) & (<K, V>(x: { [K]: V }) -> { [K]: V })

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

local function snake_to_camel<T>(value: T): T
	return transform(value, function(str)
		return str:gsub("_(%l)", function(char)
			return char:upper()
		end)
	end)
end

local function camel_to_snake<T>(value: T): T
	return transform(value, function(str)
		return str:gsub("(%u+)(%u%l)", "%1_%2"):gsub("([a-z%d])(%u)", "%1_%2"):lower()
	end)
end

return {
	snake_to_camel = snake_to_camel,
	camel_to_snake = camel_to_snake,
}
