local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
export type UniverseTeamCreateSettingsModelPages = { data: { UniverseTeamCreateSettingsModel } }

--- Model for private server details responses from the UniverseSettings controller.
export type PrivateServerDetailsResponse = {
	isEnabled: boolean,
	activeServersCount: number,
	price: number,
	activeSubscriptionsCount: number,
}

--- <no description>
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

--- <no description>
export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

--- <no description>
export type IPlaceModelPages = { nextPageCursor: string, previousPageCursor: string, data: { IPlaceModel } }

--- <no description>
export type PluginResponsePages = { data: { PluginResponse } }

--- <no description>
export type UniverseModelPages = { nextPageCursor: string, previousPageCursor: string, data: { UniverseModel } }

--- <no description>
export type ApiEmptyResponseModel = {}

--- A model containing information about a universe permissions
export type UniverseIdPermissionsModel = { canManage: boolean, universeId: number, canCloudEdit: boolean }

--- <no description>
export type AssetVotingModelPages = { data: { AssetVotingModel } }

--- <no description>
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
	universeCollisionType: number,
	price: number,
	genre: number,
	isMeshTextureApiAccessAllowed: boolean,
	isFriendsOnly: boolean,
	universeBodyType: number,
	fiatBasePriceId: string,
	fiatProductChangeType: number,
	universeAvatarType: number,
	universeScaleType: number,
	isRewardedOnDemandAdsAllowed: boolean,
	name: string,
	isForSale: boolean,
	playableDevices: { number },
	isArchived: boolean,
	universeJointPositioningType: number,
	universeAnimationType: number,
}

--- <no description>
export type SkinnyUserResponse = { id: number, name: string, displayName: string }

--- A model containing information about a group
export type GroupModel = { id: number, name: string }

--- Request model for a TeamCreate membership
export type TeamCreateMembershipRequest = { userId: number }

--- <no description>

--- A model containing information about a place to be configured
export type PlaceConfigurationModel = { name: string, description: string }

--- <no description>
export type UniverseIdPermissionsModelPages = { data: { UniverseIdPermissionsModel } }

--- <no description>
export type GroupModelPages = { data: { GroupModel } }

--- <no description>

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
	isForSaleInFiat: boolean,
	fiatModerationStatus: number,
	fiatBasePriceId: string,
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

--- <no description>
export type SkinnyUserResponsePages = { data: { SkinnyUserResponse } }

--- Model for UniverseSettings controller responses
export type UniverseSettingsResponseV2 = {
	description: string,
	price: number,
	genre: number,
	isMeshTextureApiAccessAllowed: boolean,
	isFriendsOnly: boolean,
	isForSaleInFiat: boolean,
	universeAvatarMinScales: ScaleModel,
	optInRegions: { UniverseModerationPolicyStatus },
	fiatModerationStatus: number,
	universeAvatarAssetOverrides: { UniverseAvatarAssetOverrideResponseModel },
	fiatBasePriceId: string,
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

--- <no description>
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

--- <no description>
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

--- <no description>

--- <no description>
export type UniverseAvatarAssetOverrideResponseModel = { assetID: number, assetTypeID: number, isPlayerChoice: boolean }

--- <no description>
export type ScaleModel =
	{ bodyType: number, head: number, height: number, depth: number, proportion: number, width: number }

--- <no description>

--- <no description>
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
	fiatProductChangeType: number,
	universeAvatarAssetOverrides: { UniverseAvatarAssetOverrideResponseModel },
	fiatBasePriceId: string,
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
local function activate(with: { universeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://develop.roblox.com/v1/universes/{with.universeId}/activate`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets plugin details by ids.
local function plugins(with: { pluginIds: { number } }): { PluginResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/plugins?pluginIds={table.concat(with.pluginIds, "&pluginIds=")}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets a list of universes for the authenticated user.
local function multiple(
	with: {
		isArchived: boolean?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
		cookie: string,
	}
): UniverseModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/user/universes?isArchived={with.isArchived or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a plugin.
local function configurePlugin(with: UpdatePluginRequest & { pluginId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v1/plugins/{with.pluginId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deactivates a universe.
local function deactivate(with: { universeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://develop.roblox.com/v1/universes/{with.universeId}/deactivate`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of universes for the given group.
local function ofGroup(
	with: {
		groupId: number,
		isArchived: boolean?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	}
): UniverseModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/groups/{with.groupId}/universes?isArchived={with.isArchived or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a page of templates that can be used to start off making games.
local function templates(): { GameTemplateModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/gametemplates`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Returns list of granted and declined permissions related to the universe with the id universeId for authenticated user
local function permissions(with: { universeId: number, cookie: string }): UniversePermissionsModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/universes/{with.universeId}/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of places for a universe.
local function places(with: {
	universeId: number,
	isUniverseCreation: boolean?,
	limit: number?,
	cursor: string?,
	sortOrder: "Asc" | "Desc"?,
}): IPlaceModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v1/universes/{with.universeId}/places?isUniverseCreation={with.isUniverseCreation or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update universe settings for an owned universe.
--- V2 Contains data for avatar scale and asset override.
local function configure(
	with: UniverseSettingsRequestV2 & { universeId: number, cookie: string }
): UniverseSettingsResponseV2
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v2/universes/{with.universeId}/configuration`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the place configuration for the place with the id placeId
local function configurePlace(with: PlaceConfigurationModelV2 & { placeId: number, cookie: string }): PlaceModelV2
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://develop.roblox.com/v2/places/{with.placeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the place configuration for the place with the id placeId
local function place(with: { placeId: number, cookie: string }): PlaceModelV2
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://develop.roblox.com/v2/places/{with.placeId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
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
