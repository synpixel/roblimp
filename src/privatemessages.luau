local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- A message details response.
export type AnnouncementsDetailsResponse = {
	created: string,
	sender: VerifiedSkinnyUserResponse,
	subject: string,
	id: number,
	updated: string,
	body: string,
}

--- <no description>
export type UnreadMessagesCountResponse = { count: number }

--- <no description>
export type SendMessageResponse = { message: string, success: boolean, shortMessage: string }

--- <no description>
export type BatchMessagesRequest = { messageIds: { number } }

--- <no description>
export type FailedMessageResponse = { messageId: number, errorMessage: string }

--- A response model representing user basic information and the user's verified badge status.
export type VerifiedSkinnyUserResponse = { id: number, name: string, hasVerifiedBadge: boolean, displayName: string }

--- A message details response.
export type MessageDetailsResponse = {
	recipient: VerifiedSkinnyUserResponse,
	sender: VerifiedSkinnyUserResponse,
	id: number,
	body: string,
	updated: string,
	subject: string,
	isSystemMessage: boolean,
	isReportAbuseDisplayed: boolean,
	isRead: boolean,
	created: string,
}

--- <no description>
export type GetMessagesResponse = {
	collection: { MessageDetailsResponse },
	pageNumber: number,
	totalPages: number,
	totalCollectionSize: number,
}

--- A message details response.
export type AnnouncementsMetadataResponse = { numOfAnnouncements: number }

--- <no description>
export type SendMessageRequest = {
	replyMessageId: number,
	subject: string,
	includePreviousMessage: boolean,
	recipientId: number,
	userId: number,
	body: string,
}

--- <no description>
export type CanMessageResponse = { canMessage: boolean }

--- <no description>
export type BatchMessagesResponse = { failedMessages: { FailedMessageResponse } }

--- <no description>
export type GetAnnouncementsResponse = { collection: { AnnouncementsDetailsResponse }, totalCollectionSize: number }

--- Marks a batch of messages as read.
local function markAsRead(with: BatchMessagesRequest & { cookie: string }): BatchMessagesResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/mark-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets unread messages for the authenticated user.
local function getTotalUnread(with: { cookie: string }): UnreadMessagesCountResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/unread/count`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- <no description>
local function getAnnouncementMetadata(with: { cookie: string }): AnnouncementsMetadataResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/announcements/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets whether the sender can send a message to the specified user.
local function canMessage(with: { userId: number, cookie: string }): CanMessageResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/{with.userId}/can-message`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a user's messages.
local function getMessages(
	with: {
		pageNumber: number?,
		pageSize: number?,
		messageTab: "Inbox" | "Sent" | "Archive"?,
		cookie: string,
	}
): GetMessagesResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages?pageNumber={with.pageNumber or ""}&pageSize={with.pageSize or ""}&messageTab={with.messageTab or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Migrate from RobloxWebsite project, return news notification for Private Message page
local function getAnnouncements(with: { cookie: string }): GetAnnouncementsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/announcements`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Marks a batch of messages as unread.
local function markAsUnread(with: BatchMessagesRequest & { cookie: string }): BatchMessagesResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/mark-unread`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Unarchives a batch of messages.
local function unarchive(with: BatchMessagesRequest & { cookie: string }): BatchMessagesResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/unarchive`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Sends a message to a specified user.
local function sendMessage(with: SendMessageRequest & { cookie: string }): SendMessageResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/send`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a message's details.
local function getMessage(with: { messageId: number, cookie: string }): MessageDetailsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/{with.messageId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Archives a batch of messages.
local function archive(with: BatchMessagesRequest & { cookie: string }): BatchMessagesResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/archive`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	markAsRead = markAsRead,
	getTotalUnread = getTotalUnread,
	getAnnouncementMetadata = getAnnouncementMetadata,
	canMessage = canMessage,
	getMessages = getMessages,
	getAnnouncements = getAnnouncements,
	markAsUnread = markAsUnread,
	unarchive = unarchive,
	sendMessage = sendMessage,
	getMessage = getMessage,
	archive = archive,
}
