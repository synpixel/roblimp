local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [notifications.roblox.com](https://notifications.roblox.com)
--- @class notifications

--- @interface ReceiverDestinationSettingModel
--- .platform "ChromeOnDesktop" | "AndroidNative" | "FirefoxOnDesktop" | "IOSNative" | "AndroidAmazon" | "IOSTencent" | "AndroidTencentService" | "IOSPushKit"
--- .name string
--- .isEnabled boolean
--- .destinationId number
--- .isSetByReceiver boolean
--- @within notifications
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

--- @interface ReceiverNotificationSettingGroupModel
--- .notificationSourceType "Test" | "FriendRequestReceived" | "FriendRequestAccepted" | "PartyInviteReceived" | "PartyMemberJoined" | "ChatNewMessage" | "PrivateMessageReceived" | "UserAddedToPrivateServerWhiteList" | "ConversationUniverseChanged" | "TeamCreateInvite" | "GameUpdate" | "DeveloperMetricsAvailable" | "GroupJoinRequestAccepted" | "Sendr" | "ExperienceInvitation"
--- .receiverDestinationType "DesktopPush" | "MobilePush" | "NotificationStream"
--- .isEnabled boolean
--- .isOverridable boolean
--- .isSetByReceiver boolean
--- .pushNotificationDestinationPreferences { ReceiverDestinationSettingModel }
--- @within notifications
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

--- @interface GetPushDestinationsResponseModel
--- .statusMessage string
--- .destinations { UserPushDestination }
--- @within notifications
export type GetPushDestinationsResponseModel = { statusMessage: string, destinations: { UserPushDestination } }

--- @interface NotificationIdsResponseModel
--- .statusMessage string
--- .ids { string }
--- @within notifications
export type NotificationIdsResponseModel = { statusMessage: string, ids: { string } }

--- @interface RegisterChromeRequestModel
--- .notificationToken string
--- .initiatedByUser boolean
--- @within notifications
export type RegisterChromeRequestModel = { notificationToken: string, initiatedByUser: boolean }

--- @interface UserNotificationSettingsModel
--- .optedOutReceiverDestinationTypes { "DesktopPush" | "MobilePush" | "NotificationStream" }
--- .notificationBandSettings { ReceiverNotificationSettingGroupModel }
--- .optedOutNotificationSourceTypes { "Test" | "FriendRequestReceived" | "FriendRequestAccepted" | "PartyInviteReceived" | "PartyMemberJoined" | "ChatNewMessage" | "PrivateMessageReceived" | "UserAddedToPrivateServerWhiteList" | "ConversationUniverseChanged" | "TeamCreateInvite" | "GameUpdate" | "DeveloperMetricsAvailable" | "GroupJoinRequestAccepted" | "Sendr" | "ExperienceInvitation" }
--- @within notifications
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

--- @interface SuccessResponseModel
--- .statusMessage string
--- @within notifications
export type SuccessResponseModel = { statusMessage: string }

--- @interface RolloutSettingsModel
--- .isValidFeature boolean
--- .isRolloutEnabled boolean
--- .featureName string
--- @within notifications
export type RolloutSettingsModel = { isValidFeature: boolean, isRolloutEnabled: boolean, featureName: string }

--- @interface NotificationStreamEntriesModel
--- .isInteracted boolean
--- .notificationSourceType "Test" | "FriendRequestReceived" | "FriendRequestAccepted" | "PartyInviteReceived" | "PartyMemberJoined" | "ChatNewMessage" | "PrivateMessageReceived" | "UserAddedToPrivateServerWhiteList" | "ConversationUniverseChanged" | "TeamCreateInvite" | "GameUpdate" | "DeveloperMetricsAvailable" | "GroupJoinRequestAccepted" | "Sendr" | "ExperienceInvitation"
--- .metadataCollection { nil }
--- .eventCount number
--- .id string
--- .timestamp string
--- .content nil
--- .eventDate string
--- @within notifications
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
--- @interface GameUpdateNotificationModel
--- .createdOnKey string
--- .universeId number
--- .createdOn string
--- .rootPlaceId number
--- .content string
--- .universeName string
--- @within notifications
export type GameUpdateNotificationModel = {
	createdOnKey: string,
	universeId: number,
	createdOn: string,
	rootPlaceId: number,
	content: string,
	universeName: string,
}

--- @interface MarkInteractedRequestModel
--- .eventId string
--- @within notifications
export type MarkInteractedRequestModel = { eventId: string }

--- @interface PushNotificationRegistration
--- .application string
--- .platform "ChromeOnDesktop" | "AndroidNative" | "FirefoxOnDesktop" | "IOSNative" | "AndroidAmazon" | "IOSTencent" | "AndroidTencentService" | "IOSPushKit"
--- .name string
--- .userPushNotificationDestinationId number
--- .notificationToken string
--- @within notifications
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

--- @interface PushNotificationClientMetadata
--- .fallbackDelivered boolean
--- .type string
--- .detail nil
--- .notificationId string
--- @within notifications
export type PushNotificationClientMetadata =
	{ fallbackDelivered: boolean, type: string, detail: nil, notificationId: string }

--- @interface GetMetadataResponseModel
--- .statusMessage string
--- .metadata PushNotificationClientMetadata
--- @within notifications
export type GetMetadataResponseModel = { statusMessage: string, metadata: PushNotificationClientMetadata }

--- @interface RealTimeNotificationsSettingsResponseModel
--- .fallbackDomain string
--- .primaryDomain string
--- @within notifications
export type RealTimeNotificationsSettingsResponseModel = { fallbackDomain: string, primaryDomain: string }

--- @interface GetCurrentPushDestinationResponseModel
--- .statusMessage string
--- .destination UserPushDestination
--- @within notifications
export type GetCurrentPushDestinationResponseModel = { statusMessage: string, destination: UserPushDestination }

--- @interface RegisterFirefoxRequestModel
--- .notificationEndpoint string
--- .notificationToken string
--- .initiatedByUser boolean
--- @within notifications
export type RegisterFirefoxRequestModel = {
	notificationEndpoint: string,
	notificationToken: string,
	initiatedByUser: boolean,
}

--- @interface UserPushDestination
--- .supportsUpdateNotifications boolean
--- .platform "ChromeOnDesktop" | "AndroidNative" | "FirefoxOnDesktop" | "IOSNative" | "AndroidAmazon" | "IOSTencent" | "AndroidTencentService" | "IOSPushKit"
--- .name string
--- .user NotificationUser
--- .userPushNotificationDestinationId number
--- .notificationToken string
--- .application string
--- @within notifications
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
--- @interface ChromeManifestModel
--- .name string
--- .gcm_sender_id string
--- @within notifications
export type ChromeManifestModel = { name: string, gcm_sender_id: string }

--- @interface NotificationUser
--- .name string
--- .userId number
--- @within notifications
export type NotificationUser = { name: string, userId: number }

--- @interface MarkAsReadRequestModel
--- .platformType "ChromeOnDesktop" | "AndroidNative" | "FirefoxOnDesktop" | "IOSNative" | "AndroidAmazon" | "IOSTencent" | "AndroidTencentService" | "IOSPushKit"
--- .notificationId string
--- @within notifications
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

--- @interface RegisterIOSNativeRequestModel
--- .oldNotificationToken string
--- .deviceName string
--- .authorizeForUser boolean
--- .destinationIdentifier string
--- .notificationToken string
--- @within notifications
export type RegisterIOSNativeRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	authorizeForUser: boolean,
	destinationIdentifier: string,
	notificationToken: string,
}

--- @interface NotificationRolloutSettingsModel
--- .rollOutFeatureEnabledList { RolloutSettingsModel }
--- @within notifications
export type NotificationRolloutSettingsModel = { rollOutFeatureEnabledList: { RolloutSettingsModel } }

--- @interface GameUpdateNotificationReadRequestModel
--- .universeId number
--- .createdOn string
--- .currentUserId number
--- @within notifications
export type GameUpdateNotificationReadRequestModel = { universeId: number, createdOn: string, currentUserId: number }

--- @interface UnreadStreamNotificationsModel
--- .unreadNotifications number
--- .statusMessage string
--- @within notifications
export type UnreadStreamNotificationsModel = { unreadNotifications: number, statusMessage: string }

--- @interface NotificationStreamMetadataResponse
--- .bannerDismissTimeSpan number
--- .canLaunchGameFromGameUpdate boolean
--- .signalRDisconnectionResponseInMilliseconds number
--- @within notifications
export type NotificationStreamMetadataResponse = {
	bannerDismissTimeSpan: number,
	canLaunchGameFromGameUpdate: boolean,
	signalRDisconnectionResponseInMilliseconds: number,
}

--- @interface RegistrationResponseModel
--- .statusMessage string
--- .registration PushNotificationRegistration
--- @within notifications
export type RegistrationResponseModel = { statusMessage: string, registration: PushNotificationRegistration }

--- @interface RegisterTencentServiceRequestModel
--- .deviceName string
--- .destinationIdentifier string
--- .notificationToken string
--- .authorizeForUser boolean
--- @within notifications
export type RegisterTencentServiceRequestModel = {
	deviceName: string,
	destinationIdentifier: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

--- @interface RegisterIOSPushKitRequestModel
--- .oldNotificationToken string
--- .deviceName string
--- .authorizeForUser boolean
--- .destinationIdentifier string
--- .notificationToken string
--- @within notifications
export type RegisterIOSPushKitRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	authorizeForUser: boolean,
	destinationIdentifier: string,
	notificationToken: string,
}

--- @interface RegisterAndroidRequestModel
--- .oldNotificationToken string
--- .deviceName string
--- .notificationToken string
--- .authorizeForUser boolean
--- @within notifications
export type RegisterAndroidRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

--- @interface RegisterAndroidAmazonRequestModel
--- .oldNotificationToken string
--- .deviceName string
--- .notificationToken string
--- .authorizeForUser boolean
--- @within notifications
export type RegisterAndroidAmazonRequestModel = {
	oldNotificationToken: string,
	deviceName: string,
	notificationToken: string,
	authorizeForUser: boolean,
}

--- @interface MarkInteractionRequestModel
--- .interactionType "Click" | "Dismiss" | "Action"
--- .notificationToken string
--- .platformType "ChromeOnDesktop" | "AndroidNative" | "FirefoxOnDesktop" | "IOSNative" | "AndroidAmazon" | "IOSTencent" | "AndroidTencentService" | "IOSPushKit"
--- .notificationId string
--- @within notifications
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

--- @interface MarkCategoryAsReadRequestModel
--- .latestNotificationId string
--- .notificationType "Test" | "FriendRequestReceived" | "FriendRequestAccepted" | "PartyInviteReceived" | "PartyMemberJoined" | "ChatNewMessage" | "PrivateMessageReceived" | "UserAddedToPrivateServerWhiteList" | "ConversationUniverseChanged" | "TeamCreateInvite" | "GameUpdate" | "DeveloperMetricsAvailable" | "GroupJoinRequestAccepted" | "Sendr" | "ExperienceInvitation"
--- .category string
--- @within notifications
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
--- @within notifications
local function recent(
	request: { startIndex: number?, maxRows: number? },
	cookie: string
): { NotificationStreamEntriesModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/get-recent?startIndex={request.startIndex or ""}&maxRows={request.maxRows or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers IOS device for pushkit notifications
--- @within notifications
local function registerIOSPushkit(request: RegisterIOSPushKitRequestModel, cookie: string): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-ios-pushkit`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- De-register all devices to disable push notifications
--- @within notifications
local function deregisterAllDevices(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-all-devices`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- De-register current device to disable push notifications
--- @within notifications
local function deregisterDevice(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-current-device`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- Get Chrome Manifest to link GCM project to Chrome Browser
--- @within notifications
local function chromeManifest(request: {}, cookie: string): ChromeManifestModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/chrome-manifest`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- De-register current device to disable pushkit notifications
--- @within notifications
local function deregisterIOSPushkit(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/deregister-current-device-ios-pushkit`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- Get Notification Stream metadata.
--- @within notifications
local function streamMetadata(request: {}, cookie: string): NotificationStreamMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Clears the unread Notification stream count
--- @within notifications
local function clearUnread(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/clear-unread`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- Sends metrics when a Game Update Notification is Read from the Game Update Notifications Section of the Notification Stream
--- @within notifications
local function acknowledgeGameUpdate(request: GameUpdateNotificationReadRequestModel, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/game-update-notification-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- Gets valid destinations associated with the signed user
--- @within notifications
local function destinations(request: {}, cookie: string): GetPushDestinationsResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/get-destinations`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the notificationIds for the specified notification token
--- @within notifications
local function multiple(
	request: { notificationToken: string, limit: number, cursor: number? },
	cookie: string
): NotificationIdsResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/notification-ids?notificationToken={request.notificationToken}&limit={request.limit}&cursor={request.cursor or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers IOS device for push notifications
--- @within notifications
local function registerIOSNative(request: RegisterIOSNativeRequestModel, cookie: string): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-ios-native`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Register Android Native for push notifications
--- @within notifications
local function registerAndroidNative(request: RegisterAndroidRequestModel, cookie: string): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-native`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Register Android Tencent service device for push notifications
--- @within notifications
local function registerAndroidTencentService(
	request: RegisterTencentServiceRequestModel,
	cookie: string
): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-tencent-service`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers Firefox for push notifications
--- @within notifications
local function registerFirefox(request: RegisterFirefoxRequestModel, cookie: string): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-firefox`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Registers Chrome for push notifications
--- @within notifications
local function registerChrome(request: RegisterChromeRequestModel, cookie: string): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-chrome`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the count of unread Notification stream entries
--- @within notifications
local function countUnread(request: {}, cookie: string): UnreadStreamNotificationsModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/unread-count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the corresponding metadata for the specified notification
--- @within notifications
local function metadata(
	request: { notificationToken: string, notificationId: string },
	cookie: string
): GetMetadataResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/metadata?notificationToken={request.notificationToken}&notificationId={request.notificationId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the current device destination
--- @within notifications
local function destination(request: {}, cookie: string): GetCurrentPushDestinationResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/push-notifications/get-current-device-destination`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Marks a Notification Stream Entry as Interacted
--- @within notifications
local function markInteracted(eventId: string, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/stream-notifications/mark-interacted`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { eventId = eventId }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- Marks Interaction status for push notification
--- @within notifications
local function markInteraction(request: MarkInteractionRequestModel, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/mark-interaction`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- Gets the notification settings related to realtime
--- @within notifications
local function realtimeSettings(request: {}, cookie: string): RealTimeNotificationsSettingsResponseModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/notifications/settings/realtime`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Register Amazon Android for push notifications
--- @within notifications
local function registerAmazonAndroid(
	request: RegisterAndroidAmazonRequestModel,
	cookie: string
): RegistrationResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://notifications.roblox.com/v2/push-notifications/register-android-amazon`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- @within notifications
local function latestGameUpdates(
	request: { universeIds: { number }, sinceDateTime: string? },
	cookie: string
): { GameUpdateNotificationModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://notifications.roblox.com/v2/stream-notifications/get-latest-game-updates?universeIds={table.concat(
			request.universeIds,
			"&universeIds="
		)}&sinceDateTime={request.sinceDateTime or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
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
