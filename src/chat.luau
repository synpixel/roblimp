local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

export type ChatParticipant = {
	type: "User" | "System",
	targetId: number,
	name: string,
	hasVerifiedBadge: boolean,
	displayName: string,
}

export type UpdateUserTypingStatusRequest = { isTyping: boolean, conversationId: number }

export type SetConversationUniverseEventBased = { actorUserId: number, universeId: number }

export type SendLinkChatResponse = {
	messageId: string,
	chatMessageLinkType: "Game",
	statusMessage: string,
	sent: string,
	resultType: "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection",
	messageType: "PlainText" | "Link" | "EventBased",
}

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

export type MarkAsReadRequest = { endMessageId: string, conversationId: number }

export type RemoveUserFromConversationResponse = { statusMessage: string, resultType: "Success", conversationId: number }

export type MultigetConversationMessagesResponse = { chatMessages: { ChatMessage }, conversationId: number }

export type Link = { game: GameLink, type: "Game" }

export type MarkAsReadResponse = { resultType: "Success" }

export type CreateOneToOneConversationRequest = { participantUserId: number }

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

export type AddUserToConversationResponse = {
	statusMessage: string,
	rejectedParticipants: { RejectedChatParticipant },
	resultType: "Success",
	conversationId: number,
}

export type CreateCloudEditConversationRequest = { placeId: number }

export type UserVisibleStatusResponse = { statusMessage: string }

export type RejectedChatParticipant = {
	type: "User" | "System",
	rejectedReason: string,
	name: string,
	targetId: number,
	hasVerifiedBadge: boolean,
	displayName: string,
}

export type ConversationTitle = { isDefaultTitle: boolean, titleForViewer: string }

export type StartNewConversationResponse = {
	conversation: Conversation,
	rejectedParticipants: { RejectedChatParticipant },
	resultType: "Success",
	statusMessage: string,
}

export type SendPlainTextChatMessageResponse = {
	messageId: string,
	filteredForReceivers: boolean,
	statusMessage: string,
	resultType: "Success" | "Moderated" | "TextTooLong" | "NoRealtimeConnection",
	sent: string,
	content: string,
	messageType: "PlainText" | "Link" | "EventBased",
}

export type SendPlainTextChatMessageRequest = {
	message: string,
	decorators: { string },
	conversationId: number,
	userId: number,
	isExperienceInvite: boolean,
}

export type SendGameLinkChatMessageRequest = {
	universeId: number,
	conversationId: number,
	decorators: { string },
	placeId: number,
	userId: number,
	isExperienceInvite: boolean,
}

export type MarkAsSeenResponse = { resultType: "Success" }

export type RolloutSettingsResponse = { rolloutFeatures: { RolloutSettingModel } }

export type GameLink = { universeId: number }

export type RemoveUserFromConversationRequest = { conversationId: number, participantUserId: number }

export type CreateGroupConversationRequest = { participantUserIds: { number }, title: string }

export type UnreadConversationCountResponse = { count: number }

export type RolloutSettingModel = {
	isRolloutEnabled: boolean,
	featureName: "LuaChat" | "ConversationUniverse" | "PlayTogether" | "Party" | "GameLink" | "OldPlayTogether",
}

export type RenameConversationResponse = {
	statusMessage: string,
	title: ConversationTitle,
	conversationTitle: string,
	resultType: "Success" | "Moderated" | "TextTooLong",
}

export type MarkAsSeenRequest = { conversationsToMarkSeen: { number } }

export type EventBased = { setConversationUniverse: SetConversationUniverseEventBased, type: "SetConversationUniverse" }

export type AddUsersToConversationRequest = { participantUserIds: { number }, conversationId: number }

export type RenameGroupConversationRequest = { newTitle: string, conversationId: number }

export type ConversationUniverse = { rootPlaceId: number, universeId: number }

--- Gets the rollout settings for requested feature
local function rolloutSettings(featureNames: { string }, cookie: string): Response<{ RolloutSettingModel }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-rollout-settings?featureNames={table.concat(
			featureNames,
			"&featureNames="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).rolloutFeatures
	end)
end

--- Creates a new one-on-one conversation
local function createConversation(participantUserId: number, cookie: string): Response<StartNewConversationResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/start-one-to-one-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { participantUserId = participantUserId }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Mark the specified conversation messages as seen
local function markAsSeen(conversationsToMarkSeen: { number }, cookie: string): Response<"Success">
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/mark-as-seen`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { conversationsToMarkSeen = conversationsToMarkSeen }),
	}):map(function(response)
		return serde.decode("json", response.body).resultType
	end)
end

local function sendGameLink(request: SendGameLinkChatMessageRequest, cookie: string): Response<SendLinkChatResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/send-game-link-message`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the unread messages for the conversationIds specified in the parameters
local function unreadMessages(
	request: { conversationIds: { number }, pageSize: number },
	cookie: string
): Response<{ MultigetConversationMessagesResponse }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-unread-messages?conversationIds={table.concat(
			request.conversationIds,
			"&conversationIds="
		)}&pageSize={request.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get Chat metadata.
local function metadata(cookie: string): Response<ChatMetadataResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets latest messages corresponding to the given list of conversation Ids
local function latestMessages(
	request: { conversationIds: { number }, pageSize: number },
	cookie: string
): Response<{ MultigetConversationMessagesResponse }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/multi-get-latest-messages?conversationIds={table.concat(
			request.conversationIds,
			"&conversationIds="
		)}&pageSize={request.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Updates the status for whether a user is typing currently
local function setTypingStatus(request: UpdateUserTypingStatusRequest, cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/update-user-typing-status`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).statusMessage
	end)
end

--- Gets conversations for the conversationIds specified in the parameters
local function conversations(conversationIds: { number }, cookie: string): Response<{ Conversation }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-conversations?conversationIds={table.concat(
			conversationIds,
			"&conversationIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets messages corresponding to the given conversationId
local function messages(
	request: { conversationId: number, pageSize: number, exclusiveStartMessageId: string? },
	cookie: string
): Response<{ ChatMessage }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-messages?conversationId={request.conversationId}&pageSize={request.pageSize}&exclusiveStartMessageId={request.exclusiveStartMessageId or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Sends a chat message
local function sendMessage(
	request: SendPlainTextChatMessageRequest,
	cookie: string
): Response<SendPlainTextChatMessageResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/send-message`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Creates a new group conversation
local function createGroupConversation(
	request: CreateGroupConversationRequest,
	cookie: string
): Response<StartNewConversationResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/start-group-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets all conversations associated with the logged-in User
local function allConversations(
	request: { pageNumber: number, pageSize: number },
	cookie: string
): Response<{ Conversation }>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-user-conversations?pageNumber={request.pageNumber}&pageSize={request.pageSize}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Mark the specified conversation messages as read
local function markAsRead(request: MarkAsReadRequest, cookie: string): Response<"Success">
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/mark-as-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body).resultType
	end)
end

--- Removes a user from an existing conversation
local function removeFromConversation(
	request: RemoveUserFromConversationRequest,
	cookie: string
): Response<RemoveUserFromConversationResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/remove-from-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Renames the title of an existing conversation
local function renameConversation(
	request: RenameGroupConversationRequest,
	cookie: string
): Response<RenameConversationResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/rename-group-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Adds users to an existing conversation
local function addToConversation(
	request: AddUsersToConversationRequest,
	cookie: string
): Response<AddUserToConversationResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://chat.roblox.com/v2/add-to-conversation`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- For every authenticated user, the clients hit this endpoint to get the chat related settings. Example : Chat is enabled or not
local function settings(cookie: string): Response<ChatSettingsResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/chat-settings`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the count of unread conversations
local function countUnreadConversations(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://chat.roblox.com/v2/get-unread-conversation-count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
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
