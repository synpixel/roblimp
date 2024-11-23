local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- Multi-payout request information.
export type PayoutRequest = { PayoutType: number, Recipients: { PayoutRecipientRequest } }

--- <no description>
export type GroupOpenCloudPermissionsModel = { useCloudAuthentication: boolean, administerCloudAuthentication: boolean }

--- A model representing data about an Roblox.Platform.Membership.IUser
export type GroupManagementPermissionsModel = { viewAuditLogs: boolean, manageClan: boolean, manageRelationships: boolean }

--- A request model for updating a group's settings.
export type UpdateGroupSettingsRequest = {
	areGroupFundsVisible: boolean,
	isApprovalRequired: boolean,
	areGroupGamesVisible: boolean,
	areEnemiesAllowed: boolean,
}

--- <no description>
export type UserGroupMembershipResponsePages = { data: { UserGroupMembershipResponse } }

--- <no description>
export type IUploadedFile = buffer

--- A group roles response model
export type GroupAllRolesResponse = { roles: { GroupRoleResponse }, groupId: number }

--- A response model for group wall post information
export type GroupWallPostModel = { created: string, id: number, updated: string, body: string, poster: UserModel }

--- A group search response
export type GroupSearchResponseItem = {
	created: string,
	description: string,
	id: number,
	hasVerifiedBadge: boolean,
	memberCount: number,
	updated: string,
	name: string,
	previousName: string,
	publicEntryAllowed: boolean,
}

--- A request model for setting a name for the group
export type UpdateGroupNameRequest = { name: string }

--- A group audit log response model
export type GroupAuditLogResponseItem = {
	created: string,
	actor: UserGroupRoleResponse,
	description: nil,
	actionType: string,
}

--- <no description>
export type GroupPayoutResponsePages = { data: { GroupPayoutResponse } }

--- <no description>
export type CreateRoleSetRequest = { description: string, usingGroupFunds: boolean, name: string, rank: number }

--- A model representing data about an Roblox.Platform.Membership.IUser
export type GroupEconomyPermissionsModel = {
	viewGroupPayouts: boolean,
	manageGroupGames: boolean,
	createItems: boolean,
	manageItems: boolean,
	advertiseGroup: boolean,
	viewAnalytics: boolean,
	spendGroupFunds: boolean,
	addGroupPlaces: boolean,
}

--- <no description>
export type GroupDescriptionResponse = { newDescription: string }

--- A model representing group posts permissions
export type GroupPostsPermissionsModel = {
	postToStatus: boolean,
	viewStatus: boolean,
	postToWall: boolean,
	deleteFromWall: boolean,
	viewWall: boolean,
}

--- A user's group membership metadata response model
export type GroupMembershipMetadataResponse = {
	canConfigure: boolean,
	groupId: number,
	areGroupGamesVisible: boolean,
	userRole: UserGroupRoleResponse,
	permissions: GroupPermissionsModel,
	isPendingJoin: boolean,
	isBannedFromGroup: boolean,
	isNotificationsEnabled: boolean,
	isPrimary: boolean,
	areEnemiesAllowed: boolean,
	areGroupFundsVisible: boolean,
}

--- Response model for Group Payout Restriction
export type GroupPayoutRestrictionResponse = { canUseOneTimePayout: boolean, canUseRecurringPayout: boolean }

--- Response model for Group Settings
export type GroupSettingsResponse = {
	isGroupNameChangeEnabled: boolean,
	areEnemiesAllowed: boolean,
	areGroupFundsVisible: boolean,
	isApprovalRequired: boolean,
	areGroupGamesVisible: boolean,
	isBuildersClubRequired: boolean,
}

--- <no description>
export type ShoutResponse = { created: string, updated: string, poster: UserModel, body: string }

--- A request model for changing the group owner.
export type ChangeOwnerRequest = { userId: number }

--- A group role response model
export type GroupRoleResponse = { name: string, id: number, memberCount: number, description: string, rank: number }

--- <no description>
export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- A detailed group response model
export type GroupDetailResponse = {
	description: string,
	id: number,
	owner: UserModel,
	hasVerifiedBadge: boolean,
	memberCount: number,
	isBuildersClubOnly: boolean,
	isLocked: boolean,
	name: string,
	shout: ShoutResponse,
	publicEntryAllowed: boolean,
}

--- <no description>
export type GroupRoleDetailResponse = {
	name: string,
	groupId: number,
	id: number,
	memberCount: number,
	description: string,
	rank: number,
}

--- A request model for joining group.
export type JoinGroupRequest = {
	challengeId: string,
	redemptionToken: string,
	sessionId: string,
	captchaId: string,
	captchaProvider: string,
	captchaToken: string,
}

--- <no description>
export type GroupDetailResponsePages = { data: { GroupDetailResponse } }

--- <no description>
export type GroupResponseV2 = {
	created: string,
	name: string,
	description: string,
	id: number,
	owner: GroupOwnerTypePages,
	hasVerifiedBadge: boolean,
	memberCount: number,
}

--- A response model for group configuration
export type GroupConfigurationDisplayOptionsResponse = {
	groupConfiguration: GroupConfigurationResponse,
	recurringPayoutsConfiguration: RecurringPayoutsConfigurationResponse,
	isDefaultEmblemPolicyEnabled: boolean,
	isPremiumPayoutsEnabled: boolean,
	groupNameChangeConfiguration: GroupNameChangeConfigurationResponse,
	roleConfiguration: RoleConfigurationResponse,
}

--- Response model for !:GroupJoinRequests
export type GroupJoinRequestResponse = { requester: UserModel, created: string }

--- A response model for group configuration
export type GroupConfigurationResponse = {
	iconMaxFileSizeMb: number,
	isUsingTwoStepWebviewComponent: boolean,
	cost: number,
	descriptionMaxLength: number,
	nameMaxLength: number,
}

--- <no description>
export type UpdateRoleSetRequest = { description: string, name: string, rank: number }

--- A user group role response model
export type UserGroupRoleResponse = { role: GroupRoleResponse, user: UserModel }

--- A request model for creating a group wall post
export type CreateWallPostRequest = {
	challengeId: string,
	captchaToken: string,
	captchaId: string,
	captchaProvider: string,
	body: string,
}

--- A group membership response model
export type GroupMembershipDetailResponse = {
	group: GroupDetailResponse,
	role: GroupRoleResponse,
	isPrimaryGroup: boolean,
	isNotificationsEnabled: boolean,
}

--- <no description>
export type GroupNameHistoryResponseItemPages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GroupNameHistoryResponseItem },
}

--- <no description>
export type GroupPolicyRequest = { groupIds: { number } }

--- <no description>
export type GroupRoleDetailResponsePages = { data: { GroupRoleDetailResponse } }

--- <no description>
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- <no description>
export type GroupMembershipDetailResponsePages = { data: { GroupMembershipDetailResponse } }

--- A response model for recurring payout configuration
export type RecurringPayoutsConfigurationResponse = { maxPayoutPartners: number }

--- <no description>
export type GroupBasicResponsePages = { data: { GroupBasicResponse } }

--- A model representing data about an Roblox.Platform.Membership.IUser
export type GroupMembershipPermissionsModel = {
	banMembers: boolean,
	changeRank: boolean,
	removeMembers: boolean,
	inviteMembers: boolean,
}

--- <no description>
export type GroupJoinRequestResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GroupJoinRequestResponse },
}

--- <no description>
export type RelationshipsRequest = { GroupIds: { number } }

--- <no description>
export type Stream = {
	CanRead: boolean,
	CanWrite: boolean,
	CanTimeout: boolean,
	Position: number,
	WriteTimeout: number,
	Length: number,
	ReadTimeout: number,
	CanSeek: boolean,
}

--- A request model for setting the authenticated user's primary group.
export type PostGroupStatusRequest = { message: string }

--- ApiPageResponse for catalog search
export type GroupSearchPageResponse = {
	nextPageCursor: string,
	data: { GroupSearchResponseItem },
	keyword: string,
	previousPageCursor: string,
}

--- <no description>
export type GroupWallPostModelPages = { nextPageCursor: string, previousPageCursor: string, data: { GroupWallPostModel } }

--- A group role's permissions response model
export type GroupPermissionsResponse = { permissions: GroupPermissionsModel, role: GroupRoleResponse, groupId: number }

--- <no description>
export type UserModelPages = { nextPageCursor: string, previousPageCursor: string, data: { UserModel } }

--- <no description>
export type GroupPolicyResponse = { canViewGroup: boolean, groupId: number }

--- <no description>
export type Int32Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- A request model for setting the authenticated user's primary group.
export type PrimaryGroupRequest = { groupId: number }

--- <no description>
--- <no description>
--- <no description>
export type GroupPermissionsResponsePages = { data: { GroupPermissionsResponse } }

--- A social link response from a create request
export type SocialLinkResponse = { id: number, type: number, title: string, url: string }

--- A request model for setting a users role in a group.
export type UpdateUserRoleRequest = { roleId: number }

--- <no description>
export type GroupOwnerTypePages = { id: number, type: number, name: string }

--- <no description>
export type GroupBasicResponse = { id: number, hasVerifiedBadge: boolean, name: string, memberCount: number }

--- A request model for paying out Robux.
export type PayoutRecipientRequest = { amount: number, recipientType: number, recipientId: number }

--- ApiPageResponse for group audit log
export type GroupAuditLogResponseItemPages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GroupAuditLogResponseItem },
}

--- <no description>
export type SocialLinkResponsePages = { data: { SocialLinkResponse } }

--- <no description>
export type UpdateGroupNameResponse = { newName: string }

--- <no description>
export type GroupFeaturedContentResponse = { contentType: string, contentId: string, groupId: number }

--- A users group membership response model
export type UserGroupMembershipResponse = { groups: { GroupMembershipDetailResponse }, user: UserModel }

--- <no description>
export type ApiEmptyResponseModel = {}

--- A request model for updating a group's roleset's permissions.
export type UpdatePermissionsRequest = {
	permissions: {
		InviteMembers: boolean,
		AddGroupPlaces: boolean,
		PostToWall: boolean,
		BanMembers: boolean,
		PostToStatus: boolean,
		ManageGroupGames: boolean,
		ChangeRank: boolean,
		RemoveMembers: boolean,
		ViewStatus: boolean,
		AdvertiseGroup: boolean,
		UseCloudAuthentication: boolean,
		SpendGroupFunds: boolean,
		AdministerCloudAuthentication: boolean,
		ViewAnalytics: boolean,
		ManageItems: boolean,
		CreateItems: boolean,
		ManageClan: boolean,
		ViewAuditLogs: boolean,
		DeleteFromWall: boolean,
		ManageRelationships: boolean,
		ViewWall: boolean,
	},
}

--- A request model for updating a group's notification preference.
export type UpdateGroupNotificationPreferenceRequest = { notificationsEnabled: boolean }

--- <no description>
export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- A request model for setting a description for the group
export type UpdateGroupDescriptionRequest = { description: string }

--- <no description>
--- <no description>
export type GroupPoliciesResponse = { groups: { GroupPolicyResponse } }

--- <no description>
export type GroupNameChangeConfigurationResponse =
	{ ownershipCooldownInDays: number, cooldownInDays: number, cost: number }

--- An update request for a social link
export type SocialLinkRequest = { type: number, title: string, url: string }

--- A response model for role configuration
export type RoleConfigurationResponse = {
	limit: number,
	cost: number,
	maxRank: number,
	minRank: number,
	descriptionMaxLength: number,
	nameMaxLength: number,
}

--- <no description>
export type UserGroupRoleResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { UserGroupRoleResponse },
}

--- A group name history response model
export type GroupNameHistoryResponseItem = { name: string, created: string }

--- <no description>
export type MembersRequest = { UserIds: { number } }

--- A group relationships response model
export type GroupRelationshipsResponse = {
	totalGroupCount: number,
	groupId: number,
	nextRowIndex: number,
	relationshipType: number,
	relatedGroups: { GroupDetailResponse },
}

--- A group roles response model
export type GroupsDisplayOptionsResponse = {
	isGroupWallNotificationsEnabled: boolean,
	groupPostMaxLength: number,
	currentGroupCount: number,
	groupStatusMaxLength: number,
	groupWallNotificationsSubscribeIntervalInMilliseconds: number,
	groupLimit: number,
	areGroupBansEnabled: boolean,
	areProfileGroupsHidden: boolean,
	isGroupDetailsPolicyEnabled: boolean,
	showPreviousGroupNames: boolean,
}

--- A model for group permissions.
export type GroupPermissionsModel = {
	groupMembershipPermissions: GroupMembershipPermissionsModel,
	groupEconomyPermissions: GroupEconomyPermissionsModel,
	groupOpenCloudPermissions: GroupOpenCloudPermissionsModel,
	groupPostsPermissions: GroupPostsPermissionsModel,
	groupManagementPermissions: GroupManagementPermissionsModel,
}

--- A model representing data about an Roblox.Platform.Membership.IUser
export type UserModel = {
	username: string,
	buildersClubMembershipType: number,
	userId: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- Response Model For Group Search Metadata Endpoint
export type GroupSearchMetadataResponse = { ShowFriendsGroupsSort: boolean, SuggestedGroupKeywords: { string } }

--- A group payout response
export type GroupPayoutResponse = { percentage: number, user: UserModel }

--- <no description>
--- <no description>
export type GroupMembershipResponsePages = { data: { GroupMembershipResponse } }

--- A group role response model
--- <no description>
export type GroupWallPostV2ModelPages =
	{ nextPageCursor: string, previousPageCursor: string, data: { GroupWallPostV2Model } }

--- <no description>
export type GroupResponseV2Pages = { data: { GroupResponseV2 } }

--- A basic group membership response model
export type GroupMembershipResponse = {
	group: GroupBasicResponse,
	role: GroupRoleBasicResponse,
	isNotificationsEnabled: boolean,
}

--- <no description>
--- A user group role response model
--- A request model for creating a group wall post
--- <no description>
--- <no description>
export type GroupRoleBasicResponse = { id: number, name: string, rank: number }

--- <no description>
--- A model representing data about an Roblox.Platform.Membership.IUser
--- <no description>
--- A response model for group wall post information
export type GroupWallPostV2Model = {
	created: string,
	id: number,
	updated: string,
	body: string,
	poster: UserGroupRoleResponse,
}

--- Gets Group configuration contextual information
local function configurationMetadata(): GroupConfigurationDisplayOptionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/configuration/metadata`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets Groups contextual information:
--- Max number of groups a user can be part of.
--- Current number of groups a user is a member of.
--- Whether to show/hide certain features based on device type.
local function metadata(): GroupsDisplayOptionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/metadata`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Changes the group owner to another user.
local function giveOwnership(with: ChangeOwnerRequest & { groupId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/change-owner`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch accepts group join requests
local function acceptJoinRequests(with: MembersRequest & { groupId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/join-requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch declines group join requests
local function declineJoinRequests(with: MembersRequest & { groupId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/join-requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a page of Group Join Requests for a group.
local function joinRequests(
	with: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"?, cookie: string }
): GroupJoinRequestResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/join-requests?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of users in a group for a specific roleset.
local function usersWithRole(
	with: {
		groupId: number,
		roleSetId: number,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	}
): UserModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/roles/{with.roleSetId}/users?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a social link
local function updateSocialLink(
	with: SocialLinkRequest & { groupId: number, socialLinkId: number, cookie: string }
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/social-links/{with.socialLinkId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes a social link
local function deleteSocialLink(with: { groupId: number, socialLinkId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/social-links/{with.socialLinkId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets groups that the authenticated user has requested to join
local function pending(with: { cookie: string }): { GroupDetailResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/user/groups/pending`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets the Group's audit log
local function auditLog(with: {
	groupId: number,
	actionType: "DeletePost"
		| "RemoveMember"
		| "AcceptJoinRequest"
		| "DeclineJoinRequest"
		| "PostStatus"
		| "ChangeRank"
		| "BuyAd"
		| "SendAllyRequest"
		| "CreateEnemy"
		| "AcceptAllyRequest"
		| "DeclineAllyRequest"
		| "DeleteAlly"
		| "DeleteEnemy"
		| "AddGroupPlace"
		| "RemoveGroupPlace"
		| "CreateItems"
		| "ConfigureItems"
		| "SpendGroupFunds"
		| "ChangeOwner"
		| "Delete"
		| "AdjustCurrencyAmounts"
		| "Abandon"
		| "Claim"
		| "Rename"
		| "ChangeDescription"
		| "InviteToClan"
		| "KickFromClan"
		| "CancelClanInvite"
		| "BuyClan"
		| "CreateGroupAsset"
		| "UpdateGroupAsset"
		| "ConfigureGroupAsset"
		| "RevertGroupAsset"
		| "CreateGroupDeveloperProduct"
		| "ConfigureGroupGame"
		| "CreateGroupDeveloperSubscriptionProduct"
		| "Lock"
		| "Unlock"
		| "CreateGamePass"
		| "CreateBadge"
		| "ConfigureBadge"
		| "SavePlace"
		| "PublishPlace"
		| "UpdateRolesetRank"
		| "UpdateRolesetData"
		| "BanMember"
		| "UnbanMember"?,
	userId: number?,
	limit: number?,
	cursor: string?,
	sortOrder: "Asc" | "Desc"?,
	cookie: string,
}): GroupAuditLogResponseItemPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/audit-log?actionType={with.actionType or ""}&userId={with.userId or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Joins a group
local function join(with: JoinGroupRequest & { groupId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/users`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of users in a group.
local function users(
	with: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): UserGroupRoleResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/users?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets group status
local function setStatus(with: PostGroupStatusRequest & { groupId: number, cookie: string }): ShoutResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/status`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the group's name.
local function setName(with: UpdateGroupNameRequest & { groupId: number, cookie: string }): string
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/name`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).newName
end

--- Gets a list of all groups the specified users' friends are in.
local function withFriendsOf(with: { userId: number }): { UserGroupMembershipResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/users/{with.userId}/friends/groups/roles`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets a value indicating whether the group can use payout feature
local function canPayout(with: { groupId: number, cookie: string }): GroupPayoutRestrictionResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/payout-restriction`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a group's relationships
local function relationships(
	with: { groupId: number, groupRelationshipType: string, StartRowIndex: number, MaxRows: number }
): GroupRelationshipsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}?StartRowIndex={with.StartRowIndex}&MaxRows={with.MaxRows}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the Group's name change history.
local function nameHistory(
	with: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): GroupNameHistoryResponseItemPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/name-history?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get suggested groups and other miscellaneous information needed for the group/join page like flags
local function searchMetadata(): GroupSearchMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/search/metadata`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the user's group notification preferences
local function toggleNotifications(
	with: UpdateGroupNotificationPreferenceRequest & { groupId: number, cookie: string }
): number
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/notification-preference`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Accepts a group relationship request.
local function acceptRelationshipRequest(with: {
	groupId: number,
	groupRelationshipType: string,
	relatedGroupId: number,
	cookie: string,
}): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}/requests/{with.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Declines a group relationship request.
local function declineRelationshipRequest(with: {
	groupId: number,
	groupRelationshipType: string,
	relatedGroupId: number,
	cookie: string,
}): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}/requests/{with.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes a group wall post.
local function deleteMessage(with: { groupId: number, postId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/wall/posts/{with.postId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the group icon.
local function setIcon(with: { groupId: number, Files: buffer?, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/icon?groupId={with.groupId}&Files={with.Files or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a users role in a group.
local function changeRole(
	with: UpdateUserRoleRequest & { groupId: number, userId: number, cookie: string }
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/users/{with.userId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes a user from a group
local function exileUser(with: { groupId: number, userId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/users/{with.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all permissions for each role
local function allPermissions(with: { groupId: number, cookie: string }): { GroupPermissionsResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/roles/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Updates existing group roleset.
local function updateRole(
	with: UpdateRoleSetRequest & { groupId: number, rolesetId: number, cookie: string }
): GroupRoleResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/rolesets/{with.rolesetId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes existing group roleset.
local function deleteRole(with: { groupId: number, rolesetId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/rolesets/{with.rolesetId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates new group roleset.
local function createRole(with: CreateRoleSetRequest & { groupId: number, cookie: string }): GroupRoleResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/rolesets/create`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the permissions for a group's guest roleset. These can be viewed by all (members and guests) users.
local function guestPermissions(with: { groupId: number }): GroupPermissionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/roles/guest/permissions`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes all group wall posts made by a specific user.
local function deleteMessagesOf(with: { groupId: number, userId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/wall/users/{with.userId}/posts`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets group membership information in the context of the authenticated user
local function membership(
	with: { groupId: number, includeNotificationPreferences: boolean }
): GroupMembershipMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/membership?includeNotificationPreferences={with.includeNotificationPreferences}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Pays out a user in Robux.
local function payout(with: PayoutRequest & { groupId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/payouts`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of the group payout percentages
local function recurringPayouts(with: { groupId: number, cookie: string }): { GroupPayoutResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/payouts`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Updates the group's settings
local function updateSettings(
	with: UpdateGroupSettingsRequest & { groupId: number, cookie: string }
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/settings`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the Group's settings
local function settings(with: { groupId: number, cookie: string }): GroupSettingsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/settings`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the groups description
local function setDescription(with: UpdateGroupDescriptionRequest & { groupId: number, cookie: string }): string
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/description`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).newDescription
end

--- Sets the authenticated user's primary group
local function setPrimaryGroup(with: PrimaryGroupRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/user/groups/primary`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes the authenticated user's primary group
local function removePrimaryGroup(with: { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/user/groups/primary`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Looks up groups by a name. Prioritizes an exact match as the first result.
local function lookup(with: { groupName: string }): { GroupBasicResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/search/lookup?groupName={with.groupName}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets group information
local function get(with: { groupId: number }): GroupDetailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Accepts a group join request.
local function acceptJoinRequest(with: { groupId: number, userId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/join-requests/users/{with.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Declines/cancels a group join request.
local function declineJoinRequest(with: { groupId: number, userId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/join-requests/users/{with.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a group join request by userId.
local function joinRequest(with: { groupId: number, userId: number, cookie: string }): GroupJoinRequestResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/join-requests/users/{with.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets group policy info used for compliance.
local function policies(with: GroupPolicyRequest & { cookie: string }): { GroupPolicyResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/policies`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).groups
end

--- Creates a new group.
local function create(with: {
	name: string?,
	description: string?,
	publicGroup: boolean?,
	buildersClubMembersOnly: boolean?,
	Files: buffer?,
	cookie: string,
}): GroupResponseV2
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/create?name={with.name or ""}&description={with.description or ""}&publicGroup={with.publicGroup or ""}&buildersClubMembersOnly={with.buildersClubMembersOnly or ""}&Files={with.Files or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Create a group relationship.
local function requestRelationship(
	with: {
		groupId: number,
		groupRelationshipType: string,
		relatedGroupId: number,
		cookie: string,
	}
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}/{with.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes a group relationship.
local function deleteRelationship(
	with: {
		groupId: number,
		groupRelationshipType: string,
		relatedGroupId: number,
		cookie: string,
	}
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}/{with.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Search for groups by keyword.
local function search(
	with: { keyword: string, prioritizeExactMatch: boolean?, limit: number?, cursor: string? }
): GroupSearchPageResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/search?keyword={with.keyword}&prioritizeExactMatch={with.prioritizeExactMatch or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch accepts group affiliate requests
local function acceptRelationshipRequests(
	with: RelationshipsRequest & { groupId: number, groupRelationshipType: string, cookie: string }
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}/requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch declines group affiliate requests
local function declineRelationshipRequests(
	with: RelationshipsRequest & { groupId: number, groupRelationshipType: string, cookie: string }
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}/requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a group's relationship requests
local function relationshipRequests(with: {
	groupId: number,
	groupRelationshipType: string,
	StartRowIndex: number,
	MaxRows: number,
	cookie: string,
}): GroupRelationshipsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/relationships/{with.groupRelationshipType}/requests?StartRowIndex={with.StartRowIndex}&MaxRows={with.MaxRows}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates recurring payouts.
local function updateRecurringPayouts(with: PayoutRequest & { groupId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/payouts/recurring`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the permissions for a group's roleset. The authorized user must be the group owner.
local function updateRolePermissions(
	with: UpdatePermissionsRequest & { groupId: number, roleSetId: number, cookie: string }
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/roles/{with.roleSetId}/permissions`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the permissions for a group's roleset. The authorized user must either be the group owner or the roleset being requested, except for guest roles, which can be viewed by all (members and guests).
local function permissions(with: { groupId: number, roleSetId: number, cookie: string }): GroupPermissionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/roles/{with.roleSetId}/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Claims ownership of the group as the authenticated user
local function claimOwnership(with: { groupId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/claim-ownership`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a user's primary group.
local function primary(with: { userId: number }): GroupMembershipDetailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/users/{with.userId}/groups/primary/role`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the Roles by their ids.
local function roles(with: { ids: { number } }): { GroupRoleDetailResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/roles?ids={table.concat(with.ids, "&ids=")}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Posts a social links
local function addSocialLink(with: SocialLinkRequest & { groupId: number, cookie: string }): SocialLinkResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/social-links`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get social link data associated with a group
local function socialLinks(with: { groupId: number, cookie: string }): { SocialLinkResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{with.groupId}/social-links`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Creates a post on a group wall
local function sendMessage(with: CreateWallPostRequest & { groupId: number, cookie: string }): GroupWallPostV2Model
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v2/groups/{with.groupId}/wall/posts`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of group wall posts.
local function messages(
	with: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): GroupWallPostV2ModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v2/groups/{with.groupId}/wall/posts?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Multi-get groups information by Ids.
local function multiple(with: { groupIds: { number } }): { GroupResponseV2 }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v2/groups?groupIds={table.concat(with.groupIds, "&groupIds=")}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets a list of all group roles for groups the specified user is in.
local function rolesOf(
	with: { userId: number, includeLocked: boolean, includeNotificationPreferences: boolean }
): { GroupMembershipResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v2/users/{with.userId}/groups/roles?includeLocked={with.includeLocked}&includeNotificationPreferences={with.includeNotificationPreferences}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

return {
	configurationMetadata = configurationMetadata,
	metadata = metadata,
	giveOwnership = giveOwnership,
	acceptJoinRequests = acceptJoinRequests,
	declineJoinRequests = declineJoinRequests,
	joinRequests = joinRequests,
	usersWithRole = usersWithRole,
	updateSocialLink = updateSocialLink,
	deleteSocialLink = deleteSocialLink,
	pending = pending,
	auditLog = auditLog,
	join = join,
	users = users,
	setStatus = setStatus,
	setName = setName,
	sendMessage = sendMessage,
	messages = messages,
	withFriendsOf = withFriendsOf,
	canPayout = canPayout,
	relationships = relationships,
	nameHistory = nameHistory,
	searchMetadata = searchMetadata,
	multiple = multiple,
	toggleNotifications = toggleNotifications,
	acceptRelationshipRequest = acceptRelationshipRequest,
	declineRelationshipRequest = declineRelationshipRequest,
	deleteMessage = deleteMessage,
	setIcon = setIcon,
	changeRole = changeRole,
	exileUser = exileUser,
	allPermissions = allPermissions,
	updateRole = updateRole,
	deleteRole = deleteRole,
	createRole = createRole,
	guestPermissions = guestPermissions,
	deleteMessagesOf = deleteMessagesOf,
	membership = membership,
	payout = payout,
	recurringPayouts = recurringPayouts,
	rolesOf = rolesOf,
	updateSettings = updateSettings,
	settings = settings,
	setDescription = setDescription,
	setPrimaryGroup = setPrimaryGroup,
	removePrimaryGroup = removePrimaryGroup,
	lookup = lookup,
	get = get,
	acceptJoinRequest = acceptJoinRequest,
	declineJoinRequest = declineJoinRequest,
	joinRequest = joinRequest,
	policies = policies,
	create = create,
	requestRelationship = requestRelationship,
	deleteRelationship = deleteRelationship,
	search = search,
	acceptRelationshipRequests = acceptRelationshipRequests,
	declineRelationshipRequests = declineRelationshipRequests,
	relationshipRequests = relationshipRequests,
	updateRecurringPayouts = updateRecurringPayouts,
	updateRolePermissions = updateRolePermissions,
	permissions = permissions,
	claimOwnership = claimOwnership,
	primary = primary,
	roles = roles,
	addSocialLink = addSocialLink,
	socialLinks = socialLinks,
}
