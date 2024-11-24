local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

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
local function get(userIds: { number }, cookie: string?): Response<{ UserPresence }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://presence.roblox.com/v1/presence/users`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie or ""}` },
		body = serde.encode("json", { userIds = userIds }),
	}):map(function(response)
		return serde.decode("json", response.body).userPresences
	end)
end

return { get = get }
