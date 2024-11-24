local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

--- Request model for getting users by ids.
export type MultiGetByUserIdRequest = { userIds: { number }, excludeBannedUsers: boolean }

--- A user age bracket response model.
export type UserAgeBracketResponse = { ageBracket: number }

--- A response model representing absolute minimal authenticating user information.
--- No new attributes should be added to this response since it is in the critical path of app launch and we want to minimize dependencies.
export type AuthenticatedGetUserResponse = { id: number, name: string, displayName: string }

--- The birthdate response
export type BirthdateResponse = { birthYear: number, birthMonth: number, birthDay: number }

--- The description request
export type DescriptionRequest = { description: string }

--- The description response
export type DescriptionResponse = { description: string }

--- A response model representing user information.
export type GetUserResponse = {
	created: string,
	externalAppDisplayName: string,
	description: string,
	name: string,
	id: number,
	hasVerifiedBadge: boolean,
	isBanned: boolean,
	displayName: string,
}

export type ApiEmptyResponseModel = {}

--- The gender response
export type GenderResponse = { gender: number }

--- Request model for getting users by usernames.
export type MultiGetByUsernameRequest = { excludeBannedUsers: boolean, usernames: { string } }

--- A user roles response model.
export type UserRolesResponse = { roles: { string } }

export type SearchGetUserResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { SearchGetUserResponse },
}

--- A response model specific to multi-get user by name.
export type MultiGetUserByNameResponse = {
	requestedUsername: string,
	name: string,
	id: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- Request model for changing a display name.
export type SetDisplayNameRequest = { newDisplayName: string }

--- The birthdate request
export type BirthdateRequest = { birthYear: number, birthMonth: number, password: string, birthDay: number }

export type UsernameHistoryResponse = { name: string }

export type UsernameHistoryResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { UsernameHistoryResponse },
}

--- A response model specific to multi-get user.
---
---             Note: Currently the MultiGet responses don't have all the data that the single gets have, to reduce payload size!
---             We might want to revisit this decision in the future.
---
export type MultiGetUserResponse = { id: number, name: string, hasVerifiedBadge: boolean, displayName: string }

--- A user country code response model.
export type UserCountryCodeResponse = { countryCode: string }

--- A user response model specific to getting a user from user search.
export type SearchGetUserResponse = {
	previousUsernames: { string },
	name: string,
	id: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- The gender request
export type GenderRequest = { gender: string }

--- Searches for users by keyword.
local function search(
	request: { keyword: string, sessionId: string?, limit: number?, cursor: string? },
	cookie: string?
): Response<SearchGetUserResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/search?keyword={request.keyword}&sessionId={request.sessionId or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets detailed user information by id.
local function get(userId: number, cookie: string?): Response<GetUserResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/{userId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Update the user's birthdate
local function setBirthdate(request: BirthdateRequest, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/birthdate`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get the user's birthdate
local function birthdate(cookie: string): Response<BirthdateResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/birthdate`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Update the user's description
local function setDescription(description: string, cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/description`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { description = description }),
	}):map(function(response)
		return serde.decode("json", response.body).description
	end)
end

--- Get the user's description
local function description(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/description`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).description
	end)
end

--- Retrieves the username history for a particular user.
local function usernameHistory(
	request: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string?
): Response<UsernameHistoryResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/{request.userId}/username-history?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get users by usernames.
local function fromNames(request: MultiGetByUsernameRequest, cookie: string?): Response<{ MultiGetUserByNameResponse }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/usernames/users`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie or ""}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Update the user's gender
local function setGender(gender: string, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/gender`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { gender = gender }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get the user's gender
local function gender(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/gender`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).gender
	end)
end

--- Gets the country code of the authenticated user.
local function countryCode(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/country-code`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).countryCode
	end)
end

--- Gets the (public) roles of the authenticated user, such as `"Soothsayer"` and `"BetaTester"`.
local function publicRoles(cookie: string): Response<{ string }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/roles`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).roles
	end)
end

--- Get users by ids.
local function fromIds(request: MultiGetByUserIdRequest, cookie: string?): Response<{ MultiGetUserResponse }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/users`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie or ""}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Set the display name for the authorized user.
local function setDisplayName(
	request: SetDisplayNameRequest & { userId: number },
	cookie: string
): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "PATCH",
		url = `https://users.roblox.com/v1/users/{request.userId}/display-names`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the age bracket of the authenticated user.
local function ageBracket(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/age-bracket`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).ageBracket
	end)
end

--- Gets the minimal authenticated user.
local function authenticated(cookie: string): Response<AuthenticatedGetUserResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

return {
	search = search,
	get = get,
	setBirthdate = setBirthdate,
	birthdate = birthdate,
	setDescription = setDescription,
	description = description,
	usernameHistory = usernameHistory,
	fromNames = fromNames,
	setGender = setGender,
	gender = gender,
	countryCode = countryCode,
	publicRoles = publicRoles,
	fromIds = fromIds,
	setDisplayName = setDisplayName,
	ageBracket = ageBracket,
	authenticated = authenticated,
}
