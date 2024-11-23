-- i apologize in advance to whoever's reading this

local net = require("@lune/net")
local serde = require("@lune/serde")
local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

type EndpointMappings = { [string]: { get: string?, post: string?, patch: string?, delete: string? } }

type OpenApiDefinition = {
	title: string,
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

local FORMAT = true

local mappings: { [string]: EndpointMappings } = {
	accountsettings = {
		["/v1/account/settings/metadata"] = { get = "metadata" },
		["/v1/account/settings/account-country"] = { get = "country", post = "setCountry" },
		["/v1/email"] = { get = "email", post = "setEmail" },
		["/v1/email/verify"] = { post = "verifyEmail" },
		["/v1/app-chat-privacy"] = { get = "appChatPrivacy", post = "setAppChatPrivacy" },
		["/v1/game-chat-privacy"] = { get = "gameChatPrivacy", post = "setGameChatPrivacy" },
		["/v1/inventory-privacy"] = { get = "inventoryPrivacy", post = "setInventoryPrivacy" },
		["/v1/private-message-privacy"] = { get = "messagePrivacy", post = "setMessagePrivacy" },
		-- /v1/themes/{consumerType}/{consumerId}
		-- /v1/themes/types
		["/v1/trade-privacy"] = { get = "tradePrivacy", post = "setTradePrivacy" },
		["/v1/trade-value"] = { get = "tradeQualityFilter", post = "setTradeQualityFilter" },
		["/v1/users/get-detailed-blocked-users"] = { get = "blockedUsers" },
		["/v1/users/{userId}/block"] = { post = "block" },
		["/v1/users/{userId}/unblock"] = { post = "unblock" },
	},
	avatar = {
		["/v1/avatar/metadata"] = { get = "metadata" },
		["/v1/avatar-rules"] = { get = "rules" },
		["/v1/recent-items/{recentItemListType}/list"] = { get = "recentItems" },
		["/v1/users/{userId}/currently-wearing"] = { get = "assetsWorn" },
		["/v1/avatar/redraw-thumbnail"] = { post = "redrawThumbnail" },
		["/v1/avatar/set-player-avatar-type"] = { post = "setRigType" },
		["/v1/avatar/set-scales"] = { post = "setScales" },
		["/v1/outfits/{userOutfitId}/delete"] = { post = "deleteOutfit" },
		["/v2/avatar/avatar"] = { get = "get" },
		["/v2/avatar/users/{userId}/avatar"] = { get = "of" },
		["/v2/avatar/users/{userId}/outfits"] = { get = "outfitsOf" },
		["/v2/avatar/set-body-colors"] = { post = "setBodyColors" },
		["/v2/avatar/set-wearing-assets"] = { post = "setAssetsWorn" },
		["/v3/outfits/{userOutfitId}/details"] = { get = "outfit" },
		["/v3/outfits/create"] = { post = "createOutfit" },
		["/v3/outfits/{userOutfitId}"] = { patch = "updateOutfit" },
	},
	badges = {
		["/v1/badges/metadata"] = { get = "metadata" },
		["/v1/badges/{badgeId}"] = { get = "get", patch = "update" },
		["/v1/universes/{universeId}/badges"] = { get = "universe", post = "create" },
		["/v1/universes/{universeId}/free-badges-quota"] = { get = "freeQuota" },
		["/v1/users/{userId}/badges"] = { get = "of" },
		["/v1/users/{userId}/badges/awarded-dates"] = { get = "awardedTimestamps" },
		["/v1/user/badges/{badgeId}"] = { delete = "remove" },
		["/v1/user/{userId}/badges/{badgeId}"] = { delete = "removeFrom" },
	},
	catalog = {
		["/v1/bundles/{bundleId}/details"] = { get = "bundle" },
		["/v1/bundles/details"] = { get = "bundles" },
		["/v1/users/{userId}/bundles"] = { get = "bundlesOf" },
		["/v1/catalog/items/details"] = { post = "items" },
		["/v2/search/items/details"] = { get = "search" },
	},
	chat = {
		["/v2/metadata"] = { get = "metadata" },
		["/v2/chat-settings"] = { get = "settings" },
		["/v2/get-conversations"] = { get = "conversations" },
		["/v2/get-messages"] = { get = "messages" },
		["/v2/get-rollout-settings"] = { get = "rolloutSettings" },
		["/v2/get-unread-conversation-count"] = { get = "countUnreadConversations" },
		["/v2/get-unread-messages"] = { get = "unreadMessages" },
		["/v2/get-user-conversations"] = { get = "allConversations" },
		["/v2/multi-get-latest-messages"] = { get = "latestMessages" },
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
		["/v1/gametemplates"] = { get = "templates" },
		["/v1/groups/{groupId}/universes"] = { get = "ofGroup" },
		-- /v1/places/{placeId}/teamcreate/active_session/members
		["/v1/plugins"] = { get = "plugins" },
		-- /v1/universes/{universeId}/configuration/vip-servers
		["/v1/universes/{universeId}/permissions"] = { get = "permissions" },
		["/v1/universes/{universeId}/places"] = { get = "places" },
		-- /v1/universes/{universeId}/teamcreate
		-- /v1/universes/multiget
		-- /v1/universes/multiget/permissions
		-- /v1/universes/multiget/teamcreate
		-- ["/v1/user/groups/canmanage"] = { get = "x" },
		-- /v1/user/groups/canmanagegamesoritems
		["/v1/user/universes"] = { get = "multiple" },
		["/v1/universes/{universeId}/activate"] = { post = "activate" },
		["/v1/universes/{universeId}/deactivate"] = { post = "deactivate" },
		["/v1/plugins/{pluginId}"] = { patch = "configurePlugin" },
		-- /v1/universes/{universeId}/teamcreate/memberships
		-- /v2/assets/{id}/versions
		["/v2/places/{placeId}"] = { get = "place", patch = "configurePlace" },
		["/v2/universes/{universeId}/configuration"] = { patch = "configure" },
		-- /v2/teamtest/{placeId}
	},
	economy = {
		["/v1/user/currency"] = { get = "robux" },
	},
	followings = {
		["/v1/users/{userId}/universes/{universeId}/status"] = { get = "followingStatus" },
		["/v1/users/{userId}/universes/{universeId}"] = { post = "follow", delete = "unfollow" },
		["/v2/users/{userId}/universes"] = { get = "followingsOf" },
	},
	friends = {
		["/v1/metadata"] = { get = "metadata" },
		["/v1/my/friends/count"] = { get = "count" },
		["/v1/my/friends/requests"] = { get = "friendRequests" },
		["/v1/user/friend-requests/count"] = { get = "countFriendRequests" },
		["/v1/users/{targetUserId}/followers"] = { get = "followersOf" },
		["/v1/users/{targetUserId}/followers/count"] = { get = "countFollowersOf" },
		["/v1/users/{targetUserId}/followings"] = { get = "followingsOf" },
		["/v1/users/{targetUserId}/followings/count"] = { get = "countFollowingsOf" },
		["/v1/users/{userId}/friends"] = { get = "friendsOf" },
		["/v1/users/{userId}/friends/count"] = { get = "countFriendsOf" },
		["/v1/users/{userId}/friends/find"] = { get = "friendshipsOf" },
		["/v1/users/{userId}/friends/inactive"] = { get = "inactiveFriendsOf" },
		["/v1/users/{userId}/friends/online"] = { get = "onlineFriendsOf" },
		["/v1/users/{userId}/friends/search"] = { get = "search" },
		-- /v1/users/{userId}/friends/statuses
		-- /v1/contacts/{targetContactId}/request-friendship
		["/v1/user/{userId}/multiget-are-friends"] = { post = "areFriends" },
		["/v1/user/following-exists"] = { post = "following" },
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
		["/v1/games"] = { get = "multiple" },
		["/v1/games/{placeId}/private-servers"] = { get = "privatesIn" },
		["/v1/games/{placeId}/servers/{serverType}"] = { get = "servers" },
		["/v1/games/{universeId}/favorites"] = { get = "favorited", post = "favorite" },
		["/v1/games/{universeId}/favorites/count"] = { get = "favorites" },
		["/v1/games/{universeId}/game-passes"] = { get = "gamepasses" },
		["/v1/games/{universeId}/votes/user"] = { get = "vote" },
		["/v1/games/games-product-info"] = { get = "products" },
		["/v1/games/list-spotlight"] = { get = "spotlight" },
		["/v1/games/multiget-place-details"] = { get = "places" },
		["/v1/games/multiget-playability-status"] = { get = "playability" },
		["/v1/games/recommendations/game/{universeId}"] = { get = "recommendations" },
		["/v1/games/votes"] = { get = "votes" },
		["/v1/private-servers"] = { get = "privates" },
		["/v1/private-servers/enabled-in-universe/{universeId}"] = { get = "arePrivatesEnabled" },
		["/v1/private-servers/my-private-servers"] = { get = "ownedPrivates" },
		["/v1/vip-server/can-invite/{userId}"] = { get = "canInviteToPrivate" },
		["/v1/vip-servers/{id}"] = { get = "private", patch = "configurePrivate" },
		["/v1/games/vip-servers/{universeId}"] = { post = "createPrivate" },
		["/v1/vip-servers/{id}/permissions"] = { patch = "updatePermissions" },
		["/v1/vip-servers/{id}/subscription"] = { patch = "updateSubscription" },
		["/v1/vip-servers/{id}/voicesettings"] = { patch = "updateVoiceSettings" },
		["/v1/games/{universeId}/user-votes"] = { patch = "setVote" },
		["/v2/games/{universeId}/media"] = { get = "media" },
		["/v2/groups/{groupId}/gamesV2"] = { get = "ofGroup" },
		["/v2/users/{userId}/games"] = { get = "of" },
	},
	groups = {
		["/v1/groups/metadata"] = { get = "metadata" },
		["/v1/groups/configuration/metadata"] = { get = "configurationMetadata" },
		["/v1/groups/search/metadata"] = { get = "searchMetadata" },
		-- /v1/featured-content/event
		["/v1/groups/{groupId}"] = { get = "get" },
		["/v1/groups/{groupId}/audit-log"] = { get = "auditLog" },
		["/v1/groups/{groupId}/join-requests"] = {
			get = "joinRequests",
			post = "acceptJoinRequests",
			delete = "declineJoinRequests",
		},
		["/v1/groups/{groupId}/join-requests/users/{userId}"] = {
			get = "joinRequest",
			post = "acceptJoinRequest",
			delete = "declineJoinRequest",
		},
		["/v1/groups/{groupId}/membership"] = { get = "membership" },
		["/v1/groups/{groupId}/name-history"] = { get = "nameHistory" },
		["/v1/groups/{groupId}/payout-restriction"] = { get = "canPayout" },
		["/v1/groups/{groupId}/payouts"] = { get = "recurringPayouts", post = "payout" },
		["/v1/groups/{groupId}/relationships/{groupRelationshipType}"] = { get = "relationships" },
		["/v1/groups/{groupId}/relationships/{groupRelationshipType}/requests"] = {
			get = "relationshipRequests",
			post = "acceptRelationshipRequests",
			delete = "declineRelationshipRequests",
		},
		["/v1/groups/{groupId}/roles/{roleSetId}/permissions"] = {
			get = "permissions",
			patch = "updateRolePermissions",
		},
		["/v1/groups/{groupId}/roles/{roleSetId}/users"] = { get = "usersWithRole" },
		["/v1/groups/{groupId}/roles/guest/permissions"] = { get = "guestPermissions" },
		["/v1/groups/{groupId}/roles/permissions"] = { get = "allPermissions" },
		["/v1/groups/{groupId}/settings"] = { get = "settings", patch = "updateSettings" },
		["/v1/groups/{groupId}/social-links"] = { get = "socialLinks", post = "addSocialLink" },
		["/v1/groups/{groupId}/users"] = { get = "users", post = "join" },
		["/v1/groups/search"] = { get = "search" },
		["/v1/groups/search/lookup"] = { get = "lookup" },
		["/v1/roles"] = { get = "roles" },
		["/v1/user/groups/pending"] = { get = "pending" },
		["/v1/users/{userId}/friends/groups/roles"] = { get = "withFriendsOf" },
		["/v1/users/{userId}/groups/primary/role"] = { get = "primary" },
		-- ["/v1/users/{userId}/groups/roles"] = { get = "groupsWith" },
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
		-- /v1/groups/{groupId}/wall/subscribe
		["/v1/groups/create"] = { post = "create" },
		["/v1/groups/policies"] = { post = "policies" },
		["/v1/user/groups/primary"] = { post = "setPrimaryGroup", delete = "removePrimaryGroup" },
		["/v1/groups/{groupId}/description"] = { patch = "setDescription" },
		["/v1/groups/{groupId}/name"] = { patch = "setName" },
		["/v1/groups/{groupId}/notification-preference"] = { patch = "toggleNotifications" },
		["/v1/groups/{groupId}/rolesets/{rolesetId}"] = { patch = "updateRole", delete = "deleteRole" },
		["/v1/groups/{groupId}/social-links/{socialLinkId}"] = {
			patch = "updateSocialLink",
			delete = "deleteSocialLink",
		},
		["/v1/groups/{groupId}/status"] = { patch = "setStatus" },
		["/v1/groups/{groupId}/users/{userId}"] = { patch = "changeRole", delete = "exileUser" },
		["/v1/groups/icon"] = { patch = "setIcon" },
		["/v1/groups/{groupId}/wall/posts/{postId}"] = { delete = "deleteMessage" },
		["/v1/groups/{groupId}/wall/users/{userId}/posts"] = { delete = "deleteMessagesOf" },
		["/v2/groups"] = { get = "multiple" },
		["/v2/groups/{groupId}/wall/posts"] = { get = "messages", post = "sendMessage" },
		["/v2/users/{userId}/groups/roles"] = { get = "rolesOf" },
	},
	inventory = {
		["/v1/users/{userId}/assets/collectibles"] = { get = "collectibles" },
		["/v1/users/{userId}/can-view-inventory"] = { get = "canView" },
		["/v1/users/{userId}/categories"] = { get = "categories" },
		["/v1/users/{userId}/categories/favorites"] = { get = "favorites" },
		-- /v1/users/{userId}/items/{itemType}/{itemTargetId}
		["/v1/users/{userId}/items/{itemType}/{itemTargetId}/is-owned"] = { get = "owns" },
		["/v1/users/{userId}/places/inventory"] = { get = "games" },
		-- /v1/collections/items/{itemType}/{itemTargetId}
		["/v2/assets/{assetId}/owners"] = { get = "owners" },
		["/v2/users/{userId}/inventory"] = { get = "of" },
		["/v2/inventory/asset/{assetId}"] = { delete = "remove" },
	},
	notifications = {
		["/v2/push-notifications/metadata"] = { get = "metadata" },
		["/v2/stream-notifications/metadata"] = { get = "streamMetadata" },
		["/v2/notifications/settings/realtime"] = { get = "realtimeSettings" },
		["/v2/push-notifications/chrome-manifest"] = { get = "chromeManifest" },
		["/v2/push-notifications/get-current-device-destination"] = { get = "destination" },
		["/v2/push-notifications/get-destinations"] = { get = "destinations" },
		["/v2/push-notifications/notification-ids"] = { get = "multiple" },
		["/v2/stream-notifications/get-latest-game-updates"] = { get = "latestGameUpdates" },
		["/v2/stream-notifications/get-recent"] = { get = "recent" },
		["/v2/stream-notifications/unread-count"] = { get = "countUnread" },
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
	premiumfeatures = {
		-- /v1/users/{userId}/premium-upsell-precheck
		["/v1/users/{userId}/validate-membership"] = { get = "has" },
	},
	presence = {
		-- ["/v1/presence/last-online"] = { post = "getLastOnlineTimestamps" },
		["/v1/presence/users"] = { post = "get" },
	},
	privatemessages = {
		["/v1/announcements"] = { get = "announcements" },
		["/v1/announcements/metadata"] = { get = "announcementMetadata" },
		["/v1/messages"] = { get = "all" },
		["/v1/messages/{messageId}"] = { get = "get" },
		["/v1/messages/{userId}/can-message"] = { get = "canMessage" },
		["/v1/messages/unread/count"] = { get = "countUnread" },
		["/v1/messages/archive"] = { post = "archive" },
		["/v1/messages/unarchive"] = { post = "unarchive" },
		["/v1/messages/mark-read"] = { post = "markAsRead" },
		["/v1/messages/mark-unread"] = { post = "markAsUnread" },
		["/v1/messages/send"] = { post = "send" },
	},
	trades = {
		["/v1/trades/metadata"] = { get = "metadata" },
		["/v1/trades/{tradeId}"] = { get = "get" },
		["/v1/trades/{tradeStatusType}"] = { get = "all" },
		["/v1/trades/{tradeStatusType}/count"] = { get = "count" },
		["/v1/users/{userId}/can-trade-with"] = { get = "canSend" },
		["/v1/trades/{tradeId}/accept"] = { post = "accept" },
		["/v1/trades/{tradeId}/counter"] = { post = "counter" },
		["/v1/trades/{tradeId}/decline"] = { post = "decline" },
		["/v1/trades/send"] = { post = "send" },
	},
	users = {
		["/v1/birthdate"] = { get = "birthdate", post = "setBirthdate" },
		["/v1/description"] = { get = "description", post = "setDescription" },
		["/v1/gender"] = { get = "gender", post = "setGender" },
		["/v1/users/{userId}/display-names"] = { patch = "setDisplayName" },
		["/v1/users/{userId}"] = { get = "get" },
		["/v1/users/authenticated"] = { get = "authenticated" },
		["/v1/users/authenticated/age-bracket"] = { get = "ageBracket" },
		["/v1/users/authenticated/country-code"] = { get = "countryCode" },
		["/v1/users/authenticated/roles"] = { get = "publicRoles" },
		["/v1/users"] = { post = "fromIds" },
		["/v1/usernames/users"] = { post = "fromNames" },
		["/v1/users/{userId}/username-history"] = { get = "usernameHistory" },
		["/v1/users/search"] = { get = "search" },
	},
}

local function resolveOpenApiDefinition(namespace: string, version: number): OpenApiDefinition?
	local response = net.request(
		`https://create.roblox.com/docs/_next/data/203AYidpISfppRfYMTY9D/cloud/legacy/{namespace}/v{version}.json`
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
			if openapiType.description ~= nil then
				local mappedItem = openapiType.description:match(`'([^']-)' = {item}`)
				if mappedItem ~= nil then
					item = mappedItem
				end
			end

			if typeof(item) == "string" then
				table.insert(enum, `"{item}"`)
				continue
			end

			table.insert(enum, item)
		end

		return `{table.concat(enum, " | ")}`
	end

	if openapiType.type == "array" then
		if openapiType.items == nil then
			return "{}"
		end

		return `\{ {translateOpenApiType(openapiType.items)} \}`
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

local function documentOpenApiType(name: string, openapiType: { type: string, [string]: any }): string
	if openapiType.type == "object" then
		local comment = `--- @interface {name}`

		if openapiType.properties == nil then
			return comment
		end

		for name, type in openapiType.properties do
			comment ..= `\n--- .{name} {translateOpenApiType(type)}`
		end

		return comment
	end

	return `--- @type {name} {translateOpenApiType(openapiType)}`
end

local function stylua(file: string): string
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

	file ..= `--- [{openapis[1].host}](https://{openapis[1].host})\n`
	file ..= `--- @class {namespace}\n\n`

	for _, openapi in openapis do
		if openapi.definitions == nil then
			continue
		end

		for name, model in openapi.definitions do
			local patchName = patchOpenApiModelName(name)
			if file:match(`export type {patchName} =`) ~= nil then
				file ..= "\n"
				continue
			end

			if model.description ~= nil then
				local patch = model.description:gsub("([^\n]+)", "--- %1"):gsub("</?p>", "")
				file ..= `{patch}\n`
			end

			file ..= documentOpenApiType(patchName, model) .. "\n"
			file ..= `--- @within {namespace}\n`
			file ..= `export type {patchName} = {translateOpenApiType(model)}\n\n`
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
				local accessKey: string? = nil

				if okResponse.schema ~= nil then
					local schema = okResponse.schema
					if schema["$ref"] ~= nil then
						local ref = schema["$ref"]:gsub("#/definitions/", "")
						for name, definition in openapi.definitions do
							if name == ref then
								schema = definition
								break
							end
						end
					end

					local firstKey = if schema.properties ~= nil then next(schema.properties) else nil
					if firstKey ~= nil and next(schema.properties, firstKey) == nil then
						patchModelName = translateOpenApiType(schema.properties[firstKey])
						accessKey = firstKey
					end
				end

				local needsCookie = route.responses["401"] ~= nil or route.responses["403"] ~= nil

				local parameters: { { name: string, type: string } } = {}
				local bodyParameter

				if route.parameters ~= nil then
					for _, parameter in route.parameters do
						if parameter["in"] == "body" then
							bodyParameter = parameter
							continue
						end

						local name = parameter.name:sub(1, 1):lower() .. parameter.name:sub(2)

						local type = translateOpenApiType(parameter)
						if not parameter.required then
							type ..= "?"
						end

						table.insert(parameters, { name = name, type = type })
					end
				end

				if route.summary ~= nil then
					local patchSummary = route.summary:gsub("([^\n]+)", "--- %1"):gsub("</?p>", "")
					file ..= `{patchSummary}\n`
				end

				file ..= `--- @within {namespace}\n`

				local firstKey = next(parameters)

				local onlyParameter = nil
				if firstKey ~= nil and next(parameters, firstKey) == nil and bodyParameter == nil then
					onlyParameter = parameters[firstKey]
				elseif firstKey == nil and bodyParameter ~= nil then
					local schema = bodyParameter.schema
					if schema["$ref"] ~= nil then
						local ref = schema["$ref"]:gsub("#/definitions/", "")
						for name, definition in openapi.definitions do
							if name == ref then
								schema = definition
								break
							end
						end
					end

					if schema.type == "object" then
						local firstKey = if schema.properties ~= nil then next(schema.properties) else nil
						if firstKey ~= nil and next(schema.properties, firstKey) == nil then
							onlyParameter = table.clone(schema.properties[firstKey])
							onlyParameter.name = firstKey
						end
					else
						onlyParameter = bodyParameter
					end
				end

				local cookieParameter = if needsCookie then "cookie: string" else "cookie: string?"

				if onlyParameter ~= nil then
					local parameterName = onlyParameter.name:sub(1, 1):lower() .. onlyParameter.name:sub(2)
					file ..= `local function {name}({parameterName}: {translateOpenApiType(onlyParameter)}, {cookieParameter}): {patchModelName}\n`
				elseif firstKey == nil and bodyParameter ~= nil then
					file ..= `local function {name}(`

					if consumesJson then
						file ..= `request: {translateOpenApiType(bodyParameter.schema)}`
						file ..= ", "
					end

					file ..= `{cookieParameter}): {patchModelName}\n`
				else
					file ..= `local function {name}(request:`

					if consumesJson then
						file ..= `{translateOpenApiType(bodyParameter.schema)} &`
					end

					file ..= "{"

					for _, parameter in parameters do
						file ..= `{parameter.name}: {parameter.type},`
					end

					file ..= `}, {cookieParameter}): {patchModelName}\n`
				end

				local function readRequest(field: string): string
					return if onlyParameter ~= nil then field else `request.{field}`
				end

				file ..= "local response = requestWithCsrfToken({\n"

				file ..= `method = "{method:upper()}",\n`

				local patchEndpoint = endpoint:gsub("{(.-)}", `\{{readRequest("%1")}\}`)

				if route.parameters ~= nil then
					local isFirstPathParameter = true

					for _, parameter in route.parameters do
						if parameter["in"] ~= "query" and parameter["in"] ~= "formData" then
							continue
						end

						local name = parameter.name:sub(1, 1):lower() .. parameter.name:sub(2)

						local symbol = if isFirstPathParameter then "?" else "&"

						if isFirstPathParameter then
							isFirstPathParameter = false
						end

						local value = if parameter.type == "array"
							then `table.concat({readRequest(name)} {if parameter.required then "" else "or {}"}, "&{name}=")`
							else `{readRequest(name)} {if parameter.required then "" else 'or ""'}`

						patchEndpoint ..= `{symbol}{name}=\{{value}\}`
					end
				end

				file ..= `url = \`https://{openapi.host}{patchEndpoint}\`,\n`

				file ..= "headers = {"

				if consumesJson then
					file ..= '["Content-Type"] = "application/json",'
				end

				if needsCookie then
					file ..= "Cookie = `.ROBLOSECURITY={cookie}`,"
				else
					file ..= 'Cookie = `.ROBLOSECURITY={cookie or ""}`,'
				end

				file ..= "},\n"

				if consumesJson then
					if onlyParameter == nil then
						file ..= 'body = serde.encode("json", request),\n'
					else
						local name = onlyParameter.name:sub(1, 1):lower() .. onlyParameter.name:sub(2)
						file ..= `body = serde.encode("json", \{ {name} = {onlyParameter.name} \})`
					end
				end

				file ..= "})\n\n"

				file ..= "assert(response.ok, `{response.statusCode} {response.statusMessage}`)\n\n"

				if producesJson then
					file ..= 'return serde.decode("json", response.body)'

					if accessKey ~= nil then
						file ..= `.{accessKey}`
					end

					file ..= "\n"
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

	fs.writeFile(`src/{namespace}.luau`, if FORMAT then stylua(file) else file)
end

local file = ""

for namespace in mappings do
	file ..= `local {namespace} = require("./{namespace}")\n`
end

file ..= "\nreturn {"

for namespace, _ in mappings do
	file ..= `{namespace} = {namespace},`
end

file ..= "}"

fs.writeFile("src/init.luau", if FORMAT then stylua(file) else file)
