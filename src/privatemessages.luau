local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [privatemessages.roblox.com](https://privatemessages.roblox.com)
--- @class privatemessages

--- A message details response.
--- @interface AnnouncementsDetailsResponse
--- .created string
--- .sender VerifiedSkinnyUserResponse
--- .subject string
--- .id number
--- .updated string
--- .body string
--- @within privatemessages
export type AnnouncementsDetailsResponse = {
	created: string,
	sender: VerifiedSkinnyUserResponse,
	subject: string,
	id: number,
	updated: string,
	body: string,
}

--- @interface UnreadMessagesCountResponse
--- .count number
--- @within privatemessages
export type UnreadMessagesCountResponse = { count: number }

--- @interface SendMessageResponse
--- .message string
--- .success boolean
--- .shortMessage string
--- @within privatemessages
export type SendMessageResponse = { message: string, success: boolean, shortMessage: string }

--- @interface BatchMessagesRequest
--- .messageIds { number }
--- @within privatemessages
export type BatchMessagesRequest = { messageIds: { number } }

--- @interface FailedMessageResponse
--- .messageId number
--- .errorMessage string
--- @within privatemessages
export type FailedMessageResponse = { messageId: number, errorMessage: string }

--- A response model representing user basic information and the user's verified badge status.
--- @interface VerifiedSkinnyUserResponse
--- .id number
--- .name string
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within privatemessages
export type VerifiedSkinnyUserResponse = { id: number, name: string, hasVerifiedBadge: boolean, displayName: string }

--- A message details response.
--- @interface MessageDetailsResponse
--- .recipient VerifiedSkinnyUserResponse
--- .sender VerifiedSkinnyUserResponse
--- .id number
--- .body string
--- .updated string
--- .subject string
--- .isSystemMessage boolean
--- .isReportAbuseDisplayed boolean
--- .isRead boolean
--- .created string
--- @within privatemessages
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

--- @interface GetMessagesResponse
--- .collection { MessageDetailsResponse }
--- .pageNumber number
--- .totalPages number
--- .totalCollectionSize number
--- @within privatemessages
export type GetMessagesResponse = {
	collection: { MessageDetailsResponse },
	pageNumber: number,
	totalPages: number,
	totalCollectionSize: number,
}

--- A message details response.
--- @interface AnnouncementsMetadataResponse
--- .numOfAnnouncements number
--- @within privatemessages
export type AnnouncementsMetadataResponse = { numOfAnnouncements: number }

--- @interface SendMessageRequest
--- .replyMessageId number
--- .subject string
--- .includePreviousMessage boolean
--- .recipientId number
--- .userId number
--- .body string
--- @within privatemessages
export type SendMessageRequest = {
	replyMessageId: number,
	subject: string,
	includePreviousMessage: boolean,
	recipientId: number,
	userId: number,
	body: string,
}

--- @interface CanMessageResponse
--- .canMessage boolean
--- @within privatemessages
export type CanMessageResponse = { canMessage: boolean }

--- @interface BatchMessagesResponse
--- .failedMessages { FailedMessageResponse }
--- @within privatemessages
export type BatchMessagesResponse = { failedMessages: { FailedMessageResponse } }

--- @interface GetAnnouncementsResponse
--- .collection { AnnouncementsDetailsResponse }
--- .totalCollectionSize number
--- @within privatemessages
export type GetAnnouncementsResponse = { collection: { AnnouncementsDetailsResponse }, totalCollectionSize: number }

--- Marks a batch of messages as read.
--- @within privatemessages
local function markAsRead(messageIds: { number }, cookie: string): { FailedMessageResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/mark-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).failedMessages
end

--- Gets unread messages for the authenticated user.
--- @within privatemessages
local function countUnread(request: {}, cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/unread/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).count
end

--- @within privatemessages
local function announcementMetadata(request: {}, cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/announcements/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).numOfAnnouncements
end

--- Gets whether the sender can send a message to the specified user.
--- @within privatemessages
local function canMessage(userId: number, cookie: string): boolean
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/{userId}/can-message`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).canMessage
end

--- Gets a user's messages.
--- @within privatemessages
local function all(
	request: { pageNumber: number?, pageSize: number?, messageTab: "Inbox" | "Sent" | "Archive"? },
	cookie: string
): GetMessagesResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages?pageNumber={request.pageNumber or ""}&pageSize={request.pageSize or ""}&messageTab={request.messageTab or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Migrate from RobloxWebsite project, return news notification for Private Message page
--- @within privatemessages
local function announcements(request: {}, cookie: string): GetAnnouncementsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/announcements`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Marks a batch of messages as unread.
--- @within privatemessages
local function markAsUnread(messageIds: { number }, cookie: string): { FailedMessageResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/mark-unread`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).failedMessages
end

--- Unarchives a batch of messages.
--- @within privatemessages
local function unarchive(messageIds: { number }, cookie: string): { FailedMessageResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/unarchive`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).failedMessages
end

--- Sends a message to a specified user.
--- @within privatemessages
local function send(request: SendMessageRequest, cookie: string): SendMessageResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/send`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a message's details.
--- @within privatemessages
local function get(messageId: number, cookie: string): MessageDetailsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/{messageId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Archives a batch of messages.
--- @within privatemessages
local function archive(messageIds: { number }, cookie: string): { FailedMessageResponse }
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/archive`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).failedMessages
end

return {
	markAsRead = markAsRead,
	countUnread = countUnread,
	announcementMetadata = announcementMetadata,
	canMessage = canMessage,
	all = all,
	announcements = announcements,
	markAsUnread = markAsUnread,
	unarchive = unarchive,
	send = send,
	get = get,
	archive = archive,
}
