local serde = require("./utils/serde")
local requestWithCsrfToken = require("./utils/request-with-csrf-token")

--- [games.roblox.com](https://games.roblox.com)
--- @class games

--- Response model for getting whether a universe has private servers enabled.
--- @interface PrivateServersEnabledInUniverseResponse
--- .privateServersEnabled boolean
--- @within games
export type PrivateServersEnabledInUniverseResponse = { privateServersEnabled: boolean }

--- Response model for a VIP server place
--- @interface PlaceResponse
--- .id number
--- .name string
--- @within games
export type PlaceResponse = { id: number, name: string }

--- Request model to update subscriptions for a VIP server.
--- @interface VipServerUpdateSubscriptionRequest
--- .price number
--- .active boolean
--- @within games
export type VipServerUpdateSubscriptionRequest = { price: number, active: boolean }

--- Data model for private server
--- @interface MyPrivateServersData
--- .ownerId number
--- .universeId number
--- .name string
--- .ownerName string
--- .placeId number
--- .priceInRobux number
--- @within games
export type MyPrivateServersData = {
	ownerId: number,
	universeId: number,
	name: string,
	ownerName: string,
	placeId: number,
	priceInRobux: number,
}

--- Response model for getting the user vote status for a game
--- @interface UserGameVoteResponse
--- .canVote boolean
--- .userVote boolean
--- .reasonForNotVoteable string
--- @within games
export type UserGameVoteResponse = { canVote: boolean, userVote: boolean, reasonForNotVoteable: string }

--- Game favorite request model.
--- @interface GameFavoritesRequest
--- .isFavorited boolean
--- @within games
export type GameFavoritesRequest = { isFavorited: boolean }

--- @interface VipServerUpdateVoiceSettingsRequest
--- .enabled boolean
--- @within games
export type VipServerUpdateVoiceSettingsRequest = { enabled: boolean }

--- A response model specific to multi-get user.
--- @interface VerifiedBadgeUserResponse
--- .id number
--- .name string
--- .hasVerifiedBadge boolean
--- .displayName string
--- @within games
export type VerifiedBadgeUserResponse = { id: number, name: string, hasVerifiedBadge: boolean, displayName: string }

--- Response model for favorited game count.
--- @interface GameFavoritesCountResponse
--- .favoritesCount number
--- @within games
export type GameFavoritesCountResponse = { favoritesCount: number }

--- A request for set user's vote for a game
--- @interface SetUserGameVoteRequest
--- .vote boolean
--- @within games
export type SetUserGameVoteRequest = { vote: boolean }

--- Game favorite response model.
--- @interface GameFavoriteResponse
--- .isFavorited boolean
--- @within games
export type GameFavoriteResponse = { isFavorited: boolean }

--- Response model for getting the game vote
--- @interface GameVoteResponse
--- .id number
--- .upVotes number
--- .downVotes number
--- @within games
export type GameVoteResponse = { id: number, upVotes: number, downVotes: number }

--- Response model for VIP server subscription.
--- @interface VipServerSubscriptionResponse
--- .hasPriceChanged boolean
--- .expirationDate string
--- .canRenew boolean
--- .active boolean
--- .expired boolean
--- .hasRecurringProfile boolean
--- .hasInsufficientFunds boolean
--- .price number
--- @within games
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
--- @interface GameServerResponse
--- .players { GameServerPlayerResponse }
--- .id string
--- .owner VerifiedBadgeUserResponse
--- .fps number
--- .accessCode string
--- .name string
--- .vipServerId number
--- .ping number
--- .playerTokens { string }
--- .playing number
--- .maxPlayers number
--- @within games
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
--- @interface GameResponse
--- .id number
--- .name string
--- .rootPlace PlaceResponse
--- @within games
export type GameResponse = { id: number, name: string, rootPlace: PlaceResponse }

--- Request model to update a VIP server.
--- @interface VipServerUpdateRequest
--- .newJoinCode boolean
--- .name string
--- .active boolean
--- @within games
export type VipServerUpdateRequest = { newJoinCode: boolean, name: string, active: boolean }

--- User Presences Response model
--- @interface PrivateServersResponse
--- .privateServerResponses { GameServerResponse }
--- @within games
export type PrivateServersResponse = { privateServerResponses: { GameServerResponse } }

--- @interface GameDetailResponsePages
--- .data { GameDetailResponse }
--- @within games
export type GameDetailResponsePages = { data: { GameDetailResponse } }

--- An create request for a vip server
--- @interface CreateVipServersRequest
--- .expectedPrice number
--- .name string
--- .isPurchaseConfirmed boolean
--- @within games
export type CreateVipServersRequest = { expectedPrice: number, name: string, isPurchaseConfirmed: boolean }

--- Response model for a VIP server.
--- @interface VipServerResponse
--- .active boolean
--- .id number
--- .subscription VipServerSubscriptionResponse
--- .joinCode string
--- .permissions VipServerPermissionsResponse
--- .name string
--- .game GameResponse
--- .link string
--- .voiceSettings VipServerVoiceSettingsResponse
--- @within games
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

--- Response model for games.
--- @interface GameResponseModel
--- .universeId number
--- .creatorHasVerifiedBadge boolean
--- .price number
--- .placeId number
--- .genre string
--- .minimumAge number
--- .gameDescription string
--- .creatorId number
--- .analyticsIdentifier string
--- .totalDownVotes number
--- .ageRecommendationDisplayName string
--- .imageToken string
--- .nativeAdData string
--- .isSponsored boolean
--- .name string
--- .totalUpVotes number
--- .isShowSponsoredLabel boolean
--- .playerCount number
--- .creatorName string
--- .creatorType string
--- @within games
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

--- @interface GameServerResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GameServerResponse }
--- @within games
export type GameServerResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { GameServerResponse } }

--- @interface GamePassResponsePages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GamePassResponse }
--- @within games
export type GamePassResponsePages = { nextPageCursor: string, previousPageCursor: string, data: { GamePassResponse } }

--- @interface GameVoteResponsePages
--- .data { GameVoteResponse }
--- @within games
export type GameVoteResponsePages = { data: { GameVoteResponse } }

--- Game recommendations response model.
--- @interface GameRecommendationsResponse
--- .games { GameResponseModel }
--- .nextPaginationKey string
--- @within games
export type GameRecommendationsResponse = { games: { GameResponseModel }, nextPaginationKey: string }

--- Response model for getting the game product information
--- @interface GameProductResponse
--- .universeId number
--- .isForSale boolean
--- .price number
--- .sellerId number
--- .productId number
--- @within games
export type GameProductResponse = {
	universeId: number,
	isForSale: boolean,
	price: number,
	sellerId: number,
	productId: number,
}

--- Response model for getting a universe's playability status for a user
--- @interface PlayabilityStatusResponse
--- .isPlayable boolean
--- .universeId number
--- .playabilityStatus number
--- @within games
export type PlayabilityStatusResponse = { isPlayable: boolean, universeId: number, playabilityStatus: number }

--- @interface GameProductResponsePages
--- .data { GameProductResponse }
--- @within games
export type GameProductResponsePages = { data: { GameProductResponse } }

--- @interface StartIndexCursor
--- .discriminator string
--- .count number
--- .startIndex number
--- @within games
export type StartIndexCursor = { discriminator: string, count: number, startIndex: number }

--- Response model for getting the game detail
--- @interface GameDetailResponse
--- .allowedGearCategories { string }
--- .licenseDescription string
--- .description string
--- .isGenreEnforced boolean
--- .price number
--- .genre string
--- .genre_l2 string
--- .updated string
--- .favoritedCount number
--- .isFavoritedByUser boolean
--- .playing number
--- .created string
--- .sourceName string
--- .creator GameCreator
--- .isAllGenre boolean
--- .id number
--- .allowedGearGenres { string }
--- .genre_l1 string
--- .universeAvatarType number
--- .createVipServersAllowed boolean
--- .visits number
--- .name string
--- .sourceDescription string
--- .copyingAllowed boolean
--- .rootPlaceId number
--- .studioAccessToApisAllowed boolean
--- .maxPlayers number
--- @within games
export type GameDetailResponse = {
	allowedGearCategories: { string },
	licenseDescription: string,
	description: string,
	isGenreEnforced: boolean,
	price: number,
	genre: string,
	genre_l2: string,
	updated: string,
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
--- @interface VipServerCanInviteResponse
--- .doesOwnerPrivacyRestrictJoins boolean
--- .inviteResponseType number
--- .canInvite boolean
--- @within games
export type VipServerCanInviteResponse = {
	doesOwnerPrivacyRestrictJoins: boolean,
	inviteResponseType: number,
	canInvite: boolean,
}

--- @interface StringPages
--- .discriminator string
--- .sortOrder number
--- .key string
--- .count number
--- .pagingDirection number
--- .pageNumber number
--- @within games
export type StringPages = {
	discriminator: string,
	sortOrder: number,
	key: string,
	count: number,
	pagingDirection: number,
	pageNumber: number,
}

--- @interface SkinnyUserResponse
--- .id number
--- .name string
--- .displayName string
--- @within games
export type SkinnyUserResponse = { id: number, name: string, displayName: string }

--- Response model for getting game passes
--- @interface GamePassResponse
--- .isOwned boolean
--- .sellerName string
--- .name string
--- .productId number
--- .id number
--- .sellerId number
--- .price number
--- .displayName string
--- @within games
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

--- Request model for updating permissions for a VIP server.
--- @interface VipServerUpdatePermissionsRequest
--- .usersToRemove { number }
--- .enemyClanId number
--- .usersToAdd { number }
--- .friendsAllowed boolean
--- .clanAllowed boolean
--- @within games
export type VipServerUpdatePermissionsRequest = {
	usersToRemove: { number },
	enemyClanId: number,
	usersToAdd: { number },
	friendsAllowed: boolean,
	clanAllowed: boolean,
}

--- @interface ApiEmptyResponseModel
--- @within games
export type ApiEmptyResponseModel = {}

--- Contains voice settings of a vip server
--- @interface VipServerVoiceSettingsResponse
--- .enabled boolean
--- @within games
export type VipServerVoiceSettingsResponse = { enabled: boolean }

--- Response model for getting the game media item
--- @interface GameMediaItem
--- .assetTypeId number
--- .altText string
--- .videoTitle string
--- .videoHash string
--- .id number
--- .approved boolean
--- .assetType string
--- .imageId number
--- @within games
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

--- @interface GameMediaItemPages
--- .data { GameMediaItem }
--- @within games
export type GameMediaItemPages = { data: { GameMediaItem } }

--- Response model for a place.
--- @interface PlaceDetails
--- .reasonProhibited string
--- .sourceName string
--- .description string
--- .builder string
--- .placeId number
--- .hasVerifiedBadge boolean
--- .imageToken string
--- .isPlayable boolean
--- .price number
--- .name string
--- .sourceDescription string
--- .universeRootPlaceId number
--- .url string
--- .universeId number
--- .builderId number
--- @within games
export type PlaceDetails = {
	reasonProhibited: string,
	sourceName: string,
	description: string,
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
--- @interface MyPrivateServersResponse
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { MyPrivateServersData }
--- @within games
export type MyPrivateServersResponse =
	{ nextPageCursor: string, previousPageCursor: string, data: { MyPrivateServersData } }

--- Response model for VIP server permissions.
--- @interface VipServerPermissionsResponse
--- .enemyClanId number
--- .friendsAllowed boolean
--- .users { SkinnyUserResponse }
--- .clanAllowed boolean
--- @within games
export type VipServerPermissionsResponse = {
	enemyClanId: number,
	friendsAllowed: boolean,
	users: { SkinnyUserResponse },
	clanAllowed: boolean,
}

--- Response model for getting the game creator
--- @interface GameCreator
--- .type string
--- .name string
--- .id number
--- .isRNVAccount boolean
--- .hasVerifiedBadge boolean
--- @within games
export type GameCreator = { type: string, name: string, id: number, isRNVAccount: boolean, hasVerifiedBadge: boolean }

--- A response model representing a game server player.
--- @interface GameServerPlayerResponse
--- .playerToken string
--- .id number
--- .name string
--- .displayName string
--- @within games
export type GameServerPlayerResponse = { playerToken: string, id: number, name: string, displayName: string }

--- @interface Int64Pages
--- .SortOrder number
--- .PagingDirection number
--- .Count number
--- @within games
export type Int64Pages = { SortOrder: number, PagingDirection: number, Count: number }

--- @interface Int32Pages
--- .CursorRecipe string
--- .ExclusiveStartKeyInfo Int32Pages
--- @within games
export type Int32Pages = { CursorRecipe: string, ExclusiveStartKeyInfo: Int32Pages }

--- A response model representing a game.
--- @interface GameResponseV2
--- .created string
--- .updated string
--- .name string
--- .placeVisits number
--- .id number
--- .description string
--- .creator CreatorTypePages
--- .rootPlace AssetTypePages
--- @within games
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

--- Response model for getting the game media item
--- @interface GameMediaItemResponseV2
--- .assetTypeId number
--- .videoTitle string
--- .videoHash string
--- .altText string
--- .approved boolean
--- .assetType string
--- .imageId number
--- @within games
export type GameMediaItemResponseV2 = {
	assetTypeId: number,
	videoTitle: string,
	videoHash: string,
	altText: string,
	approved: boolean,
	assetType: string,
	imageId: number,
}

--- @interface GameMediaItemResponseV2Pages
--- .data { GameMediaItemResponseV2 }
--- @within games
export type GameMediaItemResponseV2Pages = { data: { GameMediaItemResponseV2 } }

--- @interface GameResponseV2Pages
--- .nextPageCursor string
--- .previousPageCursor string
--- .data { GameResponseV2 }
--- @within games
export type GameResponseV2Pages = { nextPageCursor: string, previousPageCursor: string, data: { GameResponseV2 } }

--- @interface CreatorTypePages
--- .id number
--- .type number
--- .name string
--- @within games
export type CreatorTypePages = { id: number, type: number, name: string }

--- @interface AssetTypePages
--- .id number
--- .type number
--- .name string
--- @within games
export type AssetTypePages = { id: number, type: number, name: string }

--- Get the game server list
--- @within games
local function servers(request: {
	placeId: number,
	serverType: number,
	sortOrder: number?,
	excludeFullGames: boolean?,
	limit: number?,
	cursor: string?,
}): GameServerResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{request.placeId}/servers/{request.serverType}?sortOrder={request.sortOrder or ""}&excludeFullGames={request.excludeFullGames or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the favorites count of the a specific game
--- @within games
local function favorites(universeId: number): number
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{universeId}/favorites/count`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).favoritesCount
end

--- Updates vip server
--- @within games
local function configurePrivate(request: VipServerUpdateRequest & { id: number, cookie: string }): VipServerResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{request.id}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get necessary data to generate webpage
--- @within games
local function private(request: { id: number, cookie: string }): VipServerResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/vip-servers/{request.id}`,
		headers = { Cookie = `.ROBLOSECURITY={request.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of universe playability statuses for the authenticated user
--- @within games
local function playability(universeIds: { number }): { PlayabilityStatusResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/multiget-playability-status?universeIds={table.concat(
			universeIds,
			"&universeIds="
		)}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update friend/clan access and allowed friends/clan list
--- @within games
local function updatePermissions(
	request: VipServerUpdatePermissionsRequest & { id: number, cookie: string }
): VipServerPermissionsResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{request.id}/permissions`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get list of private servers user can access for given game id.
--- @within games
local function privatesIn(
	request: { placeId: number, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): GameServerResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{request.placeId}/private-servers?limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Checks if the private servers are enabled in the specified universe.
--- @within games
local function arePrivatesEnabled(universeId: number): boolean
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/private-servers/enabled-in-universe/{universeId}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).privateServersEnabled
end

--- Gets a list of universe vote status
--- @within games
local function votes(universeIds: { number }): { GameVoteResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/votes?universeIds={table.concat(universeIds, "&universeIds=")}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Get the user's vote status for a game
--- @within games
local function vote(request: { universeId: number, cookie: string }): UserGameVoteResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{request.universeId}/votes/user`,
		headers = { Cookie = `.ROBLOSECURITY={request.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Create VIP server for a game
--- @within games
local function createPrivate(
	request: CreateVipServersRequest & { universeId: number, cookie: string }
): GameServerResponse
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://games.roblox.com/v1/games/vip-servers/{request.universeId}`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of games' product info, used to purchase a game
--- @within games
local function products(universeIds: { number }): { GameProductResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/games-product-info?universeIds={table.concat(
			universeIds,
			"&universeIds="
		)}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Get the game's game passes
--- @within games
local function gamepasses(
	request: { universeId: number, limit: number, sortOrder: number?, cursor: string? }
): GamePassResponsePages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{request.universeId}/game-passes?limit={request.limit}&sortOrder={request.sortOrder or ""}&cursor={request.cursor or ""}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Gets a list of games' detail
--- @within games
local function multiple(universeIds: { number }): { GameDetailResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games?universeIds={table.concat(universeIds, "&universeIds=")}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Set the user's vote for a game
--- @within games
local function setVote(request: SetUserGameVoteRequest & { universeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/games/{request.universeId}/user-votes`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get private servers from private server ids
--- @within games
local function privates(request: { privateServerIds: { number }, cookie: string }): { GameServerResponse }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/private-servers?privateServerIds={table.concat(
			request.privateServerIds,
			"&privateServerIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={request.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).privateServerResponses
end

--- Get private servers for the authenticated user
--- @within games
local function ownedPrivates(
	request: { privateServersTab: number?, itemsPerPage: number?, cursor: string?, cookie: string }
): MyPrivateServersResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/private-servers/my-private-servers?privateServersTab={request.privateServersTab or ""}&itemsPerPage={request.itemsPerPage or ""}&cursor={request.cursor or ""}`,
		headers = { Cookie = `.ROBLOSECURITY={request.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get games recommendations based on a given universe
--- @within games
local function recommendations(request: {
	universeId: number,
	paginationKey: string,
	maxRows: number,
	isTruncatedResultsEnabled: boolean,
}): GameRecommendationsResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/recommendations/game/{request.universeId}?paginationKey={request.paginationKey}&maxRows={request.maxRows}&isTruncatedResultsEnabled={request.isTruncatedResultsEnabled}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Determines if a user by id is allowed to receive a VIP Server invite from the authenticated user.
--- @within games
local function canInviteToPrivate(request: { userId: number, cookie: string }): VipServerCanInviteResponse
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/vip-server/can-invite/{request.userId}`,
		headers = { Cookie = `.ROBLOSECURITY={request.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Updates subscription status of a vip server
--- @within games
local function updateSubscription(
	request: VipServerUpdateSubscriptionRequest & { id: number, cookie: string }
): VipServerSubscriptionResponse
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{request.id}/subscription`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Update voice settings for a private server.
--- @within games
local function updateVoiceSettings(
	request: VipServerUpdateVoiceSettingsRequest & { id: number, cookie: string }
): boolean
	local response = requestWithCsrfToken({
		method = "PATCH",
		url = `https://games.roblox.com/v1/vip-servers/{request.id}/voicesettings`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).enabled
end

--- Get place details
--- @within games
local function places(request: { placeIds: { number }, cookie: string }): { PlaceDetails }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/multiget-place-details?placeIds={table.concat(
			request.placeIds,
			"&placeIds="
		)}`,
		headers = { Cookie = `.ROBLOSECURITY={request.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Favors (or unfavors) a game for the authenticated user
--- @within games
local function favorite(request: GameFavoritesRequest & { universeId: number, cookie: string }): ApiEmptyResponseModel
	local response = requestWithCsrfToken({
		method = "POST",
		url = `https://games.roblox.com/v1/games/{request.universeId}/favorites`,
		headers = { ["Content-Type"] = "application/json", Cookie = `.ROBLOSECURITY={request.cookie}` },
		body = serde.encode("json", request),
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Returns if a game was marked as favorite for the authenticated user
--- @within games
local function favorited(request: { universeId: number, cookie: string }): boolean
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v1/games/{request.universeId}/favorites`,
		headers = { Cookie = `.ROBLOSECURITY={request.cookie}` },
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).isFavorited
end

--- Gets games created by the specified user.
--- @within games
local function of(
	request: { userId: number, accessFilter: number?, limit: number?, cursor: string?, sortOrder: "Asc" | "Desc"? }
): GameResponseV2Pages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v2/users/{request.userId}/games?accessFilter={request.accessFilter or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body)
end

--- Get the game media data
--- @within games
local function media(universeId: number): { GameMediaItemResponseV2 }
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v2/games/{universeId}/media`,
	})

	assert(response.ok, `{response.statusCode} {response.statusMessage}`)

	return serde.decode("json", response.body).data
end

--- Gets games created by the specified group. This will replace V1 after validation. Note that this can only used for public/all universes.
--- @within games
local function ofGroup(
	request: {
		groupId: number,
		accessFilter: number?,
		limit: number?,
		cursor: string?,
		sortOrder: "Asc" | "Desc"?,
	}
): GameResponseV2Pages
	local response = requestWithCsrfToken({
		method = "GET",
		url = `https://games.roblox.com/v2/groups/{request.groupId}/gamesV2?accessFilter={request.accessFilter or ""}&limit={request.limit or ""}&cursor={request.cursor or ""}&sortOrder={request.sortOrder or ""}`,
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
