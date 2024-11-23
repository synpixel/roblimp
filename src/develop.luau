local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [develop.roblox.com](https://develop.roblox.com)
--- @class develop

--- @interface UniverseTeamCreateSettingsModelPages
--- .data { UniverseTeamCreateSettingsModel }
--- @within develop
export type UniverseTeamCreateSettingsModelPages = { data: { UniverseTeamCreateSettingsModel } }

--- Model for private server details responses from the UniverseSettings controller.
--- @interface PrivateServerDetailsResponse
--- .isEnabled boolean
--- .activeServersCount number
--- .price number
--- .activeSubscriptionsCount number
--- @within develop
export type PrivateServerDetailsResponse = {
	isEnabled: boolean,
	activeServersCount: number,
	price: number,
	activeSubscriptionsCount: number,
}

--- @interface GameTemplateModelPages
--- .data { GameTemplateModel }
--- @within develop
export type GameTemplateModelPages = { data: { GameTemplateModel } }

--- Represents a game template in API endpoint responses.
--- @interface GameTemplateModel
--- .hasTutorials boolean
--- .universe UniverseModel
--- .gameTemplateType string
--- @within develop
export type GameTemplateModel = { hasTutorials: boolean, universe: UniverseModel, gameTemplateType: string }

--- Represents information about a plugin.
--- @interface PluginResponse
--- .versionId number
--- .name string
--- .updated string
--- .id number
--- .commentsEnabled boolean
--- .created string
--- .description string
--- @within develop
export type PluginResponse = {
	versionId: number,
	name: string,
	updated: string,
	id: number,
	commentsEnabled: boolean,
	created: string,
	description: string,
}

--- Team create settings
--- @interface TeamCreateSettingsResponse
--- .isEnabled boolean
--- @within develop
export type TeamCreateSettingsResponse = { isEnabled: boolean }

--- A model containing information about a place
--- @interface IPlaceModel
--- @within develop
export type IPlaceModel = {}

--- Represents a universe in API endpoint results.
--- @interface UniverseModel
--- .created string
--- .description string
--- .creatorTargetId number
--- .id number
--- .isActive boolean
--- .privacyType string
--- .name string
--- .updated string
--- .isArchived boolean
--- .rootPlaceId number
--- .creatorName string
--- .creatorType string
--- @within develop
export type UniverseModel = {
	created: string,
	description: string,
	creatorTargetId: number,
	id: number,
	isActive: boolean,
	privacyType: string,
	name: string,
	updated: string,
	isArchived: boolean,
	rootPlaceId: number,
	creatorName: string,
	creatorType: string,
}

--- A model containing information about a universe permissions
--- @interface UniversePermissionsModel
--- .canManage boolean
--- .canCloudEdit boolean
--- @within develop
export type UniversePermissionsModel = { canManage: boolean, canCloudEdit: boolean }

--- A model containing information about a place
--- @interface PlaceModel
--- .id number
--- .universeId number
--- .name string
--- .description string
--- @within develop
export type PlaceModel = { id: number, universeId: number, name: string, description: string }

--- @interface Int64Pages
--- .CursorRecipe string
--- .ExclusiveStartKeyInfo Int64Pages
--- @within develop
export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

--- @interface IPlaceModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { IPlaceModel }
--- @within develop
export type IPlaceModelPages = { nextPageCursor: string, previousPageCursor: string, data: { IPlaceModel } }

--- @interface PluginResponsePages
--- .data { PluginResponse }
--- @within develop
export type PluginResponsePages = { data: { PluginResponse } }

--- @interface UniverseModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { UniverseModel }
--- @within develop
export type UniverseModelPages = { nextPageCursor: string, previousPageCursor: string, data: { UniverseModel } }

--- @interface ApiEmptyResponseModel
--- @within develop
export type ApiEmptyResponseModel = {}

--- A model containing information about a universe permissions
--- @interface UniverseIdPermissionsModel
--- .canManage boolean
--- .universeId number
--- .canCloudEdit boolean
--- @within develop
export type UniverseIdPermissionsModel = { canManage: boolean, universeId: number, canCloudEdit: boolean }

--- @interface AssetVotingModelPages
--- .data { AssetVotingModel }
--- @within develop
export type AssetVotingModelPages = { data: { AssetVotingModel } }

--- @interface StartIndexCursor
--- .discriminator string
--- .count number
--- .startIndex number
--- @within develop
export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- Team create settings of a universe
--- @interface UniverseTeamCreateSettingsModel
--- .id number
--- .isEnabled boolean
--- @within develop
export type UniverseTeamCreateSettingsModel = { id: number, isEnabled: boolean }

--- Asset voting information
--- @interface AssetVotingModel
--- .canUserVote boolean
--- .assetId number
--- .hasUserVoted boolean
--- .reasonForNotAbleToVote string
--- .upVotes number
--- .downVotes number
--- .shouldShowVotes boolean
--- @within develop
export type AssetVotingModel = {
	canUserVote: boolean,
	assetId: number,
	hasUserVoted: boolean,
	reasonForNotAbleToVote: string,
	upVotes: number,
	downVotes: number,
	shouldShowVotes: boolean,
}

--- Model for UniverseSettings patch requests
--- @interface UniverseSettingsRequest
--- .isRewardedOnDemandAdsAllowed boolean
--- .universeCollisionType number
--- .isMeshTextureApiAccessAllowed boolean
--- .price number
--- .isFriendsOnly boolean
--- .genre number
--- .universeAvatarType number
--- .universeScaleType number
--- .playableDevices { number }
--- .name string
--- .isForSale boolean
--- .isArchived boolean
--- .universeBodyType number
--- .universeJointPositioningType number
--- .universeAnimationType number
--- @within develop
export type UniverseSettingsRequest = {
	isRewardedOnDemandAdsAllowed: boolean,
	universeCollisionType: number,
	isMeshTextureApiAccessAllowed: boolean,
	price: number,
	isFriendsOnly: boolean,
	genre: number,
	universeAvatarType: number,
	universeScaleType: number,
	playableDevices: { number },
	name: string,
	isForSale: boolean,
	isArchived: boolean,
	universeBodyType: number,
	universeJointPositioningType: number,
	universeAnimationType: number,
}

--- @interface SkinnyUserResponse
--- .id number
--- .name string
--- .displayName string
--- @within develop
export type SkinnyUserResponse = { id: number, name: string, displayName: string }

--- A model containing information about a group
--- @interface GroupModel
--- .id number
--- .name string
--- @within develop
export type GroupModel = { id: number, name: string }

--- Request model for a TeamCreate membership
--- @interface TeamCreateMembershipRequest
--- .userId number
--- @within develop
export type TeamCreateMembershipRequest = { userId: number }

--- A model containing information about a place to be configured
--- @interface PlaceConfigurationModel
--- .name string
--- .description string
--- @within develop
export type PlaceConfigurationModel = { name: string, description: string }

--- @interface UniverseIdPermissionsModelPages
--- .data { UniverseIdPermissionsModel }
--- @within develop
export type UniverseIdPermissionsModelPages = { data: { UniverseIdPermissionsModel } }

--- @interface GroupModelPages
--- .data { GroupModel }
--- @within develop
export type GroupModelPages = { data: { GroupModel } }

--- A request model for updating a plugin.
--- @interface UpdatePluginRequest
--- .commentsEnabled boolean
--- .name string
--- .description string
--- @within develop
export type UpdatePluginRequest = { commentsEnabled: boolean, name: string, description: string }

--- Team create settings request
--- @interface UpdateTeamCreateSettingsRequest
--- .isEnabled boolean
--- @within develop
export type UpdateTeamCreateSettingsRequest = { isEnabled: boolean }

--- Model for UniverseSettings controller responses
--- @interface UniverseSettingsResponse
--- .universeCollisionType number
--- .price number
--- .genre number
--- .isMeshTextureApiAccessAllowed boolean
--- .isFriendsOnly boolean
--- .privacyType string
--- .universeBodyType number
--- .isStudioAccessToApisAllowed boolean
--- .allowPrivateServers boolean
--- .universeScaleType number
--- .playableDevices { number }
--- .universeAvatarType number
--- .isRewardedOnDemandAdsAllowed boolean
--- .isArchived boolean
--- .name string
--- .isForSale boolean
--- .privateServerPrice number
--- .id number
--- .universeJointPositioningType number
--- .universeAnimationType number
--- @within develop
export type UniverseSettingsResponse = {
	universeCollisionType: number,
	price: number,
	genre: number,
	isMeshTextureApiAccessAllowed: boolean,
	isFriendsOnly: boolean,
	privacyType: string,
	universeBodyType: number,
	isStudioAccessToApisAllowed: boolean,
	allowPrivateServers: boolean,
	universeScaleType: number,
	playableDevices: { number },
	universeAvatarType: number,
	isRewardedOnDemandAdsAllowed: boolean,
	isArchived: boolean,
	name: string,
	isForSale: boolean,
	privateServerPrice: number,
	id: number,
	universeJointPositioningType: number,
	universeAnimationType: number,
}

--- @interface SkinnyUserResponsePages
--- .data { SkinnyUserResponse }
--- @within develop
export type SkinnyUserResponsePages = { data: { SkinnyUserResponse } }

--- Model for UniverseSettings controller responses
--- @interface UniverseSettingsResponseV2
--- .description string
--- .price number
--- .genre number
--- .isMeshTextureApiAccessAllowed boolean
--- .isFriendsOnly boolean
--- .universeAvatarMinScales ScaleModel
--- .optInRegions { UniverseModerationPolicyStatus }
--- .universeAvatarAssetOverrides { UniverseAvatarAssetOverrideResponseModel }
--- .permissions UniversePluginPermissions
--- .studioAccessToApisAllowed boolean
--- .universeAvatarMaxScales ScaleModel
--- .allowPrivateServers boolean
--- .id number
--- .playableDevices { number }
--- .universeAvatarType number
--- .isRewardedOnDemandAdsAllowed boolean
--- .isArchived boolean
--- .name string
--- .isForSale boolean
--- .privateServerPrice number
--- .universeCollisionType number
--- .universeJointPositioningType number
--- .universeAnimationType number
--- @within develop
export type UniverseSettingsResponseV2 = {
	description: string,
	price: number,
	genre: number,
	isMeshTextureApiAccessAllowed: boolean,
	isFriendsOnly: boolean,
	universeAvatarMinScales: ScaleModel,
	optInRegions: { UniverseModerationPolicyStatus },
	universeAvatarAssetOverrides: { UniverseAvatarAssetOverrideResponseModel },
	permissions: UniversePluginPermissions,
	studioAccessToApisAllowed: boolean,
	universeAvatarMaxScales: ScaleModel,
	allowPrivateServers: boolean,
	id: number,
	playableDevices: { number },
	universeAvatarType: number,
	isRewardedOnDemandAdsAllowed: boolean,
	isArchived: boolean,
	name: string,
	isForSale: boolean,
	privateServerPrice: number,
	universeCollisionType: number,
	universeJointPositioningType: number,
	universeAnimationType: number,
}

--- A model containing information about a place
--- @interface PlaceModelV2
--- .universeId number
--- .socialSlotType string
--- .id number
--- .isAllGenresAllowed boolean
--- .description string
--- .isRootPlace boolean
--- .maxPlayerCount number
--- .customSocialSlotsCount number
--- .allowCopying boolean
--- .name string
--- .currentSavedVersion number
--- .maxPlayersAllowed number
--- .allowedGearTypes { number }
--- @within develop
export type PlaceModelV2 = {
	universeId: number,
	socialSlotType: string,
	id: number,
	isAllGenresAllowed: boolean,
	description: string,
	isRootPlace: boolean,
	maxPlayerCount: number,
	customSocialSlotsCount: number,
	allowCopying: boolean,
	name: string,
	currentSavedVersion: number,
	maxPlayersAllowed: number,
	allowedGearTypes: { number },
}

--- @interface StringPages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within develop
export type StringPages = { SortOrder: number, PagingDirection: number, Count: number }

--- Represents a universe moderation policy status
--- @interface UniverseModerationPolicyStatus
--- .status string
--- .region number
--- @within develop
export type UniverseModerationPolicyStatus = { status: string, region: number }

--- A model containing information about a place to be configured
--- @interface PlaceConfigurationModelV2
--- .customSocialSlotsCount number
--- .maxPlayerCount number
--- .name string
--- .allowCopying boolean
--- .allowedGearTypes { string }
--- .isAllGenresAllowed boolean
--- .socialSlotType string
--- .description string
--- @within develop
export type PlaceConfigurationModelV2 = {
	customSocialSlotsCount: number,
	maxPlayerCount: number,
	name: string,
	allowCopying: boolean,
	allowedGearTypes: { string },
	isAllGenresAllowed: boolean,
	socialSlotType: string,
	description: string,
}

--- @interface AssetVersionPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { AssetVersion }
--- @within develop
export type AssetVersionPages = { nextPageCursor: string, previousPageCursor: string, data: { AssetVersion } }

--- Model of an asset version.
--- @interface AssetVersion
--- .creatingUniverseId number
--- .creatorTargetId number
--- .Id number
--- .assetId number
--- .assetVersionNumber number
--- .isPublished boolean
--- .isEqualToCurrentPublishedVersion boolean
--- .created string
--- .creatorType string
--- @within develop
export type AssetVersion = {
	creatingUniverseId: number,
	creatorTargetId: number,
	Id: number,
	assetId: number,
	assetVersionNumber: number,
	isPublished: boolean,
	isEqualToCurrentPublishedVersion: boolean,
	created: string,
	creatorType: string,
}

--- @interface UniverseAvatarAssetOverrideResponseModel
--- .assetID number
--- .assetTypeID number
--- .isPlayerChoice boolean
--- @within develop
export type UniverseAvatarAssetOverrideResponseModel = { assetID: number, assetTypeID: number, isPlayerChoice: boolean }

--- @interface ScaleModel
--- .bodyType number
--- .head number
--- .height number
--- .depth number
--- .proportion number
--- .width number
--- @within develop
export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

--- @interface UniversePluginPermissions
--- .IsThirdPartyTeleportAllowed boolean
--- .IsThirdPartyPurchaseAllowed boolean
--- .IsThirdPartyAssetAllowed boolean
--- @within develop
export type UniversePluginPermissions = {
	IsThirdPartyTeleportAllowed: boolean,
	IsThirdPartyPurchaseAllowed: boolean,
	IsThirdPartyAssetAllowed: boolean,
}

--- Model for UniverseSettings patch requests
--- @interface UniverseSettingsRequestV2
--- .description string
--- .price number
--- .genre number
--- .isMeshTextureApiAccessAllowed boolean
--- .isFriendsOnly boolean
--- .universeAvatarMinScales ScaleModel
--- .optInRegions { number }
--- .universeAvatarAssetOverrides { UniverseAvatarAssetOverrideResponseModel }
--- .isArchived boolean
--- .permissions UniversePluginPermissions
--- .studioAccessToApisAllowed boolean
--- .allowPrivateServers boolean
--- .universeAvatarMaxScales ScaleModel
--- .optOutRegions { number }
--- .universeAvatarType number
--- .isRewardedOnDemandAdsAllowed boolean
--- .playableDevices { number }
--- .name string
--- .isForSale boolean
--- .privateServerPrice number
--- .universeCollisionType number
--- .universeJointPositioningType number
--- .universeAnimationType number
--- @within develop
export type UniverseSettingsRequestV2 = {
	description: string,
	price: number,
	genre: number,
	isMeshTextureApiAccessAllowed: boolean,
	isFriendsOnly: boolean,
	universeAvatarMinScales: ScaleModel,
	optInRegions: { number },
	universeAvatarAssetOverrides: { UniverseAvatarAssetOverrideResponseModel },
	isArchived: boolean,
	permissions: UniversePluginPermissions,
	studioAccessToApisAllowed: boolean,
	allowPrivateServers: boolean,
	universeAvatarMaxScales: ScaleModel,
	optOutRegions: { number },
	universeAvatarType: number,
	isRewardedOnDemandAdsAllowed: boolean,
	playableDevices: { number },
	name: string,
	isForSale: boolean,
	privateServerPrice: number,
	universeCollisionType: number,
	universeJointPositioningType: number,
	universeAnimationType: number,
}

--- Activates a universes.
--- @within develop
local function activate(universeId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://develop.roblox.com/v1/universes/{universeId}/activate`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets plugin details by ids.
--- @within develop
local function plugins(pluginIds: { number }, cookie: string?): { PluginResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/plugins?pluginIds={table.concat(pluginIds, "&pluginIds=")}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets a list of universes for the authenticated user.
--- @within develop
local function multiple(
	request: { isArchived: boolean?, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): UniverseModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/user/universes?isArchived={request.isArchived or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a plugin.
--- @within develop
local function configurePlugin(
	request: UpdatePluginRequest & { pluginId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v1/plugins/{request.pluginId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deactivates a universe.
--- @within develop
local function deactivate(universeId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://develop.roblox.com/v1/universes/{universeId}/deactivate`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of universes for the given group.
--- @within develop
local function ofGroup(
	request: {
		groupId: number,
		isArchived: boolean?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string?
): UniverseModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/groups/{request.groupId}/universes?isArchived={request.isArchived or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a page of templates that can be used to start off making games.
--- @within develop
local function templates(request: {}, cookie: string?): { GameTemplateModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/gametemplates`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Returns list of granted and declined permissions related to the universe with the id universeId for authenticated user
--- @within develop
local function permissions(universeId: number, cookie: string): UniversePermissionsModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/universes/{universeId}/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of places for a universe.
--- @within develop
local function places(
	request: {
		universeId: number,
		isUniverseCreation: boolean?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string?
): IPlaceModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/universes/{request.universeId}/places?isUniverseCreation={request.isUniverseCreation or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update universe settings for an owned universe.
--- V2 Contains data for avatar scale and asset override.
--- @within develop
local function configure(
	request: UniverseSettingsRequestV2 & { universeId: number },
	cookie: string
): UniverseSettingsResponseV2
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v2/universes/{request.universeId}/configuration`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the place configuration for the place with the id placeId
--- @within develop
local function configurePlace(request: PlaceConfigurationModelV2 & { placeId: number }, cookie: string): PlaceModelV2
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v2/places/{request.placeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the place configuration for the place with the id placeId
--- @within develop
local function place(placeId: number, cookie: string): PlaceModelV2
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v2/places/{placeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	activate = activate,
	plugins = plugins,
	multiple = multiple,
	configure = configure,
	configurePlace = configurePlace,
	place = place,
	configurePlugin = configurePlugin,
	deactivate = deactivate,
	ofGroup = ofGroup,
	templates = templates,
	permissions = permissions,
	places = places,
}
