local std = require("./std")

export type EncodeDecodeFormat = "json" | "toml" | "yaml"

export type Serde = {
	encode: (format: EncodeDecodeFormat, value: any) -> string,
	decode: (format: EncodeDecodeFormat, encoded: string | buffer) -> any,
}

if std.runtime == "lune" then
	return require("@lune/serde") :: Serde
elseif std.runtime == "roblox" then
	local HttpService = game:GetService("HttpService")

	local serde = {} :: Serde

	serde.encode = function(format: "json" | "toml" | "yaml", value: any)
		assert(format == "json", "unsupported format")
		return HttpService:JSONEncode(value)
	end

	serde.decode = function(format: "json" | "toml" | "yaml", encoded: string | buffer)
		assert(format == "json", "unsupported format")

		local encoded = if typeof(encoded) == "buffer" then buffer.tostring(encoded) else encoded
		return HttpService:JSONDecode(encoded)
	end

	return serde
end

return {
	encode = std.unknownImpl,
	decode = std.unknownImpl,
} :: Serde
