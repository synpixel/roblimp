local net = require("@lune/net")
local Result = require("../../lune_packages/result")

export type Error = typeof(setmetatable(
	{} :: {
		statusCode: number,
		statusMessage: string,
	},
	{} :: {
		__tostring: (self: Error) -> string,
	}
))

local ERROR_METATABLE = {
	__tostring = function(self: Error)
		return `{self.statusCode} {self.statusMessage}`
	end,
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
		local error = {
			statusCode = response.statusCode,
			statusMessage = response.statusMessage,
		}
		return Result.Err(setmetatable(error, ERROR_METATABLE))
	end

	return Result.Ok(response)
end

return requestWithCsrfToken
