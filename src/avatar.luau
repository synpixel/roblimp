local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- Empty response, will be in WebAPI base soon
export type EmptyResponse = {}

--- A model containing details about avatar-related business rules
export type DefaultClothingAssets = { defaultPantAssetIds: { number }, defaultShirtAssetIds: { number } }

--- A model container BrickColor ids for each body part.
export type BodyColorModel = { hexColor: string, name: string, brickColorId: number }

--- A model that contains a playerAvatarType
export type PlayerAvatarTypeModel = { playerAvatarType: number }

--- A model for wear outfit responses
export type WearResponseModel = { invalidAssets: { AssetModelV2 }, invalidAssetIds: { number }, success: boolean }

--- A model containing details about an asset
--- - V2: adds CurrentVersionId, AssetMetaModel
export type AssetModelV2 = {
	name: string,
	id: number,
	meta: AssetMetaModelV1,
	assetType: AssetTypeModel,
	currentVersionId: number,
}

--- A model containing details about an asset type and its business rules
export type AssetTypeRulesModel = { id: number, maxNumber: number, name: string }

--- A model containing details about an asset type
export type AssetTypeModel = { id: number, name: string }

--- Exhaustive model denoting all possible metadata fields of an asset
export type AssetMetaModelV1 = {
	rotation: AssetRotation,
	version: number,
	position: AssetPosition,
	order: number,
	puffiness: number,
	scale: AssetScale,
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

--- A model container BrickColor ids for each body part.
export type BodyColorsModel = {
	headColorId: number,
	torsoColorId: number,
	rightArmColorId: number,
	leftLegColorId: number,
	rightLegColorId: number,
	leftArmColorId: number,
}

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

--- A model containing details needed to update or create an outfit
export type OutfitUpdateModelV1 = {
	bodyColors: BodyColorsModel,
	name: string,
	assetIds: { number },
	outfitType: number,
	playerAvatarType: string,
	scale: ScaleModel,
}

--- <no description>
export type RecentItemModelPages = { data: { RecentItemModel }, total: number }

--- Filtered page response
export type OutfitModelPages = { filteredCount: number, data: { OutfitModel }, total: number }

--- <no description>
export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

--- <no description>
export type AccessoryScaleModel = { yScale: number, xScale: number, zScale: number }

--- <no description>
export type AccessoryRefinementModel = {
	rotation: AccessoryRotationModel,
	scale: AccessoryScaleModel,
	position: AccessoryPositionModel,
}

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

--- <no description>
export type AssetScale = { Y: number, X: number, Z: number }

--- <no description>
export type UniverseAvatarAssetOverrideResponseModel = { assetID: number, assetTypeID: number, isPlayerChoice: boolean }

--- A model that contains information about the max/mins for each scale
export type ScaleRulesModel = { min: number, increment: number, max: number }

--- Success response class
export type AvatarApiSuccessResponse = { success: boolean }

--- A model that contains a list of asset ids
export type AssetIdListModel = { assetIds: { number } }

--- <no description>
export type AssetRotation = { Y: number, X: number, Z: number }

--- <no description>
export type AccessoryPositionModel = { xPosition: number, yPosition: number, zPosition: number }

--- <no description>
export type AssetPosition = { Y: number, X: number, Z: number }

--- <no description>
export type AccessoryRotationModel = { xRotation: number, zRotation: number, yRotation: number }

--- A model containing details about a recent item
export type RecentItemModel = { type: number, name: string, id: number, assetType: AssetTypeModel, isEditable: boolean }

--- A slim model for user outfits.
export type OutfitModel = { id: number, outfitType: string, name: string, isEditable: boolean }

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

--- Response object representing a user's emote
export type EmoteResponseModel = { assetId: number, assetName: string, position: number }

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

--- <no description>
export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

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

--- A model containing details about an asset
--- - V2: adds CurrentVersionId, AssetMetaModel
export type AssetModelV2 = {
	name: string,
	id: number,
	meta: AssetMetaModelV1,
	assetType: AssetTypeModel,
	currentVersionId: number,
}

--- <no description>
export type AssetPosition = { Y: number, X: number, Z: number }

--- A model containing details about an asset type
export type AssetTypeModel = { id: number, name: string }

--- <no description>
export type ApiEmptyResponseModel = {}

--- A model which contains
--- - an asset id
--- - AssetMetaModel
export type AssetWearModel = { id: number, meta: AssetMetaModelV1 }

--- Exhaustive model denoting all possible metadata fields of an asset
export type AssetMetaModelV1 = {
	rotation: AssetRotation,
	version: number,
	position: AssetPosition,
	order: number,
	puffiness: number,
	scale: AssetScale,
}

--- Success response class
export type AvatarApiSuccessResponse = { success: boolean }

--- A model container BrickColor ids for each body part.
export type BodyColorsModel = {
	headColorId: number,
	torsoColorId: number,
	rightArmColorId: number,
	leftLegColorId: number,
	rightLegColorId: number,
	leftArmColorId: number,
}

--- <no description>
export type AssetRotation = { Y: number, X: number, Z: number }

--- Response object representing a user's emote
export type EmoteResponseModel = { assetId: number, assetName: string, position: number }

--- <no description>
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

--- <no description>
export type AssetScale = { Y: number, X: number, Z: number }

--- A model for wear outfit responses
export type WearResponseModel = { invalidAssets: { AssetModelV2 }, invalidAssetIds: { number }, success: boolean }

--- A slim model for user outfits.
export type OutfitModel = { id: number, outfitType: string, name: string, isEditable: boolean }

--- Avatar page response.
export type OutfitModelPages = { data: { OutfitModel }, paginationToken: string }

--- Exhaustive model denoting all possible metadata fields of an asset
export type AssetMetaModelV1 = {
	rotation: AssetRotation,
	version: number,
	position: AssetPosition,
	order: number,
	puffiness: number,
	scale: AssetScale,
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

--- <no description>
export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

--- <no description>
export type AssetRotation = { Y: number, X: number, Z: number }

--- A model containing details about an asset
--- - V2: adds CurrentVersionId, AssetMetaModel
export type AssetModelV2 = {
	name: string,
	id: number,
	meta: AssetMetaModelV1,
	assetType: AssetTypeModel,
	currentVersionId: number,
}

--- <no description>
export type BodyColorsModelV2 = {
	leftLegColor3: string,
	torsoColor3: string,
	rightLegColor3: string,
	rightArmColor3: string,
	headColor3: string,
	leftArmColor3: string,
}

--- <no description>
export type AssetPosition = { Y: number, X: number, Z: number }

--- A model containing details about an asset type
export type AssetTypeModel = { id: number, name: string }

--- <no description>
export type AssetScale = { Y: number, X: number, Z: number }

--- A slim model for user outfits.
export type OutfitModel = { id: number, outfitType: string, name: string, isEditable: boolean }

--- A model containing RGB hex colors for each body part.
export type BodyColors3Model = {
	leftLegColor3: string,
	torsoColor3: string,
	rightLegColor3: string,
	rightArmColor3: string,
	headColor3: string,
	leftArmColor3: string,
}

--- A model which contains
--- - an asset id
--- - AssetMetaModel
export type AssetWearModel = { id: number, meta: AssetMetaModelV1 }

--- Returns the business rules related to avatars
local function getAvatarRules(): AvatarRulesModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/avatar-rules`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets the authenticated user's scales
local function setScales(with: ScaleModel & { cookie: string }): AvatarApiSuccessResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/set-scales`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Requests the authenticated user's thumbnail be redrawn
local function redrawThumbnail(with: { cookie: string }): EmptyResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/redraw-thumbnail`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets the authenticated user's player avatar type (e.g. R6 or R15).
local function setRigType(with: PlayerAvatarTypeModel & { cookie: string }): AvatarApiSuccessResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/set-player-avatar-type`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns a list of recent items
--- Recent items can be Assets or Outfits
local function getRecentItems(with: { recentItemListType: number, cookie: string }): RecentItemModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/recent-items/{with.recentItemListType}/list`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns metadata used by the avatar page of the website
local function getMetadata(): AvatarMetadataModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/avatar/metadata`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of asset ids that the user is currently wearing
local function getAssetsWorn(with: { userId: number }): AssetIdListModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/users/{with.userId}/currently-wearing`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes the outfit
local function deleteOutfit(with: { userOutfitId: number, cookie: string }): AvatarApiSuccessResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/outfits/{with.userOutfitId}/delete`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns details about the authenticated user's avatar
local function getAvatar(with: { cookie: string }): AvatarModelV3
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/avatar`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns details about a specified user's avatar
local function getAvatarOf(with: { userId: number }): AvatarModelV3
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/users/{with.userId}/avatar`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets the authenticated user's body colors
local function setBodyColors(with: BodyColorsModelV2 & { cookie: string }): AvatarApiSuccessResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v2/avatar/set-body-colors`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets the avatar's current assets to the list
local function setAssetsWorn(with: WearRequestModel & { cookie: string }): WearResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v2/avatar/set-wearing-assets`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of outfits for the specified user.
local function getOutfitsOf(with: {
	userId: number,
	paginationToken: string?,
	outfitType: string?,
	page: number?,
	itemsPerPage: number?,
	isEditable: boolean?,
}): OutfitModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/users/{with.userId}/outfits?paginationToken={with.paginationToken or ""}&outfitType={with.outfitType or ""}&page={with.page or ""}&itemsPerPage={with.itemsPerPage or ""}&isEditable={with.isEditable or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the contents of an outfit.
local function updateOutfit(with: OutfitUpdateModelV3 & { userOutfitId: number, cookie: string }): OutfitModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://avatar.roblox.com/v3/outfits/{with.userOutfitId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates a new outfit.
local function createOutfit(with: OutfitUpdateModelV3 & { cookie: string }): OutfitModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v3/outfits/create`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets details about the contents of an outfit.
local function getOufitDetails(with: { userOutfitId: number }): OutfitDetailsModelV2
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v3/outfits/{with.userOutfitId}/details`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	updateOutfit = updateOutfit,
	createOutfit = createOutfit,
	getAvatar = getAvatar,
	getAvatarOf = getAvatarOf,
	getAvatarRules = getAvatarRules,
	setBodyColors = setBodyColors,
	getOufitDetails = getOufitDetails,
	setScales = setScales,
	redrawThumbnail = redrawThumbnail,
	setRigType = setRigType,
	setAssetsWorn = setAssetsWorn,
	getRecentItems = getRecentItems,
	getMetadata = getMetadata,
	getOutfitsOf = getOutfitsOf,
	getAssetsWorn = getAssetsWorn,
	deleteOutfit = deleteOutfit,
}
