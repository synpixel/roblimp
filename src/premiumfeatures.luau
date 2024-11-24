local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

--- Get if a user has a Premium membership
local function has(userId: number, cookie: string): Response<nil>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://premiumfeatures.roblox.com/v1/users/{userId}/validate-membership`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return response.body
	end)
end

return { has = has }
