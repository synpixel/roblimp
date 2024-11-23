local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [accountsettings.roblox.com](https://accountsettings.roblox.com)
--- @class accountsettings

--- Request model for updating an email
--- @interface UpdateEmailRequest
--- .password string
--- .skipVerificationEmail boolean
--- .emailAddress string
--- .isAdsAccount boolean
--- @within accountsettings
export type UpdateEmailRequest = {
	password: string,
	skipVerificationEmail: boolean,
	emailAddress: string,
	isAdsAccount: boolean,
}

--- @interface UpdateAccountCountryResponse
--- @within accountsettings
export type UpdateAccountCountryResponse = {}

--- Response model for getting the user's inventory privacy settings
--- @interface InventoryPrivacyResponse
--- .inventoryPrivacy number
--- @within accountsettings
export type InventoryPrivacyResponse = { inventoryPrivacy: number }

--- @interface StringPages
--- .data { string }
--- @within accountsettings
export type StringPages = { data: { string } }

--- Response model for getting the user's email address and verified status
--- @interface EmailResponse
--- .verified boolean
--- .emailAddress string
--- .canBypassPasswordForEmailUpdate boolean
--- @within accountsettings
export type EmailResponse = { verified: boolean, emailAddress: string, canBypassPasswordForEmailUpdate: boolean }

--- Response model for getting the user's game chat privacy settings
--- @interface GameChatPrivacyResponse
--- .gameChatPrivacy string
--- @within accountsettings
export type GameChatPrivacyResponse = { gameChatPrivacy: string }

--- A model containing website metadata for avatars
--- @interface AccountsSettingsMetadataModel
--- .IsAccountsRestrictionsSpamBugFixEnabled boolean
--- .IsContentControlsEnabled boolean
--- .IsParentalNotificationSettingsInUIEnabled boolean
--- .IsParentalMonthlyLimitInUIEnabled boolean
--- .MaximumParentalControlsMonthlySpendLimitInUSD number
--- @within accountsettings
export type AccountsSettingsMetadataModel = {
	IsAccountsRestrictionsSpamBugFixEnabled: boolean,
	IsContentControlsEnabled: boolean,
	IsParentalNotificationSettingsInUIEnabled: boolean,
	IsParentalMonthlyLimitInUIEnabled: boolean,
	MaximumParentalControlsMonthlySpendLimitInUSD: number,
}

--- @interface ApiEmptyResponseModel
--- @within accountsettings
export type ApiEmptyResponseModel = {}

--- Request model for trade privacy setting update
--- @interface UpdateTradePrivacyRequest
--- .tradePrivacy number
--- @within accountsettings
export type UpdateTradePrivacyRequest = { tradePrivacy: number }

--- Request Model for updating a user's account country
--- @interface UpdateAccountCountryRequest
--- .targetCountryId number
--- @within accountsettings
export type UpdateAccountCountryRequest = { targetCountryId: number }

--- Response model for getting the user's trade value settings
--- @interface TradeValueResponse
--- .tradeValue string
--- @within accountsettings
export type TradeValueResponse = { tradeValue: string }

--- @interface UserAccountCountry
--- .countryId number
--- .localizedSubdivision string
--- .countryName string
--- .localizedName string
--- .subdivisionIso string
--- @within accountsettings
export type UserAccountCountry = {
	countryId: number,
	localizedSubdivision: string,
	countryName: string,
	localizedName: string,
	subdivisionIso: string,
}

--- @interface AccountCountrySettingsResponse
--- .value UserAccountCountry
--- @within accountsettings
export type AccountCountrySettingsResponse = { value: UserAccountCountry }

--- Request model for inventory privacy setting update
--- @interface InventoryPrivacyRequest
--- .inventoryPrivacy number
--- @within accountsettings
export type InventoryPrivacyRequest = { inventoryPrivacy: number }

--- Another user that has been blocked by this user.
--- @interface BlockedUser
--- .name string
--- .userId number
--- .displayName string
--- @within accountsettings
export type BlockedUser = { name: string, userId: number, displayName: string }

--- Response model for updating the user's inventory privacy settings
--- @interface InventoryPrivacyUpdateResponse
--- .privacySettingResponse number
--- .tradePrivacy number
--- .inventoryPrivacy number
--- @within accountsettings
export type InventoryPrivacyUpdateResponse = {
	privacySettingResponse: number,
	tradePrivacy: number,
	inventoryPrivacy: number,
}

--- Request model for trade value setting update
--- @interface TradeValueRequest
--- .tradeValue number
--- @within accountsettings
export type TradeValueRequest = { tradeValue: number }

--- Response model for getting the user's trade privacy settings
--- @interface TradePrivacyResponse
--- .tradePrivacy string
--- @within accountsettings
export type TradePrivacyResponse = { tradePrivacy: string }

--- Response model for updating the user's trade privacy settings
--- @interface TradePrivacyUpdateResponse
--- .privacySettingResponse number
--- .tradePrivacy number
--- .inventoryPrivacy number
--- @within accountsettings
export type TradePrivacyUpdateResponse = { privacySettingResponse: number, tradePrivacy: number, inventoryPrivacy: number }

--- Response model for get user's theme type
--- @interface ThemeConfigurationResponse
--- .themeType string
--- @within accountsettings
export type ThemeConfigurationResponse = { themeType: string }

--- Request model for game chat privacy setting update
--- @interface GameChatPrivacyRequest
--- .gameChatPrivacy number
--- @within accountsettings
export type GameChatPrivacyRequest = { gameChatPrivacy: number }

--- Response model for getting blocked users.
--- @interface GetDetailedBlockedUsersResponse
--- .blockedUsers { BlockedUser }
--- .total number
--- .maxBlockedUsers number
--- @within accountsettings
export type GetDetailedBlockedUsersResponse = { blockedUsers: { BlockedUser }, total: number, maxBlockedUsers: number }

--- Request model for sending a verify email request
--- @interface SendVerifyEmailRequest
--- .freeItem boolean
--- .isAdsAccount boolean
--- @within accountsettings
export type SendVerifyEmailRequest = { freeItem: boolean, isAdsAccount: boolean }

--- @interface GetBlockedUsersResponse
--- .blockedUserIds { number }
--- @within accountsettings
export type GetBlockedUsersResponse = { blockedUserIds: { number } }

--- Response model for getting the user's private message privacy settings
--- @interface PrivateMessagePrivacyResponse
--- .privateMessagePrivacy string
--- @within accountsettings
export type PrivateMessagePrivacyResponse = { privateMessagePrivacy: string }

--- Request model for private message privacy setting update
--- @interface PrivateMessagePrivacyRequest
--- .privateMessagePrivacy string
--- @within accountsettings
export type PrivateMessagePrivacyRequest = { privateMessagePrivacy: string }

--- Response model for get user's theme type
--- @interface ThemeConfigurationRequest
--- .themeType string
--- @within accountsettings
export type ThemeConfigurationRequest = { themeType: string }

--- Response model for getting the user's app chat privacy setting GET
--- @interface AppChatPrivacyResponse
--- .appChatPrivacy string
--- @within accountsettings
export type AppChatPrivacyResponse = { appChatPrivacy: string }

--- Request model for app chat privacy setting update
--- @interface AppChatPrivacyRequest
--- .appChatPrivacy number
--- @within accountsettings
export type AppChatPrivacyRequest = { appChatPrivacy: number }

--- Updates the user's account country.
--- @within accountsettings
local function setCountry(targetCountryId: number, cookie: string): UpdateAccountCountryResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/account/settings/account-country`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { targetCountryId = targetCountryId }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's current account country setting.
--- @within accountsettings
local function country(request: {}, cookie: string): UserAccountCountry
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/account/settings/account-country`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).value
end

--- Updates the authenticated user's email address
--- @within accountsettings
local function setEmail(request: UpdateEmailRequest, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/email`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets the authenticated user's email address and verified status
--- @within accountsettings
local function email(request: {}, cookie: string): EmailResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/email`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns metadata used by the account settings page
--- @within accountsettings
local function metadata(request: {}, cookie: string): AccountsSettingsMetadataModel
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/account/settings/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's inventory privacy setting
--- @within accountsettings
local function setInventoryPrivacy(inventoryPrivacy: number, cookie: string): InventoryPrivacyUpdateResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/inventory-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { inventoryPrivacy = inventoryPrivacy }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's inventory privacy setting
--- @within accountsettings
local function inventoryPrivacy(request: {}, cookie: string): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/inventory-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).inventoryPrivacy
end

--- Unblocks a previously blocked user.
--- @within accountsettings
local function unblock(userId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/users/{userId}/unblock`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's game chat privacy setting
--- @within accountsettings
local function setGameChatPrivacy(gameChatPrivacy: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/game-chat-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { gameChatPrivacy = gameChatPrivacy }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's game chat privacy setting
--- @within accountsettings
local function gameChatPrivacy(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/game-chat-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).gameChatPrivacy
end

--- Blocks another user.
--- @within accountsettings
local function block(userId: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/users/{userId}/block`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets all blocked users with details.
--- @within accountsettings
local function blockedUsers(request: {}, cookie: string): GetDetailedBlockedUsersResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/users/get-detailed-blocked-users`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates a user's trade quality filter setting
--- @within accountsettings
local function setTradeQualityFilter(tradeValue: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/trade-value`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { tradeValue = tradeValue }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's trade quality filter setting
--- @within accountsettings
local function tradeQualityFilter(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/trade-value`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).tradeValue
end

--- Updates a user's app chat privacy setting
--- @within accountsettings
local function setAppChatPrivacy(appChatPrivacy: number, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/app-chat-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { appChatPrivacy = appChatPrivacy }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's app chat privacy setting
--- @within accountsettings
local function appChatPrivacy(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/app-chat-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).appChatPrivacy
end

--- Updates a user's trade privacy setting
--- @within accountsettings
local function setTradePrivacy(tradePrivacy: number, cookie: string): TradePrivacyUpdateResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/trade-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { tradePrivacy = tradePrivacy }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's trade privacy setting
--- @within accountsettings
local function tradePrivacy(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/trade-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).tradePrivacy
end

--- Updates a user's private message privacy setting
--- @within accountsettings
local function setMessagePrivacy(privateMessagePrivacy: string, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/private-message-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { privateMessagePrivacy = privateMessagePrivacy }),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get a user's private message privacy setting
--- @within accountsettings
local function messagePrivacy(request: {}, cookie: string): string
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/private-message-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).privateMessagePrivacy
end

--- Send verify email to the authenticated user's email address
--- @within accountsettings
local function verifyEmail(request: SendVerifyEmailRequest, cookie: string): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/email/verify`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	setCountry = setCountry,
	country = country,
	setEmail = setEmail,
	email = email,
	metadata = metadata,
	setInventoryPrivacy = setInventoryPrivacy,
	inventoryPrivacy = inventoryPrivacy,
	unblock = unblock,
	setGameChatPrivacy = setGameChatPrivacy,
	gameChatPrivacy = gameChatPrivacy,
	block = block,
	blockedUsers = blockedUsers,
	setTradeQualityFilter = setTradeQualityFilter,
	tradeQualityFilter = tradeQualityFilter,
	setAppChatPrivacy = setAppChatPrivacy,
	appChatPrivacy = appChatPrivacy,
	setTradePrivacy = setTradePrivacy,
	tradePrivacy = tradePrivacy,
	setMessagePrivacy = setMessagePrivacy,
	messagePrivacy = messagePrivacy,
	verifyEmail = verifyEmail,
}
