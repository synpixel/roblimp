local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [chat.roblox.com](https://chat.roblox.com)
--- @class chat

--- @interface ChatParticipant
--- .type "User" | "System"
--- .targetId number
--- .name string
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within chat
export type ChatParticipant = {
	type: "User" | "System",
	targetId: number,
	name: string,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- @interface UpdateUserTypingStatusRequest
--- .isTyping boolean
--- .conversationId number
--- @within chat
export type UpdateUserTypingStatusRequest = { isTyping: boolean, conversationId: number }

--- @interface SetConversationUniverseEventBased
--- .actorUserId number
--- .universeId number
--- @within chat
export type SetConversationUniverseEventBased = { actorUserId: number, universeId: number }

--- @interface SendLinkChatResponse
--- .messageId string
--- .chatMessageLinkType "Game"
--- .statusMessage string
--- .sent string
--- .resultType "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection"
--- .messageType "PlainText" | "Link" | "EventBased"
--- @within chat
export type SendLinkChatResponse = {
	messageId: string,
	chatMessageLinkType: "Game",
	statusMessage: string,
	sent: string,
	resultType: "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection",
	messageType: "PlainText" | "Link" | "EventBased",
}

--- @interface Conversation
--- .participants { ChatParticipant }
--- .initiator ChatParticipant
--- .id number
--- .conversationType "OneToOneConversation" | "MultiUserConversation" | "CloudEditConversation"
--- .title string
--- .conversationUniverse ConversationUniverse
--- .lastUpdated string
--- .conversationTitle ConversationTitle
--- .hasUnreadMessages boolean
--- @within chat
export type Conversation = {
	participants: { ChatParticipant },
	initiator: ChatParticipant,
	id: number,
	conversationType: "OneToOneConversation" | "MultiUserConversation" | "CloudEditConversation",
	title: string,
	conversationUniverse: ConversationUniverse,
	lastUpdated: string,
	conversationTitle: ConversationTitle,
	hasUnreadMessages: boolean,
}

--- @interface MarkAsReadRequest
--- .endMessageId string
--- .conversationId number
--- @within chat
export type MarkAsReadRequest = { endMessageId: string, conversationId: number }

--- @interface RemoveUserFromConversationResponse
--- .statusMessage string
--- .resultType "Success"
--- .conversationId number
--- @within chat
export type RemoveUserFromConversationResponse = { statusMessage: string, resultType: "Success", conversationId: number }

--- @interface MultigetConversationMessagesResponse
--- .chatMessages { ChatMessage }
--- .conversationId number
--- @within chat
export type MultigetConversationMessagesResponse = { chatMessages: { ChatMessage }, conversationId: number }

--- @interface Link
--- .game GameLink
--- .type "Game"
--- @within chat
export type Link = { game: GameLink, type: "Game" }

--- @interface MarkAsReadResponse
--- .resultType "Success"
--- @within chat
export type MarkAsReadResponse = { resultType: "Success" }

--- @interface CreateOneToOneConversationRequest
--- .participantUserId number
--- @within chat
export type CreateOneToOneConversationRequest = { participantUserId: number }

--- @interface ChatSettingsResponse
--- .chatEnabled boolean
--- .isActiveChatUser boolean
--- .isConnectTabEnabled boolean
--- @within chat
export type ChatSettingsResponse = { chatEnabled: boolean, isActiveChatUser: boolean, isConnectTabEnabled: boolean }

--- Chat Metadata Response Model
--- @interface ChatMetadataResponse
--- .isUsingCacheToLoadFriendsInfoEnabled boolean
--- .shouldRespectConversationHasUnreadMessageToMarkAsRead boolean
--- .relativeValueToRecordUiPerformance number
--- .isPlayTogetherForGameCardsEnabled boolean
--- .typingInChatForReceiverExpirationMs number
--- .maxConversationTitleLength number
--- .validMessageTypesWhiteList { string }
--- .isRoactChatEnabled boolean
--- .signalRDisconnectionResponseInMilliseconds number
--- .isChatDataFromLocalStorageEnabled boolean
--- .isPlatformChatApiEnabled boolean
--- .partyChromeDisplayTimeStampInterval number
--- .isChatEnabledByPrivacySetting number
--- .senderTypesForUnknownMessageTypeError { string }
--- .isAliasChatForClientSideEnabled boolean
--- .numberOfMembersForPartyChrome number
--- .languageForPrivacySettingUnavailable string
--- .isRespectingMessageTypeEnabled boolean
--- .chatDataFromLocalStorageExpirationSeconds number
--- .isInvalidMessageTypeFallbackEnabled boolean
--- .webChatEventSampleRate number
--- .cachedDataFromLocalStorageExpirationMS number
--- .typingInChatFromSenderThrottleMs number
--- @within chat
export type ChatMetadataResponse = {
	isUsingCacheToLoadFriendsInfoEnabled: boolean,
	shouldRespectConversationHasUnreadMessageToMarkAsRead: boolean,
	relativeValueToRecordUiPerformance: number,
	isPlayTogetherForGameCardsEnabled: boolean,
	typingInChatForReceiverExpirationMs: number,
	maxConversationTitleLength: number,
	validMessageTypesWhiteList: { string },
	isRoactChatEnabled: boolean,
	signalRDisconnectionResponseInMilliseconds: number,
	isChatDataFromLocalStorageEnabled: boolean,
	isPlatformChatApiEnabled: boolean,
	partyChromeDisplayTimeStampInterval: number,
	isChatEnabledByPrivacySetting: number,
	senderTypesForUnknownMessageTypeError: { string },
	isAliasChatForClientSideEnabled: boolean,
	numberOfMembersForPartyChrome: number,
	languageForPrivacySettingUnavailable: string,
	isRespectingMessageTypeEnabled: boolean,
	chatDataFromLocalStorageExpirationSeconds: number,
	isInvalidMessageTypeFallbackEnabled: boolean,
	webChatEventSampleRate: number,
	cachedDataFromLocalStorageExpirationMS: number,
	typingInChatFromSenderThrottleMs: number,
}

--- @interface ChatMessage
--- .senderType "User" | "System"
--- .link Link
--- .id string
--- .sent string
--- .senderTargetId number
--- .read boolean
--- .decorators { string }
--- .eventBased EventBased
--- .content string
--- .messageType "PlainText" | "Link" | "EventBased"
--- @within chat
export type ChatMessage = {
	senderType: "User" | "System",
	link: Link,
	id: string,
	sent: string,
	senderTargetId: number,
	read: boolean,
	decorators: { string },
	eventBased: EventBased,
	content: string,
	messageType: "PlainText" | "Link" | "EventBased",
}

--- @interface AddUserToConversationResponse
--- .statusMessage string
--- .rejectedParticipants { RejectedChatParticipant }
--- .resultType "Success"
--- .conversationId number
--- @within chat
export type AddUserToConversationResponse = {
	statusMessage: string,
	rejectedParticipants: { RejectedChatParticipant },
	resultType: "Success",
	conversationId: number,
}

--- @interface CreateCloudEditConversationRequest
--- .placeId number
--- @within chat
export type CreateCloudEditConversationRequest = { placeId: number }

--- @interface UserVisibleStatusResponse
--- .statusMessage string
--- @within chat
export type UserVisibleStatusResponse = { statusMessage: string }

--- @interface RejectedChatParticipant
--- .type "User" | "System"
--- .rejectedReason string
--- .name string
--- .targetId number
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within chat
export type RejectedChatParticipant = {
	type: "User" | "System",
	rejectedReason: string,
	name: string,
	targetId: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- @interface ConversationTitle
--- .isDefaultTitle boolean
--- .titleForViewer string
--- @within chat
export type ConversationTitle = { isDefaultTitle: boolean, titleForViewer: string }

--- @interface StartNewConversationResponse
--- .conversation Conversation
--- .rejectedParticipants { RejectedChatParticipant }
--- .resultType "Success"
--- .statusMessage string
--- @within chat
export type StartNewConversationResponse = {
	conversation: Conversation,
	rejectedParticipants: { RejectedChatParticipant },
	resultType: "Success",
	statusMessage: string,
}

--- @interface SendPlainTextChatMessageResponse
--- .messageId string
--- .filteredForReceivers boolean
--- .statusMessage string
--- .resultType "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection"
--- .sent string
--- .content string
--- .messageType "PlainText" | "Link" | "EventBased"
--- @within chat
export type SendPlainTextChatMessageResponse = {
	messageId: string,
	filteredForReceivers: boolean,
	statusMessage: string,
	resultType: "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection",
	sent: string,
	content: string,
	messageType: "PlainText" | "Link" | "EventBased",
}

--- @interface SendPlainTextChatMessageRequest
--- .message string
--- .decorators { string }
--- .conversationId number
--- .userId number
--- .isExperienceInvite boolean
--- @within chat
export type SendPlainTextChatMessageRequest = {
	message: string,
	decorators: { string },
	conversationId: number,
	userId: number,
	isExperienceInvite: boolean,
}

--- @interface SendGameLinkChatMessageRequest
--- .universeId number
--- .conversationId number
--- .decorators { string }
--- .placeId number
--- .userId number
--- .isExperienceInvite boolean
--- @within chat
export type SendGameLinkChatMessageRequest = {
	universeId: number,
	conversationId: number,
	decorators: { string },
	placeId: number,
	userId: number,
	isExperienceInvite: boolean,
}

--- @interface MarkAsSeenResponse
--- .resultType "Success"
--- @within chat
export type MarkAsSeenResponse = { resultType: "Success" }

--- @interface RolloutSettingsResponse
--- .rolloutFeatures { RolloutSettingModel }
--- @within chat
export type RolloutSettingsResponse = { rolloutFeatures: { RolloutSettingModel } }

--- @interface GameLink
--- .universeId number
--- @within chat
export type GameLink = { universeId: number }

--- @interface RemoveUserFromConversationRequest
--- .conversationId number
--- .participantUserId number
--- @within chat
export type RemoveUserFromConversationRequest = { conversationId: number, participantUserId: number }

--- @interface CreateGroupConversationRequest
--- .participantUserIds { number }
--- .title string
--- @within chat
export type CreateGroupConversationRequest = { participantUserIds: { number }, title: string }

--- @interface UnreadConversationCountResponse
--- .count number
--- @within chat
export type UnreadConversationCountResponse = { count: number }

--- @interface RolloutSettingModel
--- .isRolloutEnabled boolean
--- .featureName "LuaChat" | "ConversationUniverse" | "PlayTogether" | "Party" | "GameLink" | "OldPlayTogether"
--- @within chat
export type RolloutSettingModel = {
	isRolloutEnabled: boolean,
	featureName: "LuaChat" | "ConversationUniverse" | "PlayTogether" | "Party" | "GameLink" | "OldPlayTogether",
}

--- @interface RenameConversationResponse
--- .statusMessage string
--- .title ConversationTitle
--- .conversationTitle string
--- .resultType "Success" | "Moderated" | "TextTooLong"
--- @within chat
export type RenameConversationResponse = {
	statusMessage: string,
	title: ConversationTitle,
	conversationTitle: string,
	resultType: "Success" | "Moderated" | "TextTooLong",
}

--- @interface MarkAsSeenRequest
--- .conversationsToMarkSeen { number }
--- @within chat
export type MarkAsSeenRequest = { conversationsToMarkSeen: { number } }

--- @interface EventBased
--- .setConversationUniverse SetConversationUniverseEventBased
--- .type "SetConversationUniverse"
--- @within chat
export type EventBased = { setConversationUniverse: SetConversationUniverseEventBased, type: "SetConversationUniverse" }

--- @interface AddUsersToConversationRequest
--- .participantUserIds { number }
--- .conversationId number
--- @within chat
export type AddUsersToConversationRequest = { participantUserIds: { number }, conversationId: number }

--- @interface RenameGroupConversationRequest
--- .newTitle string
--- .conversationId number
--- @within chat
export type RenameGroupConversationRequest = { newTitle: string, conversationId: number }

--- @interface ConversationUniverse
--- .rootPlaceId number
--- .universeId number
--- @within chat
export type ConversationUniverse = { rootPlaceId: number, universeId: number }

--- Gets the rollout settings for requested feature
--- @within chat
local function rolloutSettings(featureNames: { string }, cookie: string): { RolloutSettingModel }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-rollout-settings?featureNames={table.concat(
			featureNames,
			"&featureNames="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).rolloutFeatures
end

--- Creates a new one-on-one conversation
--- @within chat
local function createConversation(participantUserId: number, cookie: string): StartNewConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/start-one-to-one-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { participantUserId = participantUserId }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Mark the specified conversation messages as seen
--- @within chat
local function markAsSeen(conversationsToMarkSeen: { number }, cookie: string): "Success"
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/mark-as-seen`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { conversationsToMarkSeen = conversationsToMarkSeen }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).resultType
end

--- @within chat
local function sendGameLink(request: SendGameLinkChatMessageRequest, cookie: string): SendLinkChatResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/send-game-link-message`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the unread messages for the conversationIds specified in the parameters
--- @within chat
local function unreadMessages(
	request: { conversationIds: { number }, pageSize: number },
	cookie: string
): { MultigetConversationMessagesResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-unread-messages?conversationIds={table.concat(
			request.conversationIds,
			"&conversationIds="
		)}&pageSize={request.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get Chat metadata.
--- @within chat
local function metadata(request: {}, cookie: string): ChatMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets latest messages corresponding to the given list of conversation Ids
--- @within chat
local function latestMessages(
	request: { conversationIds: { number }, pageSize: number },
	cookie: string
): { MultigetConversationMessagesResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/multi-get-latest-messages?conversationIds={table.concat(
			request.conversationIds,
			"&conversationIds="
		)}&pageSize={request.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the status for whether a user is typing currently
--- @within chat
local function setTypingStatus(request: UpdateUserTypingStatusRequest, cookie: string): string
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/update-user-typing-status`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).statusMessage
end

--- Gets conversations for the conversationIds specified in the parameters
--- @within chat
local function conversations(conversationIds: { number }, cookie: string): { Conversation }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-conversations?conversationIds={table.concat(
			conversationIds,
			"&conversationIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets messages corresponding to the given conversationId
--- @within chat
local function messages(
	request: { conversationId: number, pageSize: number, exclusiveStartMessageId: string? },
	cookie: string
): { ChatMessage }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-messages?conversationId={request.conversationId}&pageSize={request.pageSize}&exclusiveStartMessageId={request.exclusiveStartMessageId or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sends a chat message
--- @within chat
local function sendMessage(request: SendPlainTextChatMessageRequest, cookie: string): SendPlainTextChatMessageResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/send-message`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates a new group conversation
--- @within chat
local function createGroupConversation(
	request: CreateGroupConversationRequest,
	cookie: string
): StartNewConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/start-group-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all conversations associated with the logged-in User
--- @within chat
local function allConversations(request: { pageNumber: number, pageSize: number }, cookie: string): { Conversation }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-user-conversations?pageNumber={request.pageNumber}&pageSize={request.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Mark the specified conversation messages as read
--- @within chat
local function markAsRead(request: MarkAsReadRequest, cookie: string): "Success"
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/mark-as-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).resultType
end

--- Removes a user from an existing conversation
--- @within chat
local function removeFromConversation(
	request: RemoveUserFromConversationRequest,
	cookie: string
): RemoveUserFromConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/remove-from-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Renames the title of an existing conversation
--- @within chat
local function renameConversation(request: RenameGroupConversationRequest, cookie: string): RenameConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/rename-group-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Adds users to an existing conversation
--- @within chat
local function addToConversation(request: AddUsersToConversationRequest, cookie: string): AddUserToConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/add-to-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- For every authenticated user, the clients hit this endpoint to get the chat related settings. Example : Chat is enabled or not
--- @within chat
local function settings(request: {}, cookie: string): ChatSettingsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/chat-settings`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the count of unread conversations
--- @within chat
local function countUnreadConversations(request: {}, cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-unread-conversation-count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

return {
	rolloutSettings = rolloutSettings,
	createConversation = createConversation,
	markAsSeen = markAsSeen,
	sendGameLink = sendGameLink,
	unreadMessages = unreadMessages,
	metadata = metadata,
	latestMessages = latestMessages,
	setTypingStatus = setTypingStatus,
	conversations = conversations,
	messages = messages,
	sendMessage = sendMessage,
	createGroupConversation = createGroupConversation,
	allConversations = allConversations,
	markAsRead = markAsRead,
	removeFromConversation = removeFromConversation,
	renameConversation = renameConversation,
	addToConversation = addToConversation,
	settings = settings,
	countUnreadConversations = countUnreadConversations,
}
