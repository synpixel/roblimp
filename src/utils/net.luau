--!strict

local std = require("./std")

export type FetchParams = {
	method: "GET" | "POST" | "PATCH" | "PUT" | "DELETE" | "HEAD" | "OPTIONS",
	url: string,
	headers: { [string]: string }?,
	body: string | buffer?,
	options: { decompress: boolean? }?,
}

export type FetchResponse = {
	ok: boolean,
	statusCode: number,
	statusMessage: string,
	headers: { [string]: string },
	body: string,
}

export type HttpHeaderMap = { [string]: string }

export type Net = {
	request: (parameters: FetchParams | string) -> FetchResponse,
}

if std.runtime == "lune" then
	return require("@lune/net") :: Net
elseif std.runtime == "roblox" then
	local HttpService = game:GetService("HttpService")

	local net = {} :: Net

	net.request = function(parameters)
		local compression = if typeof(parameters) == "table"
				and parameters.options ~= nil
				and parameters.options.decompress
			then Enum.HttpCompression.Gzip
			else Enum.HttpCompression.None

		local response = if typeof(parameters) == "string"
			then HttpService:RequestAsync({ Method = "GET", Url = parameters, Compress = Enum.HttpCompression.None })
			else HttpService:RequestAsync({
				Method = parameters.method,
				Url = parameters.url,
				Headers = parameters.headers,
				Body = parameters.body,
				Compress = compression,
			})

		return {
			ok = response.Success,
			statusCode = response.StatusCode,
			statusMessage = response.StatusMessage,
			headers = response.Headers,
			body = response.Body or "",
		}
	end

	return net
end

return {
	request = std.unknownImplementation,
} :: Net
