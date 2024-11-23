local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [users.roblox.com](https://users.roblox.com)
--- @class users

--- Request model for getting users by ids.
--- @interface MultiGetByUserIdRequest
--- .userIds { number }
--- .excludeBannedUsers boolean
--- @within users
export type MultiGetByUserIdRequest = { userIds: { number }, excludeBannedUsers: boolean }

--- A user age bracket response model.
--- @interface UserAgeBracketResponse
--- .ageBracket number
--- @within users
export type UserAgeBracketResponse = { ageBracket: number }

--- A response model representing absolute minimal authenticating user information.
--- No new attributes should be added to this response since it is in the critical path of app launch and we want to minimize dependencies.
--- @interface AuthenticatedGetUserResponse
--- .id number
--- .name string
--- .displayName string
--- @within users
export type AuthenticatedGetUserResponse = { id: number, name: string, displayName: string }

--- The birthdate response
--- @interface BirthdateResponse
--- .birthYear number
--- .birthMonth number
--- .birthDay number
--- @within users
export type BirthdateResponse = { birthYear: number, birthMonth: number, birthDay: number }

--- The description request
--- @interface DescriptionRequest
--- .description string
--- @within users
export type DescriptionRequest = { description: string }

--- The description response
--- @interface DescriptionResponse
--- .description string
--- @within users
export type DescriptionResponse = { description: string }

--- A response model representing user information.
--- @interface GetUserResponse
--- .created string
--- .externalAppDisplayName string
--- .description string
--- .name string
--- .id number
--- .hasVerifiedBadge boolean
--- .isBanned boolean
--- .displayName string
--- @within users
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

--- @interface ApiEmptyResponseModel
--- @within users
export type ApiEmptyResponseModel = {}

--- The gender response
--- @interface GenderResponse
--- .gender number
--- @within users
export type GenderResponse = { gender: number }

--- Request model for getting users by usernames.
--- @interface MultiGetByUsernameRequest
--- .excludeBannedUsers boolean
--- .usernames { string }
--- @within users
export type MultiGetByUsernameRequest = { excludeBannedUsers: boolean, usernames: { string } }

--- @interface StartIndexCursor
--- .discriminator string
--- .count number
--- .startIndex number
--- @within users
export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- A user roles response model.
--- @interface UserRolesResponse
--- .roles { string }
--- @within users
export type UserRolesResponse = { roles: { string } }

--- @interface SearchGetUserResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { SearchGetUserResponse }
--- @within users
export type SearchGetUserResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { SearchGetUserResponse },
}

--- A response model specific to multi-get user by name.
--- @interface MultiGetUserByNameResponse
--- .requestedUsername string
--- .name string
--- .id number
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within users
export type MultiGetUserByNameResponse = {
	requestedUsername: string,
	name: string,
	id: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- Request model for changing a display name.
--- @interface SetDisplayNameRequest
--- .newDisplayName string
--- @within users
export type SetDisplayNameRequest = { newDisplayName: string }

--- @interface Int64Pages
--- .discriminator string
--- .sortOrder number
--- .key number
--- .count number
--- .pagingDirection number
--- .pageNumber number
--- @within users
export type Int64Pages = {
	discriminator: string,
	sortOrder: number,
	key: number,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- @interface MultiGetUserResponsePages
--- .data { MultiGetUserResponse }
--- @within users
export type MultiGetUserResponsePages = { data: { MultiGetUserResponse } }

--- @interface MultiGetUserByNameResponsePages
--- .data { MultiGetUserByNameResponse }
--- @within users
export type MultiGetUserByNameResponsePages = { data: { MultiGetUserByNameResponse } }

--- The birthdate request
--- @interface BirthdateRequest
--- .birthYear number
--- .birthMonth number
--- .password string
--- .birthDay number
--- @within users
export type BirthdateRequest = { birthYear: number, birthMonth: number, password: string, birthDay: number }

--- @interface UsernameHistoryResponse
--- .name string
--- @within users
export type UsernameHistoryResponse = { name: string }

--- @interface UsernameHistoryResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { UsernameHistoryResponse }
--- @within users
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
--- @interface MultiGetUserResponse
--- .id number
--- .name string
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within users
export type MultiGetUserResponse = { id: number, name: string, hasVerifiedBadge: boolean, displayName: string }

--- A user country code response model.
--- @interface UserCountryCodeResponse
--- .countryCode string
--- @within users
export type UserCountryCodeResponse = { countryCode: string }

--- A user response model specific to getting a user from user search.
--- @interface SearchGetUserResponse
--- .previousUsernames { string }
--- .name string
--- .id number
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within users
export type SearchGetUserResponse = {
	previousUsernames: { string },
	name: string,
	id: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- The gender request
--- @interface GenderRequest
--- .gender string
--- @within users
export type GenderRequest = { gender: string }

--- Searches for users by keyword.
--- @within users
local function search(
	request: { keyword: string, sessionId: string?, limit: number?, cursor: string? }
): SearchGetUserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/search?keyword={request.keyword}&sessionId={request.sessionId or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets detailed user information by id.
--- @within users
local function get(userId: number): GetUserResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/{userId}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update the user's birthdate
--- @within users
local function setBirthdate(request: BirthdateRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/birthdate`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the user's birthdate
--- @within users
local function birthdate(cookie: string): BirthdateResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/birthdate`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update the user's description
--- @within users
local function setDescription(request: DescriptionRequest & { cookie: string }): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/description`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).description
end

--- Get the user's description
--- @within users
local function description(cookie: string): string
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/description`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).description
end

--- Retrieves the username history for a particular user.
--- @within users
local function usernameHistory(
	request: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): UsernameHistoryResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/{request.userId}/username-history?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get users by usernames.
--- @within users
local function fromNames(request: MultiGetByUsernameRequest): { MultiGetUserByNameResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/usernames/users`,
		headers = { ["Content-Type"] = "application/json" },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Update the user's gender
--- @within users
local function setGender(request: GenderRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/gender`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the user's gender
--- @within users
local function gender(cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/gender`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).gender
end

--- Gets the country code of the authenticated user.
--- @within users
local function countryCode(cookie: string): string
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/country-code`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).countryCode
end

--- Gets the (public) roles of the authenticated user, such as `"Soothsayer"` and `"BetaTester"`.
--- @within users
local function publicRoles(cookie: string): { string }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/roles`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).roles
end

--- Get users by ids.
--- @within users
local function fromIds(request: MultiGetByUserIdRequest): { MultiGetUserResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/users`,
		headers = { ["Content-Type"] = "application/json" },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Set the display name for the authorized user.
--- @within users
local function setDisplayName(
	request: SetDisplayNameRequest & { userId: number, cookie: string }
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://users.roblox.com/v1/users/{request.userId}/display-names`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the age bracket of the authenticated user.
--- @within users
local function ageBracket(cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/age-bracket`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).ageBracket
end

--- Gets the minimal authenticated user.
--- @within users
local function authenticated(cookie: string): AuthenticatedGetUserResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
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
