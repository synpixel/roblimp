local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [trades.roblox.com](https://trades.roblox.com)
--- @class trades

--- @interface Int64Pages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within trades
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- @interface TradeRequest
--- .offers { TradeOfferRequest }
--- @within trades
export type TradeRequest = { offers: { TradeOfferRequest } }

--- @interface NewTradeResponse
--- .id number
--- @within trades
export type NewTradeResponse = { id: number }

--- @interface SkinnyUserResponse
--- .id number
--- .name string
--- .displayName string
--- @within trades
export type SkinnyUserResponse = { id: number, name: string, displayName: string }

--- A model containing information about a UserAsset.
--- @interface UserAssetResponse
--- .membershipType number
--- .assetId number
--- .serialNumber number
--- .originalPrice number
--- .id number
--- .assetStock number
--- .recentAveragePrice number
--- .name string
--- @within trades
export type UserAssetResponse = {
	membershipType: number,
	assetId: number,
	serialNumber: number,
	originalPrice: number,
	id: number,
	assetStock: number,
	recentAveragePrice: number,
	name: string,
}

--- @interface CanTradeResponse
--- .canTrade boolean
--- .status number
--- @within trades
export type CanTradeResponse = { canTrade: boolean, status: number }

--- @interface TradeOfferRequest
--- .robux number
--- .userId number
--- .userAssetIds { number }
--- @within trades
export type TradeOfferRequest = { robux: number, userId: number, userAssetIds: { number } }

--- @interface TradeResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { TradeResponse }
--- @within trades
export type TradeResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { TradeResponse } }

--- @interface TradeMetadata
--- .tradeSystemRobuxFee number
--- .tradeSystemMaxRobuxPercent number
--- .minValueRatio number
--- .maxItemsPerSide number
--- @within trades
export type TradeMetadata = {
	tradeSystemRobuxFee: number,
	tradeSystemMaxRobuxPercent: number,
	minValueRatio: number,
	maxItemsPerSide: number,
}

--- @interface TradeResponse
--- .created string
--- .user SkinnyUserResponse
--- .id number
--- .status number
--- .isActive boolean
--- .expiration string
--- @within trades
export type TradeResponse = {
	created: string,
	user: SkinnyUserResponse,
	id: number,
	status: number,
	isActive: boolean,
	expiration: string,
}

--- @interface TradeDetailResponse
--- .created string
--- .status number
--- .user SkinnyUserResponse
--- .id number
--- .expiration string
--- .isActive boolean
--- .offers { TradeOfferResponse }
--- @within trades
export type TradeDetailResponse = {
	created: string,
	status: number,
	user: SkinnyUserResponse,
	id: number,
	expiration: string,
	isActive: boolean,
	offers: { TradeOfferResponse },
}

--- @interface ApiEmptyResponseModel
--- @within trades
export type ApiEmptyResponseModel = {}

--- @interface TradeCountResponse
--- .count number
--- @within trades
export type TradeCountResponse = { count: number }

--- @interface TradeOfferResponse
--- .robux number
--- .userAssets { UserAssetResponse }
--- .user SkinnyUserResponse
--- @within trades
export type TradeOfferResponse = { robux: number, userAssets: { UserAssetResponse }, user: SkinnyUserResponse }

--- Fetches a list of the authenticated user's trades.
--- @within trades
local function all(
	request: { tradeStatusType: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): TradeResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{request.tradeStatusType}?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Accepts a trade.
--- @within trades
local function accept(tradeId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{tradeId}/accept`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets metadata about the trade system.
--- @within trades
local function metadata(cookie: string): TradeMetadata
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns whether you can trade with another user.
--- @within trades
local function canSend(userId: number, cookie: string): CanTradeResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/users/{userId}/can-trade-with`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets detailed information about a trade.
--- @within trades
local function get(tradeId: number, cookie: string): TradeDetailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{tradeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sends a trade.
--- @within trades
local function send(offers: { TradeOfferRequest }, cookie: string): number
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/send`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { offers = offers }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).id
end

--- Gets the total number of pending trades for the authenticated user.
--- Inbound is the only accepted tradeStatusType.
--- @within trades
local function count(tradeStatusType: number, cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{tradeStatusType}/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

--- Counters a trade.
--- @within trades
local function counter(request: TradeRequest & { tradeId: number }, cookie: string): number
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{request.tradeId}/counter`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).id
end

--- Declines a trade.
--- @within trades
local function decline(tradeId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{tradeId}/decline`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	all = all,
	accept = accept,
	metadata = metadata,
	canSend = canSend,
	get = get,
	send = send,
	count = count,
	counter = counter,
	decline = decline,
}
