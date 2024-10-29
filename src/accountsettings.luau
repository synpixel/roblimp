local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- Request model for updating an email
export type UpdateEmailRequest = {
	password: string,
	skipVerificationEmail: boolean,
	emailAddress: string,
	isAdsAccount: boolean,
}

--- <no description>
export type UpdateAccountCountryResponse = {}

--- Response model for getting the user's inventory privacy settings
export type InventoryPrivacyResponse = { inventoryPrivacy: number }

--- <no description>
export type StringPages = { data: { string } }

--- Response model for getting the user's email address and verified status
export type EmailResponse = { verified: boolean, emailAddress: string, canBypassPasswordForEmailUpdate: boolean }

--- Response model for getting the user's game chat privacy settings
export type GameChatPrivacyResponse = { gameChatPrivacy: string }

--- A model containing website metadata for avatars
export type AccountsSettingsMetadataModel = {
	IsAccountsRestrictionsSpamBugFixEnabled: boolean,
	IsContentControlsEnabled: boolean,
	IsParentalNotificationSettingsInUIEnabled: boolean,
	IsParentalMonthlyLimitInUIEnabled: boolean,
	MaximumParentalControlsMonthlySpendLimitInUSD: number,
}

--- <no description>
export type ApiEmptyResponseModel = {}

--- Request model for trade privacy setting update
export type UpdateTradePrivacyRequest = { tradePrivacy: number }

--- Request Model for updating a user's account country
export type UpdateAccountCountryRequest = { targetCountryId: number }

--- Response model for getting the user's trade value settings
export type TradeValueResponse = { tradeValue: string }

export type UserAccountCountry = {
	countryId: number,
	localizedSubdivision: string,
	countryName: string,
	localizedName: string,
	subdivisionIso: string,
}

export type AccountCountrySettingsResponse = { value: UserAccountCountry }

--- Request model for inventory privacy setting update
export type InventoryPrivacyRequest = { inventoryPrivacy: number }

--- Another user that has been blocked by this user.
export type BlockedUser = { name: string, userId: number, displayName: string }

--- Response model for updating the user's inventory privacy settings
export type InventoryPrivacyUpdateResponse = {
	privacySettingResponse: number,
	tradePrivacy: number,
	inventoryPrivacy: number,
}

--- Request model for trade value setting update
export type TradeValueRequest = { tradeValue: number }

--- Response model for getting the user's trade privacy settings
export type TradePrivacyResponse = { tradePrivacy: string }

--- Response model for updating the user's trade privacy settings
export type TradePrivacyUpdateResponse = { privacySettingResponse: number, tradePrivacy: number, inventoryPrivacy: number }

--- Response model for get user's theme type
export type ThemeConfigurationResponse = { themeType: string }

--- Request model for game chat privacy setting update
export type GameChatPrivacyRequest = { gameChatPrivacy: number }

--- Response model for getting blocked users.
export type GetDetailedBlockedUsersResponse = { blockedUsers: { BlockedUser }, total: number, maxBlockedUsers: number }

--- Request model for sending a verify email request
export type SendVerifyEmailRequest = { freeItem: boolean, isAdsAccount: boolean }

--- <no description>
export type GetBlockedUsersResponse = { blockedUserIds: { number } }

--- Response model for getting the user's private message privacy settings
export type PrivateMessagePrivacyResponse = { privateMessagePrivacy: string }

--- Request model for private message privacy setting update
export type PrivateMessagePrivacyRequest = { privateMessagePrivacy: string }

--- Response model for get user's theme type
export type ThemeConfigurationRequest = { themeType: string }

--- Response model for getting the user's app chat privacy setting GET
export type AppChatPrivacyResponse = { appChatPrivacy: string }

--- Request model for app chat privacy setting update
export type AppChatPrivacyRequest = { appChatPrivacy: number }

--- Updates the user's account country.
local function setCountry(with: UpdateAccountCountryRequest & { cookie: string }): UpdateAccountCountryResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/account/settings/account-country`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's current account country setting.
local function getCountry(with: { cookie: string }): AccountCountrySettingsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/account/settings/account-country`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates the authenticated user's email address
local function setEmail(with: UpdateEmailRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/email`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the authenticated user's email address and verified status
local function getEmail(with: { cookie: string }): EmailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/email`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns metadata used by the account settings page
local function getMetadata(with: { cookie: string }): AccountsSettingsMetadataModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/account/settings/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's inventory privacy setting
local function setInventoryPrivacy(with: InventoryPrivacyRequest & { cookie: string }): InventoryPrivacyUpdateResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/inventory-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's inventory privacy setting
local function getInventoryPrivacy(with: { cookie: string }): InventoryPrivacyResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/inventory-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Unblocks a previously blocked user.
local function unblock(with: { userId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/users/{with.userId}/unblock`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's game chat privacy setting
local function setGameChatPrivacy(with: GameChatPrivacyRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/game-chat-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's game chat privacy setting
local function getGameChatPrivacy(with: { cookie: string }): GameChatPrivacyResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/game-chat-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Blocks another user.
local function block(with: { userId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/users/{with.userId}/block`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all blocked users with details.
local function getBlockedUsers(with: { cookie: string }): GetDetailedBlockedUsersResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/users/get-detailed-blocked-users`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's trade quality filter setting
local function setTradeQualityFilter(with: TradeValueRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/trade-value`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's trade quality filter setting
local function getTradeQualityFilter(with: { cookie: string }): TradeValueResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/trade-value`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's app chat privacy setting
local function setAppChatPrivacy(with: AppChatPrivacyRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/app-chat-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's app chat privacy setting
local function getAppChatPrivacy(with: { cookie: string }): AppChatPrivacyResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/app-chat-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's trade privacy setting
local function setTradePrivacy(with: UpdateTradePrivacyRequest & { cookie: string }): TradePrivacyUpdateResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/trade-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's trade privacy setting
local function getTradePrivacy(with: { cookie: string }): TradePrivacyResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/trade-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's private message privacy setting
local function setMessagePrivacy(with: PrivateMessagePrivacyRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/private-message-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's private message privacy setting
local function getMessagePrivacy(with: { cookie: string }): PrivateMessagePrivacyResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/private-message-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Send verify email to the authenticated user's email address
local function verifyEmail(with: SendVerifyEmailRequest & { cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/email/verify`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	setCountry = setCountry,
	getCountry = getCountry,
	setEmail = setEmail,
	getEmail = getEmail,
	getMetadata = getMetadata,
	setInventoryPrivacy = setInventoryPrivacy,
	getInventoryPrivacy = getInventoryPrivacy,
	unblock = unblock,
	setGameChatPrivacy = setGameChatPrivacy,
	getGameChatPrivacy = getGameChatPrivacy,
	block = block,
	getBlockedUsers = getBlockedUsers,
	setTradeQualityFilter = setTradeQualityFilter,
	getTradeQualityFilter = getTradeQualityFilter,
	setAppChatPrivacy = setAppChatPrivacy,
	getAppChatPrivacy = getAppChatPrivacy,
	setTradePrivacy = setTradePrivacy,
	getTradePrivacy = getTradePrivacy,
	setMessagePrivacy = setMessagePrivacy,
	getMessagePrivacy = getMessagePrivacy,
	verifyEmail = verifyEmail,
}
