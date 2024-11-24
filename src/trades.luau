local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

export type TradeRequest = { offers: { TradeOfferRequest } }

export type NewTradeResponse = { id: number }

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

export type CanTradeResponse = { canTrade: boolean, status: number }

export type TradeOfferRequest = { robux: number, userId: number, userAssetIds: { number } }

export type TradeResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { TradeResponse } }

export type TradeMetadata = {
	tradeSystemRobuxFee: number,
	tradeSystemMaxRobuxPercent: number,
	minValueRatio: number,
	maxItemsPerSide: number,
}

export type TradeResponse = {
	created: string,
	user: SkinnyUserResponse,
	id: number,
	status: number,
	isActive: boolean,
	expiration: string,
}

export type TradeDetailResponse = {
	created: string,
	status: number,
	user: SkinnyUserResponse,
	id: number,
	expiration: string,
	isActive: boolean,
	offers: { TradeOfferResponse },
}

export type ApiEmptyResponseModel = {}

export type TradeCountResponse = { count: number }

export type TradeOfferResponse = { robux: number, userAssets: { UserAssetResponse }, user: SkinnyUserResponse }

--- Fetches a list of the authenticated user's trades.
local function all(
	request: { tradeStatusType: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): Response<TradeResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{request.tradeStatusType}?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Accepts a trade.
local function accept(tradeId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{tradeId}/accept`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets metadata about the trade system.
local function metadata(cookie: string): Response<TradeMetadata>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Returns whether you can trade with another user.
local function canSend(userId: number, cookie: string): Response<CanTradeResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/users/{userId}/can-trade-with`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets detailed information about a trade.
local function get(tradeId: number, cookie: string): Response<TradeDetailResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{tradeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Sends a trade.
local function send(offers: { TradeOfferRequest }, cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/send`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { offers = offers }),
	}):map(function(response)
		return serde.decode("json", response.body).id
	end)
end

--- Gets the total number of pending trades for the authenticated user.
--- Inbound is the only accepted tradeStatusType.
local function count(tradeStatusType: number, cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://trades.roblox.com/v1/trades/{tradeStatusType}/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
end

--- Counters a trade.
local function counter(request: TradeRequest & { tradeId: number }, cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{request.tradeId}/counter`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).id
	end)
end

--- Declines a trade.
local function decline(tradeId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://trades.roblox.com/v1/trades/{tradeId}/decline`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
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
