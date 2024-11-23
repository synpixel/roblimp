local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
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

--- <no description>
export type BundleCreatorModel = { id: number, type: string, name: string, hasVerifiedBadge: boolean }

--- <no description>
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

--- <no description>
export type MultigetItemDetailsRequestModel = { items: { MultigetItemDetailsRequestItem } }

--- <no description>
export type OwnedBundleModelPages = { nextPageCursor: string, previousPageCursor: string, data: { OwnedBundleModel } }

--- <no description>

--- A model to represent asset favorites.
export type AssetFavoriteModel = { created: string, assetId: number, userId: number }

--- <no description>
export type ApiEmptyResponseModel = {}

--- <no description>
export type CatalogSearchDetailedResponseItemPages = { data: { CatalogSearchDetailedResponseItem } }

--- <no description>

--- <no description>
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

--- <no description>
export type IBundleInstancePages = { CursorRecipe: string, ExclusiveStartKeyInfo: IBundleInstancePages }

--- Defines the Premium pricing for a catalog item
export type PremiumPricingModel = { premiumDiscountPercentage: number, premiumPriceInRobux: number }

--- <no description>
export type BundleDetailsModelPages = { data: { BundleDetailsModel } }

--- <no description>
export type Error = { Message: string, Code: number }

--- A model to represent bundle favorites.
export type BundleFavoriteModel = { created: string, bundleId: number, userId: number }

--- A model to represent owned bundles.
export type OwnedBundleModel = { id: number, creator: BundleCreatorModel, name: string, bundleType: string }

--- <no description>
export type BundleItemDetailModel = { owned: boolean, type: string, name: string, id: number }

--- <no description>

--- <no description>
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

--- <no description>

--- <no description>
export type AvatarItem = { TargetId: number, ItemType: number }

--- <no description>
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

--- <no description>
export type TopicResponse = { topics: { TopicModel }, error: Error }

--- <no description>
export type MultigetItemDetailsRequestItem = { itemType: number, id: number }

--- <no description>

--- The detailed model for catalog items.

--- <no description>
export type Int32Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- <no description>
export type ElasticsearchDebugInfo = {
	isForceTerminationEnabledByRequest: boolean,
	searchResultDataSource: string,
	isFromCache: boolean,
	indexName: string,
	elasticsearchQuery: string,
	isTerminatedEarly: boolean,
}

--- <no description>

--- ApiPageResponse for catalog search

--- Returns list of item details.
local function items(with: MultigetItemDetailsRequestModel & { cookie: string }): { CatalogSearchDetailedResponseItem }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://catalog.roblox.com/v1/catalog/items/details`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Search for catalog items.
local function search(with: {
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
	cookie: string,
}): CatalogSearchDetailedResponseItemPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://catalog.roblox.com/v2/search/items/details?assetTypeIds={table.concat(
			with.assetTypeIds or {},
			"&assetTypeIds="
		)}&bundleTypeIds={table.concat(with.bundleTypeIds or {}, "&bundleTypeIds=")}&sortAggregation={with.sortAggregation or ""}&sortType={with.sortType or ""}&creatorType={with.creatorType or ""}&creatorTargetId={with.creatorTargetId or ""}&creatorName={with.creatorName or ""}&maxPrice={with.maxPrice or ""}&minPrice={with.minPrice or ""}&keyword={with.keyword or ""}&includeNotForSale={with.includeNotForSale or ""}&triggeredByTopicDiscovery={with.triggeredByTopicDiscovery or ""}&salesTypeFilter={with.salesTypeFilter or ""}&topics={with.topics or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return { items = items, search = search }
