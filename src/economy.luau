local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
export type CurrencyResponse = { robux: number }

--- Gets currency for the authenticated user.
local function getCurrency(with: { cookie: string }): CurrencyResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://economy.roblox.com/v1/user/currency`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return { getCurrency = getCurrency }
