local net = require("@lune/net")
local serde = require("@lune/serde")
local Result = require("../../lune_packages/result")

export type HttpHeaderMap = { [string]: string }

export type FetchParams = {
	url: string,
	method: net.HttpMethod?,
	body: (string | buffer)?,
	query: net.HttpQueryMap?,
	headers: HttpHeaderMap?,
	options: net.FetchParamsOptions?,
}

type RobloxError = { code: number, message: string }

export type Error = typeof(setmetatable(
	{} :: {
		statusCode: number,
		statusMessage: string,
		roblox: RobloxError?,
	},
	{} :: {
		__tostring: (self: Error) -> string,
	}
))

local ERROR_METATABLE = {
	__tostring = function(self: Error)
		if self.roblox == nil then
			return `{self.statusCode} {self.statusMessage}`
		else
			return `{self.statusCode} {self.statusMessage} ({self.roblox.code}: {self.roblox.message})`
		end
	end,
}

local csrfTokenCache = {}

local function decodeJson(encoded: string): Result.Result<any, unknown>
	return Result.try(serde.decode, "json" :: serde.EncodeDecodeFormat, encoded)
end

local function readRobloxError(response: net.FetchResponse): Result.Result<RobloxError, unknown>
	return Result.try(function()
		local body = decodeJson(response.body):unwrap()
		return body.errors[1]
	end)
end

local function requestWithCsrfToken(params: FetchParams): Result.Result<net.FetchResponse, Error>
	local headers: HttpHeaderMap = if params.headers ~= nil then table.clone(params.headers) else {}

	local cookie = if headers.Cookie == nil then nil else headers.Cookie:match("%.ROBLOSECURITY=(.+);?")
	if cookie ~= nil then
		headers["X-Csrf-Token"] = csrfTokenCache[cookie]
	end

	local response = net.request({
		method = params.method,
		url = params.url,
		headers = headers,
		body = params.body,
		options = params.options,
	})

	if response.headers["x-csrf-token"] ~= nil then
		csrfTokenCache[cookie] = response.headers["x-csrf-token"]
		return requestWithCsrfToken(params)
	end

	if response.ok == false then
		local error = {
			statusCode = response.statusCode,
			statusMessage = response.statusMessage,
			roblox = readRobloxError(response):unwrapOr(nil :: any),
		}
		return Result.Err(setmetatable(error, ERROR_METATABLE))
	end

	return Result.Ok(response)
end

return requestWithCsrfToken
