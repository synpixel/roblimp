local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [avatar.roblox.com](https://avatar.roblox.com)
--- @class avatar

--- Empty response, will be in WebAPI base soon
--- @interface EmptyResponse
--- @within avatar
export type EmptyResponse = {}

--- A model containing details about avatar-related business rules
--- @interface DefaultClothingAssets
--- .defaultPantAssetIds { number }
--- .defaultShirtAssetIds { number }
--- @within avatar
export type DefaultClothingAssets = { defaultPantAssetIds: { number }, defaultShirtAssetIds: { number } }

--- Filtered page response
--- @interface OutfitModelPages
--- .filteredCount number
--- .data { OutfitModel }
--- .total number
--- @within avatar
export type OutfitModelPages = { filteredCount: number, data: { OutfitModel }, total: number }

--- A model container BrickColor ids for each body part.
--- @interface BodyColorModel
--- .hexColor string
--- .name string
--- .brickColorId number
--- @within avatar
export type BodyColorModel = { hexColor: string, name: string, brickColorId: number }

--- A model that contains a playerAvatarType
--- @interface PlayerAvatarTypeModel
--- .playerAvatarType number
--- @within avatar
export type PlayerAvatarTypeModel = { playerAvatarType: number }

--- @interface ScaleModel
--- .bodyType number
--- .head number
--- .height number
--- .depth number
--- .proportion number
--- .width number
--- @within avatar
export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

--- A model for wear outfit responses
--- @interface WearResponseModel
--- .invalidAssets { AssetModelV2 }
--- .invalidAssetIds { number }
--- .success boolean
--- @within avatar
export type WearResponseModel = { invalidAssets: { AssetModelV2 }, invalidAssetIds: { number }, success: boolean }

--- @interface AccessoryScaleModel
--- .yScale number
--- .xScale number
--- .zScale number
--- @within avatar
export type AccessoryScaleModel = { yScale: number, xScale: number, zScale: number }

--- A model containing details about an asset
--- - V2: adds CurrentVersionId, AssetMetaModel
--- @interface AssetModelV2
--- .name string
--- .id number
--- .meta AssetMetaModelV1
--- .assetType AssetTypeModel
--- .currentVersionId number
--- @within avatar
export type AssetModelV2 = {
	name: string,
	id: number,
	meta: AssetMetaModelV1,
	assetType: AssetTypeModel,
	currentVersionId: number,
}

--- Response object representing a user's emote
--- @interface EmoteResponseModel
--- .assetId number
--- .assetName string
--- .position number
--- @within avatar
export type EmoteResponseModel = { assetId: number, assetName: string, position: number }

--- A model containing details about an asset type and its business rules
--- @interface AssetTypeRulesModel
--- .id number
--- .maxNumber number
--- .name string
--- @within avatar
export type AssetTypeRulesModel = { id: number, maxNumber: number, name: string }

--- A model containing details about an asset type
--- @interface AssetTypeModel
--- .id number
--- .name string
--- @within avatar
export type AssetTypeModel = { id: number, name: string }

--- A model containing website metadata for avatars
--- @interface AvatarMetadataModel
--- .isBodyTypeScaleOutOfTab boolean
--- .scaleWidthIncrement number
--- .isJustinUiChangesEnabled boolean
--- .scaleHeadIncrement number
--- .supportProportionAndBodyType boolean
--- .scaleHeightIncrement number
--- .isCategoryReorgEnabled boolean
--- .isAvatarScaleEmbeddedInTab boolean
--- .showDefaultClothingMessageOnPageLoad boolean
--- .enableDefaultClothingMessage boolean
--- .isLCCompletelyEnabled boolean
--- .isAvatarWearingApiCallsLockingOnFrontendEnabled boolean
--- .LCEnabledInEditorAndCatalog boolean
--- .isOutfitHandlingOnFrontendEnabled boolean
--- .scaleProportionIncrement number
--- .scaleBodyTypeIncrement number
--- .areThreeDeeThumbsEnabled boolean
--- @within avatar
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

--- @interface AssetPosition
--- .Y number
--- .X number
--- .Z number
--- @within avatar
export type AssetPosition = { Y: number, X: number, Z: number }

--- @interface UniverseAvatarAssetOverrideResponseModel
--- .assetID number
--- .assetTypeID number
--- .isPlayerChoice boolean
--- @within avatar
export type UniverseAvatarAssetOverrideResponseModel = { assetID: number, assetTypeID: number, isPlayerChoice: boolean }

--- @interface AssetScale
--- .Y number
--- .X number
--- .Z number
--- @within avatar
export type AssetScale = { Y: number, X: number, Z: number }

--- Exhaustive model denoting all possible metadata fields of an asset
--- @interface AssetMetaModelV1
--- .rotation AssetRotation
--- .version number
--- .position AssetPosition
--- .order number
--- .puffiness number
--- .scale AssetScale
--- @within avatar
export type AssetMetaModelV1 = {
	rotation: AssetRotation,
	version: number,
	position: AssetPosition,
	order: number,
	puffiness: number,
	scale: AssetScale,
}

--- @interface AccessoryRotationModel
--- .xRotation number
--- .zRotation number
--- .yRotation number
--- @within avatar
export type AccessoryRotationModel = { xRotation: number, zRotation: number, yRotation: number }

--- @interface AccessoryRefinementModel
--- .rotation AccessoryRotationModel
--- .scale AccessoryScaleModel
--- .position AccessoryPositionModel
--- @within avatar
export type AccessoryRefinementModel = {
	rotation: AccessoryRotationModel,
	scale: AccessoryScaleModel,
	position: AccessoryPositionModel,
}

--- A model containing details about a user outfit
--- @interface OutfitDetailsModel
--- .universeId number
--- .id number
--- .moderationStatus string
--- .bodyColors BodyColorsModel
--- .name string
--- .isEditable boolean
--- .playerAvatarType string
--- .outfitType string
--- .scale ScaleModel
--- .assets { AssetModelV2 }
--- @within avatar
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
--- @interface AvatarApiSuccessResponse
--- .success boolean
--- @within avatar
export type AvatarApiSuccessResponse = { success: boolean }

--- @interface AccessoryPositionModel
--- .xPosition number
--- .yPosition number
--- .zPosition number
--- @within avatar
export type AccessoryPositionModel = { xPosition: number, yPosition: number, zPosition: number }

--- A model that contains a list of asset ids
--- @interface AssetIdListModel
--- .assetIds { number }
--- @within avatar
export type AssetIdListModel = { assetIds: { number } }

--- @interface AssetRotation
--- .Y number
--- .X number
--- .Z number
--- @within avatar
export type AssetRotation = { Y: number, X: number, Z: number }

--- A model containing details about avatar-related business rules
--- @interface AvatarRulesModel
--- .accessoryRefinementTypes { number }
--- .bundlesEnabledForUser boolean
--- .emotesEnabledForUser boolean
--- .proportionsAndBodyTypeEnabledForUser boolean
--- .wearableAssetTypes { AssetTypeRulesModel }
--- .playerAvatarTypes { number }
--- .scales {}
--- .basicBodyColorsPalette { BodyColorModel }
--- .minimumDeltaEBodyColorDifference number
--- .defaultClothingAssetLists DefaultClothingAssets
--- .bodyColorsPalette { BodyColorModel }
--- .accessoryRefinementUpperBounds {Badge: AccessoryRefinementModel,Code: AccessoryRefinementModel,Legs: AccessoryRefinementModel,Face: AccessoryRefinementModel,ShortsAccessory: AccessoryRefinementModel,HTML: AccessoryRefinementModel,Shirt: AccessoryRefinementModel,Mesh: AccessoryRefinementModel,HairAccessory: AccessoryRefinementModel,RightArm: AccessoryRefinementModel,Lua: AccessoryRefinementModel,Head: AccessoryRefinementModel,Video: AccessoryRefinementModel,FallAnimation: AccessoryRefinementModel,RightLeg: AccessoryRefinementModel,YouTubeVideo: AccessoryRefinementModel,LeftLeg: AccessoryRefinementModel,Decal: AccessoryRefinementModel,Package: AccessoryRefinementModel,Image: AccessoryRefinementModel,LeftShoeAccessory: AccessoryRefinementModel,Pants: AccessoryRefinementModel,Animation: AccessoryRefinementModel,RightShoeAccessory: AccessoryRefinementModel,DynamicHead: AccessoryRefinementModel,ShirtAccessory: AccessoryRefinementModel,Plugin: AccessoryRefinementModel,Model: AccessoryRefinementModel,WalkAnimation: AccessoryRefinementModel,App: AccessoryRefinementModel,Avatar: AccessoryRefinementModel,ClimbAnimation: AccessoryRefinementModel,FaceAccessory: AccessoryRefinementModel,Arms: AccessoryRefinementModel,CodeSnippet: AccessoryRefinementModel,Audio: AccessoryRefinementModel,AdsVideo: AccessoryRefinementModel,OtaUpdate: AccessoryRefinementModel,LeftArm: AccessoryRefinementModel,MoodAnimation: AccessoryRefinementModel,EyelashAccessory: AccessoryRefinementModel,EyebrowAccessory: AccessoryRefinementModel,MeshHiddenSurfaceRemoval: AccessoryRefinementModel,FontFamily: AccessoryRefinementModel,FontFace: AccessoryRefinementModel,TexturePack: AccessoryRefinementModel,DressSkirtAccessory: AccessoryRefinementModel,Place: AccessoryRefinementModel,SweaterAccessory: AccessoryRefinementModel,SolidModel: AccessoryRefinementModel,FrontAccessory: AccessoryRefinementModel,WaistAccessory: AccessoryRefinementModel,BackAccessory: AccessoryRefinementModel,ShoulderAccessory: AccessoryRefinementModel,EmoteAnimation: AccessoryRefinementModel,LocalizationTableTranslation: AccessoryRefinementModel,LocalizationTableManifest: AccessoryRefinementModel,PoseAnimation: AccessoryRefinementModel,GamePass: AccessoryRefinementModel,SwimAnimation: AccessoryRefinementModel,Hat: AccessoryRefinementModel,RunAnimation: AccessoryRefinementModel,JumpAnimation: AccessoryRefinementModel,TShirtAccessory: AccessoryRefinementModel,Text: AccessoryRefinementModel,DeathAnimation: AccessoryRefinementModel,PantsAccessory: AccessoryRefinementModel,NeckAccessory: AccessoryRefinementModel,JacketAccessory: AccessoryRefinementModel,IdleAnimation: AccessoryRefinementModel,MeshPart: AccessoryRefinementModel,Torso: AccessoryRefinementModel,GroupEmblem: AccessoryRefinementModel,Gear: AccessoryRefinementModel,TShirt: AccessoryRefinementModel,}
--- .accessoryRefinementLowerBounds {Badge: AccessoryRefinementModel,Code: AccessoryRefinementModel,Legs: AccessoryRefinementModel,Face: AccessoryRefinementModel,ShortsAccessory: AccessoryRefinementModel,HTML: AccessoryRefinementModel,Shirt: AccessoryRefinementModel,Mesh: AccessoryRefinementModel,HairAccessory: AccessoryRefinementModel,RightArm: AccessoryRefinementModel,Lua: AccessoryRefinementModel,Head: AccessoryRefinementModel,Video: AccessoryRefinementModel,FallAnimation: AccessoryRefinementModel,RightLeg: AccessoryRefinementModel,YouTubeVideo: AccessoryRefinementModel,LeftLeg: AccessoryRefinementModel,Decal: AccessoryRefinementModel,Package: AccessoryRefinementModel,Image: AccessoryRefinementModel,LeftShoeAccessory: AccessoryRefinementModel,Pants: AccessoryRefinementModel,Animation: AccessoryRefinementModel,RightShoeAccessory: AccessoryRefinementModel,DynamicHead: AccessoryRefinementModel,ShirtAccessory: AccessoryRefinementModel,Plugin: AccessoryRefinementModel,Model: AccessoryRefinementModel,WalkAnimation: AccessoryRefinementModel,App: AccessoryRefinementModel,Avatar: AccessoryRefinementModel,ClimbAnimation: AccessoryRefinementModel,FaceAccessory: AccessoryRefinementModel,Arms: AccessoryRefinementModel,CodeSnippet: AccessoryRefinementModel,Audio: AccessoryRefinementModel,AdsVideo: AccessoryRefinementModel,OtaUpdate: AccessoryRefinementModel,LeftArm: AccessoryRefinementModel,MoodAnimation: AccessoryRefinementModel,EyelashAccessory: AccessoryRefinementModel,EyebrowAccessory: AccessoryRefinementModel,MeshHiddenSurfaceRemoval: AccessoryRefinementModel,FontFamily: AccessoryRefinementModel,FontFace: AccessoryRefinementModel,TexturePack: AccessoryRefinementModel,DressSkirtAccessory: AccessoryRefinementModel,Place: AccessoryRefinementModel,SweaterAccessory: AccessoryRefinementModel,SolidModel: AccessoryRefinementModel,FrontAccessory: AccessoryRefinementModel,WaistAccessory: AccessoryRefinementModel,BackAccessory: AccessoryRefinementModel,ShoulderAccessory: AccessoryRefinementModel,EmoteAnimation: AccessoryRefinementModel,LocalizationTableTranslation: AccessoryRefinementModel,LocalizationTableManifest: AccessoryRefinementModel,PoseAnimation: AccessoryRefinementModel,GamePass: AccessoryRefinementModel,SwimAnimation: AccessoryRefinementModel,Hat: AccessoryRefinementModel,RunAnimation: AccessoryRefinementModel,JumpAnimation: AccessoryRefinementModel,TShirtAccessory: AccessoryRefinementModel,Text: AccessoryRefinementModel,DeathAnimation: AccessoryRefinementModel,PantsAccessory: AccessoryRefinementModel,NeckAccessory: AccessoryRefinementModel,JacketAccessory: AccessoryRefinementModel,IdleAnimation: AccessoryRefinementModel,MeshPart: AccessoryRefinementModel,Torso: AccessoryRefinementModel,GroupEmblem: AccessoryRefinementModel,Gear: AccessoryRefinementModel,TShirt: AccessoryRefinementModel,}
--- @within avatar
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
--- @interface ScaleRulesModel
--- .min number
--- .increment number
--- .max number
--- @within avatar
export type ScaleRulesModel = { min: number, increment: number, max: number }

--- A slim model for user outfits.
--- @interface OutfitModel
--- .id number
--- .outfitType string
--- .name string
--- .isEditable boolean
--- @within avatar
export type OutfitModel = { id: number, outfitType: string, name: string, isEditable: boolean }

--- A model containing details about a recent item
--- @interface RecentItemModel
--- .type number
--- .name string
--- .id number
--- .assetType AssetTypeModel
--- .isEditable boolean
--- @within avatar
export type RecentItemModel = { type: number, name: string, id: number, assetType: AssetTypeModel, isEditable: boolean }

--- @interface RecentItemModelPages
--- .data { RecentItemModel }
--- .total number
--- @within avatar
export type RecentItemModelPages = { data: { RecentItemModel }, total: number }

--- The game start info
--- @interface GameStartInfoResponse
--- .universeAvatarCollisionType string
--- .universeAvatarBodyType string
--- .allowCustomAnimations string
--- .moderationStatus string
--- .message string
--- .universeAvatarMinScales ScaleModel
--- .gameAvatarType string
--- .universeAvatarAssetOverrides { UniverseAvatarAssetOverrideResponseModel }
--- .jointPositioningType string
--- .universeAvatarMaxScales ScaleModel
--- @within avatar
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
--- @interface BodyColorsModel
--- .headColorId number
--- .torsoColorId number
--- .rightArmColorId number
--- .leftLegColorId number
--- .rightLegColorId number
--- .leftArmColorId number
--- @within avatar
export type BodyColorsModel = {
	headColorId: number,
	torsoColorId: number,
	rightArmColorId: number,
	leftLegColorId: number,
	rightLegColorId: number,
	leftArmColorId: number,
}

--- A model containing details about an avatar
--- @interface AvatarModelV2
--- .bodyColors BodyColorsModel
--- .scales ScaleModel
--- .defaultPantsApplied boolean
--- .defaultShirtApplied boolean
--- .playerAvatarType number
--- .emotes { EmoteResponseModel }
--- .assets { AssetModelV2 }
--- @within avatar
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
--- @interface AvatarModelV3
--- .scales ScaleModel
--- .bodyColor3s BodyColors3Model
--- .defaultShirtApplied boolean
--- .playerAvatarType number
--- .emotes { EmoteResponseModel }
--- .defaultPantsApplied boolean
--- .assets { AssetModelV2 }
--- @within avatar
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
--- @interface OutfitUpdateModelV2
--- .bodyColors BodyColorsModel
--- .assets { AssetWearModel }
--- .name string
--- .scale ScaleModel
--- .outfitType number
--- .playerAvatarType string
--- @within avatar
export type OutfitUpdateModelV2 = {
	bodyColors: BodyColorsModel,
	assets: { AssetWearModel },
	name: string,
	scale: ScaleModel,
	outfitType: number,
	playerAvatarType: string,
}

--- A model that contains a list of AssetWear models
--- @interface WearRequestModel
--- .assets { AssetWearModel }
--- @within avatar
export type WearRequestModel = { assets: { AssetWearModel } }

--- @interface ApiEmptyResponseModel
--- @within avatar
export type ApiEmptyResponseModel = {}

--- A model which contains
--- - an asset id
--- - AssetMetaModel
--- @interface AssetWearModel
--- .id number
--- .meta AssetMetaModelV1
--- @within avatar
export type AssetWearModel = { id: number, meta: AssetMetaModelV1 }

--- @interface BodyColorsModelV2
--- .leftLegColor3 string
--- .torsoColor3 string
--- .rightLegColor3 string
--- .rightArmColor3 string
--- .headColor3 string
--- .leftArmColor3 string
--- @within avatar
export type BodyColorsModelV2 = {
	leftLegColor3: string,
	torsoColor3: string,
	rightLegColor3: string,
	rightArmColor3: string,
	headColor3: string,
	leftArmColor3: string,
}

--- A model containing RGB hex colors for each body part.
--- @interface BodyColors3Model
--- .leftLegColor3 string
--- .torsoColor3 string
--- .rightLegColor3 string
--- .rightArmColor3 string
--- .headColor3 string
--- .leftArmColor3 string
--- @within avatar
export type BodyColors3Model = {
	leftLegColor3: string,
	torsoColor3: string,
	rightLegColor3: string,
	rightArmColor3: string,
	headColor3: string,
	leftArmColor3: string,
}

--- A model containing details about a user outfit
--- @interface OutfitDetailsModelV2
--- .assets { AssetModelV2 }
--- .bodyColor3s BodyColors3Model
--- .id number
--- .moderationStatus string
--- .bundleId number
--- .name string
--- .universeId number
--- .playerAvatarType string
--- .outfitType string
--- .isEditable boolean
--- .scale ScaleModel
--- @within avatar
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
--- @interface OutfitUpdateModelV3
--- .assets { AssetWearModel }
--- .name string
--- .scale ScaleModel
--- .outfitType number
--- .playerAvatarType string
--- .bodyColor3s BodyColorsModelV2
--- @within avatar
export type OutfitUpdateModelV3 = {
	assets: { AssetWearModel },
	name: string,
	scale: ScaleModel,
	outfitType: number,
	playerAvatarType: string,
	bodyColor3s: BodyColorsModelV2,
}

--- Returns the business rules related to avatars
--- @within avatar
local function rules(cookie: string?): AvatarRulesModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/avatar-rules`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets the authenticated user's scales
--- @within avatar
local function setScales(request: ScaleModel, cookie: string): boolean
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/set-scales`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).success
end

--- Requests the authenticated user's thumbnail be redrawn
--- @within avatar
local function redrawThumbnail(cookie: string): EmptyResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/redraw-thumbnail`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets the authenticated user's player avatar type (e.g. R6 or R15).
--- @within avatar
local function setRigType(playerAvatarType: number, cookie: string): boolean
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/avatar/set-player-avatar-type`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { playerAvatarType = playerAvatarType }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).success
end

--- Returns a list of recent items
--- Recent items can be Assets or Outfits
--- @within avatar
local function recentItems(recentItemListType: number, cookie: string): RecentItemModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/recent-items/{recentItemListType}/list`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns metadata used by the avatar page of the website
--- @within avatar
local function metadata(cookie: string?): AvatarMetadataModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/avatar/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of asset ids that the user is currently wearing
--- @within avatar
local function assetsWorn(userId: number, cookie: string?): { number }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v1/users/{userId}/currently-wearing`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).assetIds
end

--- Deletes the outfit
--- @within avatar
local function deleteOutfit(userOutfitId: number, cookie: string): boolean
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v1/outfits/{userOutfitId}/delete`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).success
end

--- Returns details about the authenticated user's avatar
--- @within avatar
local function get(cookie: string): AvatarModelV3
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/avatar`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns details about a specified user's avatar
--- @within avatar
local function of(userId: number, cookie: string?): AvatarModelV3
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/users/{userId}/avatar`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets the authenticated user's body colors
--- @within avatar
local function setBodyColors(request: BodyColorsModelV2, cookie: string): boolean
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v2/avatar/set-body-colors`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).success
end

--- Sets the avatar's current assets to the list
--- @within avatar
local function setAssetsWorn(assets: { AssetWearModel }, cookie: string): WearResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v2/avatar/set-wearing-assets`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { assets = assets }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of outfits for the specified user.
--- @within avatar
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
): OutfitModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v2/avatar/users/{request.userId}/outfits?paginationToken={request.paginationToken or ""}&outfitType={request.outfitType or ""}&page={request.page or ""}&itemsPerPage={request.itemsPerPage or ""}&isEditable={request.isEditable or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the contents of an outfit.
--- @within avatar
local function updateOutfit(request: OutfitUpdateModelV3 & { userOutfitId: number }, cookie: string): OutfitModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://avatar.roblox.com/v3/outfits/{request.userOutfitId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates a new outfit.
--- @within avatar
local function createOutfit(request: OutfitUpdateModelV3, cookie: string): OutfitModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://avatar.roblox.com/v3/outfits/create`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets details about the contents of an outfit.
--- @within avatar
local function outfit(userOutfitId: number, cookie: string): OutfitDetailsModelV2
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://avatar.roblox.com/v3/outfits/{userOutfitId}/details`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
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
