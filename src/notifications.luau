local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
export type ReceiverDestinationSettingModel = {
	platform: "ChromeOnDesktop"
		| "AndroidNative"
		| "FirefoxOnDesktop"
		| "IOSNative"
		| "AndroidAmazon"
		| "IOSTencent"
		| "AndroidTencentService"
		| "IOSPushKit",
	name: string,
	isEnabled: boolean,
	destinationId: number,
	isSetByReceiver: boolean,
}

--- <no description>
export type ReceiverNotificationSettingGroupModel = {
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
	receiverDestinationType: "DesktopPush" | "MobilePush" | "NotificationStream",
	isEnabled: boolean,
	isOverridable: boolean,
	isSetByReceiver: boolean,
	pushNotificationDestinationPreferences: { ReceiverDestinationSettingModel },
}

--- <no description>
export type GetPushDestinationsResponseModel = { statusMessage: string, destinations: { UserPushDestination } }

--- <no description>
export type NotificationIdsResponseModel = { statusMessage: string, ids: { string } }

--- <no description>
export type RegisterChromeRequestModel = { notificationToken: string, initiatedByUser: boolean }

--- <no description>
export type UserNotificationSettingsModel = {
	optedOutReceiverDestinationTypes: { "DesktopPush" | "MobilePush" | "NotificationStream" },
	notificationBandSettings: { ReceiverNotificationSettingGroupModel },
	optedOutNotificationSourceTypes: {
		"Test"
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
		| "ExperienceInvitation"
	},
}

--- <no description>
export type SuccessResponseModel = { statusMessage: string }

--- <no description>
export type RolloutSettingsModel = { isValidFeature: boolean, isRolloutEnabled: boolean, featureName: string }

--- <no description>
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

--- <no description>
export type MarkInteractedRequestModel = { eventId: string }

--- <no description>
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

--- <no description>
export type PushNotificationClientMetadata =
	{ fallbackDelivered: boolean, type: string, detail: nil, notificationId: string }

--- <no description>
export type GetMetadataResponseModel = { statusMessage: string, metadata: PushNotificationClientMetadata }

--- <no description>
export type RealTimeNotificationsSettingsResponseModel = { fallbackDomain: string, primaryDomain: string }

--- <no description>
export type GetCurrentPushDestinationResponseModel = { statusMessage: string, destination: UserPushDestination }

--- <no description>
export type RegisterFirefoxRequestModel = {
	notificationEndpoint: string,
	notificationToken: string,
	initiatedByUser: boolean,
}

--- <no description>
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

--- <no description>
export type NotificationUser = { name: string, userId: number }

--- <no description>
export type MarkAsReadRequestModel = {
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

--- <no description>
export type RegisterIOSNativeRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	authorizeForUser: boolean,
	destinationIdentifier: string,
	notificationToken: string,
}

--- <no description>
export type NotificationRolloutSettingsModel = { rollOutFeatureEnabledList: { RolloutSettingsModel } }

--- <no description>
export type GameUpdateNotificationReadRequestModel = { universeId: number, createdOn: string, currentUserId: number }

--- <no description>
export type UnreadStreamNotificationsModel = { unreadNotifications: number, statusMessage: string }

--- <no description>
export type NotificationStreamMetadataResponse = {
	bannerDismissTimeSpan: number,
	canLaunchGameFromGameUpdate: boolean,
	signalRDisconnectionResponseInMilliseconds: number,
}

--- <no description>
export type RegistrationResponseModel = { statusMessage: string, registration: PushNotificationRegistration }

--- <no description>
export type RegisterTencentServiceRequestModel = {
	deviceName: string,
	destinationIdentifier: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

--- <no description>
export type RegisterIOSPushKitRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	authorizeForUser: boolean,
	destinationIdentifier: string,
	notificationToken: string,
}

--- <no description>
export type RegisterAndroidRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

--- <no description>
export type RegisterAndroidAmazonRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

--- <no description>
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

--- <no description>
export type MarkCategoryAsReadRequestModel = {
	latestNotificationId: string,
	notificationType: "Test"
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
	category: string,
}

--- Gets the recent entries from the notification stream
local function getRecent(
	with: { startIndex: number?, maxRows: number?, cookie: string }
): { NotificationStreamEntriesModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/get-recent?startIndex={with.startIndex or ""}&maxRows={with.maxRows or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers IOS device for pushkit notifications
local function registerIOSPushkit(with: RegisterIOSPushKitRequestModel & { cookie: string }): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-ios-pushkit`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- De-register all devices to disable push notifications
local function deregisterAllDevices(with: { cookie: string }): SuccessResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-all-devices`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- De-register current device to disable push notifications
local function deregisterDevice(with: { cookie: string }): SuccessResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-current-device`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get Chrome Manifest to link GCM project to Chrome Browser
local function getChromeManifest(with: { cookie: string }): ChromeManifestModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/chrome-manifest`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- De-register current device to disable pushkit notifications
local function deregisterIOSPushkit(with: { cookie: string }): SuccessResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-current-device-ios-pushkit`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get Notification Stream metadata.
local function getStreamMetadata(with: { cookie: string }): NotificationStreamMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Clears the unread Notification stream count
local function clearUnread(with: { cookie: string }): SuccessResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/clear-unread`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sends metrics when a Game Update Notification is Read from the Game Update Notifications Section of the Notification Stream
local function acknowledgeGameUpdate(
	with: GameUpdateNotificationReadRequestModel & { cookie: string }
): SuccessResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/game-update-notification-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets valid destinations associated with the signed user
local function getDestinations(with: { cookie: string }): GetPushDestinationsResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/get-destinations`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the notificationIds for the specified notification token
local function getNotificationIds(
	with: { notificationToken: string, limit: number, cursor: number?, cookie: string }
): NotificationIdsResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/notification-ids?notificationToken={with.notificationToken}&limit={with.limit}&cursor={with.cursor or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers IOS device for push notifications
local function registerIOSNative(with: RegisterIOSNativeRequestModel & { cookie: string }): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-ios-native`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Register Android Native for push notifications
local function registerAndroidNative(with: RegisterAndroidRequestModel & { cookie: string }): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-native`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Register Android Tencent service device for push notifications
local function registerAndroidTencentService(
	with: RegisterTencentServiceRequestModel & { cookie: string }
): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-tencent-service`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers Firefox for push notifications
local function registerFirefox(with: RegisterFirefoxRequestModel & { cookie: string }): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-firefox`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers Chrome for push notifications
local function registerChrome(with: RegisterChromeRequestModel & { cookie: string }): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-chrome`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the count of unread Notification stream entries
local function getTotalUnread(with: { cookie: string }): UnreadStreamNotificationsModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/unread-count`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the corresponding metadata for the specified notification
local function getMetadata(
	with: { notificationToken: string, notificationId: string, cookie: string }
): GetMetadataResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/metadata?notificationToken={with.notificationToken}&notificationId={with.notificationId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the current device destination
local function getDeviceDestination(with: { cookie: string }): GetCurrentPushDestinationResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/get-current-device-destination`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Marks a Notification Stream Entry as Interacted
local function markInteracted(with: MarkInteractedRequestModel & { cookie: string }): SuccessResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/mark-interacted`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Marks Interaction status for push notification
local function markInteraction(with: MarkInteractionRequestModel & { cookie: string }): SuccessResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/mark-interaction`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the notification settings related to realtime
local function getRealtimeSettings(with: { cookie: string }): RealTimeNotificationsSettingsResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/notifications/settings/realtime`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Register Amazon Android for push notifications
local function registerAmazonAndroid(
	with: RegisterAndroidAmazonRequestModel & { cookie: string }
): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-amazon`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- <no description>
local function getLatestGameUpdates(
	with: { universeIds: { number }, sinceDateTime: string?, cookie: string }
): { GameUpdateNotificationModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/get-latest-game-updates?universeIds={table.concat(
			with.universeIds,
			"&universeIds="
		)}&sinceDateTime={with.sinceDateTime or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	getRecent = getRecent,
	registerIOSPushkit = registerIOSPushkit,
	deregisterAllDevices = deregisterAllDevices,
	deregisterDevice = deregisterDevice,
	getChromeManifest = getChromeManifest,
	deregisterIOSPushkit = deregisterIOSPushkit,
	getStreamMetadata = getStreamMetadata,
	clearUnread = clearUnread,
	acknowledgeGameUpdate = acknowledgeGameUpdate,
	getDestinations = getDestinations,
	getNotificationIds = getNotificationIds,
	registerIOSNative = registerIOSNative,
	registerAndroidNative = registerAndroidNative,
	registerAndroidTencentService = registerAndroidTencentService,
	registerFirefox = registerFirefox,
	registerChrome = registerChrome,
	getTotalUnread = getTotalUnread,
	getMetadata = getMetadata,
	getDeviceDestination = getDeviceDestination,
	markInteracted = markInteracted,
	markInteraction = markInteraction,
	getRealtimeSettings = getRealtimeSettings,
	registerAmazonAndroid = registerAmazonAndroid,
	getLatestGameUpdates = getLatestGameUpdates,
}
