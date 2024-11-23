local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- Response model for getting whether a universe has private servers enabled.
export type PrivateServersEnabledInUniverseResponse = { privateServersEnabled: boolean }

--- Response model for a VIP server place
export type PlaceResponse = { id: number, name: string }

--- Request model to update subscriptions for a VIP server.
export type VipServerUpdateSubscriptionRequest = { price: number, active: boolean }

--- Data model for private server
export type MyPrivateServersData = {
	ownerId: number,
	universeId: number,
	name: string,
	ownerName: string,
	placeId: number,
	priceInRobux: number,
}

--- Response model for getting the user vote status for a game
export type UserGameVoteResponse = { canVote: boolean, userVote: boolean, reasonForNotVoteable: string }

--- Game favorite request model.
export type GameFavoritesRequest = { isFavorited: boolean }

--- <no description>
export type VipServerUpdateVoiceSettingsRequest = { enabled: boolean }

--- A response model specific to multi-get user.
export type VerifiedBadgeUserResponse = { id: number, name: string, hasVerifiedBadge: boolean, displayName: string }

--- Response model for favorited game count.
export type GameFavoritesCountResponse = { favoritesCount: number }

--- A request for set user's vote for a game
export type SetUserGameVoteRequest = { vote: boolean }

--- Game favorite response model.
export type GameFavoriteResponse = { isFavorited: boolean }

--- Response model for getting the game vote
export type GameVoteResponse = { id: number, upVotes: number, downVotes: number }

--- <no description>
export type PurchaseData = { localizedFiatPrice: string, basePriceId: string }

--- Response model for VIP server subscription.
export type VipServerSubscriptionResponse = {
	hasPriceChanged: boolean,
	expirationDate: string,
	canRenew: boolean,
	active: boolean,
	expired: boolean,
	hasRecurringProfile: boolean,
	hasInsufficientFunds: boolean,
	price: number,
}

--- Game server list response model.
export type GameServerResponse = {
	players: { GameServerPlayerResponse },
	id: string,
	owner: VerifiedBadgeUserResponse,
	fps: number,
	accessCode: string,
	name: string,
	vipServerId: number,
	ping: number,
	playerTokens: { string },
	playing: number,
	maxPlayers: number,
}

--- Response model for a VIP server game.
export type GameResponse = { id: number, name: string, rootPlace: PlaceResponse }

--- Request model to update a VIP server.
export type VipServerUpdateRequest = { newJoinCode: boolean, name: string, active: boolean }

--- User Presences Response model
export type PrivateServersResponse = { privateServerResponses: { GameServerResponse } }

--- <no description>
export type GameDetailResponsePages = { data: { GameDetailResponse } }

--- An create request for a vip server
export type CreateVipServersRequest = { expectedPrice: number, name: string, isPurchaseConfirmed: boolean }

--- Response model for a VIP server.
export type VipServerResponse = {
	active: boolean,
	id: number,
	subscription: VipServerSubscriptionResponse,
	joinCode: string,
	permissions: VipServerPermissionsResponse,
	name: string,
	game: GameResponse,
	link: string,
	voiceSettings: VipServerVoiceSettingsResponse,
}

--- <no description>
export type GameServerResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { GameServerResponse } }

--- Response model for games.
export type GameResponseModel = {
	universeId: number,
	creatorHasVerifiedBadge: boolean,
	price: number,
	placeId: number,
	genre: string,
	minimumAge: number,
	gameDescription: string,
	creatorId: number,
	analyticsIdentifier: string,
	totalDownVotes: number,
	ageRecommendationDisplayName: string,
	imageToken: string,
	nativeAdData: string,
	isSponsored: boolean,
	name: string,
	totalUpVotes: number,
	isShowSponsoredLabel: boolean,
	playerCount: number,
	creatorName: string,
	creatorType: string,
}

--- <no description>
export type GamePassResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { GamePassResponse } }

--- <no description>
export type GameVoteResponsePages = { data: { GameVoteResponse } }

--- <no description>
export type GameProductResponsePages = { data: { GameProductResponse } }

--- Game recommendations response model.
export type GameRecommendationsResponse = { games: { GameResponseModel }, nextPaginationKey: string }

--- Response model for getting the game product information
export type GameProductResponse = {
	universeId: number,
	isForSale: boolean,
	price: number,
	sellerId: number,
	fiatPurchaseData: PurchaseData,
	productId: number,
}

--- Response model for getting a universe's playability status for a user
export type PlayabilityStatusResponse = {
	isPlayable: boolean,
	universeId: number,
	unplayableDisplayText: string,
	playabilityStatus: number,
}

--- <no description>
export type RefundPolicy = { locale: string, articleId: string, policyText: string, learnMoreBaseUrl: string }

--- <no description>
export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- Response model for getting the game detail
export type GameDetailResponse = {
	allowedGearCategories: { string },
	licenseDescription: string,
	description: string,
	isGenreEnforced: boolean,
	price: number,
	genre: string,
	genre_l2: string,
	updated: string,
	refundPolicy: RefundPolicy,
	localizedFiatPrice: string,
	refundLink: string,
	favoritedCount: number,
	isFavoritedByUser: boolean,
	playing: number,
	created: string,
	sourceName: string,
	creator: GameCreator,
	isAllGenre: boolean,
	id: number,
	allowedGearGenres: { string },
	genre_l1: string,
	universeAvatarType: number,
	createVipServersAllowed: boolean,
	visits: number,
	name: string,
	sourceDescription: string,
	copyingAllowed: boolean,
	rootPlaceId: number,
	studioAccessToApisAllowed: boolean,
	maxPlayers: number,
}

--- Response model for VIP server can-invite user.
export type VipServerCanInviteResponse = {
	doesOwnerPrivacyRestrictJoins: boolean,
	inviteResponseType: number,
	canInvite: boolean,
}

--- <no description>
export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- <no description>
export type SkinnyUserResponse = { id: number, name: string, displayName: string }

--- <no description>
export type ApiEmptyResponseModel = {}

--- Request model for updating permissions for a VIP server.
export type VipServerUpdatePermissionsRequest = {
	usersToRemove: { number },
	enemyClanId: number,
	usersToAdd: { number },
	friendsAllowed: boolean,
	clanAllowed: boolean,
}

--- Contains voice settings of a vip server
export type VipServerVoiceSettingsResponse = { enabled: boolean }

--- Response model for getting game passes
export type GamePassResponse = {
	isOwned: boolean,
	sellerName: string,
	name: string,
	productId: number,
	id: number,
	sellerId: number,
	price: number,
	displayName: string,
}

--- Response model for getting the game media item
export type GameMediaItem = {
	assetTypeId: number,
	altText: string,
	videoTitle: string,
	videoHash: string,
	id: number,
	approved: boolean,
	assetType: string,
	imageId: number,
}

--- <no description>
export type GameMediaItemPages = { data: { GameMediaItem } }

--- Response model for a place.
export type PlaceDetails = {
	reasonProhibited: string,
	sourceName: string,
	description: string,
	fiatPurchaseData: PurchaseData,
	builder: string,
	placeId: number,
	hasVerifiedBadge: boolean,
	imageToken: string,
	isPlayable: boolean,
	price: number,
	name: string,
	sourceDescription: string,
	universeRootPlaceId: number,
	url: string,
	universeId: number,
	builderId: number,
}

--- Response model for getting private servers
export type MyPrivateServersResponse =
	{ nextPageCursor: string, previousPageCursor: string, data: { MyPrivateServersData } }

--- Response model for VIP server permissions.
export type VipServerPermissionsResponse = {
	enemyClanId: number,
	friendsAllowed: boolean,
	users: { SkinnyUserResponse },
	clanAllowed: boolean,
}

--- Response model for getting the game creator
export type GameCreator = { type: string, name: string, id: number, isRNVAccount: boolean, hasVerifiedBadge: boolean }

--- A response model representing a game server player.
export type GameServerPlayerResponse = { playerToken: string, id: number, name: string, displayName: string }

--- <no description>
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- <no description>
export type Int32Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int32Pages }

--- <no description>

--- Response model for getting the game media item
export type GameMediaItemResponseV2 = {
	assetTypeId: number,
	videoTitle: string,
	videoHash: string,
	altText: string,
	approved: boolean,
	assetType: string,
	imageId: number,
}

--- <no description>
export type GameMediaItemResponseV2Pages = { data: { GameMediaItemResponseV2 } }

--- <no description>

--- <no description>
export type GameResponseV2Pages = { nextPageCursor: string, previousPageCursor: string, data: { GameResponseV2 } }

--- <no description>

--- <no description>

--- <no description>
export type AssetTypePages = { id: number, type: number, name: string }

--- <no description>
export type CreatorTypePages = { id: number, type: number, name: string }

--- A response model representing a game.
export type GameResponseV2 = {
	created: string,
	updated: string,
	name: string,
	placeVisits: number,
	id: number,
	description: string,
	creator: CreatorTypePages,
	rootPlace: AssetTypePages,
}

--- Get the game server list
local function servers(with: {
	placeId: number,
	serverType: number,
	sortOrder: number?,
	excludeFullGames: boolean?,
	limit: number?,
	cursor: string?,
}): GameServerResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{with.placeId}/servers/{with.serverType}?sortOrder={with.sortOrder or ""}&excludeFullGames={with.excludeFullGames or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the favorites count of the a specific game
local function favorites(with: { universeId: number }): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{with.universeId}/favorites/count`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).favoritesCount
end

--- Updates vip server
local function configurePrivate(with: VipServerUpdateRequest & { id: number, cookie: string }): VipServerResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{with.id}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get necessary data to generate webpage
local function private(with: { id: number, cookie: string }): VipServerResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/vip-servers/{with.id}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of universe playability statuses for the authenticated user
local function playability(with: { universeIds: { number } }): { PlayabilityStatusResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/multiget-playability-status?universeIds={table.concat(
			with.universeIds,
			"&universeIds="
		)}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update friend/clan access and allowed friends/clan list
local function updatePermissions(
	with: VipServerUpdatePermissionsRequest & { id: number, cookie: string }
): VipServerPermissionsResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{with.id}/permissions`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of private servers user can access for given game id.
local function privatesIn(
	with: { placeId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): GameServerResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{with.placeId}/private-servers?limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Checks if the private servers are enabled in the specified universe.
local function arePrivatesEnabled(with: { universeId: number }): boolean
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/private-servers/enabled-in-universe/{with.universeId}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).privateServersEnabled
end

--- Gets a list of universe vote status
local function votes(with: { universeIds: { number } }): { GameVoteResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/votes?universeIds={table.concat(with.universeIds, "&universeIds=")}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Get the user's vote status for a game
local function vote(with: { universeId: number, cookie: string }): UserGameVoteResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{with.universeId}/votes/user`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Create VIP server for a game
local function createPrivate(with: CreateVipServersRequest & { universeId: number, cookie: string }): GameServerResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://games.roblox.com/v1/games/vip-servers/{with.universeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of games' product info, used to purchase a game
local function products(with: { universeIds: { number } }): { GameProductResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/games-product-info?universeIds={table.concat(
			with.universeIds,
			"&universeIds="
		)}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Get the game's game passes
local function gamepasses(
	with: { universeId: number, limit: number, sortOrder: number?, cursor: string? }
): GamePassResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{with.universeId}/game-passes?limit={with.limit}&sortOrder={with.sortOrder or ""}&cursor={with.cursor or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of games' detail
local function multiple(with: { universeIds: { number } }): { GameDetailResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games?universeIds={table.concat(with.universeIds, "&universeIds=")}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Set the user's vote for a game
local function setVote(with: SetUserGameVoteRequest & { universeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/games/{with.universeId}/user-votes`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get private servers from private server ids
local function privates(with: { privateServerIds: { number }, cookie: string }): { GameServerResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/private-servers?privateServerIds={table.concat(
			with.privateServerIds,
			"&privateServerIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).privateServerResponses
end

--- Get private servers for the authenticated user
local function ownedPrivates(
	with: { privateServersTab: number?, itemsPerPage: number?, cursor: string?, cookie: string }
): MyPrivateServersResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/private-servers/my-private-servers?privateServersTab={with.privateServersTab or ""}&itemsPerPage={with.itemsPerPage or ""}&cursor={with.cursor or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get games recommendations based on a given universe
local function recommendations(with: {
	universeId: number,
	PaginationKey: string,
	MaxRows: number,
	IsTruncatedResultsEnabled: boolean,
}): GameRecommendationsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/recommendations/game/{with.universeId}?PaginationKey={with.PaginationKey}&MaxRows={with.MaxRows}&IsTruncatedResultsEnabled={with.IsTruncatedResultsEnabled}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Determines if a user by id is allowed to receive a VIP Server invite from the authenticated user.
local function canInviteToPrivate(with: { userId: number, cookie: string }): VipServerCanInviteResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/vip-server/can-invite/{with.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates subscription status of a vip server
local function updateSubscription(
	with: VipServerUpdateSubscriptionRequest & { id: number, cookie: string }
): VipServerSubscriptionResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{with.id}/subscription`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update voice settings for a private server.
local function updateVoiceSettings(with: VipServerUpdateVoiceSettingsRequest & { id: number, cookie: string }): boolean
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{with.id}/voicesettings`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).enabled
end

--- Get place details
local function places(with: { placeIds: { number }, cookie: string }): { PlaceDetails }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/multiget-place-details?placeIds={table.concat(
			with.placeIds,
			"&placeIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Favors (or unfavors) a game for the authenticated user
local function favorite(with: GameFavoritesRequest & { universeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://games.roblox.com/v1/games/{with.universeId}/favorites`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={with.cookie}` },
		body = serde.encode("json", with),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns if a game was marked as favorite for the authenticated user
local function favorited(with: { universeId: number, cookie: string }): boolean
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{with.universeId}/favorites`,
		headers = { Cookie = `.ROBLOSECURITY={with.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).isFavorited
end

--- Gets games created by the specified user.
local function of(
	with: { userId: number, accessFilter: number?, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): GameResponseV2Pages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v2/users/{with.userId}/games?accessFilter={with.accessFilter or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the game media data
local function media(with: { universeId: number }): { GameMediaItemResponseV2 }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v2/games/{with.universeId}/media`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets games created by the specified group. This will replace V1 after validation. Note that this can only used for public/all universes.
local function ofGroup(
	with: {
		groupId: number,
		accessFilter: number?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	}
): GameResponseV2Pages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v2/groups/{with.groupId}/gamesV2?accessFilter={with.accessFilter or ""}&limit={with.limit or ""}&cursor={with.cursor or ""}&sortOrder={with.sortOrder or ""}`,
		headers = {},
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

return {
	servers = servers,
	favorites = favorites,
	configurePrivate = configurePrivate,
	private = private,
	playability = playability,
	spotlight = spotlight,
	updatePermissions = updatePermissions,
	privatesIn = privatesIn,
	arePrivatesEnabled = arePrivatesEnabled,
	votes = votes,
	of = of,
	vote = vote,
	createPrivate = createPrivate,
	products = products,
	gamepasses = gamepasses,
	multiple = multiple,
	setVote = setVote,
	privates = privates,
	ownedPrivates = ownedPrivates,
	recommendations = recommendations,
	canInviteToPrivate = canInviteToPrivate,
	media = media,
	updateSubscription = updateSubscription,
	updateVoiceSettings = updateVoiceSettings,
	places = places,
	ofGroup = ofGroup,
	favorite = favorite,
	favorited = favorited,
}
