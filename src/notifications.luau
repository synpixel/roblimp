local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

export type GetPushDestinationsResponseModel = { statusMessage: string, destinations: { UserPushDestination } }

export type NotificationIdsResponseModel = { statusMessage: string, ids: { string } }

export type RegisterChromeRequestModel = { notificationToken: string, initiatedByUser: boolean }

export type NotificationStreamEntriesModel = {
	isInteracted: boolean,
	notificationSourceType: "Test"
		| "FriendRequestReceived"
		| "FriendRequestAccepted"
		| "PartyInviteReceived"
		| "PartyMemberJoined"
		| "ChatNewMessage"
		| "PrivateMessageReceived"
		| "UserAddedToPrivateServerWhiteList"
		| "ConversationUniverseChanged"
		| "TeamCreateInvite"
		| "GameUpdate"
		| "DeveloperMetricsAvailable"
		| "GroupJoinRequestAccepted"
		| "Sendr"
		| "ExperienceInvitation",
	metadataCollection: { nil },
	eventCount: number,
	id: string,
	timestamp: string,
	content: nil,
	eventDate: string,
}

--- Model for a game update message to be displayed in notification stream.
export type GameUpdateNotificationModel = {
	createdOnKey: string,
	universeId: number,
	createdOn: string,
	rootPlaceId: number,
	content: string,
	universeName: string,
}

export type MarkInteractedRequestModel = { eventId: string }

export type PushNotificationRegistration = {
	application: string,
	platform: "ChromeOnDesktop"
		| "AndroidNative"
		| "FirefoxOnDesktop"
		| "IOSNative"
		| "AndroidAmazon"
		| "IOSTencent"
		| "AndroidTencentService"
		| "IOSPushKit",
	name: string,
	userPushNotificationDestinationId: number,
	notificationToken: string,
}

export type PushNotificationClientMetadata =
	{ fallbackDelivered: boolean, type: string, detail: nil, notificationId: string }

export type GetMetadataResponseModel = { statusMessage: string, metadata: PushNotificationClientMetadata }

export type RealTimeNotificationsSettingsResponseModel = { fallbackDomain: string, primaryDomain: string }

export type GetCurrentPushDestinationResponseModel = { statusMessage: string, destination: UserPushDestination }

export type RegisterFirefoxRequestModel = {
	notificationEndpoint: string,
	notificationToken: string,
	initiatedByUser: boolean,
}

export type UserPushDestination = {
	supportsUpdateNotifications: boolean,
	platform: "ChromeOnDesktop"
		| "AndroidNative"
		| "FirefoxOnDesktop"
		| "IOSNative"
		| "AndroidAmazon"
		| "IOSTencent"
		| "AndroidTencentService"
		| "IOSPushKit",
	name: string,
	user: NotificationUser,
	userPushNotificationDestinationId: number,
	notificationToken: string,
	application: string,
}

--- Chrome Manifest to link GCM project to Chrome browser
export type ChromeManifestModel = { name: string, gcm_sender_id: string }

export type NotificationUser = { name: string, userId: number }

export type RegisterIOSNativeRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	authorizeForUser: boolean,
	destinationIdentifier: string,
	notificationToken: string,
}

export type GameUpdateNotificationReadRequestModel = { universeId: number, createdOn: string, currentUserId: number }

export type UnreadStreamNotificationsModel = { unreadNotifications: number, statusMessage: string }

export type NotificationStreamMetadataResponse = {
	bannerDismissTimeSpan: number,
	canLaunchGameFromGameUpdate: boolean,
	signalRDisconnectionResponseInMilliseconds: number,
}

export type RegistrationResponseModel = { statusMessage: string, registration: PushNotificationRegistration }

export type RegisterTencentServiceRequestModel = {
	deviceName: string,
	destinationIdentifier: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

export type RegisterIOSPushKitRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	authorizeForUser: boolean,
	destinationIdentifier: string,
	notificationToken: string,
}

export type RegisterAndroidRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

export type RegisterAndroidAmazonRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

export type MarkInteractionRequestModel = {
	interactionType: "Click" | "Dismiss" | "Action",
	notificationToken: string,
	platformType: "ChromeOnDesktop"
		| "AndroidNative"
		| "FirefoxOnDesktop"
		| "IOSNative"
		| "AndroidAmazon"
		| "IOSTencent"
		| "AndroidTencentService"
		| "IOSPushKit",
	notificationId: string,
}

--- Gets the recent entries from the notification stream
local function recent(
	request: { startIndex: number?, maxRows: number? },
	cookie: string
): Response<{ NotificationStreamEntriesModel }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/get-recent?startIndex={request.startIndex or ""}&maxRows={request.maxRows or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Registers IOS device for pushkit notifications
local function registerIOSPushkit(
	request: RegisterIOSPushKitRequestModel,
	cookie: string
): Response<RegistrationResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-ios-pushkit`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- De-register all devices to disable push notifications
local function deregisterAllDevices(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-all-devices`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- De-register current device to disable push notifications
local function deregisterDevice(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-current-device`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- Get Chrome Manifest to link GCM project to Chrome Browser
local function chromeManifest(cookie: string): Response<ChromeManifestModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/chrome-manifest`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- De-register current device to disable pushkit notifications
local function deregisterIOSPushkit(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-current-device-ios-pushkit`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- Get Notification Stream metadata.
local function streamMetadata(cookie: string): Response<NotificationStreamMetadataResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Clears the unread Notification stream count
local function clearUnread(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/clear-unread`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- Sends metrics when a Game Update Notification is Read from the Game Update Notifications Section of the Notification Stream
local function acknowledgeGameUpdate(request: GameUpdateNotificationReadRequestModel, cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/game-update-notification-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- Gets valid destinations associated with the signed user
local function destinations(cookie: string): Response<GetPushDestinationsResponseModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/get-destinations`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the notificationIds for the specified notification token
local function multiple(
	request: { notificationToken: string, limit: number, cursor: number? },
	cookie: string
): Response<NotificationIdsResponseModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/notification-ids?notificationToken={request.notificationToken}&limit={request.limit}&cursor={request.cursor or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Registers IOS device for push notifications
local function registerIOSNative(
	request: RegisterIOSNativeRequestModel,
	cookie: string
): Response<RegistrationResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-ios-native`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Register Android Native for push notifications
local function registerAndroidNative(
	request: RegisterAndroidRequestModel,
	cookie: string
): Response<RegistrationResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-native`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Register Android Tencent service device for push notifications
local function registerAndroidTencentService(
	request: RegisterTencentServiceRequestModel,
	cookie: string
): Response<RegistrationResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-tencent-service`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Registers Firefox for push notifications
local function registerFirefox(
	request: RegisterFirefoxRequestModel,
	cookie: string
): Response<RegistrationResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-firefox`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Registers Chrome for push notifications
local function registerChrome(request: RegisterChromeRequestModel, cookie: string): Response<RegistrationResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-chrome`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the count of unread Notification stream entries
local function countUnread(cookie: string): Response<UnreadStreamNotificationsModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/unread-count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the corresponding metadata for the specified notification
local function metadata(
	request: { notificationToken: string, notificationId: string },
	cookie: string
): Response<GetMetadataResponseModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/metadata?notificationToken={request.notificationToken}&notificationId={request.notificationId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the current device destination
local function destination(cookie: string): Response<GetCurrentPushDestinationResponseModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/get-current-device-destination`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Marks a Notification Stream Entry as Interacted
local function markInteracted(eventId: string, cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/mark-interacted`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { eventId = eventId }),
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- Marks Interaction status for push notification
local function markInteraction(request: MarkInteractionRequestModel, cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/mark-interaction`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- Gets the notification settings related to realtime
local function realtimeSettings(cookie: string): Response<RealTimeNotificationsSettingsResponseModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/notifications/settings/realtime`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Register Amazon Android for push notifications
local function registerAmazonAndroid(
	request: RegisterAndroidAmazonRequestModel,
	cookie: string
): Response<RegistrationResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-amazon`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

local function latestGameUpdates(
	request: { universeIds: { number }, sinceDateTime: string? },
	cookie: string
): Response<{ GameUpdateNotificationModel }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/get-latest-game-updates?universeIds={table.concat(
			request.universeIds,
			"&universeIds="
		)}&sinceDateTime={request.sinceDateTime or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

return {
	recent = recent,
	registerIOSPushkit = registerIOSPushkit,
	deregisterAllDevices = deregisterAllDevices,
	deregisterDevice = deregisterDevice,
	chromeManifest = chromeManifest,
	deregisterIOSPushkit = deregisterIOSPushkit,
	streamMetadata = streamMetadata,
	clearUnread = clearUnread,
	acknowledgeGameUpdate = acknowledgeGameUpdate,
	destinations = destinations,
	multiple = multiple,
	registerIOSNative = registerIOSNative,
	registerAndroidNative = registerAndroidNative,
	registerAndroidTencentService = registerAndroidTencentService,
	registerFirefox = registerFirefox,
	registerChrome = registerChrome,
	countUnread = countUnread,
	metadata = metadata,
	destination = destination,
	markInteracted = markInteracted,
	markInteraction = markInteraction,
	realtimeSettings = realtimeSettings,
	registerAmazonAndroid = registerAmazonAndroid,
	latestGameUpdates = latestGameUpdates,
}
