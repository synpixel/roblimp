local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [badges.roblox.com](https://badges.roblox.com)
--- @class badges

--- A response containing universe information.
--- @interface UniverseResponse
--- .id number
--- .rootPlaceId number
--- .name string
--- @within badges
export type UniverseResponse = { id: number, rootPlaceId: number, name: string }

--- @interface BadgeResponseV2
--- .enabled boolean
--- .description string
--- .id number
--- .iconImageId number
--- .displayName string
--- .updated string
--- .name string
--- .created string
--- .displayIconImageId number
--- .statistics BadgeAwardStatisticsResponse
--- .awarder BadgeAwarderTypePages
--- .displayDescription string
--- @within badges
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
--- @interface GetBadgesByUserResponse
--- .enabled boolean
--- .creator BadgeCreatorResponse
--- .id number
--- .iconImageId number
--- .displayName string
--- .updated string
--- .created string
--- .name string
--- .awarder BadgeAwarderTypePages
--- .displayIconImageId number
--- .statistics BadgeAwardStatisticsResponse
--- .displayDescription string
--- .description string
--- @within badges
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

--- @interface BadgeAwarderTypePages
--- .id number
--- .type number
--- .name string
--- @within badges
export type BadgeAwarderTypePages = { id: number, type: number, name: string }

--- @interface StringPages
--- .discriminator string
--- .sortOrder number
--- .key string
--- .count number
--- .pagingDirection number
--- .pageNumber number
--- @within badges
export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- @interface Stream
--- .CanRead boolean
--- .CanWrite boolean
--- .CanTimeout boolean
--- .Position number
--- .WriteTimeout number
--- .Length number
--- .ReadTimeout number
--- .CanSeek boolean
--- @within badges
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
--- @interface BadgeCreatorResponse
--- .id number
--- .type string
--- .name string
--- @within badges
export type BadgeCreatorResponse = { id: number, type: string, name: string }

--- @type IUploadedFile buffer
--- @within badges
export type IUploadedFile = buffer

--- A response containing badge information.
--- @interface BadgeResponse
--- .enabled boolean
--- .description string
--- .awardingUniverse UniverseResponse
--- .id number
--- .iconImageId number
--- .displayName string
--- .updated string
--- .name string
--- .displayIconImageId number
--- .statistics BadgeAwardStatisticsResponse
--- .created string
--- .displayDescription string
--- @within badges
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

--- @interface BadgeAwardResponsePages
--- .data { BadgeAwardResponse }
--- @within badges
export type BadgeAwardResponsePages = { data: { BadgeAwardResponse } }

--- @interface GetBadgesByUserResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GetBadgesByUserResponse }
--- @within badges
export type GetBadgesByUserResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GetBadgesByUserResponse },
}

--- A request model used for updating badge information.
--- @interface UpdateBadgeRequest
--- .enabled boolean
--- .name string
--- .description string
--- @within badges
export type UpdateBadgeRequest = { enabled: boolean, name: string, description: string }

--- Metadata about badges.
--- @interface BadgeMetadataResponse
--- .maxBadgeNameLength number
--- .badgeCreationPrice number
--- .maxBadgeDescriptionLength number
--- @within badges
export type BadgeMetadataResponse = {
	maxBadgeNameLength: number,
	badgeCreationPrice: number,
	maxBadgeDescriptionLength: number,
}

--- @interface BadgeResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { BadgeResponse }
--- @within badges
export type BadgeResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { BadgeResponse } }

--- @interface ApiEmptyResponseModel
--- @within badges
export type ApiEmptyResponseModel = {}

--- The result of being awarded a badge.
--- @interface BadgeAwardResponse
--- .badgeId number
--- .awardedDate string
--- @within badges
export type BadgeAwardResponse = { badgeId: number, awardedDate: string }

--- @interface BadgeAwardStatisticsResponse
--- .pastDayAwardedCount number
--- .winRatePercentage number
--- .awardedCount number
--- @within badges
export type BadgeAwardStatisticsResponse = { pastDayAwardedCount: number, winRatePercentage: number, awardedCount: number }

--- Gets timestamps for when badges were awarded to a user.
--- @within badges
local function awardedTimestamps(
	request: { userId: number, badgeIds: { number } },
	cookie: string?
): { BadgeAwardResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/users/{request.userId}/badges/awarded-dates?badgeIds={table.concat(
			request.badgeIds,
			"&badgeIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Updates badge configuration.
--- @within badges
local function update(request: UpdateBadgeRequest & { badgeId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://badges.roblox.com/v1/badges/{request.badgeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets badge information by the badge Id.
--- @within badges
local function get(badgeId: number, cookie: string?): BadgeResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/badges/{badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the number of free badges left for the current UTC day by their awarding game.
--- @within badges
local function freeQuota(universeId: number, cookie: string?): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/universes/{universeId}/free-badges-quota`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes a badge from the user.
--- @within badges
local function removeFrom(request: { userId: number, badgeId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://badges.roblox.com/v1/user/{request.userId}/badges/{request.badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets metadata about the badges system.
--- @within badges
local function metadata(request: {}, cookie: string?): BadgeMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/badges/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates a new badge.
--- @within badges
local function create(
	request: {
		universeId: number,
		name: string?,
		description: string?,
		paymentSourceType: number?,
		files: buffer?,
		expectedCost: number?,
		isActive: boolean?,
	},
	cookie: string
): BadgeResponseV2
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://badges.roblox.com/v1/universes/{request.universeId}/badges?name={request.name or ""}&description={request.description or ""}&paymentSourceType={request.paymentSourceType or ""}&files={request.files or ""}&expectedCost={request.expectedCost or ""}&isActive={request.isActive or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets badges by their awarding game.
--- @within badges
local function universe(
	request: {
		universeId: number,
		sortBy: "Rank" | "DateCreated"?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string?
): BadgeResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/universes/{request.universeId}/badges?sortBy={request.sortBy or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes a badge from the authenticated user.
--- @within badges
local function remove(badgeId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://badges.roblox.com/v1/user/badges/{badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of badges a user has been awarded.
--- @within badges
local function of(
	request: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string?
): GetBadgesByUserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/users/{request.userId}/badges?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	awardedTimestamps = awardedTimestamps,
	update = update,
	get = get,
	freeQuota = freeQuota,
	removeFrom = removeFrom,
	metadata = metadata,
	create = create,
	universe = universe,
	remove = remove,
	of = of,
}
