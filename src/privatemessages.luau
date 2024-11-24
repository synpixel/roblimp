local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

--- A message details response.
export type AnnouncementsDetailsResponse = {
	created: string,
	sender: VerifiedSkinnyUserResponse,
	subject: string,
	id: number,
	updated: string,
	body: string,
}

export type UnreadMessagesCountResponse = { count: number }

export type SendMessageResponse = { message: string, success: boolean, shortMessage: string }

export type BatchMessagesRequest = { messageIds: { number } }

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

export type GetMessagesResponse = {
	collection: { MessageDetailsResponse },
	pageNumber: number,
	totalPages: number,
	totalCollectionSize: number,
}

--- A message details response.
export type AnnouncementsMetadataResponse = { numOfAnnouncements: number }

export type SendMessageRequest = {
	replyMessageId: number,
	subject: string,
	includePreviousMessage: boolean,
	recipientId: number,
	userId: number,
	body: string,
}

export type CanMessageResponse = { canMessage: boolean }

export type BatchMessagesResponse = { failedMessages: { FailedMessageResponse } }

export type GetAnnouncementsResponse = { collection: { AnnouncementsDetailsResponse }, totalCollectionSize: number }

--- Marks a batch of messages as read.
local function markAsRead(messageIds: { number }, cookie: string): Response<{ FailedMessageResponse }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/mark-read`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	}):map(function(response)
		return serde.decode("json", response.body).failedMessages
	end)
end

--- Gets unread messages for the authenticated user.
local function countUnread(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/unread/count`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).count
	end)
end

local function announcementMetadata(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/announcements/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).numOfAnnouncements
	end)
end

--- Gets whether the sender can send a message to the specified user.
local function canMessage(userId: number, cookie: string): Response<boolean>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/{userId}/can-message`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).canMessage
	end)
end

--- Gets a user's messages.
local function all(
	request: { pageNumber: number?, pageSize: number?, messageTab: "Inbox" | "Sent" | "Archive"? },
	cookie: string
): Response<GetMessagesResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages?pageNumber={request.pageNumber or ""}&pageSize={request.pageSize or ""}&messageTab={request.messageTab or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Migrate from RobloxWebsite project, return news notification for Private Message page
local function announcements(cookie: string): Response<GetAnnouncementsResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/announcements`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Marks a batch of messages as unread.
local function markAsUnread(messageIds: { number }, cookie: string): Response<{ FailedMessageResponse }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/mark-unread`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	}):map(function(response)
		return serde.decode("json", response.body).failedMessages
	end)
end

--- Unarchives a batch of messages.
local function unarchive(messageIds: { number }, cookie: string): Response<{ FailedMessageResponse }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/unarchive`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	}):map(function(response)
		return serde.decode("json", response.body).failedMessages
	end)
end

--- Sends a message to a specified user.
local function send(request: SendMessageRequest, cookie: string): Response<SendMessageResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/send`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets a message's details.
local function get(messageId: number, cookie: string): Response<MessageDetailsResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://privatemessages.roblox.com/v1/messages/{messageId}`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Archives a batch of messages.
local function archive(messageIds: { number }, cookie: string): Response<{ FailedMessageResponse }>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://privatemessages.roblox.com/v1/messages/archive`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { messageIds = messageIds }),
	}):map(function(response)
		return serde.decode("json", response.body).failedMessages
	end)
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
