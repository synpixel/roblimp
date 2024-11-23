local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- <no description>
export type TradeRequest = { offers: { TradeOfferRequest } }

--- <no description>
export type NewTradeResponse = { id: number }

--- <no description>
export type SkinnyUserResponse = { id: number, name: string, displayName: string }

--- A model containing information about a UserAsset.
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

--- <no description>

--- <no description>
export type CanTradeResponse = { canTrade: boolean, status: number }

--- <no description>
export type TradeOfferRequest = { robux: number, userId: number, userAssetIds: { number } }

--- <no description>
export type TradeResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { TradeResponse } }

--- <no description>
export type TradeMetadata = {
	tradeSystemRobuxFee: number,
	tradeSystemMaxRobuxPercent: number,
	minValueRatio: number,
	maxItemsPerSide: number,
}

--- <no description>
export type TradeResponse = {
	created: string,
	user: SkinnyUserResponse,
	id: number,
	status: number,
	isActive: boolean,
	expiration: string,
}

--- <no description>
export type TradeDetailResponse = {
	created: string,
	status: number,
	user: SkinnyUserResponse,
	id: number,
	expiration: string,
	isActive: boolean,
	offers: { TradeOfferResponse },
}

--- <no description>
export type ApiEmptyResponseModel = {}

--- <no description>
export type TradeCountResponse = { count: number }

--- <no description>
export type TradeOfferResponse = { robux: number, userAssets: { UserAssetResponse }, user: SkinnyUserResponse }

--- Fetches a list of the authenticated user's trades.
local function all(
	with: { tradeStatusType: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"?, cookie: string }
): TradeResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{with.tradeStatusType}?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Accepts a trade.
local function accept(with: { tradeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{with.tradeId}/accept`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets metadata about the trade system.
local function metadata(with: { cookie: string }): TradeMetadata
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns whether you can trade with another user.
local function canSend(with: { userId: number, cookie: string }): CanTradeResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/users/{with.userId}/can-trade-with`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets detailed information about a trade.
local function get(with: { tradeId: number, cookie: string }): TradeDetailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{with.tradeId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sends a trade.
local function send(with: TradeRequest & { cookie: string }): number
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/send`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).id
end

--- Gets the total number of pending trades for the authenticated user.
--- Inbound is the only accepted tradeStatusType.
local function count(with: { tradeStatusType: number, cookie: string }): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{with.tradeStatusType}/count`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

--- Counters a trade.
local function counter(with: TradeRequest & { tradeId: number, cookie: string }): number
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{with.tradeId}/counter`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).id
end

--- Declines a trade.
local function decline(with: { tradeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{with.tradeId}/decline`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
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
