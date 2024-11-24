local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

export type CurrencyResponse = { robux: number }

--- Gets currency for the authenticated user.
local function robux(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://economy.roblox.com/v1/user/currency`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).robux
	end)
end

return { robux = robux }
