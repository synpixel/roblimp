local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
export type CurrencyResponse = { robux: number }

--- Gets currency for the authenticated user.
local function robux(with: { cookie: string }): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://economy.roblox.com/v1/user/currency`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).robux
end

return { robux = robux }
