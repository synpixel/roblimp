local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [economy.roblox.com](https://economy.roblox.com)
--- @class economy

--- @interface CurrencyResponse
--- .robux number
--- @within economy
export type CurrencyResponse = { robux: number }

--- Gets currency for the authenticated user.
--- @within economy
local function robux(cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://economy.roblox.com/v1/user/currency`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).robux
end

return { robux = robux }
