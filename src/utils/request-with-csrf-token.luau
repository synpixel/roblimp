local net = require("@lune/net")
local Result = require("../../lune_packages/result")

export type Error = {
	statusCode: number,
	statusMessage: string,
}

local csrfTokenCache = {}

local function requestWithCsrfToken(parameters: net.FetchParams): Result.Result<net.FetchResponse, Error>
	local headers = if parameters.headers == nil then {} else table.clone(parameters.headers :: net.HttpHeaderMap)

	local cookie = if headers.Cookie == nil then nil else headers.Cookie:match("%.ROBLOSECURITY=(.+);?")
	if cookie ~= nil then
		headers["X-Csrf-Token"] = csrfTokenCache[cookie]
	end

	local response = net.request({
		method = parameters.method,
		url = parameters.url,
		headers = headers,
		body = parameters.body,
		options = parameters.options,
	})

	if response.headers["x-csrf-token"] ~= nil then
		csrfTokenCache[cookie] = response.headers["x-csrf-token"]
		return requestWithCsrfToken(parameters)
	end

	if response.ok == false then
		return Result.Err({
			statusCode = response.statusCode,
			statusMessage = response.statusMessage,
		})
	end

	return Result.Ok(response)
end

return requestWithCsrfToken
