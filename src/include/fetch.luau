local net = require("@lune/net")
local serde = require("@lune/serde")

local Result = require("../../lune_packages/result")

type RobloxError = { code: number, message: string }

export type Error = typeof(setmetatable(
	{} :: {
		status_code: number,
		status_message: string,
		headers: net.HttpHeaderMap,
		roblox_error: RobloxError?,
	},
	{} :: { __tostring: (err: Error) -> string }
))

export type Response<T> = Result.Result<T, Error>

local ERROR_METATABLE = table.freeze {
	__tostring = function(err: Error)
		if err.roblox_error then
			return `{err.status_code} {err.status_message} + Roblox({err.roblox_error.code}: {err.roblox_error.message})`
		else
			return `{err.status_code} {err.status_message}`
		end
	end,
}

local function try_read_roblox_error(response: net.FetchResponse): RobloxError?
	local produces = response.headers["content-type"]
	if produces ~= "application/json" then
		return nil
	end

	local body = serde.decode("json", response.body)
	return if body.errors then body.errors[1] else nil
end

local function fetch<T>(config: net.FetchParams): Response<net.FetchResponse>
	local response = net.request(config)
	if response.ok then
		return Result.Ok(response)
	end

	local err = setmetatable({
		status_code = response.statusCode,
		status_message = response.statusMessage,
		headers = response.headers,
		roblox_error = try_read_roblox_error(response),
	}, ERROR_METATABLE)

	return Result.Err(err)
end

return fetch
