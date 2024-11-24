local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

export type CurrencyResponse = { robux: number }

--- Gets currency for the authenticated user.
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
