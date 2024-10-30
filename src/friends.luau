local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
export type FriendsPageMetadataResponse = {
	isFriendsFilterBarEnabled: boolean,
	isFriendsUserDataStoreCacheEnabled: boolean,
	frequentFriendSortRollout: number,
	isFriendsPageSortExperimentEnabled: boolean,
	userName: string,
	displayName: string,
}

--- Response contained in list for FollowingExists endpoint. Corresponds to a single userId.
export type FollowingExistsResponse = { userId: number, isFollowing: boolean, isFollowed: boolean }

--- Request model for AcceptFriendRequestWithToken endpoint
export type FriendingTokenRequestModel = { friendingToken: string }

--- <no description>
export type FriendshipRequestModel = { senderNickname: string, friendshipOriginSourceType: number }

--- A response model representing user information that also contains select presence information
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
export type FriendStatusResponse = { id: number, status: number }

--- Response model for following or followers Count
export type FollowCountResponse = { count: number }

--- Response model for Pending Friend Request Count
export type PendingFriendRequestCountModel = { count: number }

--- <no description>
export type FriendRequestsPlatformExclusiveStartKeyPages = { SortOrder: number, PagingDirection: number, Count: number }

--- Response model for MultigetAreFriendsResponse
export type MultigetAreFriendsResponse = { friendsId: { number } }

--- A response model representing user presence information.
export type UserPresenceResponse =
	{ id: number, userPresence: UserPresenceResponseModel, name: string, displayName: string }

--- <no description>
export type CaptchaTokenRequest = { captchaToken: string, captchaId: string, captchaProvider: string, challengeId: string }

--- Response model for Friends Count
export type FriendsCountResponse = { count: number }

--- A response model representing friend information
export type FriendResponse = { id: number, hasVerifiedBadge: boolean }

--- <no description>
export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

--- <no description>
export type StringPages = { Item2: StringPages, Item1: Int64Pages }

--- <no description>
export type UserPresenceResponsePages = { data: { UserPresenceResponse } }

--- Request model for MultigetAreFriends endpoint
export type MultigetAreFriendsRequestModel = { targetUserIds: { number } }

--- Request model for FollowingExists endpoint
export type FollowingExistsRequestModel = { targetUserIds: { number } }

--- <no description>
export type UserResponsePages = { data: { UserResponse } }

--- <no description>
export type ApiEmptyResponseModel = {}

--- Response model for Roblox.Web.Presence.Interfaces.IUserPresence objects
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
export type FollowingExistsResponseModel = { followings: { FollowingExistsResponse } }

--- A response model representing a friend request.
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

--- <no description>
export type UserResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { UserResponse } }

--- <no description>
export type FriendRequestResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { FriendRequestResponse },
}

--- <no description>
export type FriendStatusResponsePages = { data: { FriendStatusResponse } }

--- <no description>
export type FriendRequestsPlatformExclusiveStartKeyPages = {
	CursorRecipe: string,
	ExclusiveStartKeyInfo: FriendRequestsPlatformExclusiveStartKeyPages,
}

--- This is response model to notify when action succeeded, failed, or captcha is required
export type CaptchaStatusResponseModel = { success: boolean, isCaptchaRequired: boolean }

--- <no description>
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- <no description>
export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- A response model representing a friend request.
export type FriendRequest = {
	originSourceType: number,
	contactName: string,
	sentAt: string,
	senderId: number,
	sourceUniverseId: number,
	senderNickname: string,
}

--- <no description>
export type FriendResponsePages = {
	PreviousCursor: string,
	PageItems: { FriendResponse },
	HasMore: boolean,
	NextCursor: string,
}

--- response for DeclineAllFriendRequests
export type DeclineAllFriendRequestsResponse = { backgrounded: boolean }

--- Returns whether or not the current user is following each userId in a list of userIds
local function isFollowing(with: FollowingExistsRequestModel & { cookie: string }): FollowingExistsResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/following-exists`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates the following between a user and user with targetUserId
local function follow(with: CaptchaTokenRequest & { targetUserId: number, cookie: string }): CaptchaStatusResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/follow`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the number of friends a user has
local function getTotalFriendsOf(with: { userId: number }): FriendsCountResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.userId}/friends/count`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- <no description>
local function getMetadata(with: { targetUserId: number? }): FriendsPageMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/metadata?targetUserId={with.targetUserId or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the number of friends a user has
local function getTotalFriends(with: { cookie: string }): FriendsCountResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/my/friends/count`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Accept a friend request.
local function acceptFriendRequest(with: { requesterUserId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{with.requesterUserId}/accept-friend-request`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Search for friends by name using a text query.
local function searchFriendsOf(
	with: { userId: number, query: string?, cursor: string?, limit: number?, cookie: string }
): FriendResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.userId}/friends/search?query={with.query or ""}&cursor={with.cursor or ""}&limit={with.limit or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of all online friends for the specified user.
local function getOnlineFriendsOf(
	with: { userId: number, userSort: number?, cookie: string }
): UserPresenceResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.userId}/friends/online?userSort={with.userSort or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Decline all pending friend requests for the authenticated user.
local function declineAllFriendRequests(with: { cookie: string }): DeclineAllFriendRequestsResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/friend-requests/decline-all`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get all users that user with targetUserId is following in page response format
local function getFollowingsOf(
	with: { targetUserId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): UserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/followings?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Check if the requesting user is friends with the specified users.
local function areFriends(with: MultigetAreFriendsRequestModel & { userId: number }): MultigetAreFriendsResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/{with.userId}/multiget-are-friends`,
		headers = { ["Content-Type"] = "application/json" },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get all users that follow user with targetUserId in page response format
local function getFollowersOf(
	with: { targetUserId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): UserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/followers?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Unfriend a user
local function unfriend(with: { targetUserId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/unfriend`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Send a friend request to target user
local function sendFriendRequest(
	with: FriendshipRequestModel & { targetUserId: number, cookie: string }
): CaptchaStatusResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/request-friendship`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the number of following a user has
local function getTotalFollowingsOf(with: { targetUserId: number }): FollowCountResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/followings/count`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes the following between a user and user with targetUserId
local function unfollow(with: { targetUserId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/unfollow`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of inactive friends for the specified user.
local function getInactiveFriendsOf(with: { userId: number, cookie: string }): UserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.userId}/friends/inactive`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get all users that friend requests with targetUserId using exclusive start paging
local function getFriendRequests(
	with: { limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"?, cookie: string }
): FriendRequestResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/my/friends/requests?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Decline a friend request.
local function declineFriendRequest(with: { requesterUserId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{with.requesterUserId}/decline-friend-request`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of all friends for the specified user.
local function getFriendsOf(with: { userId: number, userSort: number? }): UserResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.userId}/friends?userSort={with.userSort or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a paginated list of all friends for the specified user.
local function getFriendshipsOf(
	with: { userId: number, userSort: number?, cursor: string?, limit: number?, cookie: string }
): FriendResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.userId}/friends/find?userSort={with.userSort or ""}&cursor={with.cursor or ""}&limit={with.limit or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Return the number of pending friend requests.
local function getTotalFriendRequests(with: { cookie: string }): PendingFriendRequestCountModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/user/friend-requests/count`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the number of following a user has
local function getTotalFollowersOf(with: { targetUserId: number }): FollowCountResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{with.targetUserId}/followers/count`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	isFollowing = isFollowing,
	follow = follow,
	getTotalFriendsOf = getTotalFriendsOf,
	getMetadata = getMetadata,
	getTotalFriends = getTotalFriends,
	acceptFriendRequest = acceptFriendRequest,
	searchFriendsOf = searchFriendsOf,
	getOnlineFriendsOf = getOnlineFriendsOf,
	declineAllFriendRequests = declineAllFriendRequests,
	getFollowingsOf = getFollowingsOf,
	areFriends = areFriends,
	getFollowersOf = getFollowersOf,
	unfriend = unfriend,
	sendFriendRequest = sendFriendRequest,
	getTotalFollowingsOf = getTotalFollowingsOf,
	unfollow = unfollow,
	getInactiveFriendsOf = getInactiveFriendsOf,
	getFriendRequests = getFriendRequests,
	declineFriendRequest = declineFriendRequest,
	getFriendsOf = getFriendsOf,
	getFriendshipsOf = getFriendshipsOf,
	getTotalFriendRequests = getTotalFriendRequests,
	getTotalFollowersOf = getTotalFollowersOf,
}
