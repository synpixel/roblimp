local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- A response containing universe information.
export type UniverseResponse = { id: number, rootPlaceId: number, name: string }

--- <no description>
export type BadgeResponseV2 = {
	enabled: boolean,
	description: string,
	id: number,
	iconImageId: number,
	displayName: string,
	updated: string,
	name: string,
	created: string,
	displayIconImageId: number,
	statistics: BadgeAwardStatisticsResponse,
	awarder: BadgeAwarderTypePages,
	displayDescription: string,
}

--- Response for the GetBadgesByUser endpoint.
export type GetBadgesByUserResponse = {
	enabled: boolean,
	creator: BadgeCreatorResponse,
	id: number,
	iconImageId: number,
	displayName: string,
	updated: string,
	created: string,
	name: string,
	awarder: BadgeAwarderTypePages,
	displayIconImageId: number,
	statistics: BadgeAwardStatisticsResponse,
	displayDescription: string,
	description: string,
}

--- <no description>
export type BadgeAwarderTypePages = { id: number, type: number, name: string }

--- <no description>
export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- <no description>
export type Stream = {
	CanRead: boolean,
	CanWrite: boolean,
	CanTimeout: boolean,
	Position: number,
	WriteTimeout: number,
	Length: number,
	ReadTimeout: number,
	CanSeek: boolean,
}

--- Represents information about the badge creator. (Creator of the place that awarded the badge)
export type BadgeCreatorResponse = { id: number, type: string, name: string }

--- <no description>
export type IUploadedFile = buffer

--- A response containing badge information.
export type BadgeResponse = {
	enabled: boolean,
	description: string,
	awardingUniverse: UniverseResponse,
	id: number,
	iconImageId: number,
	displayName: string,
	updated: string,
	name: string,
	displayIconImageId: number,
	statistics: BadgeAwardStatisticsResponse,
	created: string,
	displayDescription: string,
}

--- <no description>
export type BadgeAwardResponsePages = { data: { BadgeAwardResponse } }

--- <no description>
export type GetBadgesByUserResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GetBadgesByUserResponse },
}

--- A request model used for updating badge information.
export type UpdateBadgeRequest = { enabled: boolean, name: string, description: string }

--- Metadata about badges.
export type BadgeMetadataResponse = {
	maxBadgeNameLength: number,
	badgeCreationPrice: number,
	maxBadgeDescriptionLength: number,
}

--- <no description>
export type BadgeResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { BadgeResponse } }

--- <no description>
export type ApiEmptyResponseModel = {}

--- The result of being awarded a badge.
export type BadgeAwardResponse = { badgeId: number, awardedDate: string }

--- <no description>
export type BadgeAwardStatisticsResponse = { pastDayAwardedCount: number, winRatePercentage: number, awardedCount: number }

--- Gets timestamps for when badges were awarded to a user.
local function getBadgeAwardedTimestamps(with: { userId: number, badgeIds: { number } }): BadgeAwardResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/users/{with.userId}/badges/awarded-dates?badgeIds={table.concat(
			with.badgeIds,
			"&badgeIds="
		)}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates badge configuration.
local function updateBadge(with: UpdateBadgeRequest & { badgeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://badges.roblox.com/v1/badges/{with.badgeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets badge information by the badge Id.
local function getBadge(with: { badgeId: number }): BadgeResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/badges/{with.badgeId}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the number of free badges left for the current UTC day by their awarding game.
local function getFreeBadgesQuota(with: { universeId: number }): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/universes/{with.universeId}/free-badges-quota`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes a badge from the user.
local function removeBadgeFrom(with: { userId: number, badgeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://badges.roblox.com/v1/user/{with.userId}/badges/{with.badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets metadata about the badges system.
local function getMetadata(): BadgeMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/badges/metadata`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates a new badge.
local function createBadge(with: {
	universeId: number,
	name: string?,
	description: string?,
	paymentSourceType: number?,
	files: buffer?,
	expectedCost: number?,
	isActive: boolean?,
	cookie: string,
}): BadgeResponseV2
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://badges.roblox.com/v1/universes/{with.universeId}/badges?name={with.name or ""}&description={with.description or ""}&paymentSourceType={with.paymentSourceType or ""}&files={with.files or ""}&expectedCost={with.expectedCost or ""}&isActive={with.isActive or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets badges by their awarding game.
local function getBadgesFor(with: {
	universeId: number,
	sortBy: "Rank" | "DateCreated"?,
	limit: number?,
	cursor: string?,
	sortOrder: "Asc" | "Desc"?,
}): BadgeResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/universes/{with.universeId}/badges?sortBy={with.sortBy or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes a badge from the authenticated user.
local function removeBadge(with: { badgeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://badges.roblox.com/v1/user/badges/{with.badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of badges a user has been awarded.
local function getBadgesOf(
	with: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): GetBadgesByUserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/users/{with.userId}/badges?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	getBadgeAwardedTimestamps = getBadgeAwardedTimestamps,
	updateBadge = updateBadge,
	getBadge = getBadge,
	getFreeBadgesQuota = getFreeBadgesQuota,
	removeBadgeFrom = removeBadgeFrom,
	getMetadata = getMetadata,
	createBadge = createBadge,
	getBadgesFor = getBadgesFor,
	removeBadge = removeBadge,
	getBadgesOf = getBadgesOf,
}
