local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [friends.roblox.com](https://friends.roblox.com)
--- @class friends

--- @interface FriendsPageMetadataResponse
--- .isFriendsFilterBarEnabled boolean
--- .isFriendsUserDataStoreCacheEnabled boolean
--- .frequentFriendSortRollout number
--- .isFriendsPageSortExperimentEnabled boolean
--- .userName string
--- .displayName string
--- @within friends
export type FriendsPageMetadataResponse = {
	isFriendsFilterBarEnabled: boolean,
	isFriendsUserDataStoreCacheEnabled: boolean,
	frequentFriendSortRollout: number,
	isFriendsPageSortExperimentEnabled: boolean,
	userName: string,
	displayName: string,
}

--- Response contained in list for FollowingExists endpoint. Corresponds to a single userId.
--- @interface FollowingExistsResponse
--- .userId number
--- .isFollowing boolean
--- .isFollowed boolean
--- @within friends
export type FollowingExistsResponse = { userId: number, isFollowing: boolean, isFollowed: boolean }

--- Request model for AcceptFriendRequestWithToken endpoint
--- @interface FriendingTokenRequestModel
--- .friendingToken string
--- @within friends
export type FriendingTokenRequestModel = { friendingToken: string }

--- @interface FriendshipRequestModel
--- .senderNickname string
--- .friendshipOriginSourceType number
--- @within friends
export type FriendshipRequestModel = { senderNickname: string, friendshipOriginSourceType: number }

--- A response model representing user information that also contains select presence information
--- @interface UserResponse
--- .created string
--- .description string
--- .isOnline boolean
--- .id number
--- .hasVerifiedBadge boolean
--- .displayName string
--- .isDeleted boolean
--- .name string
--- .externalAppDisplayName string
--- .friendFrequentScore number
--- .presenceType number
--- .isBanned boolean
--- .friendFrequentRank number
--- @within friends
export type UserResponse = {
	created: string,
	description: string,
	isOnline: boolean,
	id: number,
	hasVerifiedBadge: boolean,
	displayName: string,
	isDeleted: boolean,
	name: string,
	externalAppDisplayName: string,
	friendFrequentScore: number,
	presenceType: number,
	isBanned: boolean,
	friendFrequentRank: number,
}

--- The friendship status response model.
--- @interface FriendStatusResponse
--- .id number
--- .status number
--- @within friends
export type FriendStatusResponse = { id: number, status: number }

--- Response model for following or followers Count
--- @interface FollowCountResponse
--- .count number
--- @within friends
export type FollowCountResponse = { count: number }

--- Response model for Pending Friend Request Count
--- @interface PendingFriendRequestCountModel
--- .count number
--- @within friends
export type PendingFriendRequestCountModel = { count: number }

--- @interface FriendRequestsPlatformExclusiveStartKeyPages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within friends
export type FriendRequestsPlatformExclusiveStartKeyPages = { SortOrder: number, PagingDirection: number, Count: number }

--- The friendship status response model.
--- @interface ClearNewFriendRequestResponse
--- .status boolean
--- @within friends
export type ClearNewFriendRequestResponse = { status: boolean }

--- Response model for MultigetAreFriendsResponse
--- @interface MultigetAreFriendsResponse
--- .friendsId { number }
--- @within friends
export type MultigetAreFriendsResponse = { friendsId: { number } }

--- A response model representing user presence information.
--- @interface UserPresenceResponse
--- .id number
--- .userPresence UserPresenceResponseModel
--- .name string
--- .displayName string
--- @within friends
export type UserPresenceResponse =
	{ id: number, userPresence: UserPresenceResponseModel, name: string, displayName: string }

--- @interface CaptchaTokenRequest
--- .captchaToken string
--- .captchaId string
--- .captchaProvider string
--- .challengeId string
--- @within friends
export type CaptchaTokenRequest = { captchaToken: string, captchaId: string, captchaProvider: string, challengeId: string }

--- Response model for Friends Count
--- @interface FriendsCountResponse
--- .count number
--- @within friends
export type FriendsCountResponse = { count: number }

--- A response model representing friend information
--- @interface FriendResponse
--- .id number
--- .hasVerifiedBadge boolean
--- @within friends
export type FriendResponse = { id: number, hasVerifiedBadge: boolean }

--- @interface Int64Pages
--- .CursorRecipe string
--- .ExclusiveStartKeyInfo Int64Pages
--- @within friends
export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

--- @interface StringPages
--- .Item2 StringPages
--- .Item1 Int64Pages
--- @within friends
export type StringPages = { Item2: StringPages, Item1: Int64Pages }

--- @interface UserPresenceResponsePages
--- .data { UserPresenceResponse }
--- @within friends
export type UserPresenceResponsePages = { data: { UserPresenceResponse } }

--- Request model for MultigetAreFriends endpoint
--- @interface MultigetAreFriendsRequestModel
--- .targetUserIds { number }
--- @within friends
export type MultigetAreFriendsRequestModel = { targetUserIds: { number } }

--- Request model for FollowingExists endpoint
--- @interface FollowingExistsRequestModel
--- .targetUserIds { number }
--- @within friends
export type FollowingExistsRequestModel = { targetUserIds: { number } }

--- The friendship status response model.
--- @interface NewFriendRequestsCountResponse
--- .count number
--- @within friends
export type NewFriendRequestsCountResponse = { count: number }

--- @interface UserResponsePages
--- .data { UserResponse }
--- @within friends
export type UserResponsePages = { data: { UserResponse } }

--- @interface ApiEmptyResponseModel
--- @within friends
export type ApiEmptyResponseModel = {}

--- Response model for Roblox.Web.Presence.Interfaces.IUserPresence objects
--- @interface UserPresenceResponseModel
--- .UserPresenceType string
--- .universeId number
--- .UserLocationType string
--- .lastOnline string
--- .lastLocation string
--- .placeId number
--- .gameInstanceId string
--- .rootPlaceId number
--- @within friends
export type UserPresenceResponseModel = {
	UserPresenceType: string,
	universeId: number,
	UserLocationType: string,
	lastOnline: string,
	lastLocation: string,
	placeId: number,
	gameInstanceId: string,
	rootPlaceId: number,
}

--- Response model for FollowingExists endpoint.
--- @interface FollowingExistsResponseModel
--- .followings { FollowingExistsResponse }
--- @within friends
export type FollowingExistsResponseModel = { followings: { FollowingExistsResponse } }

--- A response model representing a friend request.
--- @interface FriendRequestResponse
--- .created string
--- .description string
--- .id number
--- .hasVerifiedBadge boolean
--- .displayName string
--- .name string
--- .mutualFriendsList { string }
--- .externalAppDisplayName string
--- .isBanned boolean
--- .friendRequest FriendRequest
--- @within friends
export type FriendRequestResponse = {
	created: string,
	description: string,
	id: number,
	hasVerifiedBadge: boolean,
	displayName: string,
	name: string,
	mutualFriendsList: { string },
	externalAppDisplayName: string,
	isBanned: boolean,
	friendRequest: FriendRequest,
}

--- @interface FriendRequestResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { FriendRequestResponse }
--- @within friends
export type FriendRequestResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { FriendRequestResponse },
}

--- @interface FriendStatusResponsePages
--- .data { FriendStatusResponse }
--- @within friends
export type FriendStatusResponsePages = { data: { FriendStatusResponse } }

--- This is response model to notify when action succeeded, failed, or captcha is required
--- @interface CaptchaStatusResponseModel
--- .success boolean
--- .isCaptchaRequired boolean
--- @within friends
export type CaptchaStatusResponseModel = { success: boolean, isCaptchaRequired: boolean }

--- A response model representing a friend request.
--- @interface FriendRequest
--- .originSourceType number
--- .contactName string
--- .sentAt string
--- .senderId number
--- .sourceUniverseId number
--- .senderNickname string
--- @within friends
export type FriendRequest = {
	originSourceType: number,
	contactName: string,
	sentAt: string,
	senderId: number,
	sourceUniverseId: number,
	senderNickname: string,
}

--- @interface FriendResponsePages
--- .PreviousCursor string
--- .PageItems { FriendResponse }
--- .HasMore boolean
--- .NextCursor string
--- @within friends
export type FriendResponsePages = {
	PreviousCursor: string,
	PageItems: { FriendResponse },
	HasMore: boolean,
	NextCursor: string,
}

--- response for DeclineAllFriendRequests
--- @interface DeclineAllFriendRequestsResponse
--- .backgrounded boolean
--- @within friends
export type DeclineAllFriendRequestsResponse = { backgrounded: boolean }

--- Returns whether or not the current user is following each userId in a list of userIds
--- @within friends
local function following(targetUserIds: { number }, cookie: string): { FollowingExistsResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/following-exists`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { targetUserIds = targetUserIds }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).followings
end

--- Creates the following between a user and user with targetUserId
--- @within friends
local function follow(
	request: CaptchaTokenRequest & { targetUserId: number },
	cookie: string
): CaptchaStatusResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/follow`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the number of friends a user has
--- @within friends
local function countFriendsOf(userId: number, cookie: string?): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{userId}/friends/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

--- @within friends
local function metadata(targetUserId: number?, cookie: string?): FriendsPageMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/metadata?targetUserId={targetUserId or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the number of friends a user has
--- @within friends
local function count(request: {}, cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/my/friends/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

--- Accept a friend request.
--- @within friends
local function acceptFriendRequest(requesterUserId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{requesterUserId}/accept-friend-request`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Search for friends by name using a text query.
--- @within friends
local function search(
	request: { userId: number, query: string?, cursor: string?, limit: number? },
	cookie: string
): FriendResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends/search?query={request.query or ""}&cursor={request.cursor or ""}&limit={request.limit or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of all online friends for the specified user.
--- @within friends
local function onlineFriendsOf(request: { userId: number, userSort: number? }, cookie: string): { UserPresenceResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends/online?userSort={request.userSort or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Decline all pending friend requests for the authenticated user.
--- @within friends
local function declineAllFriendRequests(request: {}, cookie: string): boolean
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/friend-requests/decline-all`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).backgrounded
end

--- Get all users that user with targetUserId is following in page response format
--- @within friends
local function followingsOf(
	request: { targetUserId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): UserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/followings?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Check if the requesting user is friends with the specified users.
--- @within friends
local function areFriends(request: MultigetAreFriendsRequestModel & { userId: number }, cookie: string): { number }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/{request.userId}/multiget-are-friends`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).friendsId
end

--- Get all users that follow user with targetUserId in page response format
--- @within friends
local function followersOf(
	request: { targetUserId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): UserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/followers?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Unfriend a user
--- @within friends
local function unfriend(targetUserId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/unfriend`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Send a friend request to target user
--- @within friends
local function sendFriendRequest(
	request: FriendshipRequestModel & { targetUserId: number },
	cookie: string
): CaptchaStatusResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/request-friendship`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the number of following a user has
--- @within friends
local function countFollowingsOf(targetUserId: number, cookie: string?): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/followings/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

--- Deletes the following between a user and user with targetUserId
--- @within friends
local function unfollow(targetUserId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/unfollow`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of inactive friends for the specified user.
--- @within friends
local function inactiveFriendsOf(userId: number, cookie: string): { UserResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{userId}/friends/inactive`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Get all users that friend requests with targetUserId using exclusive start paging
--- @within friends
local function friendRequests(
	request: { limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): FriendRequestResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/my/friends/requests?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Decline a friend request.
--- @within friends
local function declineFriendRequest(requesterUserId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{requesterUserId}/decline-friend-request`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of all friends for the specified user.
--- @within friends
local function friendsOf(request: { userId: number, userSort: number? }, cookie: string?): { UserResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends?userSort={request.userSort or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Get a paginated list of all friends for the specified user.
--- @within friends
local function friendshipsOf(
	request: { userId: number, userSort: number?, cursor: string?, limit: number? },
	cookie: string?
): FriendResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends/find?userSort={request.userSort or ""}&cursor={request.cursor or ""}&limit={request.limit or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Return the number of pending friend requests.
--- @within friends
local function countFriendRequests(request: {}, cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/user/friend-requests/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

--- Get the number of following a user has
--- @within friends
local function countFollowersOf(targetUserId: number, cookie: string?): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/followers/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

return {
	following = following,
	follow = follow,
	countFriendsOf = countFriendsOf,
	metadata = metadata,
	count = count,
	acceptFriendRequest = acceptFriendRequest,
	search = search,
	onlineFriendsOf = onlineFriendsOf,
	declineAllFriendRequests = declineAllFriendRequests,
	followingsOf = followingsOf,
	areFriends = areFriends,
	followersOf = followersOf,
	unfriend = unfriend,
	sendFriendRequest = sendFriendRequest,
	countFollowingsOf = countFollowingsOf,
	unfollow = unfollow,
	inactiveFriendsOf = inactiveFriendsOf,
	friendRequests = friendRequests,
	declineFriendRequest = declineFriendRequest,
	friendsOf = friendsOf,
	friendshipsOf = friendshipsOf,
	countFriendRequests = countFriendRequests,
	countFollowersOf = countFollowersOf,
}
