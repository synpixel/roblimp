local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

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

export type FriendRequestsPlatformExclusiveStartKeyPages = { SortOrder: number, PagingDirection: number, Count: number }

--- The friendship status response model.
export type ClearNewFriendRequestResponse = { status: boolean }

--- Response model for MultigetAreFriendsResponse
export type MultigetAreFriendsResponse = { friendsId: { number } }

--- A response model representing user presence information.
export type UserPresenceResponse =
	{ id: number, userPresence: UserPresenceResponseModel, name: string, displayName: string }

export type CaptchaTokenRequest = { captchaToken: string, captchaId: string, captchaProvider: string, challengeId: string }

--- Response model for Friends Count
export type FriendsCountResponse = { count: number }

--- A response model representing friend information
export type FriendResponse = { id: number, hasVerifiedBadge: boolean }

export type Int64Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int64Pages }

export type StringPages = { Item2: StringPages, Item1: Int64Pages }

export type UserPresenceResponsePages = { data: { UserPresenceResponse } }

--- Request model for MultigetAreFriends endpoint
export type MultigetAreFriendsRequestModel = { targetUserIds: { number } }

--- Request model for FollowingExists endpoint
export type FollowingExistsRequestModel = { targetUserIds: { number } }

--- The friendship status response model.
export type NewFriendRequestsCountResponse = { count: number }

export type UserResponsePages = { data: { UserResponse } }

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

export type FriendRequestResponsePages = {
	nextPageCursor: string,
	previousPageCursor: string,
	data: { FriendRequestResponse },
}

export type FriendStatusResponsePages = { data: { FriendStatusResponse } }

--- This is response model to notify when action succeeded, failed, or captcha is required
export type CaptchaStatusResponseModel = { success: boolean, isCaptchaRequired: boolean }

--- A response model representing a friend request.
export type FriendRequest = {
	originSourceType: number,
	contactName: string,
	sentAt: string,
	senderId: number,
	sourceUniverseId: number,
	senderNickname: string,
}

export type FriendResponsePages = {
	PreviousCursor: string,
	PageItems: { FriendResponse },
	HasMore: boolean,
	NextCursor: string,
}

--- response for DeclineAllFriendRequests
export type DeclineAllFriendRequestsResponse = { backgrounded: boolean }

--- Returns whether or not the current user is following each userId in a list of userIds
local function following(targetUserIds: { number }, cookie: string): Response<{ FollowingExistsResponse }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/following-exists`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { targetUserIds = targetUserIds }),
	}):map(function(response)
		return serde.decode("json", response.body).followings
	end)
end

--- Creates the following between a user and user with targetUserId
local function follow(
	request: CaptchaTokenRequest & { targetUserId: number },
	cookie: string
): Response<CaptchaStatusResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/follow`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get the number of friends a user has
local function countFriendsOf(userId: number, cookie: string?): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{userId}/friends/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
end

local function metadata(targetUserId: number?, cookie: string?): Response<FriendsPageMetadataResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/metadata?targetUserId={targetUserId or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get the number of friends a user has
local function count(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/my/friends/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
end

--- Accept a friend request.
local function acceptFriendRequest(requesterUserId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{requesterUserId}/accept-friend-request`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Search for friends by name using a text query.
local function search(
	request: { userId: number, query: string?, cursor: string?, limit: number? },
	cookie: string
): Response<FriendResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends/search?query={request.query or ""}&cursor={request.cursor or ""}&limit={request.limit or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get list of all online friends for the specified user.
local function onlineFriendsOf(
	request: { userId: number, userSort: number? },
	cookie: string
): Response<{ UserPresenceResponse }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends/online?userSort={request.userSort or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Decline all pending friend requests for the authenticated user.
local function declineAllFriendRequests(cookie: string): Response<boolean>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/friend-requests/decline-all`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).backgrounded
	end)
end

--- Get all users that user with targetUserId is following in page response format
local function followingsOf(
	request: { targetUserId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): Response<UserResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/followings?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Check if the requesting user is friends with the specified users.
local function areFriends(
	request: MultigetAreFriendsRequestModel & { userId: number },
	cookie: string
): Response<{ number }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/user/{request.userId}/multiget-are-friends`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).friendsId
	end)
end

--- Get all users that follow user with targetUserId in page response format
local function followersOf(
	request: { targetUserId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): Response<UserResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/followers?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Unfriend a user
local function unfriend(targetUserId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/unfriend`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Send a friend request to target user
local function sendFriendRequest(
	request: FriendshipRequestModel & { targetUserId: number },
	cookie: string
): Response<CaptchaStatusResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{request.targetUserId}/request-friendship`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get the number of following a user has
local function countFollowingsOf(targetUserId: number, cookie: string?): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/followings/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
end

--- Deletes the following between a user and user with targetUserId
local function unfollow(targetUserId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/unfollow`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get list of inactive friends for the specified user.
local function inactiveFriendsOf(userId: number, cookie: string): Response<{ UserResponse }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{userId}/friends/inactive`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Get all users that friend requests with targetUserId using exclusive start paging
local function friendRequests(
	request: { limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? },
	cookie: string
): Response<FriendRequestResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/my/friends/requests?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Decline a friend request.
local function declineFriendRequest(requesterUserId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://friends.roblox.com/v1/users/{requesterUserId}/decline-friend-request`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get list of all friends for the specified user.
local function friendsOf(request: { userId: number, userSort: number? }, cookie: string?): Response<{ UserResponse }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends?userSort={request.userSort or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).data
	end)
end

--- Get a paginated list of all friends for the specified user.
local function friendshipsOf(
	request: { userId: number, userSort: number?, cursor: string?, limit: number? },
	cookie: string?
): Response<FriendResponsePages>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{request.userId}/friends/find?userSort={request.userSort or ""}&cursor={request.cursor or ""}&limit={request.limit or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Return the number of pending friend requests.
local function countFriendRequests(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/user/friend-requests/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
end

--- Get the number of following a user has
local function countFollowersOf(targetUserId: number, cookie: string?): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://friends.roblox.com/v1/users/{targetUserId}/followers/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie or ""}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
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
