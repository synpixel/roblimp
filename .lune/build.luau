-- i apologize in advance to whoever's reading this

local net = require("@lune/net")
local serde = require("@lune/serde")
local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

type EndpointMappings = { [string]: { get: string?, post: string?, patch: string?, delete: string? } }

type OpenApiDefinition = {
	host: string,
	paths: {
		[string]: {
			[string]: {
				summary: string,
				consumes: { string },
				produces: { string },
				parameters: {
					{
						["in"]: "path" | "body" | "query" | "formData",
						name: string,
						required: boolean,
						optional: any,
						type: string,
					}
				},
				responses: { [string]: { schema: { ["$ref"]: string } } },
				deprecated: boolean?,
			},
		},
	},
	definitions: { [string]: { description: string } },
}

local mappings: { [string]: EndpointMappings } = {
	accountsettings = {
		["/v1/account/settings/metadata"] = { get = "getMetadata" },
		["/v1/account/settings/account-country"] = { get = "getCountry", post = "setCountry" },
		["/v1/email"] = { get = "getEmail", post = "setEmail" },
		["/v1/email/verify"] = { post = "verifyEmail" },
		["/v1/app-chat-privacy"] = { get = "getAppChatPrivacy", post = "setAppChatPrivacy" },
		["/v1/game-chat-privacy"] = { get = "getGameChatPrivacy", post = "setGameChatPrivacy" },
		["/v1/inventory-privacy"] = { get = "getInventoryPrivacy", post = "setInventoryPrivacy" },
		["/v1/private-message-privacy"] = { get = "getMessagePrivacy", post = "setMessagePrivacy" },
		-- /v1/themes/{consumerType}/{consumerId}
		-- /v1/themes/types
		["/v1/trade-privacy"] = { get = "getTradePrivacy", post = "setTradePrivacy" },
		["/v1/trade-value"] = { get = "getTradeQualityFilter", post = "setTradeQualityFilter" },
		["/v1/users/get-detailed-blocked-users"] = { get = "getBlockedUsers" },
		["/v1/users/{userId}/block"] = { post = "block" },
		["/v1/users/{userId}/unblock"] = { post = "unblock" },
	},
	avatar = {
		["/v1/avatar/metadata"] = { get = "getMetadata" },
		["/v1/avatar-rules"] = { get = "getAvatarRules" },
		["/v1/recent-items/{recentItemListType}/list"] = { get = "getRecentItems" },
		["/v1/users/{userId}/currently-wearing"] = { get = "getAssetsWorn" },
		["/v1/avatar/redraw-thumbnail"] = { post = "redrawThumbnail" },
		["/v1/avatar/set-player-avatar-type"] = { post = "setRigType" },
		["/v1/avatar/set-scales"] = { post = "setScales" },
		["/v1/outfits/{userOutfitId}/delete"] = { post = "deleteOutfit" },
		["/v2/avatar/avatar"] = { get = "getAvatar" },
		["/v2/avatar/users/{userId}/avatar"] = { get = "getAvatarOf" },
		["/v2/avatar/users/{userId}/outfits"] = { get = "getOutfitsOf" },
		["/v2/avatar/set-body-colors"] = { post = "setBodyColors" },
		["/v2/avatar/set-wearing-assets"] = { post = "setAssetsWorn" },
		["/v3/outfits/{userOutfitId}/details"] = { get = "getOufitDetails" },
		["/v3/outfits/create"] = { post = "createOutfit" },
		["/v3/outfits/{userOutfitId}"] = { patch = "updateOutfit" },
	},
	badges = {
		["/v1/badges/metadata"] = { get = "getMetadata" },
		["/v1/badges/{badgeId}"] = { get = "getBadge", patch = "updateBadge" },
		["/v1/universes/{universeId}/badges"] = { get = "getBadgesFor", post = "createBadge" },
		["/v1/universes/{universeId}/free-badges-quota"] = { get = "getFreeBadgesQuota" },
		["/v1/users/{userId}/badges"] = { get = "getBadgesOf" },
		["/v1/users/{userId}/badges/awarded-dates"] = { get = "getBadgeAwardedTimestamps" },
		["/v1/user/badges/{badgeId}"] = { delete = "removeBadge" },
		["/v1/user/{userId}/badges/{badgeId}"] = { delete = "removeBadgeFrom" },
	},
	chat = {
		["/v2/metadata"] = { get = "getMetadata" },
		["/v2/chat-settings"] = { get = "getSettings" },
		["/v2/get-conversations"] = { get = "getConversations" },
		["/v2/get-messages"] = { get = "getMessages" },
		["/v2/get-rollout-settings"] = { get = "getRolloutSettings" },
		["/v2/get-unread-conversation-count"] = { get = "getTotalUnreadConversations" },
		["/v2/get-unread-messages"] = { get = "getUnreadMessages" },
		["/v2/get-user-conversations"] = { get = "getActiveConversations" },
		["/v2/multi-get-latest-messages"] = { get = "getLatestMessages" },
		["/v2/add-to-conversation"] = { post = "addToConversation" },
		["/v2/remove-from-conversation"] = { post = "removeFromConversation" },
		["/v2/mark-as-read"] = { post = "markAsRead" },
		["/v2/mark-as-seen"] = { post = "markAsSeen" },
		["/v2/rename-group-conversation"] = { post = "renameConversation" },
		["/v2/send-game-link-message"] = { post = "sendGameLink" },
		["/v2/send-message"] = { post = "sendMessage" },
		-- /v2/start-cloud-edit-conversation
		["/v2/start-one-to-one-conversation"] = { post = "createConversation" },
		["/v2/start-group-conversation"] = { post = "createGroupConversation" },
		["/v2/update-user-typing-status"] = { post = "setTypingStatus" },
	},
	develop = {
		["/v1/gametemplates"] = { get = "getGameTemplates" },
		["/v1/groups/{groupId}/universes"] = { get = "getUniversesByGroup" },
		-- /v1/places/{placeId}/teamcreate/active_session/members
		["/v1/plugins"] = { get = "getPlugins" },
		-- /v1/universes/{universeId}/configuration/vip-servers
		["/v1/universes/{universeId}/permissions"] = { get = "getUniversePermissions" },
		["/v1/universes/{universeId}/places"] = { get = "getUniversePlaces" },
		-- /v1/universes/{universeId}/teamcreate
		-- /v1/universes/multiget
		-- /v1/universes/multiget/permissions
		-- /v1/universes/multiget/teamcreate
		["/v1/user/groups/canmanage"] = { get = "getGroups" },
		-- /v1/user/groups/canmanagegamesoritems
		["/v1/user/universes"] = { get = "getUniverses" },
		["/v1/universes/{universeId}/activate"] = { post = "activateUniverse" },
		["/v1/universes/{universeId}/deactivate"] = { post = "deactivateUniverse" },
		["/v1/plugins/{pluginId}"] = { patch = "updatePlugin" },
		-- /v1/universes/{universeId}/teamcreate/memberships
		-- /v2/assets/{id}/versions
		["/v2/places/{placeId}"] = { get = "getPlaceConfiguration", patch = "updatePlace" },
		["/v2/universes/{universeId}/configuration"] = { patch = "updateUniverse" },
		-- /v2/teamtest/{placeId}
	},
	economy = {
		["/v1/user/currency"] = { get = "getCurrency" },
	},
	followings = {
		["/v1/users/{userId}/universes/{universeId}/status"] = { get = "getFollowingStatus" },
		["/v1/users/{userId}/universes/{universeId}"] = { post = "follow", delete = "unfollow" },
		["/v2/users/{userId}/universes"] = { get = "getFollowingsOf" },
	},
	friends = {
		["/v1/metadata"] = { get = "getMetadata" },
		["/v1/my/friends/count"] = { get = "getTotalFriends" },
		["/v1/my/friends/requests"] = { get = "getFriendRequests" },
		["/v1/user/friend-requests/count"] = { get = "getTotalFriendRequests" },
		["/v1/users/{targetUserId}/followers"] = { get = "getFollowersOf" },
		["/v1/users/{targetUserId}/followers/count"] = { get = "getTotalFollowersOf" },
		["/v1/users/{targetUserId}/followings"] = { get = "getFollowingsOf" },
		["/v1/users/{targetUserId}/followings/count"] = { get = "getTotalFollowingsOf" },
		["/v1/users/{userId}/friends"] = { get = "getFriendsOf" },
		["/v1/users/{userId}/friends/count"] = { get = "getTotalFriendsOf" },
		["/v1/users/{userId}/friends/find"] = { get = "getFriendshipsOf" },
		["/v1/users/{userId}/friends/inactive"] = { get = "getInactiveFriendsOf" },
		["/v1/users/{userId}/friends/online"] = { get = "getOnlineFriendsOf" },
		["/v1/users/{userId}/friends/search"] = { get = "searchFriendsOf" },
		-- /v1/users/{userId}/friends/statuses
		-- /v1/contacts/{targetContactId}/request-friendship
		["/v1/user/{userId}/multiget-are-friends"] = { post = "areFriends" },
		["/v1/user/following-exists"] = { post = "isFollowing" },
		["/v1/user/friend-requests/decline-all"] = { post = "declineAllFriendRequests" },
		["/v1/users/{requesterUserId}/accept-friend-request"] = { post = "acceptFriendRequest" },
		["/v1/users/{requesterUserId}/decline-friend-request"] = { post = "declineFriendRequest" },
		-- /v1/users/{senderUserId}/accept-friend-request-with-token
		["/v1/users/{targetUserId}/follow"] = { post = "follow" },
		["/v1/users/{targetUserId}/unfollow"] = { post = "unfollow" },
		["/v1/users/{targetUserId}/request-friendship"] = { post = "sendFriendRequest" },
		["/v1/users/{targetUserId}/unfriend"] = { post = "unfriend" },
	},
	games = {
		["/v1/games"] = { get = "getUniverses" },
		["/v1/games/{placeId}/private-servers"] = { get = "getPrivateServersFor" },
		["/v1/games/{placeId}/servers/{serverType}"] = { get = "getServers" },
		["/v1/games/{universeId}/favorites"] = { get = "isFavorited", post = "favorite" },
		["/v1/games/{universeId}/favorites/count"] = { get = "getTotalFavorites" },
		["/v1/games/{universeId}/game-passes"] = { get = "getGamepasses" },
		["/v1/games/{universeId}/votes/user"] = { get = "getVote" },
		["/v1/games/games-product-info"] = { get = "getProductInfo" },
		["/v1/games/list-spotlight"] = { get = "listSpotlight" },
		["/v1/games/multiget-place-details"] = { get = "getPlaceDetails" },
		["/v1/games/multiget-playability-status"] = { get = "getPlayabilityStatuses" },
		["/v1/games/recommendations/game/{universeId}"] = { get = "getRecommendations" },
		["/v1/games/votes"] = { get = "getVotes" },
		["/v1/private-servers"] = { get = "getPrivateServers" },
		["/v1/private-servers/enabled-in-universe/{universeId}"] = { get = "arePrivateServersEnabled" },
		["/v1/private-servers/my-private-servers"] = { get = "getOwnedPrivateServers" },
		["/v1/vip-server/can-invite/{userId}"] = { get = "canInvite" },
		["/v1/vip-servers/{id}"] = { get = "getPrivateServer", patch = "updatePrivateServer" },
		["/v1/games/vip-servers/{universeId}"] = { post = "createPrivateServer" },
		["/v1/vip-servers/{id}/permissions"] = { patch = "updatePermissions" },
		["/v1/vip-servers/{id}/subscription"] = { patch = "updateSubscription" },
		["/v1/vip-servers/{id}/voicesettings"] = { patch = "updateVoiceSettings" },
		["/v1/games/{universeId}/user-votes"] = { patch = "vote" },
		["/v2/games/{universeId}/media"] = { get = "getMedia" },
		["/v2/groups/{groupId}/gamesV2"] = { get = "getUniversesByGroup" },
		["/v2/users/{userId}/games"] = { get = "getUniversesBy" },
	},
	groups = {
		["/v1/groups/metadata"] = { get = "getMetadata" },
		["/v1/groups/configuration/metadata"] = { get = "getConfigurationMetadata" },
		["/v1/groups/search/metadata"] = { get = "getSearchMetadata" },
		-- /v1/featured-content/event
		["/v1/groups/{groupId}"] = { get = "getGroup" },
		["/v1/groups/{groupId}/audit-log"] = { get = "getAuditLog" },
		["/v1/groups/{groupId}/join-requests"] = {
			get = "getJoinRequests",
			post = "acceptJoinRequests",
			delete = "declineJoinRequests",
		},
		["/v1/groups/{groupId}/join-requests/users/{userId}"] = {
			get = "getJoinRequest",
			post = "acceptJoinRequest",
			delete = "declineJoinRequest",
		},
		["/v1/groups/{groupId}/membership"] = { get = "getMembership" },
		["/v1/groups/{groupId}/name-history"] = { get = "getNameHistory" },
		["/v1/groups/{groupId}/payout-restriction"] = { get = "canUsePayout" },
		["/v1/groups/{groupId}/payouts"] = { get = "getRecurringPayouts", post = "payout" },
		["/v1/groups/{groupId}/relationships/{groupRelationshipType}"] = { get = "getRelationships" },
		["/v1/groups/{groupId}/relationships/{groupRelationshipType}/requests"] = {
			get = "getRelationshipRequests",
			post = "acceptRelationshipRequests",
			delete = "declineRelationshipRequests",
		},
		["/v1/groups/{groupId}/roles/{roleSetId}/permissions"] = {
			get = "getRolePermissions",
			patch = "updateRolePermissions",
		},
		["/v1/groups/{groupId}/roles/{roleSetId}/users"] = { get = "getUsersWithRole" },
		["/v1/groups/{groupId}/roles/guest/permissions"] = { get = "getGuestPermissions" },
		["/v1/groups/{groupId}/roles/permissions"] = { get = "getAllRolePermissions" },
		["/v1/groups/{groupId}/settings"] = { get = "getSettings", patch = "updateSettings" },
		["/v1/groups/{groupId}/social-links"] = { get = "getSocialLinks", post = "addSocialLink" },
		["/v1/groups/{groupId}/users"] = { get = "getUsers", post = "joinGroup" },
		["/v1/groups/search"] = { get = "searchGroups" },
		["/v1/groups/search/lookup"] = { get = "lookupGroups" },
		["/v1/roles"] = { get = "getRoles" },
		["/v1/user/groups/pending"] = { get = "getPendingGroups" },
		["/v1/users/{userId}/friends/groups/roles"] = { get = "getGroupsWithFriends" },
		["/v1/users/{userId}/groups/primary/role"] = { get = "getPrimaryGroup" },
		-- ["/v1/users/{userId}/groups/roles"] = { get = "getGroupsWith" },
		["/v1/groups/{groupId}/change-owner"] = { post = "giveOwnership" },
		["/v1/groups/{groupId}/claim-ownership"] = { post = "claimOwnership" },
		["/v1/groups/{groupId}/payouts/recurring"] = { post = "updateRecurringPayouts" },
		["/v1/groups/{groupId}/relationships/{groupRelationshipType}/{relatedGroupId}"] = {
			post = "requestRelationship",
			delete = "deleteRelationship",
		},
		["/v1/groups/{groupId}/relationships/{groupRelationshipType}/requests/{relatedGroupId}"] = {
			post = "acceptRelationshipRequest",
			delete = "declineRelationshipRequest",
		},
		["/v1/groups/{groupId}/rolesets/create"] = { post = "createRole" },
		["/v1/groups/{groupId}/wall/subscribe"] = { post = "subscribeGroupWall" },
		["/v1/groups/create"] = { post = "createGroup" },
		["/v1/groups/policies"] = { post = "getPolicies" },
		["/v1/user/groups/primary"] = { post = "setPrimaryGroup", delete = "removePrimaryGroup" },
		["/v1/groups/{groupId}/description"] = { patch = "setDescription" },
		["/v1/groups/{groupId}/name"] = { patch = "setName" },
		["/v1/groups/{groupId}/notification-preference"] = { patch = "updateNotificationPreferences" },
		["/v1/groups/{groupId}/rolesets/{rolesetId}"] = { patch = "updateRole", delete = "deleteRole" },
		["/v1/groups/{groupId}/social-links/{socialLinkId}"] = {
			patch = "updateSocialLink",
			delete = "deleteSocialLink",
		},
		["/v1/groups/{groupId}/status"] = { patch = "setStatus" },
		["/v1/groups/{groupId}/users/{userId}"] = { patch = "changeRole", delete = "exileUser" },
		["/v1/groups/icon"] = { patch = "setIcon" },
		["/v1/groups/{groupId}/wall/posts/{postId}"] = { delete = "deleteGroupWallMessage" },
		["/v1/groups/{groupId}/wall/users/{userId}/posts"] = { delete = "deleteUserGroupWallMessages" },
		["/v2/groups"] = { get = "getGroups" },
		["/v2/groups/{groupId}/wall/posts"] = { get = "getGroupWallMessages", post = "sendGroupWallMessage" },
		["/v2/users/{userId}/groups/roles"] = { get = "getRolesOf" },
	},
	notifications = {
		["/v2/push-notifications/metadata"] = { get = "getMetadata" },
		["/v2/stream-notifications/metadata"] = { get = "getStreamMetadata" },
		["/v2/notifications/settings/realtime"] = { get = "getRealtimeSettings" },
		["/v2/push-notifications/chrome-manifest"] = { get = "getChromeManifest" },
		["/v2/push-notifications/get-current-device-destination"] = { get = "getDeviceDestination" },
		["/v2/push-notifications/get-destinations"] = { get = "getDestinations" },
		["/v2/push-notifications/notification-ids"] = { get = "getNotificationIds" },
		["/v2/stream-notifications/get-latest-game-updates"] = { get = "getLatestGameUpdates" },
		["/v2/stream-notifications/get-recent"] = { get = "getRecent" },
		["/v2/stream-notifications/unread-count"] = { get = "getTotalUnread" },
		["/v2/push-notifications/deregister-all-devices"] = { post = "deregisterAllDevices" },
		["/v2/push-notifications/deregister-current-device"] = { post = "deregisterDevice" },
		["/v2/push-notifications/deregister-current-device-ios-pushkit"] = { post = "deregisterIOSPushkit" },
		["/v2/push-notifications/mark-interaction"] = { post = "markInteraction" },
		["/v2/stream-notifications/mark-interacted"] = { post = "markInteracted" },
		["/v2/push-notifications/register-android-amazon"] = { post = "registerAmazonAndroid" },
		["/v2/push-notifications/register-android-native"] = { post = "registerAndroidNative" },
		["/v2/push-notifications/register-android-tencent-service"] = { post = "registerAndroidTencentService" },
		["/v2/push-notifications/register-chrome"] = { post = "registerChrome" },
		["/v2/push-notifications/register-firefox"] = { post = "registerFirefox" },
		["/v2/push-notifications/register-ios-native"] = { post = "registerIOSNative" },
		["/v2/push-notifications/register-ios-pushkit"] = { post = "registerIOSPushkit" },
		["/v2/stream-notifications/clear-unread"] = { post = "clearUnread" },
		["/v2/stream-notifications/game-update-notification-read"] = { post = "acknowledgeGameUpdate" },
	},
	presence = {
		["/v1/presence/last-online"] = { post = "getLastOnlineTimestamps" },
		["/v1/presence/users"] = { post = "getPresences" },
	},
	privatemessages = {
		["/v1/announcements"] = { get = "getAnnouncements" },
		["/v1/announcements/metadata"] = { get = "getAnnouncementMetadata" },
		["/v1/messages"] = { get = "getMessages" },
		["/v1/messages/{messageId}"] = { get = "getMessage" },
		["/v1/messages/{userId}/can-message"] = { get = "canMessage" },
		["/v1/messages/unread/count"] = { get = "getTotalUnread" },
		["/v1/messages/archive"] = { post = "archive" },
		["/v1/messages/unarchive"] = { post = "unarchive" },
		["/v1/messages/mark-read"] = { post = "markAsRead" },
		["/v1/messages/mark-unread"] = { post = "markAsUnread" },
		["/v1/messages/send"] = { post = "sendMessage" },
	},
	trades = {
		["/v1/trades/metadata"] = { get = "getMetadata" },
		["/v1/trades/{tradeId}"] = { get = "getTrade" },
		["/v1/trades/{tradeStatusType}"] = { get = "getTrades" },
		["/v1/trades/{tradeStatusType}/count"] = { get = "getTotalTrades" },
		["/v1/users/{userId}/can-trade-with"] = { get = "canTradeWith" },
		["/v1/trades/{tradeId}/accept"] = { post = "acceptTrade" },
		["/v1/trades/{tradeId}/counter"] = { post = "counterTrade" },
		["/v1/trades/{tradeId}/decline"] = { post = "declineTrade" },
		["/v1/trades/send"] = { post = "sendTrade" },
	},
	users = {
		["/v1/birthdate"] = { get = "getBirthdate", post = "setBirthdate" },
		["/v1/description"] = { get = "getDescription", post = "setDescription" },
		["/v1/gender"] = { get = "getGender", post = "setGender" },
		["/v1/users/{userId}/display-names"] = { patch = "setDisplayName" },
		["/v1/users/{userId}"] = { get = "getUser" },
		["/v1/users/authenticated"] = { get = "getAuthenticatedUser" },
		["/v1/users/authenticated/age-bracket"] = { get = "getAgeBracket" },
		["/v1/users/authenticated/country-code"] = { get = "getCountryCode" },
		["/v1/users/authenticated/roles"] = { get = "getPublicRoles" },
		["/v1/users"] = { post = "getUsersByIds" },
		["/v1/usernames/users"] = { post = "getUsersByNames" },
		["/v1/users/{userId}/username-history"] = { get = "getUsernameHistory" },
		["/v1/users/search"] = { get = "searchUsers" },
	},
}

local function resolveOpenApiDefinition(namespace: string, version: number): OpenApiDefinition?
	local response = net.request(
		`https://create.roblox.com/docs/_next/data/-lXptKM5ny0kISifArYeq/cloud/legacy/{namespace}/v{version}.json`
	)

	if response.statusCode == 404 then
		return nil
	end

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	local body = serde.decode("json", response.body) :: { pageProps: { data: { content: OpenApiDefinition } } }
	local openapi = body.pageProps.data.content

	return openapi
end

local function patchOpenApiModelName(name: string): string
	local hasBrackets = name:match("%[(.+)%]") ~= nil
	local patchName = name:gsub("[%[%]]", ""):match("([^.]+)$")

	if hasBrackets then
		patchName ..= "Pages"
	end

	return patchName
end

local function translateOpenApiType(openapiType: { type: string, [string]: any }?): string
	if openapiType == nil then
		return "nil"
	end

	if openapiType["$ref"] ~= nil then
		return patchOpenApiModelName(openapiType["$ref"])
	end

	if openapiType.type == "integer" then
		return "number"
	end

	if openapiType.enum ~= nil then
		local enum = {}

		for _, item in openapiType.enum do
			if typeof(item) == "string" then
				table.insert(enum, `"{item}"`)
				continue
			end

			table.insert(enum, item)
		end

		return `{table.concat(enum, "|")}`
	end

	if openapiType.type == "array" then
		if openapiType.items == nil then
			return "{}"
		end

		return `\{{translateOpenApiType(openapiType.items)}\}`
	end

	if openapiType.type == "object" then
		if openapiType.properties == nil then
			return "{}"
		end

		local objectType = "{"

		for name, type in openapiType.properties do
			objectType ..= `{name}: {translateOpenApiType(type)},`
		end

		objectType ..= "}"

		return objectType
	end

	if openapiType.type == "file" then
		return "buffer"
	end

	return openapiType.type
end

local function formatWithStylua(file: string): string
	local formatted = process.spawn("stylua", { "-" }, { shell = true, stdin = file })
	assert(formatted.ok, formatted.stderr)
	return formatted.stdout
end

for namespace, definitions in mappings do
	local file = ""

	file ..= `local serde = require("./utils/serde")\n`
	file ..= `local requestWithCsrfToken = require("./utils/request-with-csrf-token")\n\n`

	local openapis = {}

	for version = 1, 3 do
		local openapi = resolveOpenApiDefinition(namespace, version)

		if openapi == nil then
			continue
		end

		table.insert(openapis, openapi)
	end

	for _, openapi in openapis do
		for name, model in openapi.definitions do
			if model.description ~= nil then
				local patch = model.description:gsub("([^\n]+)", "--- %1"):gsub("</?p>", "")
				file ..= `{patch}\n`
			else
				file ..= "--- <no description>\n"
			end

			file ..= `export type {patchOpenApiModelName(name)} = {translateOpenApiType(model)}\n\n`
		end
	end

	for _, openapi in openapis do
		for endpoint, routes in definitions do
			if openapi.paths[endpoint] == nil then
				continue
			end

			for method, name in routes do
				assert(openapi.paths[endpoint][method] ~= nil, `invalid method for {namespace} {endpoint}: {method}`)

				local route = openapi.paths[endpoint][method]
				local consumesJson = route.consumes ~= nil and route.consumes[1] == "application/json"
				local producesJson = route.produces ~= nil and route.produces[1] == "application/json"

				if route.deprecated then
					print(
						`{stdio.color("yellow")}{stdio.style("bold")}DEPRECATED{stdio.color("reset")} {method:upper()} {openapi.host}{endpoint}`
					)
				end

				local okResponse = route.responses["200"]
				local patchModelName = translateOpenApiType(okResponse.schema)

				local needsCookie = route.responses["401"] ~= nil

				local parameters: { { name: string, type: string } } = {}
				local bodyParameter

				if route.parameters ~= nil then
					for _, parameter in route.parameters do
						if parameter["in"] == "body" then
							bodyParameter = parameter
							continue
						end

						local type = translateOpenApiType(parameter)
						if parameter.required == nil then
							type ..= "?"
						end

						table.insert(parameters, { name = parameter.name, type = type })
					end
				end

				if needsCookie then
					table.insert(parameters, { name = "cookie", type = "string" })
				end

				if route.summary ~= nil then
					local patchSummary = route.summary:gsub("([^\n]+)", "--- %1"):gsub("</?p>", "")
					file ..= `{patchSummary}\n`
				else
					file ..= "--- <no description>\n"
				end

				if next(parameters) == nil then
					file ..= `local function {name}(`

					if consumesJson then
						file ..= `with: {translateOpenApiType(bodyParameter.schema)}`
					end

					file ..= `): {patchModelName}\n`
				else
					file ..= `local function {name}(with:`

					if consumesJson then
						file ..= `{translateOpenApiType(bodyParameter.schema)} &`
					end

					file ..= "{"

					for _, parameter in parameters do
						file ..= `{parameter.name}: {parameter.type},`
					end

					file ..= `}): {patchModelName}\n`
				end

				file ..= "local response = requestWithCsrfToken({\n"

				file ..= `method = "{method:upper()}",\n`

				local patchEndpoint = endpoint:gsub("{(.-)}", "{with.%1}")

				if route.parameters ~= nil then
					local isFirstPathParameter = true

					for _, parameter in route.parameters do
						if parameter["in"] ~= "query" and parameter["in"] ~= "formData" then
							continue
						end

						local symbol = if isFirstPathParameter then "?" else "&"

						if isFirstPathParameter then
							isFirstPathParameter = false
						end

						local value = if parameter.type == "array"
							then `table.concat(with.{parameter.name}, "&{parameter.name}=")`
							else `with.{parameter.name}`

						if not parameter.required then
							value ..= ' or ""'
						end

						patchEndpoint ..= `{symbol}{parameter.name}=\{{value}\}`
					end
				end

				file ..= `url = \`https://{openapi.host}{patchEndpoint}\`,\n`

				file ..= "headers = {"

				if consumesJson then
					file ..= '["Content-Type"] = "application/json",'
				end

				if needsCookie then
					file ..= "Cookie = `.ROBLOSECURITY={with.cookie}`,"
				end

				file ..= "},\n"

				if consumesJson then
					file ..= 'body = serde.encode("json", with),\n'
				end

				file ..= "})\n\n"

				file ..= "assert(response.ok, `{response.statusCode} {response.statusMessage}`)\n\n"

				if producesJson then
					file ..= 'return serde.decode("json", response.body)\n'
				else
					file ..= "return response.body\n"
				end

				file ..= `end\n\n`
			end
		end
	end

	file ..= "return {"

	for endpoint, routes in definitions do
		for _, name in routes do
			file ..= `{name} = {name},`
		end
	end

	file ..= "}\n\n"

	fs.writeFile(`src/{namespace}.luau`, formatWithStylua(file))
end

local file = ""

for namespace, _ in mappings do
	file ..= `local {namespace} = require("./{namespace}")\n`
end

file ..= "\nreturn {"

for namespace, _ in mappings do
	file ..= `{namespace} = {namespace},`
end

file ..= "}"

fs.writeFile("src/init.luau", formatWithStylua(file))
