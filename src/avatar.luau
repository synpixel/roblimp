local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

--- Empty response, will be in WebAPI base soon
export type EmptyResponse = {}

--- A model containing details about avatar-related business rules
export type DefaultClothingAssets = { defaultPantAssetIds: { number }, defaultShirtAssetIds: { number } }

--- Filtered page response
export type OutfitModelPages = { filteredCount: number, data: { OutfitModel }, total: number }

--- A model container BrickColor ids for each body part.
export type BodyColorModel = { hexColor: string, name: string, brickColorId: number }

--- A model that contains a playerAvatarType
export type PlayerAvatarTypeModel = { playerAvatarType: number }

export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

--- A model for wear outfit responses
export type WearResponseModel = { invalidAssets: { AssetModelV2 }, invalidAssetIds: { number }, success: boolean }

export type AccessoryScaleModel = { yScale: number, xScale: number, zScale: number }

--- A model containing details about an asset
--- - V2: adds CurrentVersionId, AssetMetaModel
export type AssetModelV2 = {
	name: string,
	id: number,
	meta: AssetMetaModelV1,
	assetType: AssetTypeModel,
	currentVersionId: number,
}

--- Response object representing a user's emote
export type EmoteResponseModel = { assetId: number, assetName: string, position: number }

--- A model containing details about an asset type and its business rules
export type AssetTypeRulesModel = { id: number, maxNumber: number, name: string }

--- A model containing details about an asset type
export type AssetTypeModel = { id: number, name: string }

--- A model containing website metadata for avatars
export type AvatarMetadataModel = {
	isBodyTypeScaleOutOfTab: boolean,
	scaleWidthIncrement: number,
	isJustinUiChangesEnabled: boolean,
	scaleHeadIncrement: number,
	supportProportionAndBodyType: boolean,
	scaleHeightIncrement: number,
	isCategoryReorgEnabled: boolean,
	isAvatarScaleEmbeddedInTab: boolean,
	showDefaultClothingMessageOnPageLoad: boolean,
	enableDefaultClothingMessage: boolean,
	isLCCompletelyEnabled: boolean,
	isAvatarWearingApiCallsLockingOnFrontendEnabled: boolean,
	LCEnabledInEditorAndCatalog: boolean,
	isOutfitHandlingOnFrontendEnabled: boolean,
	scaleProportionIncrement: number,
	scaleBodyTypeIncrement: number,
	areThreeDeeThumbsEnabled: boolean,
}

export type AssetPosition = { Y: number, X: number, Z: number }

export type AssetScale = { Y: number, X: number, Z: number }

--- Exhaustive model denoting all possible metadata fields of an asset
export type AssetMetaModelV1 = {
	rotation: AssetRotation,
	version: number,
	position: AssetPosition,
	order: number,
	puffiness: number,
	scale: AssetScale,
}

export type AccessoryRotationModel = { xRotation: number, zRotation: number, yRotation: number }

export type AccessoryRefinementModel = {
	rotation: AccessoryRotationModel,
	scale: AccessoryScaleModel,
	position: AccessoryPositionModel,
}

--- A model containing details about a user outfit
export type OutfitDetailsModel = {
	universeId: number,
	id: number,
	moderationStatus: string,
	bodyColors: BodyColorsModel,
	name: string,
	isEditable: boolean,
	playerAvatarType: string,
	outfitType: string,
	scale: ScaleModel,
	assets: { AssetModelV2 },
}

--- Success response class
export type AvatarApiSuccessResponse = { success: boolean }

export type AccessoryPositionModel = { xPosition: number, yPosition: number, zPosition: number }

--- A model that contains a list of asset ids
export type AssetIdListModel = { assetIds: { number } }

export type AssetRotation = { Y: number, X: number, Z: number }

--- A model containing details about avatar-related business rules
export type AvatarRulesModel = {
	accessoryRefinementTypes: { number },
	bundlesEnabledForUser: boolean,
	emotesEnabledForUser: boolean,
	proportionsAndBodyTypeEnabledForUser: boolean,
	wearableAssetTypes: { AssetTypeRulesModel },
	playerAvatarTypes: { number },
	scales: {},
	basicBodyColorsPalette: { BodyColorModel },
	minimumDeltaEBodyColorDifference: number,
	defaultClothingAssetLists: DefaultClothingAssets,
	bodyColorsPalette: { BodyColorModel },
	accessoryRefinementUpperBounds: {
		Badge: AccessoryRefinementModel,
		Code: AccessoryRefinementModel,
		Legs: AccessoryRefinementModel,
		Face: AccessoryRefinementModel,
		ShortsAccessory: AccessoryRefinementModel,
		HTML: AccessoryRefinementModel,
		Shirt: AccessoryRefinementModel,
		Mesh: AccessoryRefinementModel,
		HairAccessory: AccessoryRefinementModel,
		RightArm: AccessoryRefinementModel,
		Lua: AccessoryRefinementModel,
		Head: AccessoryRefinementModel,
		Video: AccessoryRefinementModel,
		FallAnimation: AccessoryRefinementModel,
		RightLeg: AccessoryRefinementModel,
		YouTubeVideo: AccessoryRefinementModel,
		LeftLeg: AccessoryRefinementModel,
		Decal: AccessoryRefinementModel,
		Package: AccessoryRefinementModel,
		Image: AccessoryRefinementModel,
		LeftShoeAccessory: AccessoryRefinementModel,
		Pants: AccessoryRefinementModel,
		Animation: AccessoryRefinementModel,
		RightShoeAccessory: AccessoryRefinementModel,
		DynamicHead: AccessoryRefinementModel,
		ShirtAccessory: AccessoryRefinementModel,
		Plugin: AccessoryRefinementModel,
		Model: AccessoryRefinementModel,
		WalkAnimation: AccessoryRefinementModel,
		App: AccessoryRefinementModel,
		Avatar: AccessoryRefinementModel,
		ClimbAnimation: AccessoryRefinementModel,
		FaceAccessory: AccessoryRefinementModel,
		Arms: AccessoryRefinementModel,
		CodeSnippet: AccessoryRefinementModel,
		Audio: AccessoryRefinementModel,
		AdsVideo: AccessoryRefinementModel,
		OtaUpdate: AccessoryRefinementModel,
		LeftArm: AccessoryRefinementModel,
		MoodAnimation: AccessoryRefinementModel,
		EyelashAccessory: AccessoryRefinementModel,
		EyebrowAccessory: AccessoryRefinementModel,
		MeshHiddenSurfaceRemoval: AccessoryRefinementModel,
		FontFamily: AccessoryRefinementModel,
		FontFace: AccessoryRefinementModel,
		TexturePack: AccessoryRefinementModel,
		DressSkirtAccessory: AccessoryRefinementModel,
		Place: AccessoryRefinementModel,
		SweaterAccessory: AccessoryRefinementModel,
		SolidModel: AccessoryRefinementModel,
		FrontAccessory: AccessoryRefinementModel,
		WaistAccessory: AccessoryRefinementModel,
		BackAccessory: AccessoryRefinementModel,
		ShoulderAccessory: AccessoryRefinementModel,
		EmoteAnimation: AccessoryRefinementModel,
		LocalizationTableTranslation: AccessoryRefinementModel,
		LocalizationTableManifest: AccessoryRefinementModel,
		PoseAnimation: AccessoryRefinementModel,
		GamePass: AccessoryRefinementModel,
		SwimAnimation: AccessoryRefinementModel,
		Hat: AccessoryRefinementModel,
		RunAnimation: AccessoryRefinementModel,
		JumpAnimation: AccessoryRefinementModel,
		TShirtAccessory: AccessoryRefinementModel,
		Text: AccessoryRefinementModel,
		DeathAnimation: AccessoryRefinementModel,
		PantsAccessory: AccessoryRefinementModel,
		NeckAccessory: AccessoryRefinementModel,
		JacketAccessory: AccessoryRefinementModel,
		IdleAnimation: AccessoryRefinementModel,
		MeshPart: AccessoryRefinementModel,
		Torso: AccessoryRefinementModel,
		GroupEmblem: AccessoryRefinementModel,
		Gear: AccessoryRefinementModel,
		TShirt: AccessoryRefinementModel,
	},
	accessoryRefinementLowerBounds: {
		Badge: AccessoryRefinementModel,
		Code: AccessoryRefinementModel,
		Legs: AccessoryRefinementModel,
		Face: AccessoryRefinementModel,
		ShortsAccessory: AccessoryRefinementModel,
		HTML: AccessoryRefinementModel,
		Shirt: AccessoryRefinementModel,
		Mesh: AccessoryRefinementModel,
		HairAccessory: AccessoryRefinementModel,
		RightArm: AccessoryRefinementModel,
		Lua: AccessoryRefinementModel,
		Head: AccessoryRefinementModel,
		Video: AccessoryRefinementModel,
		FallAnimation: AccessoryRefinementModel,
		RightLeg: AccessoryRefinementModel,
		YouTubeVideo: AccessoryRefinementModel,
		LeftLeg: AccessoryRefinementModel,
		Decal: AccessoryRefinementModel,
		Package: AccessoryRefinementModel,
		Image: AccessoryRefinementModel,
		LeftShoeAccessory: AccessoryRefinementModel,
		Pants: AccessoryRefinementModel,
		Animation: AccessoryRefinementModel,
		RightShoeAccessory: AccessoryRefinementModel,
		DynamicHead: AccessoryRefinementModel,
		ShirtAccessory: AccessoryRefinementModel,
		Plugin: AccessoryRefinementModel,
		Model: AccessoryRefinementModel,
		WalkAnimation: AccessoryRefinementModel,
		App: AccessoryRefinementModel,
		Avatar: AccessoryRefinementModel,
		ClimbAnimation: AccessoryRefinementModel,
		FaceAccessory: AccessoryRefinementModel,
		Arms: AccessoryRefinementModel,
		CodeSnippet: AccessoryRefinementModel,
		Audio: AccessoryRefinementModel,
		AdsVideo: AccessoryRefinementModel,
		OtaUpdate: AccessoryRefinementModel,
		LeftArm: AccessoryRefinementModel,
		MoodAnimation: AccessoryRefinementModel,
		EyelashAccessory: AccessoryRefinementModel,
		EyebrowAccessory: AccessoryRefinementModel,
		MeshHiddenSurfaceRemoval: AccessoryRefinementModel,
		FontFamily: AccessoryRefinementModel,
		FontFace: AccessoryRefinementModel,
		TexturePack: AccessoryRefinementModel,
		DressSkirtAccessory: AccessoryRefinementModel,
		Place: AccessoryRefinementModel,
		SweaterAccessory: AccessoryRefinementModel,
		SolidModel: AccessoryRefinementModel,
		FrontAccessory: AccessoryRefinementModel,
		WaistAccessory: AccessoryRefinementModel,
		BackAccessory: AccessoryRefinementModel,
		ShoulderAccessory: AccessoryRefinementModel,
		EmoteAnimation: AccessoryRefinementModel,
		LocalizationTableTranslation: AccessoryRefinementModel,
		LocalizationTableManifest: AccessoryRefinementModel,
		PoseAnimation: AccessoryRefinementModel,
		GamePass: AccessoryRefinementModel,
		SwimAnimation: AccessoryRefinementModel,
		Hat: AccessoryRefinementModel,
		RunAnimation: AccessoryRefinementModel,
		JumpAnimation: AccessoryRefinementModel,
		TShirtAccessory: AccessoryRefinementModel,
		Text: AccessoryRefinementModel,
		DeathAnimation: AccessoryRefinementModel,
		PantsAccessory: AccessoryRefinementModel,
		NeckAccessory: AccessoryRefinementModel,
		JacketAccessory: AccessoryRefinementModel,
		IdleAnimation: AccessoryRefinementModel,
		MeshPart: AccessoryRefinementModel,
		Torso: AccessoryRefinementModel,
		GroupEmblem: AccessoryRefinementModel,
		Gear: AccessoryRefinementModel,
		TShirt: AccessoryRefinementModel,
	},
}

--- A model that contains information about the max/mins for each scale
export type ScaleRulesModel = { min: number, increment: number, max: number }

--- A slim model for user outfits.
export type OutfitModel = { id: number, outfitType: string, name: string, isEditable: boolean }

--- A model containing details about a recent item
export type RecentItemModel = { type: number, name: string, id: number, assetType: AssetTypeModel, isEditable: boolean }

export type RecentItemModelPages = { data: { RecentItemModel }, total: number }

--- The game start info
export type GameStartInfoResponse = {
	universeAvatarCollisionType: string,
	universeAvatarBodyType: string,
	allowCustomAnimations: string,
	moderationStatus: string,
	message: string,
	universeAvatarMinScales: ScaleModel,
	gameAvatarType: string,
	universeAvatarAssetOverrides: { UniverseAvatarAssetOverrideResponseModel },
	jointPositioningType: string,
	universeAvatarMaxScales: ScaleModel,
}

--- A model container BrickColor ids for each body part.
export type BodyColorsModel = {
	headColorId: number,
	torsoColorId: number,
	rightArmColorId: number,
	leftLegColorId: number,
	rightLegColorId: number,
	leftArmColorId: number,
}

--- A model containing details about an avatar
export type AvatarModelV2 = {
	bodyColors: BodyColorsModel,
	scales: ScaleModel,
	defaultPantsApplied: boolean,
	defaultShirtApplied: boolean,
	playerAvatarType: number,
	emotes: { EmoteResponseModel },
	assets: { AssetModelV2 },
}

--- A model containing details about an avatar
export type AvatarModelV3 = {
	scales: ScaleModel,
	bodyColor3s: BodyColors3Model,
	defaultShirtApplied: boolean,
	playerAvatarType: number,
	emotes: { EmoteResponseModel },
	defaultPantsApplied: boolean,
	assets: { AssetModelV2 },
}

--- A model containing details needed to update or create an outfit
export type OutfitUpdateModelV2 = {
	bodyColors: BodyColorsModel,
	assets: { AssetWearModel },
	name: string,
	scale: ScaleModel,
	outfitType: number,
	playerAvatarType: string,
}

--- A model that contains a list of AssetWear models
export type WearRequestModel = { assets: { AssetWearModel } }

--- A model which contains
--- - an asset id
--- - AssetMetaModel
export type AssetWearModel = { id: number, meta: AssetMetaModelV1 }

export type BodyColorsModelV2 = {
	leftLegColor3: string,
	torsoColor3: string,
	rightLegColor3: string,
	rightArmColor3: string,
	headColor3: string,
	leftArmColor3: string,
}

--- A model containing RGB hex colors for each body part.
export type BodyColors3Model = {
	leftLegColor3: string,
	torsoColor3: string,
	rightLegColor3: string,
	rightArmColor3: string,
	headColor3: string,
	leftArmColor3: string,
}

--- A model containing details about a user outfit
export type OutfitDetailsModelV2 = {
	assets: { AssetModelV2 },
	bodyColor3s: BodyColors3Model,
	id: number,
	moderationStatus: string,
	bundleId: number,
	name: string,
	universeId: number,
	playerAvatarType: string,
	outfitType: string,
	isEditable: boolean,
	scale: ScaleModel,
}

--- A model containing details needed to update or create an outfit.
export type OutfitUpdateModelV3 = {
	assets: { AssetWearModel },
	name: string,
	scale: ScaleModel,
	outfitType: number,
	playerAvatarType: string,
	bodyColor3s: BodyColorsModelV2,
}

--- Returns the business rules related to avatars
local function rules(cookie: string?): Response<AvatarRulesModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/avatar-rules`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Sets the authenticated user's scales
local function setScales(request: ScaleModel, cookie: string): Response<boolean>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/set-scales`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).success
	end)
end

--- Requests the authenticated user's thumbnail be redrawn
local function redrawThumbnail(cookie: string): Response<EmptyResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/redraw-thumbnail`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Sets the authenticated user's player avatar type (e.g. R6 or R15).
local function setRigType(playerAvatarType: number, cookie: string): Response<boolean>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/set-player-avatar-type`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { playerAvatarType = playerAvatarType }),
	}):map(function(response)
		return serde.decode("json", response.body).success
	end)
end

--- Returns a list of recent items
--- Recent items can be Assets or Outfits
local function recentItems(recentItemListType: number, cookie: string): Response<RecentItemModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/recent-items/{recentItemListType}/list`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Returns metadata used by the avatar page of the website
local function metadata(cookie: string?): Response<AvatarMetadataModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/avatar/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a list of asset ids that the user is currently wearing
local function assetsWorn(userId: number, cookie: string?): Response<{ number }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/users/{userId}/currently-wearing`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).assetIds
	end)
end

--- Deletes the outfit
local function deleteOutfit(userOutfitId: number, cookie: string): Response<boolean>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/outfits/{userOutfitId}/delete`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).success
	end)
end

--- Returns details about the authenticated user's avatar
local function get(cookie: string): Response<AvatarModelV3>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/avatar`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Returns details about a specified user's avatar
local function of(userId: number, cookie: string?): Response<AvatarModelV3>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/users/{userId}/avatar`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Sets the authenticated user's body colors
local function setBodyColors(request: BodyColorsModelV2, cookie: string): Response<boolean>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v2/avatar/set-body-colors`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).success
	end)
end

--- Sets the avatar's current assets to the list
local function setAssetsWorn(assets: { AssetWearModel }, cookie: string): Response<WearResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v2/avatar/set-wearing-assets`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { assets = assets }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a list of outfits for the specified user.
local function outfitsOf(
	request: {
		userId: number,
		paginationToken: string?,
		outfitType: string?,
		page: number?,
		itemsPerPage: number?,
		isEditable: boolean?,
	},
	cookie: string?
): Response<OutfitModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/users/{request.userId}/outfits?paginationToken={request.paginationToken or ""}&outfitType={request.outfitType or ""}&page={request.page or ""}&itemsPerPage={request.itemsPerPage or ""}&isEditable={request.isEditable or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Updates the contents of an outfit.
local function updateOutfit(
	request: OutfitUpdateModelV3 & { userOutfitId: number },
	cookie: string
): Response<OutfitModel>
	return requestWithCsrfToken({
		method = "PATCH",
		url = `https://avatar.roblox.com/v3/outfits/{request.userOutfitId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Creates a new outfit.
local function createOutfit(request: OutfitUpdateModelV3, cookie: string): Response<OutfitModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v3/outfits/create`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets details about the contents of an outfit.
local function outfit(userOutfitId: number, cookie: string): Response<OutfitDetailsModelV2>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v3/outfits/{userOutfitId}/details`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

return {
	updateOutfit = updateOutfit,
	createOutfit = createOutfit,
	get = get,
	of = of,
	rules = rules,
	setBodyColors = setBodyColors,
	outfit = outfit,
	setScales = setScales,
	redrawThumbnail = redrawThumbnail,
	setRigType = setRigType,
	setAssetsWorn = setAssetsWorn,
	recentItems = recentItems,
	metadata = metadata,
	outfitsOf = outfitsOf,
	assetsWorn = assetsWorn,
	deleteOutfit = deleteOutfit,
}
