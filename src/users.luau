local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

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

--- <no description>
export type ApiEmptyResponseModel = {}

--- The gender response
export type GenderResponse = { gender: number }

--- Request model for getting users by usernames.
export type MultiGetByUsernameRequest = { excludeBannedUsers: boolean, usernames: { string } }

--- <no description>
export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- A user roles response model.
export type UserRolesResponse = { roles: { string } }

--- <no description>
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

--- <no description>
export type Int64Pages = {
	discriminator: string,
	sortOrder: number,
	key: number,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- <no description>
export type MultiGetUserResponsePages = { data: { MultiGetUserResponse } }

--- <no description>
export type MultiGetUserByNameResponsePages = { data: { MultiGetUserByNameResponse } }

--- The birthdate request
export type BirthdateRequest = { birthYear: number, birthMonth: number, password: string, birthDay: number }

--- <no description>
export type UsernameHistoryResponse = { name: string }

--- <no description>
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
local function searchUsers(
	with: { keyword: string, sessionId: string?, limit: number?, cursor: string? }
): SearchGetUserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/search?keyword={with.keyword}&sessionId={with.sessionId or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets detailed user information by id.
local function getUser(with: { userId: number }): GetUserResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/{with.userId}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update the user's birthdate
local function setBirthdate(with: BirthdateRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/birthdate`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the user's birthdate
local function getBirthdate(with: { cookie: string }): BirthdateResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/birthdate`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update the user's description
local function setDescription(with: DescriptionRequest & { cookie: string }): DescriptionResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/description`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the user's description
local function getDescription(with: { cookie: string }): DescriptionResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/description`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Retrieves the username history for a particular user.
local function getUsernameHistory(
	with: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): UsernameHistoryResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/{with.userId}/username-history?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get users by usernames.
local function getUsersByNames(with: MultiGetByUsernameRequest): MultiGetUserByNameResponsePages
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/usernames/users`,
		headers = { ["Content-Type"] = "application/json" },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update the user's gender
local function setGender(with: GenderRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/gender`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the user's gender
local function getGender(with: { cookie: string }): GenderResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/gender`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the country code of the authenticated user.
local function getCountryCode(with: { cookie: string }): UserCountryCodeResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/country-code`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the (public) roles of the authenticated user, such as `"Soothsayer"` and `"BetaTester"`.
local function getPublicRoles(with: { cookie: string }): UserRolesResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/roles`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get users by ids.
local function getUsersByIds(with: MultiGetByUserIdRequest): MultiGetUserResponsePages
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://users.roblox.com/v1/users`,
		headers = { ["Content-Type"] = "application/json" },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Set the display name for the authorized user.
local function setDisplayName(with: SetDisplayNameRequest & { userId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://users.roblox.com/v1/users/{with.userId}/display-names`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the age bracket of the authenticated user.
local function getAgeBracket(with: { cookie: string }): UserAgeBracketResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated/age-bracket`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the minimal authenticated user.
local function getAuthenticatedUser(with: { cookie: string }): AuthenticatedGetUserResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://users.roblox.com/v1/users/authenticated`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	searchUsers = searchUsers,
	getUser = getUser,
	setBirthdate = setBirthdate,
	getBirthdate = getBirthdate,
	setDescription = setDescription,
	getDescription = getDescription,
	getUsernameHistory = getUsernameHistory,
	getUsersByNames = getUsersByNames,
	setGender = setGender,
	getGender = getGender,
	getCountryCode = getCountryCode,
	getPublicRoles = getPublicRoles,
	getUsersByIds = getUsersByIds,
	setDisplayName = setDisplayName,
	getAgeBracket = getAgeBracket,
	getAuthenticatedUser = getAuthenticatedUser,
}
