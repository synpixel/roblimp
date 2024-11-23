local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [inventory.roblox.com](https://inventory.roblox.com)
--- @class inventory

--- @interface Int64Pages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within inventory
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- @interface AssetsExplorerCategoryModel
--- .items { AssetsExplorerCategoryItemModel }
--- .categoryType string
--- .name string
--- .displayName string
--- @within inventory
export type AssetsExplorerCategoryModel = {
	items: { AssetsExplorerCategoryItemModel },
	categoryType: string,
	name: string,
	displayName: string,
}

--- @interface CollectibleUserAssetModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { CollectibleUserAssetModel }
--- @within inventory
export type CollectibleUserAssetModelPages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { CollectibleUserAssetModel },
}

--- @interface PlaceModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { PlaceModel }
--- @within inventory
export type PlaceModelPages = { nextPageCursor: string, previousPageCursor: string, data: { PlaceModel } }

--- A model that contains a list of asset ids
--- @interface AssetIdListModel
--- .assetIds { number }
--- @within inventory
export type AssetIdListModel = { assetIds: { number } }

--- @interface CanViewInventoryResponse
--- .canView boolean
--- @within inventory
export type CanViewInventoryResponse = { canView: boolean }

--- A model containing information about a Roblox.Platform.AssetOwnership.UserAsset
--- @interface CollectibleUserAssetModel
--- .buildersClubMembershipType number
--- .serialNumber number
--- .userAssetId number
--- .assetId number
--- .name string
--- .originalPrice number
--- .isOnHold boolean
--- .assetStock number
--- .recentAveragePrice number
--- @within inventory
export type CollectibleUserAssetModel = {
	buildersClubMembershipType: number,
	serialNumber: number,
	userAssetId: number,
	assetId: number,
	name: string,
	originalPrice: number,
	isOnHold: boolean,
	assetStock: number,
	recentAveragePrice: number,
}

--- @interface AssetsExplorerCategoryItemModel
--- .type number
--- .name string
--- .filter string
--- .id number
--- .categoryType string
--- .displayName string
--- @within inventory
export type AssetsExplorerCategoryItemModel = {
	type: number,
	name: string,
	filter: string,
	id: number,
	categoryType: string,
	displayName: string,
}

--- Model representing an inventory item
--- @interface IItemModel
--- .Id number
--- .Type number
--- .Name string
--- .InstanceId number
--- @within inventory
export type IItemModel = { Id: number, Type: number, Name: string, InstanceId: number }

--- @interface PlaceModel
--- .universeId number
--- .name string
--- .priceInRobux number
--- .placeId number
--- .creator CreatorModel
--- @within inventory
export type PlaceModel = { universeId: number, name: string, priceInRobux: number, placeId: number, creator: CreatorModel }

--- Model class that contains the categories of the Inventory or Favorites page
--- @interface CategoriesModel
--- .categories { AssetsExplorerCategoryModel }
--- @within inventory
export type CategoriesModel = { categories: { AssetsExplorerCategoryModel } }

--- @interface IItemModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { IItemModel }
--- @within inventory
export type IItemModelPages = { nextPageCursor: string, previousPageCursor: string, data: { IItemModel } }

--- @interface ApiEmptyResponseModel
--- @within inventory
export type ApiEmptyResponseModel = {}

--- @interface CreatorModel
--- .id number
--- .type number
--- .name string
--- @within inventory
export type CreatorModel = { id: number, type: number, name: string }

--- @interface InventoryPageResponse
--- .total number
--- .data { nil }
--- .includesAccessories boolean
--- @within inventory
export type InventoryPageResponse = { total: number, data: { nil }, includesAccessories: boolean }

--- A model representing data about an Roblox.Platform.Membership.IUser
--- @interface UserModel
--- .username string
--- .buildersClubMembershipType number
--- .userId number
--- @within inventory
export type UserModel = { username: string, buildersClubMembershipType: number, userId: number }

--- @interface UserAssetItemModelV2Pages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { UserAssetItemModelV2 }
--- @within inventory
export type UserAssetItemModelV2Pages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { UserAssetItemModelV2 },
}

--- @interface AssetOwnerResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { AssetOwnerResponse }
--- @within inventory
export type AssetOwnerResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { AssetOwnerResponse } }

--- @interface AgentTypePages
--- .id number
--- .type number
--- .name string
--- @within inventory
export type AgentTypePages = { id: number, type: number, name: string }

--- A model containing information about an inventory item.
--- @interface InventoryItemModel
--- .collectibleItemInstanceId string
--- .assetName string
--- .userAssetId number
--- .owner UserModel
--- .collectibleItemId string
--- .updated string
--- .assetId number
--- .created string
--- .serialNumber number
--- @within inventory
export type InventoryItemModel = {
	collectibleItemInstanceId: string,
	assetName: string,
	userAssetId: number,
	owner: UserModel,
	collectibleItemId: string,
	updated: string,
	assetId: number,
	created: string,
	serialNumber: number,
}

--- @interface InventoryItemModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { InventoryItemModel }
--- @within inventory
export type InventoryItemModelPages = { nextPageCursor: string, previousPageCursor: string, data: { InventoryItemModel } }

--- The user asset item model for V2 controllers.
--- @interface UserAssetItemModelV2
--- .created string
--- .assetId number
--- .name string
--- .assetType number
--- @within inventory
export type UserAssetItemModelV2 = { created: string, assetId: number, name: string, assetType: number }

--- @interface AssetOwnerResponse
--- .created string
--- .serialNumber number
--- .id number
--- .owner AgentTypePages
--- .updated string
--- @within inventory
export type AssetOwnerResponse =
	{ created: string, serialNumber: number, id: number, owner: AgentTypePages, updated: string }

--- Return favorites categories for a user
--- @within inventory
local function favorites(with: { userId: number }): { AssetsExplorerCategoryModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{with.userId}/categories/favorites`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).categories
end

--- Gets whether the specified user's inventory can be viewed.
--- @within inventory
local function canView(with: { userId: number }): boolean
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{with.userId}/can-view-inventory`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).canView
end

--- Gets all collectible assets owned by the specified user.
--- @within inventory
local function collectibles(with: {
	userId: number,
	assetType: number?,
	limit: number?,
	cursor: string?,
	sortOrder: "Asc" | "Desc"?,
	cookie: string,
}): CollectibleUserAssetModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{with.userId}/assets/collectibles?assetType={with.assetType or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets Created, MyGames, or OtherGames places inventory for a user
--- @within inventory
local function games(
	with: { userId: number, placesTab: number, itemsPerPage: number, cursor: number, cookie: string }
): PlaceModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{with.userId}/places/inventory?placesTab={with.placesTab}&itemsPerPage={with.itemsPerPage}&cursor={with.cursor}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Return inventory categories for a user
--- @within inventory
local function categories(with: { userId: number }): { AssetsExplorerCategoryModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{with.userId}/categories`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).categories
end

--- Gets whether a user owns an item of type itemType with id itemTargetId.
--- @within inventory
local function owns(with: { userId: number, itemType: number, itemTargetId: number }): boolean
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{with.userId}/items/{with.itemType}/{with.itemTargetId}/is-owned`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get user's inventory by multiple Roblox.Platform.Assets.AssetType.
--- @within inventory
local function of(with: {
	userId: number,
	assetTypes: {
		"Image"
		| "TShirt"
		| "Audio"
		| "Mesh"
		| "Lua"
		| "HTML"
		| "Text"
		| "Hat"
		| "Place"
		| "Model"
		| "Shirt"
		| "Pants"
		| "Decal"
		| "Avatar"
		| "Head"
		| "Face"
		| "Gear"
		| "Badge"
		| "GroupEmblem"
		| "Animation"
		| "Arms"
		| "Legs"
		| "Torso"
		| "RightArm"
		| "LeftArm"
		| "LeftLeg"
		| "RightLeg"
		| "Package"
		| "YouTubeVideo"
		| "GamePass"
		| "App"
		| "Code"
		| "Plugin"
		| "SolidModel"
		| "MeshPart"
		| "HairAccessory"
		| "FaceAccessory"
		| "NeckAccessory"
		| "ShoulderAccessory"
		| "FrontAccessory"
		| "BackAccessory"
		| "WaistAccessory"
		| "ClimbAnimation"
		| "DeathAnimation"
		| "FallAnimation"
		| "IdleAnimation"
		| "JumpAnimation"
		| "RunAnimation"
		| "SwimAnimation"
		| "WalkAnimation"
		| "PoseAnimation"
		| "LocalizationTableManifest"
		| "LocalizationTableTranslation"
		| "EmoteAnimation"
		| "Video"
		| "TexturePack"
		| "TShirtAccessory"
		| "ShirtAccessory"
		| "PantsAccessory"
		| "JacketAccessory"
		| "SweaterAccessory"
		| "ShortsAccessory"
		| "LeftShoeAccessory"
		| "RightShoeAccessory"
		| "DressSkirtAccessory"
		| "FontFamily"
		| "FontFace"
		| "MeshHiddenSurfaceRemoval"
		| "EyebrowAccessory"
		| "EyelashAccessory"
		| "MoodAnimation"
		| "DynamicHead"
		| "CodeSnippet"
		| "AdsVideo"
		| "OtaUpdate"
	},
	filterDisapprovedAssets: boolean?,
	showApprovedOnly: boolean?,
	limit: number?,
	cursor: string?,
	sortOrder: "Asc" | "Desc"?,
	cookie: string,
}): UserAssetItemModelV2Pages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v2/users/{with.userId}/inventory?assetTypes={table.concat(
			with.assetTypes,
			"&assetTypes="
		)}&filterDisapprovedAssets={with.filterDisapprovedAssets or ""}&showApprovedOnly={with.showApprovedOnly or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of owners of an asset.
--- @within inventory
local function owners(
	with: { assetId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"?, cookie: string }
): AssetOwnerResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v2/assets/{with.assetId}/owners?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Give up an asset owned by the authenticated user.
--- Assets that are created by Roblox user or are limited edition are not eligible for deletion
--- and will return NotEligibleForDelete.
--- @within inventory
local function remove(with: { assetId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://inventory.roblox.com/v2/inventory/asset/{with.assetId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	favorites = favorites,
	of = of,
	canView = canView,
	collectibles = collectibles,
	games = games,
	categories = categories,
	owners = owners,
	remove = remove,
	owns = owns,
}
