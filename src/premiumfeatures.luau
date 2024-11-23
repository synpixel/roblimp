local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [premiumfeatures.roblox.com](https://premiumfeatures.roblox.com)
--- @class premiumfeatures

--- Get if a user has a Premium membership
--- @within premiumfeatures
local function has(with: { userId: number, cookie: string }): nil
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://premiumfeatures.roblox.com/v1/users/{with.userId}/validate-membership`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return response.body
end

return { has = has }
