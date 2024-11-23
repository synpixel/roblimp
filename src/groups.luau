local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [groups.roblox.com](https://groups.roblox.com)
--- @class groups

--- Multi-payout request information.
--- @interface PayoutRequest
--- .PayoutType number
--- .Recipients { PayoutRecipientRequest }
--- @within groups
export type PayoutRequest = { PayoutType: number, Recipients: { PayoutRecipientRequest } }

--- @interface GroupOpenCloudPermissionsModel
--- .useCloudAuthentication boolean
--- .administerCloudAuthentication boolean
--- @within groups
export type GroupOpenCloudPermissionsModel = { useCloudAuthentication: boolean, administerCloudAuthentication: boolean }

--- A model representing data about an Roblox.Platform.Membership.IUser
--- @interface GroupManagementPermissionsModel
--- .viewAuditLogs boolean
--- .manageClan boolean
--- .manageRelationships boolean
--- @within groups
export type GroupManagementPermissionsModel = { viewAuditLogs: boolean, manageClan: boolean, manageRelationships: boolean }

--- A request model for updating a group's settings.
--- @interface UpdateGroupSettingsRequest
--- .areGroupFundsVisible boolean
--- .isApprovalRequired boolean
--- .areGroupGamesVisible boolean
--- .areEnemiesAllowed boolean
--- @within groups
export type UpdateGroupSettingsRequest = {
	areGroupFundsVisible: boolean,
	isApprovalRequired: boolean,
	areGroupGamesVisible: boolean,
	areEnemiesAllowed: boolean,
}

--- @interface UserGroupMembershipResponsePages
--- .data { UserGroupMembershipResponse }
--- @within groups
export type UserGroupMembershipResponsePages = { data: { UserGroupMembershipResponse } }

--- @type IUploadedFile buffer
--- @within groups
export type IUploadedFile = buffer

--- A group roles response model
--- @interface GroupAllRolesResponse
--- .roles { GroupRoleResponse }
--- .groupId number
--- @within groups
export type GroupAllRolesResponse = { roles: { GroupRoleResponse }, groupId: number }

--- A response model for group wall post information
--- @interface GroupWallPostModel
--- .created string
--- .id number
--- .updated string
--- .body string
--- .poster UserModel
--- @within groups
export type GroupWallPostModel = { created: string, id: number, updated: string, body: string, poster: UserModel }

--- A group search response
--- @interface GroupSearchResponseItem
--- .created string
--- .description string
--- .id number
--- .hasVerifiedBadge boolean
--- .memberCount number
--- .updated string
--- .name string
--- .previousName string
--- .publicEntryAllowed boolean
--- @within groups
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
--- @interface UpdateGroupNameRequest
--- .name string
--- @within groups
export type UpdateGroupNameRequest = { name: string }

--- A group audit log response model
--- @interface GroupAuditLogResponseItem
--- .created string
--- .actor UserGroupRoleResponse
--- .description nil
--- .actionType string
--- @within groups
export type GroupAuditLogResponseItem = {
	created: string,
	actor: UserGroupRoleResponse,
	description: nil,
	actionType: string,
}

--- @interface GroupPayoutResponsePages
--- .data { GroupPayoutResponse }
--- @within groups
export type GroupPayoutResponsePages = { data: { GroupPayoutResponse } }

--- @interface CreateRoleSetRequest
--- .description string
--- .usingGroupFunds boolean
--- .name string
--- .rank number
--- @within groups
export type CreateRoleSetRequest = { description: string, usingGroupFunds: boolean, name: string, rank: number }

--- A model representing data about an Roblox.Platform.Membership.IUser
--- @interface GroupEconomyPermissionsModel
--- .viewGroupPayouts boolean
--- .manageGroupGames boolean
--- .createItems boolean
--- .manageItems boolean
--- .advertiseGroup boolean
--- .viewAnalytics boolean
--- .spendGroupFunds boolean
--- .addGroupPlaces boolean
--- @within groups
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

--- @interface GroupDescriptionResponse
--- .newDescription string
--- @within groups
export type GroupDescriptionResponse = { newDescription: string }

--- A model representing group posts permissions
--- @interface GroupPostsPermissionsModel
--- .postToStatus boolean
--- .viewStatus boolean
--- .postToWall boolean
--- .deleteFromWall boolean
--- .viewWall boolean
--- @within groups
export type GroupPostsPermissionsModel = {
	postToStatus: boolean,
	viewStatus: boolean,
	postToWall: boolean,
	deleteFromWall: boolean,
	viewWall: boolean,
}

--- A user's group membership metadata response model
--- @interface GroupMembershipMetadataResponse
--- .canConfigure boolean
--- .groupId number
--- .areGroupGamesVisible boolean
--- .userRole UserGroupRoleResponse
--- .permissions GroupPermissionsModel
--- .isPendingJoin boolean
--- .isBannedFromGroup boolean
--- .isNotificationsEnabled boolean
--- .isPrimary boolean
--- .areEnemiesAllowed boolean
--- .areGroupFundsVisible boolean
--- @within groups
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
--- @interface GroupPayoutRestrictionResponse
--- .canUseOneTimePayout boolean
--- .canUseRecurringPayout boolean
--- @within groups
export type GroupPayoutRestrictionResponse = { canUseOneTimePayout: boolean, canUseRecurringPayout: boolean }

--- Response model for Group Settings
--- @interface GroupSettingsResponse
--- .isGroupNameChangeEnabled boolean
--- .areEnemiesAllowed boolean
--- .areGroupFundsVisible boolean
--- .isApprovalRequired boolean
--- .areGroupGamesVisible boolean
--- .isBuildersClubRequired boolean
--- @within groups
export type GroupSettingsResponse = {
	isGroupNameChangeEnabled: boolean,
	areEnemiesAllowed: boolean,
	areGroupFundsVisible: boolean,
	isApprovalRequired: boolean,
	areGroupGamesVisible: boolean,
	isBuildersClubRequired: boolean,
}

--- @interface ShoutResponse
--- .created string
--- .updated string
--- .poster UserModel
--- .body string
--- @within groups
export type ShoutResponse = { created: string, updated: string, poster: UserModel, body: string }

--- A request model for changing the group owner.
--- @interface ChangeOwnerRequest
--- .userId number
--- @within groups
export type ChangeOwnerRequest = { userId: number }

--- A group role response model
--- @interface GroupRoleResponse
--- .name string
--- .id number
--- .memberCount number
--- .description string
--- .rank number
--- @within groups
export type GroupRoleResponse = { name: string, id: number, memberCount: number, description: string, rank: number }

--- @interface StringPages
--- .discriminator string
--- .sortOrder number
--- .key string
--- .count number
--- .pagingDirection number
--- .pageNumber number
--- @within groups
export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- A detailed group response model
--- @interface GroupDetailResponse
--- .description string
--- .id number
--- .owner UserModel
--- .hasVerifiedBadge boolean
--- .memberCount number
--- .isBuildersClubOnly boolean
--- .isLocked boolean
--- .name string
--- .shout ShoutResponse
--- .publicEntryAllowed boolean
--- @within groups
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

--- @interface GroupRoleDetailResponse
--- .name string
--- .groupId number
--- .id number
--- .memberCount number
--- .description string
--- .rank number
--- @within groups
export type GroupRoleDetailResponse = {
	name: string,
	groupId: number,
	id: number,
	memberCount: number,
	description: string,
	rank: number,
}

--- A request model for joining group.
--- @interface JoinGroupRequest
--- .challengeId string
--- .redemptionToken string
--- .sessionId string
--- .captchaId string
--- .captchaProvider string
--- .captchaToken string
--- @within groups
export type JoinGroupRequest = {
	challengeId: string,
	redemptionToken: string,
	sessionId: string,
	captchaId: string,
	captchaProvider: string,
	captchaToken: string,
}

--- @interface GroupDetailResponsePages
--- .data { GroupDetailResponse }
--- @within groups
export type GroupDetailResponsePages = { data: { GroupDetailResponse } }

--- @interface GroupResponseV2
--- .created string
--- .name string
--- .description string
--- .id number
--- .owner GroupOwnerTypePages
--- .hasVerifiedBadge boolean
--- .memberCount number
--- @within groups
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
--- @interface GroupConfigurationDisplayOptionsResponse
--- .groupConfiguration GroupConfigurationResponse
--- .recurringPayoutsConfiguration RecurringPayoutsConfigurationResponse
--- .isDefaultEmblemPolicyEnabled boolean
--- .isPremiumPayoutsEnabled boolean
--- .groupNameChangeConfiguration GroupNameChangeConfigurationResponse
--- .roleConfiguration RoleConfigurationResponse
--- @within groups
export type GroupConfigurationDisplayOptionsResponse = {
	groupConfiguration: GroupConfigurationResponse,
	recurringPayoutsConfiguration: RecurringPayoutsConfigurationResponse,
	isDefaultEmblemPolicyEnabled: boolean,
	isPremiumPayoutsEnabled: boolean,
	groupNameChangeConfiguration: GroupNameChangeConfigurationResponse,
	roleConfiguration: RoleConfigurationResponse,
}

--- Response model for !:GroupJoinRequests
--- @interface GroupJoinRequestResponse
--- .requester UserModel
--- .created string
--- @within groups
export type GroupJoinRequestResponse = { requester: UserModel, created: string }

--- A response model for group configuration
--- @interface GroupConfigurationResponse
--- .iconMaxFileSizeMb number
--- .isUsingTwoStepWebviewComponent boolean
--- .cost number
--- .descriptionMaxLength number
--- .nameMaxLength number
--- @within groups
export type GroupConfigurationResponse = {
	iconMaxFileSizeMb: number,
	isUsingTwoStepWebviewComponent: boolean,
	cost: number,
	descriptionMaxLength: number,
	nameMaxLength: number,
}

--- @interface UpdateRoleSetRequest
--- .description string
--- .name string
--- .rank number
--- @within groups
export type UpdateRoleSetRequest = { description: string, name: string, rank: number }

--- A user group role response model
--- @interface UserGroupRoleResponse
--- .role GroupRoleResponse
--- .user UserModel
--- @within groups
export type UserGroupRoleResponse = { role: GroupRoleResponse, user: UserModel }

--- A request model for creating a group wall post
--- @interface CreateWallPostRequest
--- .challengeId string
--- .captchaToken string
--- .captchaId string
--- .captchaProvider string
--- .body string
--- @within groups
export type CreateWallPostRequest = {
	challengeId: string,
	captchaToken: string,
	captchaId: string,
	captchaProvider: string,
	body: string,
}

--- A group membership response model
--- @interface GroupMembershipDetailResponse
--- .group GroupDetailResponse
--- .role GroupRoleResponse
--- .isPrimaryGroup boolean
--- .isNotificationsEnabled boolean
--- @within groups
export type GroupMembershipDetailResponse = {
	group: GroupDetailResponse,
	role: GroupRoleResponse,
	isPrimaryGroup: boolean,
	isNotificationsEnabled: boolean,
}

--- @interface GroupNameHistoryResponseItemPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GroupNameHistoryResponseItem }
--- @within groups
export type GroupNameHistoryResponseItemPages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GroupNameHistoryResponseItem },
}

--- @interface GroupPolicyRequest
--- .groupIds { number }
--- @within groups
export type GroupPolicyRequest = { groupIds: { number } }

--- @interface GroupRoleDetailResponsePages
--- .data { GroupRoleDetailResponse }
--- @within groups
export type GroupRoleDetailResponsePages = { data: { GroupRoleDetailResponse } }

--- @interface Int64Pages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within groups
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- @interface GroupMembershipDetailResponsePages
--- .data { GroupMembershipDetailResponse }
--- @within groups
export type GroupMembershipDetailResponsePages = { data: { GroupMembershipDetailResponse } }

--- A response model for recurring payout configuration
--- @interface RecurringPayoutsConfigurationResponse
--- .maxPayoutPartners number
--- @within groups
export type RecurringPayoutsConfigurationResponse = { maxPayoutPartners: number }

--- @interface GroupBasicResponsePages
--- .data { GroupBasicResponse }
--- @within groups
export type GroupBasicResponsePages = { data: { GroupBasicResponse } }

--- A model representing data about an Roblox.Platform.Membership.IUser
--- @interface GroupMembershipPermissionsModel
--- .banMembers boolean
--- .changeRank boolean
--- .removeMembers boolean
--- .inviteMembers boolean
--- @within groups
export type GroupMembershipPermissionsModel = {
	banMembers: boolean,
	changeRank: boolean,
	removeMembers: boolean,
	inviteMembers: boolean,
}

--- @interface GroupJoinRequestResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GroupJoinRequestResponse }
--- @within groups
export type GroupJoinRequestResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GroupJoinRequestResponse },
}

--- @interface RelationshipsRequest
--- .GroupIds { number }
--- @within groups
export type RelationshipsRequest = { GroupIds: { number } }

--- @interface Stream
--- .CanRead boolean
--- .CanWrite boolean
--- .CanTimeout boolean
--- .Position number
--- .WriteTimeout number
--- .Length number
--- .ReadTimeout number
--- .CanSeek boolean
--- @within groups
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
--- @interface PostGroupStatusRequest
--- .message string
--- @within groups
export type PostGroupStatusRequest = { message: string }

--- ApiPageResponse for catalog search
--- @interface GroupSearchPageResponse
--- .nextPageCursor string
--- .data { GroupSearchResponseItem }
--- .keyword string
--- .previousPageCursor string
--- @within groups
export type GroupSearchPageResponse = {
	nextPageCursor: string,
	data: { GroupSearchResponseItem },
	keyword: string,
	previousPageCursor: string,
}

--- @interface GroupWallPostModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GroupWallPostModel }
--- @within groups
export type GroupWallPostModelPages = { nextPageCursor: string, previousPageCursor: string, data: { GroupWallPostModel } }

--- A group role's permissions response model
--- @interface GroupPermissionsResponse
--- .permissions GroupPermissionsModel
--- .role GroupRoleResponse
--- .groupId number
--- @within groups
export type GroupPermissionsResponse = { permissions: GroupPermissionsModel, role: GroupRoleResponse, groupId: number }

--- @interface UserModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { UserModel }
--- @within groups
export type UserModelPages = { nextPageCursor: string, previousPageCursor: string, data: { UserModel } }

--- @interface GroupPolicyResponse
--- .canViewGroup boolean
--- .groupId number
--- @within groups
export type GroupPolicyResponse = { canViewGroup: boolean, groupId: number }

--- @interface Int32Pages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within groups
export type Int32Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- A request model for setting the authenticated user's primary group.
--- @interface PrimaryGroupRequest
--- .groupId number
--- @within groups
export type PrimaryGroupRequest = { groupId: number }

--- @interface GroupPermissionsResponsePages
--- .data { GroupPermissionsResponse }
--- @within groups
export type GroupPermissionsResponsePages = { data: { GroupPermissionsResponse } }

--- A social link response from a create request
--- @interface SocialLinkResponse
--- .id number
--- .type number
--- .title string
--- .url string
--- @within groups
export type SocialLinkResponse = { id: number, type: number, title: string, url: string }

--- A request model for setting a users role in a group.
--- @interface UpdateUserRoleRequest
--- .roleId number
--- @within groups
export type UpdateUserRoleRequest = { roleId: number }

--- @interface GroupOwnerTypePages
--- .id number
--- .type number
--- .name string
--- @within groups
export type GroupOwnerTypePages = { id: number, type: number, name: string }

--- @interface GroupBasicResponse
--- .id number
--- .hasVerifiedBadge boolean
--- .name string
--- .memberCount number
--- @within groups
export type GroupBasicResponse = { id: number, hasVerifiedBadge: boolean, name: string, memberCount: number }

--- A request model for paying out Robux.
--- @interface PayoutRecipientRequest
--- .amount number
--- .recipientType number
--- .recipientId number
--- @within groups
export type PayoutRecipientRequest = { amount: number, recipientType: number, recipientId: number }

--- ApiPageResponse for group audit log
--- @interface GroupAuditLogResponseItemPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GroupAuditLogResponseItem }
--- @within groups
export type GroupAuditLogResponseItemPages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GroupAuditLogResponseItem },
}

--- @interface SocialLinkResponsePages
--- .data { SocialLinkResponse }
--- @within groups
export type SocialLinkResponsePages = { data: { SocialLinkResponse } }

--- @interface UpdateGroupNameResponse
--- .newName string
--- @within groups
export type UpdateGroupNameResponse = { newName: string }

--- @interface GroupFeaturedContentResponse
--- .contentType string
--- .contentId string
--- .groupId number
--- @within groups
export type GroupFeaturedContentResponse = { contentType: string, contentId: string, groupId: number }

--- A users group membership response model
--- @interface UserGroupMembershipResponse
--- .groups { GroupMembershipDetailResponse }
--- .user UserModel
--- @within groups
export type UserGroupMembershipResponse = { groups: { GroupMembershipDetailResponse }, user: UserModel }

--- @interface ApiEmptyResponseModel
--- @within groups
export type ApiEmptyResponseModel = {}

--- A request model for updating a group's roleset's permissions.
--- @interface UpdatePermissionsRequest
--- .permissions {InviteMembers: boolean,AddGroupPlaces: boolean,PostToWall: boolean,BanMembers: boolean,PostToStatus: boolean,ManageGroupGames: boolean,ChangeRank: boolean,RemoveMembers: boolean,ViewStatus: boolean,AdvertiseGroup: boolean,UseCloudAuthentication: boolean,SpendGroupFunds: boolean,AdministerCloudAuthentication: boolean,ViewAnalytics: boolean,ManageItems: boolean,CreateItems: boolean,ManageClan: boolean,ViewAuditLogs: boolean,DeleteFromWall: boolean,ManageRelationships: boolean,ViewWall: boolean,}
--- @within groups
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
--- @interface UpdateGroupNotificationPreferenceRequest
--- .notificationsEnabled boolean
--- @within groups
export type UpdateGroupNotificationPreferenceRequest = { notificationsEnabled: boolean }

--- @interface StartIndexCursor
--- .discriminator string
--- .count number
--- .startIndex number
--- @within groups
export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- A request model for setting a description for the group
--- @interface UpdateGroupDescriptionRequest
--- .description string
--- @within groups
export type UpdateGroupDescriptionRequest = { description: string }

--- @interface GroupPoliciesResponse
--- .groups { GroupPolicyResponse }
--- @within groups
export type GroupPoliciesResponse = { groups: { GroupPolicyResponse } }

--- @interface GroupNameChangeConfigurationResponse
--- .ownershipCooldownInDays number
--- .cooldownInDays number
--- .cost number
--- @within groups
export type GroupNameChangeConfigurationResponse =
	{ ownershipCooldownInDays: number, cooldownInDays: number, cost: number }

--- An update request for a social link
--- @interface SocialLinkRequest
--- .type number
--- .title string
--- .url string
--- @within groups
export type SocialLinkRequest = { type: number, title: string, url: string }

--- A response model for role configuration
--- @interface RoleConfigurationResponse
--- .limit number
--- .cost number
--- .maxRank number
--- .minRank number
--- .descriptionMaxLength number
--- .nameMaxLength number
--- @within groups
export type RoleConfigurationResponse = {
	limit: number,
	cost: number,
	maxRank: number,
	minRank: number,
	descriptionMaxLength: number,
	nameMaxLength: number,
}

--- @interface UserGroupRoleResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { UserGroupRoleResponse }
--- @within groups
export type UserGroupRoleResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { UserGroupRoleResponse },
}

--- A group name history response model
--- @interface GroupNameHistoryResponseItem
--- .name string
--- .created string
--- @within groups
export type GroupNameHistoryResponseItem = { name: string, created: string }

--- @interface MembersRequest
--- .UserIds { number }
--- @within groups
export type MembersRequest = { UserIds: { number } }

--- A group relationships response model
--- @interface GroupRelationshipsResponse
--- .totalGroupCount number
--- .groupId number
--- .nextRowIndex number
--- .relationshipType number
--- .relatedGroups { GroupDetailResponse }
--- @within groups
export type GroupRelationshipsResponse = {
	totalGroupCount: number,
	groupId: number,
	nextRowIndex: number,
	relationshipType: number,
	relatedGroups: { GroupDetailResponse },
}

--- A group roles response model
--- @interface GroupsDisplayOptionsResponse
--- .isGroupWallNotificationsEnabled boolean
--- .groupPostMaxLength number
--- .currentGroupCount number
--- .groupStatusMaxLength number
--- .groupWallNotificationsSubscribeIntervalInMilliseconds number
--- .groupLimit number
--- .areGroupBansEnabled boolean
--- .areProfileGroupsHidden boolean
--- .isGroupDetailsPolicyEnabled boolean
--- .showPreviousGroupNames boolean
--- @within groups
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
--- @interface GroupPermissionsModel
--- .groupMembershipPermissions GroupMembershipPermissionsModel
--- .groupEconomyPermissions GroupEconomyPermissionsModel
--- .groupOpenCloudPermissions GroupOpenCloudPermissionsModel
--- .groupPostsPermissions GroupPostsPermissionsModel
--- .groupManagementPermissions GroupManagementPermissionsModel
--- @within groups
export type GroupPermissionsModel = {
	groupMembershipPermissions: GroupMembershipPermissionsModel,
	groupEconomyPermissions: GroupEconomyPermissionsModel,
	groupOpenCloudPermissions: GroupOpenCloudPermissionsModel,
	groupPostsPermissions: GroupPostsPermissionsModel,
	groupManagementPermissions: GroupManagementPermissionsModel,
}

--- A model representing data about an Roblox.Platform.Membership.IUser
--- @interface UserModel
--- .username string
--- .buildersClubMembershipType number
--- .userId number
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within groups
export type UserModel = {
	username: string,
	buildersClubMembershipType: number,
	userId: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- Response Model For Group Search Metadata Endpoint
--- @interface GroupSearchMetadataResponse
--- .ShowFriendsGroupsSort boolean
--- .SuggestedGroupKeywords { string }
--- @within groups
export type GroupSearchMetadataResponse = { ShowFriendsGroupsSort: boolean, SuggestedGroupKeywords: { string } }

--- A group payout response
--- @interface GroupPayoutResponse
--- .percentage number
--- .user UserModel
--- @within groups
export type GroupPayoutResponse = { percentage: number, user: UserModel }

--- @interface GroupMembershipResponsePages
--- .data { GroupMembershipResponse }
--- @within groups
export type GroupMembershipResponsePages = { data: { GroupMembershipResponse } }

--- @interface GroupWallPostV2ModelPages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GroupWallPostV2Model }
--- @within groups
export type GroupWallPostV2ModelPages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { GroupWallPostV2Model },
}

--- @interface GroupResponseV2Pages
--- .data { GroupResponseV2 }
--- @within groups
export type GroupResponseV2Pages = { data: { GroupResponseV2 } }

--- A basic group membership response model
--- @interface GroupMembershipResponse
--- .group GroupBasicResponse
--- .role GroupRoleBasicResponse
--- .isNotificationsEnabled boolean
--- @within groups
export type GroupMembershipResponse = {
	group: GroupBasicResponse,
	role: GroupRoleBasicResponse,
	isNotificationsEnabled: boolean,
}

--- @interface GroupRoleBasicResponse
--- .id number
--- .name string
--- .rank number
--- @within groups
export type GroupRoleBasicResponse = { id: number, name: string, rank: number }

--- A response model for group wall post information
--- @interface GroupWallPostV2Model
--- .created string
--- .id number
--- .updated string
--- .body string
--- .poster UserGroupRoleResponse
--- @within groups
export type GroupWallPostV2Model = {
	created: string,
	id: number,
	updated: string,
	body: string,
	poster: UserGroupRoleResponse,
}

--- Gets Group configuration contextual information
--- @within groups
local function configurationMetadata(request: {}, cookie: string?): GroupConfigurationDisplayOptionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/configuration/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets Groups contextual information:
--- Max number of groups a user can be part of.
--- Current number of groups a user is a member of.
--- Whether to show/hide certain features based on device type.
--- @within groups
local function metadata(request: {}, cookie: string?): GroupsDisplayOptionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Changes the group owner to another user.
--- @within groups
local function giveOwnership(request: ChangeOwnerRequest & { groupId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/change-owner`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch accepts group join requests
--- @within groups
local function acceptJoinRequests(request: MembersRequest & { groupId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/join-requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch declines group join requests
--- @within groups
local function declineJoinRequests(request: MembersRequest & { groupId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/join-requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a page of Group Join Requests for a group.
--- @within groups
local function joinRequests(
	request: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): GroupJoinRequestResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/join-requests?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of users in a group for a specific roleset.
--- @within groups
local function usersWithRole(
	request: {
		groupId: number,
		roleSetId: number,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	},
	cookie: string
): UserModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/roles/{request.roleSetId}/users?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a social link
--- @within groups
local function updateSocialLink(
	request: SocialLinkRequest & { groupId: number, socialLinkId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/social-links/{request.socialLinkId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes a social link
--- @within groups
local function deleteSocialLink(
	request: { groupId: number, socialLinkId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/social-links/{request.socialLinkId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets groups that the authenticated user has requested to join
--- @within groups
local function pending(request: {}, cookie: string): { GroupDetailResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/user/groups/pending`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets the Group's audit log
--- @within groups
local function auditLog(
	request: {
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
	},
	cookie: string
): GroupAuditLogResponseItemPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/audit-log?actionType={request.actionType or ""}&userId={request.userId or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Joins a group
--- @within groups
local function join(request: JoinGroupRequest & { groupId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/users`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of users in a group.
--- @within groups
local function users(
	request: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string?
): UserGroupRoleResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/users?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sets group status
--- @within groups
local function setStatus(request: PostGroupStatusRequest & { groupId: number }, cookie: string): ShoutResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/status`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the group's name.
--- @within groups
local function setName(request: UpdateGroupNameRequest & { groupId: number }, cookie: string): string
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/name`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).newName
end

--- Gets a list of all groups the specified users' friends are in.
--- @within groups
local function withFriendsOf(userId: number, cookie: string): { UserGroupMembershipResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/users/{userId}/friends/groups/roles`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets a value indicating whether the group can use payout feature
--- @within groups
local function canPayout(groupId: number, cookie: string): GroupPayoutRestrictionResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{groupId}/payout-restriction`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a group's relationships
--- @within groups
local function relationships(
	request: { groupId: number, groupRelationshipType: string, startRowIndex: number, maxRows: number },
	cookie: string?
): GroupRelationshipsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}?startRowIndex={request.startRowIndex}&maxRows={request.maxRows}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the Group's name change history.
--- @within groups
local function nameHistory(
	request: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): GroupNameHistoryResponseItemPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/name-history?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get suggested groups and other miscellaneous information needed for the group/join page like flags
--- @within groups
local function searchMetadata(request: {}, cookie: string?): GroupSearchMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/search/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the user's group notification preferences
--- @within groups
local function toggleNotifications(
	request: UpdateGroupNotificationPreferenceRequest & { groupId: number },
	cookie: string
): number
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/notification-preference`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Accepts a group relationship request.
--- @within groups
local function acceptRelationshipRequest(
	request: { groupId: number, groupRelationshipType: string, relatedGroupId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}/requests/{request.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Declines a group relationship request.
--- @within groups
local function declineRelationshipRequest(
	request: { groupId: number, groupRelationshipType: string, relatedGroupId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}/requests/{request.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes a group wall post.
--- @within groups
local function deleteMessage(request: { groupId: number, postId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/wall/posts/{request.postId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the group icon.
--- @within groups
local function setIcon(request: { groupId: number, files: buffer? }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/icon?groupId={request.groupId}&files={request.files or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a users role in a group.
--- @within groups
local function changeRole(
	request: UpdateUserRoleRequest & { groupId: number, userId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/users/{request.userId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes a user from a group
--- @within groups
local function exileUser(request: { groupId: number, userId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/users/{request.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all permissions for each role
--- @within groups
local function allPermissions(groupId: number, cookie: string): { GroupPermissionsResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{groupId}/roles/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Updates existing group roleset.
--- @within groups
local function updateRole(
	request: UpdateRoleSetRequest & { groupId: number, rolesetId: number },
	cookie: string
): GroupRoleResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/rolesets/{request.rolesetId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes existing group roleset.
--- @within groups
local function deleteRole(request: { groupId: number, rolesetId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/rolesets/{request.rolesetId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates new group roleset.
--- @within groups
local function createRole(request: CreateRoleSetRequest & { groupId: number }, cookie: string): GroupRoleResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/rolesets/create`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the permissions for a group's guest roleset. These can be viewed by all (members and guests) users.
--- @within groups
local function guestPermissions(groupId: number, cookie: string?): GroupPermissionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{groupId}/roles/guest/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes all group wall posts made by a specific user.
--- @within groups
local function deleteMessagesOf(request: { groupId: number, userId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/wall/users/{request.userId}/posts`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets group membership information in the context of the authenticated user
--- @within groups
local function membership(
	request: { groupId: number, includeNotificationPreferences: boolean },
	cookie: string?
): GroupMembershipMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/membership?includeNotificationPreferences={request.includeNotificationPreferences}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Pays out a user in Robux.
--- @within groups
local function payout(request: PayoutRequest & { groupId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/payouts`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of the group payout percentages
--- @within groups
local function recurringPayouts(groupId: number, cookie: string): { GroupPayoutResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{groupId}/payouts`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Updates the group's settings
--- @within groups
local function updateSettings(
	request: UpdateGroupSettingsRequest & { groupId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/settings`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the Group's settings
--- @within groups
local function settings(groupId: number, cookie: string): GroupSettingsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{groupId}/settings`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the groups description
--- @within groups
local function setDescription(request: UpdateGroupDescriptionRequest & { groupId: number }, cookie: string): string
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/description`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).newDescription
end

--- Sets the authenticated user's primary group
--- @within groups
local function setPrimaryGroup(groupId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/user/groups/primary`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { groupId = groupId }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes the authenticated user's primary group
--- @within groups
local function removePrimaryGroup(request: {}, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/user/groups/primary`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Looks up groups by a name. Prioritizes an exact match as the first result.
--- @within groups
local function lookup(groupName: string, cookie: string?): { GroupBasicResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/search/lookup?groupName={groupName}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets group information
--- @within groups
local function get(groupId: number, cookie: string?): GroupDetailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{groupId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Accepts a group join request.
--- @within groups
local function acceptJoinRequest(request: { groupId: number, userId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/join-requests/users/{request.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Declines/cancels a group join request.
--- @within groups
local function declineJoinRequest(request: { groupId: number, userId: number }, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/join-requests/users/{request.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a group join request by userId.
--- @within groups
local function joinRequest(request: { groupId: number, userId: number }, cookie: string): GroupJoinRequestResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/join-requests/users/{request.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets group policy info used for compliance.
--- @within groups
local function policies(groupIds: { number }, cookie: string): { GroupPolicyResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/policies`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { groupIds = groupIds }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).groups
end

--- Creates a new group.
--- @within groups
local function create(
	request: {
		name: string?,
		description: string?,
		publicGroup: boolean?,
		buildersClubMembersOnly: boolean?,
		files: buffer?,
	},
	cookie: string
): GroupResponseV2
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/create?name={request.name or ""}&description={request.description or ""}&publicGroup={request.publicGroup or ""}&buildersClubMembersOnly={request.buildersClubMembersOnly or ""}&files={request.files or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Create a group relationship.
--- @within groups
local function requestRelationship(
	request: { groupId: number, groupRelationshipType: string, relatedGroupId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}/{request.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes a group relationship.
--- @within groups
local function deleteRelationship(
	request: { groupId: number, groupRelationshipType: string, relatedGroupId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}/{request.relatedGroupId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Search for groups by keyword.
--- @within groups
local function search(
	request: { keyword: string, prioritizeExactMatch: boolean?, limit: number?, cursor: string? },
	cookie: string?
): GroupSearchPageResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/search?keyword={request.keyword}&prioritizeExactMatch={request.prioritizeExactMatch or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch accepts group affiliate requests
--- @within groups
local function acceptRelationshipRequests(
	request: RelationshipsRequest & { groupId: number, groupRelationshipType: string },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}/requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Batch declines group affiliate requests
--- @within groups
local function declineRelationshipRequests(
	request: RelationshipsRequest & { groupId: number, groupRelationshipType: string },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}/requests`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a group's relationship requests
--- @within groups
local function relationshipRequests(
	request: {
		groupId: number,
		groupRelationshipType: string,
		startRowIndex: number,
		maxRows: number,
	},
	cookie: string
): GroupRelationshipsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/relationships/{request.groupRelationshipType}/requests?startRowIndex={request.startRowIndex}&maxRows={request.maxRows}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates recurring payouts.
--- @within groups
local function updateRecurringPayouts(
	request: PayoutRequest & { groupId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/payouts/recurring`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the permissions for a group's roleset. The authorized user must be the group owner.
--- @within groups
local function updateRolePermissions(
	request: UpdatePermissionsRequest & { groupId: number, roleSetId: number },
	cookie: string
): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/roles/{request.roleSetId}/permissions`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the permissions for a group's roleset. The authorized user must either be the group owner or the roleset being requested, except for guest roles, which can be viewed by all (members and guests).
--- @within groups
local function permissions(request: { groupId: number, roleSetId: number }, cookie: string): GroupPermissionsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/roles/{request.roleSetId}/permissions`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Claims ownership of the group as the authenticated user
--- @within groups
local function claimOwnership(groupId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{groupId}/claim-ownership`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a user's primary group.
--- @within groups
local function primary(userId: number, cookie: string?): GroupMembershipDetailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/users/{userId}/groups/primary/role`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the Roles by their ids.
--- @within groups
local function roles(ids: { number }, cookie: string?): { GroupRoleDetailResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/roles?ids={table.concat(ids, "&ids=")}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Posts a social links
--- @within groups
local function addSocialLink(request: SocialLinkRequest & { groupId: number }, cookie: string): SocialLinkResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v1/groups/{request.groupId}/social-links`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get social link data associated with a group
--- @within groups
local function socialLinks(groupId: number, cookie: string): { SocialLinkResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v1/groups/{groupId}/social-links`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Creates a post on a group wall
--- @within groups
local function sendMessage(request: CreateWallPostRequest & { groupId: number }, cookie: string): GroupWallPostV2Model
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://groups.roblox.com/v2/groups/{request.groupId}/wall/posts`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of group wall posts.
--- @within groups
local function messages(
	request: { groupId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): GroupWallPostV2ModelPages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v2/groups/{request.groupId}/wall/posts?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Multi-get groups information by Ids.
--- @within groups
local function multiple(groupIds: { number }, cookie: string?): { GroupResponseV2 }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v2/groups?groupIds={table.concat(groupIds, "&groupIds=")}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets a list of all group roles for groups the specified user is in.
--- @within groups
local function rolesOf(
	request: { userId: number, includeLocked: boolean, includeNotificationPreferences: boolean },
	cookie: string?
): { GroupMembershipResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://groups.roblox.com/v2/users/{request.userId}/groups/roles?includeLocked={request.includeLocked}&includeNotificationPreferences={request.includeNotificationPreferences}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
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
