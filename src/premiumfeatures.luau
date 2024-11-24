local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- Get if a user has a Premium membership
local function has(userId: number, cookie: string): nil
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://premiumfeatures.roblox.com/v1/users/{userId}/validate-membership`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return response.body
end

return { has = has }
