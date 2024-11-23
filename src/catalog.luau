local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [catalog.roblox.com](https://catalog.roblox.com)
--- @class catalog

--- @interface Int64Pages
--- .CursorRecipe string
--- .ExclusiveStartKeyInfo Int64Pages
--- @within catalog
export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

--- A response containing favorited bundles and whether there are more.
--- @interface FavoriteBundlesResponse
--- .moreFavorites boolean
--- .previousCursor string
--- .nextCursor string
--- .favorites { BundleDetailsModel }
--- @within catalog
export type FavoriteBundlesResponse = {
	moreFavorites: boolean,
	previousCursor: string,
	nextCursor: string,
	favorites: { BundleDetailsModel },
}

--- The detailed model for catalog items.
--- @interface CatalogSearchDetailedResponseItem
--- .description string
--- .creatorTargetId number
--- .bundledItems { BundleItemDetailModel }
--- .priceStatus string
--- .assetType number
--- .isOffSale boolean
--- .productId number
--- .itemRestrictions { number }
--- .itemStatus { number }
--- .quantityLimitPerUser number
--- .totalQuantity number
--- .saleLocationType number
--- .favoriteCount number
--- .itemType number
--- .hasResellers boolean
--- .id number
--- .collectibleItemId string
--- .unitsAvailableForConsumption number
--- .creatorHasVerifiedBadge boolean
--- .bundleType number
--- .offSaleDeadline string
--- .name string
--- .lowestResalePrice number
--- .price number
--- .lowestPrice number
--- .creatorName string
--- .creatorType number
--- @within catalog
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

--- @interface BundleCreatorModel
--- .id number
--- .type string
--- .name string
--- .hasVerifiedBadge boolean
--- @within catalog
export type BundleCreatorModel = { id: number, type: string, name: string, hasVerifiedBadge: boolean }

--- @interface BundleDetailsModel
--- .description string
--- .id number
--- .product BundleProductModel
--- .bundleType string
--- .name string
--- .itemRestrictions { number }
--- .collectibleItemDetail CollectibleItemDetail
--- .creator BundleCreatorModel
--- .items { BundleItemDetailModel }
--- @within catalog
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
--- @interface TopicModel
--- .originalTopicName string
--- .displayName string
--- @within catalog
export type TopicModel = { originalTopicName: string, displayName: string }

--- @interface MultigetItemDetailsRequestModel
--- .items { MultigetItemDetailsRequestItem }
--- @within catalog
export type MultigetItemDetailsRequestModel = { items: { MultigetItemDetailsRequestItem } }

--- @interface OwnedBundleModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { OwnedBundleModel }
--- @within catalog
export type OwnedBundleModelPages = { nextPageCursor: string, previousPageCursor: string, data: { OwnedBundleModel } }

--- A model to represent asset favorites.
--- @interface AssetFavoriteModel
--- .created string
--- .assetId number
--- .userId number
--- @within catalog
export type AssetFavoriteModel = { created: string, assetId: number, userId: number }

--- @interface ApiEmptyResponseModel
--- @within catalog
export type ApiEmptyResponseModel = {}

--- @interface CatalogSearchDetailedResponseItemPages
--- .data { CatalogSearchDetailedResponseItem }
--- @within catalog
export type CatalogSearchDetailedResponseItemPages = { data: { CatalogSearchDetailedResponseItem } }

--- @interface TopicRequestModel
--- .items { AvatarItem }
--- .inputQuery string
--- .selectTopics { string }
--- .genderType number
--- .maxResult number
--- @within catalog
export type TopicRequestModel = {
	items: { AvatarItem },
	inputQuery: string,
	selectTopics: { string },
	genderType: number,
	maxResult: number,
}

--- SaleLocation information for a collectible item (asset or bundle).
--- @interface SaleLocation
--- .saleLocationType number
--- .universeIds { number }
--- .enabledUniverseIds { number }
--- .saleLocationTypeId number
--- @within catalog
export type SaleLocation = {
	saleLocationType: number,
	universeIds: { number },
	enabledUniverseIds: { number },
	saleLocationTypeId: number,
}

--- @interface IBundleInstancePages
--- .CursorRecipe string
--- .ExclusiveStartKeyInfo IBundleInstancePages
--- @within catalog
export type IBundleInstancePages = { CursorRecipe: string, ExclusiveStartKeyInfo: IBundleInstancePages }

--- Defines the Premium pricing for a catalog item
--- @interface PremiumPricingModel
--- .premiumDiscountPercentage number
--- .premiumPriceInRobux number
--- @within catalog
export type PremiumPricingModel = { premiumDiscountPercentage: number, premiumPriceInRobux: number }

--- @interface BundleDetailsModelPages
--- .data { BundleDetailsModel }
--- @within catalog
export type BundleDetailsModelPages = { data: { BundleDetailsModel } }

--- @interface Error
--- .Message string
--- .Code number
--- @within catalog
export type Error = { Message: string, Code: number }

--- A model to represent bundle favorites.
--- @interface BundleFavoriteModel
--- .created string
--- .bundleId number
--- .userId number
--- @within catalog
export type BundleFavoriteModel = { created: string, bundleId: number, userId: number }

--- A model to represent owned bundles.
--- @interface OwnedBundleModel
--- .id number
--- .creator BundleCreatorModel
--- .name string
--- .bundleType string
--- @within catalog
export type OwnedBundleModel = { id: number, creator: BundleCreatorModel, name: string, bundleType: string }

--- @interface BundleItemDetailModel
--- .owned boolean
--- .type string
--- .name string
--- .id number
--- @within catalog
export type BundleItemDetailModel = { owned: boolean, type: string, name: string, id: number }

--- @interface CollectibleItemDetail
--- .lowestAvailableResaleItemInstanceId string
--- .unitsAvailable number
--- .totalQuantity number
--- .hasResellers boolean
--- .price number
--- .resaleRestriction number
--- .collectibleItemId string
--- .collectibleItemType number
--- .collectibleProductId string
--- .offSaleDeadline string
--- .lowestAvailableResaleProductId string
--- .lowestResalePrice number
--- .saleStatus number
--- .lowestPrice number
--- .quantityLimitPerUser number
--- .saleLocation SaleLocation
--- @within catalog
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

--- @interface AvatarItem
--- .TargetId number
--- .ItemType number
--- @within catalog
export type AvatarItem = { TargetId: number, ItemType: number }

--- @interface BundleProductModel
--- .isPublicDomain boolean
--- .type string
--- .isFree boolean
--- .isForSale boolean
--- .id number
--- .priceInRobux number
--- .noPriceText string
--- .premiumPricing PremiumPricingModel
--- @within catalog
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

--- @interface TopicResponse
--- .topics { TopicModel }
--- .error Error
--- @within catalog
export type TopicResponse = { topics: { TopicModel }, error: Error }

--- @interface MultigetItemDetailsRequestItem
--- .itemType number
--- .id number
--- @within catalog
export type MultigetItemDetailsRequestItem = { itemType: number, id: number }

--- @interface Int32Pages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within catalog
export type Int32Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- @interface ElasticsearchDebugInfo
--- .isForceTerminationEnabledByRequest boolean
--- .searchResultDataSource string
--- .isFromCache boolean
--- .indexName string
--- .elasticsearchQuery string
--- .isTerminatedEarly boolean
--- @within catalog
export type ElasticsearchDebugInfo = {
	isForceTerminationEnabledByRequest: boolean,
	searchResultDataSource: string,
	isFromCache: boolean,
	indexName: string,
	elasticsearchQuery: string,
	isTerminatedEarly: boolean,
}

--- Returns details about the given bundleId.
--- @within catalog
local function bundle(bundleId: number, cookie: string?): BundleDetailsModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v1/bundles/{bundleId}/details`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns list of item details.
--- @within catalog
local function items(items: { MultigetItemDetailsRequestItem }, cookie: string): { CatalogSearchDetailedResponseItem }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://catalog.roblox.com/v1/catalog/items/details`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { items = items }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Returns details about the given bundleIds.
--- @within catalog
local function bundles(bundleIds: { number }, cookie: string?): { BundleDetailsModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v1/bundles/details?bundleIds={table.concat(bundleIds, "&bundleIds=")}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Lists the bundles owned by a given user.
--- @within catalog
local function bundlesOf(
	request: { userId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string?
): OwnedBundleModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v1/users/{request.userId}/bundles?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Search for catalog items.
--- @within catalog
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
): CatalogSearchDetailedResponseItemPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v2/search/items/details?assetTypeIds={table.concat(
			request.assetTypeIds or {},
			"&assetTypeIds="
		)}&bundleTypeIds={table.concat(request.bundleTypeIds or {}, "&bundleTypeIds=")}&sortAggregation={request.sortAggregation or ""}&sortType={request.sortType or ""}&creatorType={request.creatorType or ""}&creatorTargetId={request.creatorTargetId or ""}&creatorName={request.creatorName or ""}&maxPrice={request.maxPrice or ""}&minPrice={request.minPrice or ""}&keyword={request.keyword or ""}&includeNotForSale={request.includeNotForSale or ""}&triggeredByTopicDiscovery={request.triggeredByTopicDiscovery or ""}&salesTypeFilter={request.salesTypeFilter or ""}&topics={request.topics or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return { bundle = bundle, items = items, search = search, bundles = bundles, bundlesOf = bundlesOf }
