local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

export type UniverseTeamCreateSettingsModelPages = { data: { UniverseTeamCreateSettingsModel } }

--- Model for private server details responses from the UniverseSettings controller.
export type PrivateServerDetailsResponse = {
	isEnabled: boolean,
	activeServersCount: number,
	price: number,
	activeSubscriptionsCount: number,
}

export type GameTemplateModelPages = { data: { GameTemplateModel } }

--- Represents a game template in API endpoint responses.
export type GameTemplateModel = { hasTutorials: boolean, universe: UniverseModel, gameTemplateType: string }

--- Represents information about a plugin.
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
export type TeamCreateSettingsResponse = { isEnabled: boolean }

--- A model containing information about a place
export type IPlaceModel = {}

--- Represents a universe in API endpoint results.
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
export type UniversePermissionsModel = { canManage: boolean, canCloudEdit: boolean }

--- A model containing information about a place
export type PlaceModel = { id: number, universeId: number, name: string, description: string }

export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

export type IPlaceModelPages = { nextPageCursor: string, previousPageCursor: string, data: { IPlaceModel } }

export type PluginResponsePages = { data: { PluginResponse } }

export type UniverseModelPages = { nextPageCursor: string, previousPageCursor: string, data: { UniverseModel } }

export type ApiEmptyResponseModel = {}

--- A model containing information about a universe permissions
export type UniverseIdPermissionsModel = { canManage: boolean, universeId: number, canCloudEdit: boolean }

export type AssetVotingModelPages = { data: { AssetVotingModel } }

export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- Team create settings of a universe
export type UniverseTeamCreateSettingsModel = { id: number, isEnabled: boolean }

--- Asset voting information
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

export type SkinnyUserResponse = { id: number, name: string, displayName: string }

--- A model containing information about a group
export type GroupModel = { id: number, name: string }

--- Request model for a TeamCreate membership
export type TeamCreateMembershipRequest = { userId: number }

--- A model containing information about a place to be configured
export type PlaceConfigurationModel = { name: string, description: string }

export type UniverseIdPermissionsModelPages = { data: { UniverseIdPermissionsModel } }

export type GroupModelPages = { data: { GroupModel } }

--- A request model for updating a plugin.
export type UpdatePluginRequest = { commentsEnabled: boolean, name: string, description: string }

--- Team create settings request
export type UpdateTeamCreateSettingsRequest = { isEnabled: boolean }

--- Model for UniverseSettings controller responses
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

export type SkinnyUserResponsePages = { data: { SkinnyUserResponse } }

--- Model for UniverseSettings controller responses
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

export type StringPages = { SortOrder: number, PagingDirection: number, Count: number }

--- Represents a universe moderation policy status
export type UniverseModerationPolicyStatus = { status: string, region: number }

--- A model containing information about a place to be configured
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

export type AssetVersionPages = { nextPageCursor: string, previousPageCursor: string, data: { AssetVersion } }

--- Model of an asset version.
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

export type UniverseAvatarAssetOverrideResponseModel = { assetID: number, assetTypeID: number, isPlayerChoice: boolean }

export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

export type UniversePluginPermissions = {
	IsThirdPartyTeleportAllowed: boolean,
	IsThirdPartyPurchaseAllowed: boolean,
	IsThirdPartyAssetAllowed: boolean,
}

--- Model for UniverseSettings patch requests
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
local function activate(universeId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://develop.roblox.com/v1/universes/{universeId}/activate`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets plugin details by ids.
local function plugins(pluginIds: { number }, cookie: string?): Response<{ PluginResponse }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/plugins?pluginIds={table.concat(pluginIds, "&pluginIds=")}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Gets a list of universes for the authenticated user.
local function multiple(
	request: { isArchived: boolean?, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): Response<UniverseModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/user/universes?isArchived={request.isArchived or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Updates a plugin.
local function configurePlugin(
	request: UpdatePluginRequest & { pluginId: number },
	cookie: string
): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v1/plugins/{request.pluginId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Deactivates a universe.
local function deactivate(universeId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://develop.roblox.com/v1/universes/{universeId}/deactivate`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a list of universes for the given group.
local function ofGroup(
	request: {
		groupId: number,
		isArchived: boolean?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string?
): Response<UniverseModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/groups/{request.groupId}/universes?isArchived={request.isArchived or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a page of templates that can be used to start off making games.
local function templates(cookie: string?): Response<{ GameTemplateModel }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/gametemplates`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Returns list of granted and declined permissions related to the universe with the id universeId for authenticated user
local function permissions(universeId: number, cookie: string): Response<UniversePermissionsModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/universes/{universeId}/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a list of places for a universe.
local function places(
	request: {
		universeId: number,
		isUniverseCreation: boolean?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string?
): Response<IPlaceModelPages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/universes/{request.universeId}/places?isUniverseCreation={request.isUniverseCreation or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Update universe settings for an owned universe.
--- V2 Contains data for avatar scale and asset override.
local function configure(
	request: UniverseSettingsRequestV2 & { universeId: number },
	cookie: string
): Response<UniverseSettingsResponseV2>
	return requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v2/universes/{request.universeId}/configuration`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Updates the place configuration for the place with the id placeId
local function configurePlace(
	request: PlaceConfigurationModelV2 & { placeId: number },
	cookie: string
): Response<PlaceModelV2>
	return requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v2/places/{request.placeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the place configuration for the place with the id placeId
local function place(placeId: number, cookie: string): Response<PlaceModelV2>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v2/places/{placeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
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
