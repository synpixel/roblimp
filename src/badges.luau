local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

--- A response containing universe information.
export type UniverseResponse = { id: number, rootPlaceId: number, name: string }

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

export type BadgeAwarderTypePages = { id: number, type: number, name: string }

export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

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

export type BadgeAwardResponsePages = { data: { BadgeAwardResponse } }

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

export type BadgeResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { BadgeResponse } }

export type ApiEmptyResponseModel = {}

--- The result of being awarded a badge.
export type BadgeAwardResponse = { badgeId: number, awardedDate: string }

export type BadgeAwardStatisticsResponse = { pastDayAwardedCount: number, winRatePercentage: number, awardedCount: number }

--- Gets timestamps for when badges were awarded to a user.
local function awardedTimestamps(
	request: { userId: number, badgeIds: { number } },
	cookie: string?
): Response<{ BadgeAwardResponse }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/users/{request.userId}/badges/awarded-dates?badgeIds={table.concat(
			request.badgeIds,
			"&badgeIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Updates badge configuration.
local function update(
	request: UpdateBadgeRequest & { badgeId: number },
	cookie: string
): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "PATCH",
		url = `https://badges.roblox.com/v1/badges/{request.badgeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets badge information by the badge Id.
local function get(badgeId: number, cookie: string?): Response<BadgeResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/badges/{badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the number of free badges left for the current UTC day by their awarding game.
local function freeQuota(universeId: number, cookie: string?): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/universes/{universeId}/free-badges-quota`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Removes a badge from the user.
local function removeFrom(request: { userId: number, badgeId: number }, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "DELETE",
		url = `https://badges.roblox.com/v1/user/{request.userId}/badges/{request.badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets metadata about the badges system.
local function metadata(cookie: string?): Response<BadgeMetadataResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/badges/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Creates a new badge.
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
): Response<BadgeResponseV2>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://badges.roblox.com/v1/universes/{request.universeId}/badges?name={request.name or ""}&description={request.description or ""}&paymentSourceType={request.paymentSourceType or ""}&files={request.files or ""}&expectedCost={request.expectedCost or ""}&isActive={request.isActive or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets badges by their awarding game.
local function universe(
	request: {
		universeId: number,
		sortBy: "Rank" | "DateCreated"?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string?
): Response<BadgeResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/universes/{request.universeId}/badges?sortBy={request.sortBy or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Removes a badge from the authenticated user.
local function remove(badgeId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "DELETE",
		url = `https://badges.roblox.com/v1/user/badges/{badgeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a list of badges a user has been awarded.
local function of(
	request: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string?
): Response<GetBadgesByUserResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://badges.roblox.com/v1/users/{request.userId}/badges?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
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
