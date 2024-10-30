local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- Model for a user following a universe controller responses
export type UserFollowingUniverseResponse = { userId: number, universeId: number }

--- Model for a user following a universe  state controller responses
export type UserFollowingUniverseStatusResponse = {
	UniverseId: number,
	IsFollowing: boolean,
	FollowingLimitByType: number,
	FollowingCountByType: number,
	UserId: number,
	CanFollow: boolean,
}

--- Data model containing collection of all followed sources of a specific type.
export type FollowsByTypeResponse = { followedSources: {}, followerId: number, followerType: number, sourceType: number }

--- Gets the status of a following relationship between a user and a universe.
local function getFollowingStatus(
	with: { userId: number, universeId: number, cookie: string }
): UserFollowingUniverseStatusResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://followings.roblox.com/v1/users/{with.userId}/universes/{with.universeId}/status`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates the following between a user with userId and universe with universeId
local function follow(with: { userId: number, universeId: number, cookie: string }): UserFollowingUniverseResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://followings.roblox.com/v1/users/{with.userId}/universes/{with.universeId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Deletes the following between a user with userId and universe with universeId
local function unfollow(with: { userId: number, universeId: number, cookie: string }): UserFollowingUniverseResponse
	local response = requestWithCsrfToken({
		method = "DELETE",
		url = `https://followings.roblox.com/v1/users/{with.userId}/universes/{with.universeId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all universes followed by a user.
local function getFollowingsOf(with: { userId: number, cookie: string }): FollowsByTypeResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://followings.roblox.com/v2/users/{with.userId}/universes`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	getFollowingStatus = getFollowingStatus,
	getFollowingsOf = getFollowingsOf,
	follow = follow,
	unfollow = unfollow,
}
