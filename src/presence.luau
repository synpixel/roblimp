local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- Get users presences request model
export type UserPresenceRequest = { userIds: { number } }

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
export type UserPresencesResponse = { userPresences: { UserPresence } }

--- Last online data for given user id.
export type LastOnline = { userId: number, lastOnline: string }

--- Last online endpoint response model.
export type LastOnlineResponse = { lastOnlineTimestamps: { LastOnline } }

--- Get last online timestamps request model
export type LastOnlineRequest = { userIds: { number } }

--- Get Presence for a list of users
local function get(with: UserPresenceRequest): { UserPresence }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://presence.roblox.com/v1/presence/users`,
		headers = { ["Content-Type"] = "application/json" },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).userPresences
end

return { get = get }
