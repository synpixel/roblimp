local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- <no description>
export type ChatParticipant = {
	type: "User" | "System",
	targetId: number,
	name: string,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- <no description>
export type UpdateUserTypingStatusRequest = { isTyping: boolean, conversationId: number }

--- <no description>
export type SetConversationUniverseEventBased = { actorUserId: number, universeId: number }

--- <no description>
export type SendLinkChatResponse = {
	messageId: string,
	chatMessageLinkType: "Game",
	statusMessage: string,
	sent: string,
	resultType: "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection",
	messageType: "PlainText" | "Link" | "EventBased",
}

--- <no description>
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

--- <no description>
export type MarkAsReadRequest = { endMessageId: string, conversationId: number }

--- <no description>
export type RemoveUserFromConversationResponse = { statusMessage: string, resultType: "Success", conversationId: number }

--- <no description>
export type MultigetConversationMessagesResponse = { chatMessages: { ChatMessage }, conversationId: number }

--- <no description>
export type Link = { game: GameLink, type: "Game" }

--- <no description>
export type MarkAsReadResponse = { resultType: "Success" }

--- <no description>
export type CreateOneToOneConversationRequest = { participantUserId: number }

--- <no description>
export type ChatSettingsResponse = { chatEnabled: boolean, isActiveChatUser: boolean, isConnectTabEnabled: boolean }

--- Chat Metadata Response Model
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

--- <no description>
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

--- <no description>
export type AddUserToConversationResponse = {
	statusMessage: string,
	rejectedParticipants: { RejectedChatParticipant },
	resultType: "Success",
	conversationId: number,
}

--- <no description>
export type CreateCloudEditConversationRequest = { placeId: number }

--- <no description>
export type UserVisibleStatusResponse = { statusMessage: string }

--- <no description>
export type RejectedChatParticipant = {
	type: "User" | "System",
	rejectedReason: string,
	name: string,
	targetId: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

--- <no description>
export type ConversationTitle = { isDefaultTitle: boolean, titleForViewer: string }

--- <no description>
export type StartNewConversationResponse = {
	conversation: Conversation,
	rejectedParticipants: { RejectedChatParticipant },
	resultType: "Success",
	statusMessage: string,
}

--- <no description>
export type SendPlainTextChatMessageResponse = {
	messageId: string,
	filteredForReceivers: boolean,
	statusMessage: string,
	resultType: "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection",
	sent: string,
	content: string,
	messageType: "PlainText" | "Link" | "EventBased",
}

--- <no description>
export type SendPlainTextChatMessageRequest = {
	message: string,
	decorators: { string },
	conversationId: number,
	userId: number,
	isExperienceInvite: boolean,
}

--- <no description>
export type SendGameLinkChatMessageRequest = {
	universeId: number,
	conversationId: number,
	decorators: { string },
	placeId: number,
	userId: number,
	isExperienceInvite: boolean,
}

--- <no description>
export type MarkAsSeenResponse = { resultType: "Success" }

--- <no description>
export type RolloutSettingsResponse = { rolloutFeatures: { RolloutSettingModel } }

--- <no description>
export type GameLink = { universeId: number }

--- <no description>
export type RemoveUserFromConversationRequest = { conversationId: number, participantUserId: number }

--- <no description>
export type CreateGroupConversationRequest = { participantUserIds: { number }, title: string }

--- <no description>
export type UnreadConversationCountResponse = { count: number }

--- <no description>
export type RolloutSettingModel = {
	isRolloutEnabled: boolean,
	featureName: "LuaChat" | "ConversationUniverse" | "PlayTogether" | "Party" | "GameLink" | "OldPlayTogether",
}

--- <no description>
export type RenameConversationResponse = {
	statusMessage: string,
	title: ConversationTitle,
	conversationTitle: string,
	resultType: "Success" | "Moderated" | "TextTooLong",
}

--- <no description>
export type MarkAsSeenRequest = { conversationsToMarkSeen: { number } }

--- <no description>
export type EventBased = { setConversationUniverse: SetConversationUniverseEventBased, type: "SetConversationUniverse" }

--- <no description>
export type AddUsersToConversationRequest = { participantUserIds: { number }, conversationId: number }

--- <no description>
export type RenameGroupConversationRequest = { newTitle: string, conversationId: number }

--- <no description>
export type ConversationUniverse = { rootPlaceId: number, universeId: number }

--- Gets the rollout settings for requested feature
local function getRolloutSettings(with: { featureNames: { string }, cookie: string }): RolloutSettingsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-rollout-settings?featureNames={table.concat(
			with.featureNames,
			"&featureNames="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates a new one-on-one conversation
local function createConversation(
	with: CreateOneToOneConversationRequest & { cookie: string }
): StartNewConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/start-one-to-one-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Mark the specified conversation messages as seen
local function markAsSeen(with: MarkAsSeenRequest & { cookie: string }): MarkAsSeenResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/mark-as-seen`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- <no description>
local function sendGameLink(with: SendGameLinkChatMessageRequest & { cookie: string }): SendLinkChatResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/send-game-link-message`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the unread messages for the conversationIds specified in the parameters
local function getUnreadMessages(
	with: { conversationIds: { number }, pageSize: number, cookie: string }
): { MultigetConversationMessagesResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-unread-messages?conversationIds={table.concat(
			with.conversationIds,
			"&conversationIds="
		)}&pageSize={with.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get Chat metadata.
local function getMetadata(with: { cookie: string }): ChatMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets latest messages corresponding to the given list of conversation Ids
local function getLatestMessages(
	with: { conversationIds: { number }, pageSize: number, cookie: string }
): { MultigetConversationMessagesResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/multi-get-latest-messages?conversationIds={table.concat(
			with.conversationIds,
			"&conversationIds="
		)}&pageSize={with.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the status for whether a user is typing currently
local function setTypingStatus(with: UpdateUserTypingStatusRequest & { cookie: string }): UserVisibleStatusResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/update-user-typing-status`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets conversations for the conversationIds specified in the parameters
local function getConversations(with: { conversationIds: { number }, cookie: string }): { Conversation }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-conversations?conversationIds={table.concat(
			with.conversationIds,
			"&conversationIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets messages corresponding to the given conversationId
local function getMessages(
	with: { conversationId: number, pageSize: number, exclusiveStartMessageId: string?, cookie: string }
): { ChatMessage }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-messages?conversationId={with.conversationId}&pageSize={with.pageSize}&exclusiveStartMessageId={with.exclusiveStartMessageId or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sends a chat message
local function sendMessage(with: SendPlainTextChatMessageRequest & { cookie: string }): SendPlainTextChatMessageResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/send-message`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Creates a new group conversation
local function createGroupConversation(
	with: CreateGroupConversationRequest & { cookie: string }
): StartNewConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/start-group-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all conversations associated with the logged-in User
local function getActiveConversations(with: { pageNumber: number, pageSize: number, cookie: string }): { Conversation }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-user-conversations?pageNumber={with.pageNumber}&pageSize={with.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Mark the specified conversation messages as read
local function markAsRead(with: MarkAsReadRequest & { cookie: string }): MarkAsReadResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/mark-as-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Removes a user from an existing conversation
local function removeFromConversation(
	with: RemoveUserFromConversationRequest & { cookie: string }
): RemoveUserFromConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/remove-from-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Renames the title of an existing conversation
local function renameConversation(with: RenameGroupConversationRequest & { cookie: string }): RenameConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/rename-group-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Adds users to an existing conversation
local function addToConversation(
	with: AddUsersToConversationRequest & { cookie: string }
): AddUserToConversationResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/add-to-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- For every authenticated user, the clients hit this endpoint to get the chat related settings. Example : Chat is enabled or not
local function getSettings(with: { cookie: string }): ChatSettingsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/chat-settings`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the count of unread conversations
local function getTotalUnreadConversations(with: { cookie: string }): UnreadConversationCountResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-unread-conversation-count`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	getRolloutSettings = getRolloutSettings,
	createConversation = createConversation,
	markAsSeen = markAsSeen,
	sendGameLink = sendGameLink,
	getUnreadMessages = getUnreadMessages,
	getMetadata = getMetadata,
	getLatestMessages = getLatestMessages,
	setTypingStatus = setTypingStatus,
	getConversations = getConversations,
	getMessages = getMessages,
	sendMessage = sendMessage,
	createGroupConversation = createGroupConversation,
	getActiveConversations = getActiveConversations,
	markAsRead = markAsRead,
	removeFromConversation = removeFromConversation,
	renameConversation = renameConversation,
	addToConversation = addToConversation,
	getSettings = getSettings,
	getTotalUnreadConversations = getTotalUnreadConversations,
}
