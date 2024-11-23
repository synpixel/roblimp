local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [followings.roblox.com](https://followings.roblox.com)
--- @class followings

--- Model for a user following a universe controller responses
--- @interface UserFollowingUniverseResponse
--- .userId number
--- .universeId number
--- @within followings
export type UserFollowingUniverseResponse = { userId: number, universeId: number }

--- Model for a user following a universe  state controller responses
--- @interface UserFollowingUniverseStatusResponse
--- .UniverseId number
--- .IsFollowing boolean
--- .FollowingLimitByType number
--- .FollowingCountByType number
--- .UserId number
--- .CanFollow boolean
--- @within followings
export type UserFollowingUniverseStatusResponse = {
	UniverseId: number,
	IsFollowing: boolean,
	FollowingLimitByType: number,
	FollowingCountByType: number,
	UserId: number,
	CanFollow: boolean,
}

--- Data model containing collection of all followed sources of a specific type.
--- @interface FollowsByTypeResponse
--- .followedSources {}
--- .followerId number
--- .followerType number
--- .sourceType number
--- @within followings
export type FollowsByTypeResponse = { followedSources: {}, followerId: number, followerType: number, sourceType: number }

--- Gets the status of a following relationship between a user and a universe.
--- @within followings
local function followingStatus(
	request: { userId: number, universeId: number },
	cookie: string
): UserFollowingUniverseStatusResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://followings.roblox.com/v1/users/{request.userId}/universes/{request.universeId}/status`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates the following between a user with userId and universe with universeId
--- @within followings
local function follow(request: { userId: number, universeId: number }, cookie: string): UserFollowingUniverseResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://followings.roblox.com/v1/users/{request.userId}/universes/{request.universeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes the following between a user with userId and universe with universeId
--- @within followings
local function unfollow(request: { userId: number, universeId: number }, cookie: string): UserFollowingUniverseResponse
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://followings.roblox.com/v1/users/{request.userId}/universes/{request.universeId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all universes followed by a user.
--- @within followings
local function followingsOf(userId: number, cookie: string): FollowsByTypeResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://followings.roblox.com/v2/users/{userId}/universes`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return { followingStatus = followingStatus, followingsOf = followingsOf, follow = follow, unfollow = unfollow }
