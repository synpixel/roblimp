local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [presence.roblox.com](https://presence.roblox.com)
--- @class presence

--- Get users presences request model
--- @interface UserPresenceRequest
--- .userIds { number }
--- @within presence
export type UserPresenceRequest = { userIds: { number } }

--- @interface UserPresence
--- .universeId number
--- .placeId number
--- .userId number
--- .userPresenceType number
--- .invisibleModeExpiry string
--- .gameId string
--- .lastLocation string
--- .rootPlaceId number
--- .lastOnline string
--- @within presence
export type UserPresence = {
	universeId: number,
	placeId: number,
	userId: number,
	userPresenceType: number,
	invisibleModeExpiry: string,
	gameId: string,
	lastLocation: string,
	rootPlaceId: number,
	lastOnline: string,
}

--- User Presences Response model
--- @interface UserPresencesResponse
--- .userPresences { UserPresence }
--- @within presence
export type UserPresencesResponse = { userPresences: { UserPresence } }

--- Last online data for given user id.
--- @interface LastOnline
--- .userId number
--- .lastOnline string
--- @within presence
export type LastOnline = { userId: number, lastOnline: string }

--- Last online endpoint response model.
--- @interface LastOnlineResponse
--- .lastOnlineTimestamps { LastOnline }
--- @within presence
export type LastOnlineResponse = { lastOnlineTimestamps: { LastOnline } }

--- Get last online timestamps request model
--- @interface LastOnlineRequest
--- .userIds { number }
--- @within presence
export type LastOnlineRequest = { userIds: { number } }

--- Get Presence for a list of users
--- @within presence
local function get(userIds: { number }, cookie: string?): { UserPresence }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://presence.roblox.com/v1/presence/users`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie or ""}` },
		body = serde.encode("json", { userIds = userIds }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).userPresences
end

return { get = get }
