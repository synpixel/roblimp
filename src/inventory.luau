local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

export type AssetsExplorerCategoryModel = {
	items: { AssetsExplorerCategoryItemModel },
	categoryType: string,
	name: string,
	displayName: string,
}

export type CollectibleUserAssetModelPages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { CollectibleUserAssetModel },
}

export type PlaceModelPages = { nextPageCursor: string, previousPageCursor: string, data: { PlaceModel } }

--- A model that contains a list of asset ids
export type AssetIdListModel = { assetIds: { number } }

--- A model containing information about a Roblox.Platform.AssetOwnership.UserAsset
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

export type AssetsExplorerCategoryItemModel = {
	type: number,
	name: string,
	filter: string,
	id: number,
	categoryType: string,
	displayName: string,
}

--- Model representing an inventory item
export type IItemModel = { Id: number, Type: number, Name: string, InstanceId: number }

export type PlaceModel = { universeId: number, name: string, priceInRobux: number, placeId: number, creator: CreatorModel }

--- Model class that contains the categories of the Inventory or Favorites page
export type CategoriesModel = { categories: { AssetsExplorerCategoryModel } }

export type ApiEmptyResponseModel = {}

export type CreatorModel = { id: number, type: number, name: string }

--- A model representing data about an Roblox.Platform.Membership.IUser
export type UserModel = { username: string, buildersClubMembershipType: number, userId: number }

export type UserAssetItemModelV2Pages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { UserAssetItemModelV2 },
}

export type AssetOwnerResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { AssetOwnerResponse } }

export type AgentTypePages = { id: number, type: number, name: string }

--- A model containing information about an inventory item.
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

--- The user asset item model for V2 controllers.
export type UserAssetItemModelV2 = { created: string, assetId: number, name: string, assetType: number }

export type AssetOwnerResponse =
	{ created: string, serialNumber: number, id: number, owner: AgentTypePages, updated: string }

--- Return favorites categories for a user
local function favorites(userId: number, cookie: string?): Response<{ AssetsExplorerCategoryModel }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{userId}/categories/favorites`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).categories
	end)
end

--- Gets whether the specified user's inventory can be viewed.
local function canView(userId: number, cookie: string?): Response<boolean>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{userId}/can-view-inventory`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).canView
	end)
end

--- Gets all collectible assets owned by the specified user.
local function collectibles(
	request: {
		userId: number,
		assetType: number?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string
): Response<CollectibleUserAssetModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{request.userId}/assets/collectibles?assetType={request.assetType or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets Created, MyGames, or OtherGames places inventory for a user
local function games(
	request: { userId: number, placesTab: number, itemsPerPage: number, cursor: number },
	cookie: string
): Response<PlaceModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{request.userId}/places/inventory?placesTab={request.placesTab}&itemsPerPage={request.itemsPerPage}&cursor={request.cursor}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Return inventory categories for a user
local function categories(userId: number, cookie: string?): Response<{ AssetsExplorerCategoryModel }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{userId}/categories`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).categories
	end)
end

--- Gets whether a user owns an item of type itemType with id itemTargetId.
local function owns(
	request: { userId: number, itemType: number, itemTargetId: number },
	cookie: string?
): Response<boolean>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v1/users/{request.userId}/items/{request.itemType}/{request.itemTargetId}/is-owned`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get user's inventory by multiple Roblox.Platform.Assets.AssetType.
local function of(
	request: {
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
	},
	cookie: string
): Response<UserAssetItemModelV2Pages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v2/users/{request.userId}/inventory?assetTypes={table.concat(
			request.assetTypes,
			"&assetTypes="
		)}&filterDisapprovedAssets={request.filterDisapprovedAssets or ""}&showApprovedOnly={request.showApprovedOnly or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a list of owners of an asset.
local function owners(
	request: { assetId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): Response<AssetOwnerResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://inventory.roblox.com/v2/assets/{request.assetId}/owners?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Give up an asset owned by the authenticated user.
--- Assets that are created by Roblox user or are limited edition are not eligible for deletion
--- and will return NotEligibleForDelete.
local function remove(assetId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "DELETE",
		url = `https://inventory.roblox.com/v2/inventory/asset/{assetId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
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
