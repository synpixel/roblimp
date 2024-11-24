local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

--- A response containing favorited bundles and whether there are more.
export type FavoriteBundlesResponse = {
	moreFavorites: boolean,
	previousCursor: string,
	nextCursor: string,
	favorites: { BundleDetailsModel },
}

--- The detailed model for catalog items.
export type CatalogSearchDetailedResponseItem = {
	description: string,
	creatorTargetId: number,
	bundledItems: { BundleItemDetailModel },
	priceStatus: string,
	assetType: number,
	isOffSale: boolean,
	productId: number,
	itemRestrictions: { number },
	itemStatus: { number },
	quantityLimitPerUser: number,
	totalQuantity: number,
	saleLocationType: number,
	favoriteCount: number,
	itemType: number,
	hasResellers: boolean,
	id: number,
	collectibleItemId: string,
	unitsAvailableForConsumption: number,
	creatorHasVerifiedBadge: boolean,
	bundleType: number,
	offSaleDeadline: string,
	name: string,
	lowestResalePrice: number,
	price: number,
	lowestPrice: number,
	creatorName: string,
	creatorType: number,
}

export type BundleCreatorModel = { id: number, type: string, name: string, hasVerifiedBadge: boolean }

export type BundleDetailsModel = {
	description: string,
	id: number,
	product: BundleProductModel,
	bundleType: string,
	name: string,
	itemRestrictions: { number },
	collectibleItemDetail: CollectibleItemDetail,
	creator: BundleCreatorModel,
	items: { BundleItemDetailModel },
}

--- Response model for avatar topics
export type TopicModel = { originalTopicName: string, displayName: string }

export type MultigetItemDetailsRequestModel = { items: { MultigetItemDetailsRequestItem } }

export type OwnedBundleModelPages = { nextPageCursor: string, previousPageCursor: string, data: { OwnedBundleModel } }

--- A model to represent asset favorites.
export type AssetFavoriteModel = { created: string, assetId: number, userId: number }

export type ApiEmptyResponseModel = {}

export type CatalogSearchDetailedResponseItemPages = { data: { CatalogSearchDetailedResponseItem } }

export type TopicRequestModel = {
	items: { AvatarItem },
	inputQuery: string,
	selectTopics: { string },
	genderType: number,
	maxResult: number,
}

--- SaleLocation information for a collectible item (asset or bundle).
export type SaleLocation = {
	saleLocationType: number,
	universeIds: { number },
	enabledUniverseIds: { number },
	saleLocationTypeId: number,
}

export type IBundleInstancePages = { CursorRecipe: string, ExclusiveStartKeyInfo: IBundleInstancePages }

--- Defines the Premium pricing for a catalog item
export type PremiumPricingModel = { premiumDiscountPercentage: number, premiumPriceInRobux: number }

export type BundleDetailsModelPages = { data: { BundleDetailsModel } }

export type Error = { Message: string, Code: number }

--- A model to represent bundle favorites.
export type BundleFavoriteModel = { created: string, bundleId: number, userId: number }

--- A model to represent owned bundles.
export type OwnedBundleModel = { id: number, creator: BundleCreatorModel, name: string, bundleType: string }

export type BundleItemDetailModel = { owned: boolean, type: string, name: string, id: number }

export type CollectibleItemDetail = {
	lowestAvailableResaleItemInstanceId: string,
	unitsAvailable: number,
	totalQuantity: number,
	hasResellers: boolean,
	price: number,
	resaleRestriction: number,
	collectibleItemId: string,
	collectibleItemType: number,
	collectibleProductId: string,
	offSaleDeadline: string,
	lowestAvailableResaleProductId: string,
	lowestResalePrice: number,
	saleStatus: number,
	lowestPrice: number,
	quantityLimitPerUser: number,
	saleLocation: SaleLocation,
}

export type AvatarItem = { TargetId: number, ItemType: number }

export type BundleProductModel = {
	isPublicDomain: boolean,
	type: string,
	isFree: boolean,
	isForSale: boolean,
	id: number,
	priceInRobux: number,
	noPriceText: string,
	premiumPricing: PremiumPricingModel,
}

export type TopicResponse = { topics: { TopicModel }, error: Error }

export type MultigetItemDetailsRequestItem = { itemType: number, id: number }

export type Int32Pages = { SortOrder: number, PagingDirection: number, Count: number }

export type ElasticsearchDebugInfo = {
	isForceTerminationEnabledByRequest: boolean,
	searchResultDataSource: string,
	isFromCache: boolean,
	indexName: string,
	elasticsearchQuery: string,
	isTerminatedEarly: boolean,
}

--- Returns details about the given bundleId.
local function bundle(bundleId: number, cookie: string?): Response<BundleDetailsModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v1/bundles/{bundleId}/details`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Returns list of item details.
local function items(
	items: { MultigetItemDetailsRequestItem },
	cookie: string
): Response<{ CatalogSearchDetailedResponseItem }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://catalog.roblox.com/v1/catalog/items/details`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { items = items }),
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Returns details about the given bundleIds.
local function bundles(bundleIds: { number }, cookie: string?): Response<{ BundleDetailsModel }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v1/bundles/details?bundleIds={table.concat(bundleIds, "&bundleIds=")}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Lists the bundles owned by a given user.
local function bundlesOf(
	request: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string?
): Response<OwnedBundleModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v1/users/{request.userId}/bundles?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Search for catalog items.
local function search(
	request: {
		assetTypeIds: { number }?,
		bundleTypeIds: { number }?,
		sortAggregation: number?,
		sortType: number?,
		creatorType: number?,
		creatorTargetId: number?,
		creatorName: string?,
		maxPrice: number?,
		minPrice: number?,
		keyword: string?,
		includeNotForSale: boolean?,
		triggeredByTopicDiscovery: boolean?,
		salesTypeFilter: number?,
		topics: string?,
		limit: number?,
		cursor: string?,
		sortOrder: "Desc"?,
	},
	cookie: string
): Response<CatalogSearchDetailedResponseItemPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v2/search/items/details?assetTypeIds={table.concat(
			request.assetTypeIds or {},
			"&assetTypeIds="
		)}&bundleTypeIds={table.concat(request.bundleTypeIds or {}, "&bundleTypeIds=")}&sortAggregation={request.sortAggregation or ""}&sortType={request.sortType or ""}&creatorType={request.creatorType or ""}&creatorTargetId={request.creatorTargetId or ""}&creatorName={request.creatorName or ""}&maxPrice={request.maxPrice or ""}&minPrice={request.minPrice or ""}&keyword={request.keyword or ""}&includeNotForSale={request.includeNotForSale or ""}&triggeredByTopicDiscovery={request.triggeredByTopicDiscovery or ""}&salesTypeFilter={request.salesTypeFilter or ""}&topics={request.topics or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

return { bundle = bundle, items = items, search = search, bundles = bundles, bundlesOf = bundlesOf }
