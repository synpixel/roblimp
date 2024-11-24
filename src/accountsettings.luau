local serde = require("@lune/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")
local Result = require("../lune_packages/result")

type Error = requestWithCsrfToken.Error
type Response<T> = Result.Result<T, Error>

--- Request model for updating an email
export type UpdateEmailRequest = {
	password: string,
	skipVerificationEmail: boolean,
	emailAddress: string,
	isAdsAccount: boolean,
}

export type UpdateAccountCountryResponse = {}

--- Response model for getting the user's inventory privacy settings
export type InventoryPrivacyResponse = { inventoryPrivacy: number }

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
local function setCountry(targetCountryId: number, cookie: string): Response<UpdateAccountCountryResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/account/settings/account-country`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { targetCountryId = targetCountryId }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get a user's current account country setting.
local function country(cookie: string): Response<UserAccountCountry>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/account/settings/account-country`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).value
	end)
end

--- Updates the authenticated user's email address
local function setEmail(request: UpdateEmailRequest, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/email`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets the authenticated user's email address and verified status
local function email(cookie: string): Response<EmailResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/email`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Returns metadata used by the account settings page
local function metadata(cookie: string): Response<AccountsSettingsMetadataModel>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/account/settings/metadata`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Updates a user's inventory privacy setting
local function setInventoryPrivacy(inventoryPrivacy: number, cookie: string): Response<InventoryPrivacyUpdateResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/inventory-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { inventoryPrivacy = inventoryPrivacy }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get a user's inventory privacy setting
local function inventoryPrivacy(cookie: string): Response<number>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/inventory-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).inventoryPrivacy
	end)
end

--- Unblocks a previously blocked user.
local function unblock(userId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/users/{userId}/unblock`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Updates a user's game chat privacy setting
local function setGameChatPrivacy(gameChatPrivacy: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/game-chat-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { gameChatPrivacy = gameChatPrivacy }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get a user's game chat privacy setting
local function gameChatPrivacy(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/game-chat-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).gameChatPrivacy
	end)
end

--- Blocks another user.
local function block(userId: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/users/{userId}/block`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Gets all blocked users with details.
local function blockedUsers(cookie: string): Response<GetDetailedBlockedUsersResponse>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/users/get-detailed-blocked-users`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Updates a user's trade quality filter setting
local function setTradeQualityFilter(tradeValue: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/trade-value`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { tradeValue = tradeValue }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get a user's trade quality filter setting
local function tradeQualityFilter(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/trade-value`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).tradeValue
	end)
end

--- Updates a user's app chat privacy setting
local function setAppChatPrivacy(appChatPrivacy: number, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/app-chat-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { appChatPrivacy = appChatPrivacy }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get a user's app chat privacy setting
local function appChatPrivacy(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/app-chat-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).appChatPrivacy
	end)
end

--- Updates a user's trade privacy setting
local function setTradePrivacy(tradePrivacy: number, cookie: string): Response<TradePrivacyUpdateResponse>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/trade-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { tradePrivacy = tradePrivacy }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get a user's trade privacy setting
local function tradePrivacy(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/trade-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).tradePrivacy
	end)
end

--- Updates a user's private message privacy setting
local function setMessagePrivacy(privateMessagePrivacy: string, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/private-message-privacy`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", { privateMessagePrivacy = privateMessagePrivacy }),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
end

--- Get a user's private message privacy setting
local function messagePrivacy(cookie: string): Response<string>
	return requestWithCsrfToken({
		method = "GET",
		url = `https://accountsettings.roblox.com/v1/private-message-privacy`,
		headers = { Cookie = `.ROBLOSECURITY={cookie}` },
	}):map(function(response)
		return serde.decode("json", response.body).privateMessagePrivacy
	end)
end

--- Send verify email to the authenticated user's email address
local function verifyEmail(request: SendVerifyEmailRequest, cookie: string): Response<ApiEmptyResponseModel>
	return requestWithCsrfToken({
		method = "POST",
		url = `https://accountsettings.roblox.com/v1/email/verify`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={cookie}` },
		body = serde.encode("json", request),
	}):map(function(response)
		return serde.decode("json", response.body)
	end)
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
