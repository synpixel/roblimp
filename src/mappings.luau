export type Mapping = {
	path: string,
	methods: Methods,
}

export type Methods = {
	get: string?,
	post: string?,
	patch: string?,
	delete: string?,
}

local function endpoint(path: string): (Methods) -> Mapping
	return function(methods)
		return {
			path = path,
			methods = methods,
		}
	end
end

return table.freeze {
	-- Account Information v1
	endpoint "/v1/birthdate" { get = "birthdate", post = "set_birthdate" },
	endpoint "/v1/description" { get = "description", post = "set_description" },
	endpoint "/v1/gender" { get = "gender", post = "set_gender" },
	endpoint "/v1/xbox-live/consecutive-login-days" { get = "consecutive_login_days_for_xbox" },
	endpoint "/v1/metadata" { get = "account_information_metadata" },

	-- Badges v1
	endpoint "/v1/badges/{badgeId}" { get = "badge_from_id", patch = "update_badge" },
	endpoint "/v1/badges/metadata" { get = "badges_metadata" },
	endpoint "/v1/universes/{universeId}/badges" { get = "badges_in_universe", post = "create_badge" },
	endpoint "/v1/universes/{universeId}/free-badges-quota" { get = "free_badge_quota" },
	endpoint "/v1/users/{userId}/badges" { get = "badges_of_user" },
	endpoint "/v1/badges/{badgeId}/icon" { post = "set_badge_icon" },
	-- endpoint "/v1/users/{userId}/badges/{badgeId}/awarded-date" { get = "badge_awarded_timestamp" },
	endpoint "/v1/users/{userId}/badges/awarded-dates" { get = "badge_awarded_timestamps" },
	endpoint "/v1/user/{userId}/badges/{badgeId}" { delete = "remove_badge_from_user" },
	endpoint "/v1/user/badges/{badgeId}" { delete = "remove_badge" },

	-- Catalog v1
	endpoint "/v1/assets/{assetId}/bundles" { get = "bundles_of_asset" },

	-- Catalog v2
	endpoint "/v2/search/items/details" { get = "search_for_items" },

	-- Economy
	endpoint "/v1/user/currency" { get = "robux" },

	-- Games v1
	endpoint "/v1/games" { get = "universes_from_ids" },
	endpoint "/v1/games/games-product-info" { get = "universes_product_info" },
	endpoint "/v1/games/multiget-place-details" { get = "places_from_ids" },
	endpoint "/v1/games/multiget-playability-status" { get = "playability_status_for_universes" },
	endpoint "/v1/games/recommendations/game/{universeId}" { get = "universe_recommendations_from_id" },
	endpoint "/v1/games/{placeId}/private-servers" { get = "private_servers_in_place" },
	endpoint "/v1/games/{placeId}/servers/{serverType}" { get = "servers_in_place" },
	endpoint "/v1/games/{universeId}/favorites" { get = "is_universe_favorite", post = "set_favorite_for_universe" },
	endpoint "/v1/games/{universeId}/favorites/count" { get = "count_universe_favorites" },
	endpoint "/v1/games/{universeId}/game-passes" { get = "gamepasses_in_universe" },
	endpoint "/v1/games/{universeId}/votes/user" { get = "self_vote_for_universe" },
	endpoint "/v1/games/votes" { get = "all_votes_for_universes" },
	endpoint "/v1/games/{universeId}/user-votes" { patch = "set_vote_for_universe" },
	endpoint "/v1/private-servers" { get = "private_servers_from_ids" },
	endpoint "/v1/private-servers/enabled-in-universe/{universeId}" { get = "are_private_servers_enabled" },
	endpoint "/v1/private-servers/my-private-servers" { get = "self_private_servers" },
	endpoint "/v1/vip-server/can-invite/{userId}" { get = "can_invite_to_private_server" },
	endpoint "/v1/vip-servers/{id}" { get = "private_server_from_id", patch = "update_private_server" },
	endpoint "/v1/games/vip-servers/{universeId}" { post = "create_private_server" },
	endpoint "/v1/vip-servers/{id}/permissions" { patch = "update_private_server_permissions" },
	endpoint "/v1/vip-servers/{id}/subscription" { patch = "update_private_server_subscription" },
	endpoint "/v1/vip-servers/{id}/voicesettings" { patch = "update_private_server_voice_settings" },

	-- Games v2
	endpoint "/v2/games/{universeId}/media" { get = "media_for_universe" },
	endpoint "/v2/groups/{groupId}/games" { get = "universes_by_group" },
	endpoint "/v2/users/{userId}/favorite/games" { get = "favorite_universes" },
	endpoint "/v2/users/{userId}/games" { get = "universes_by_user" },

	-- Inventory v1
	endpoint "/v1/users/{userId}/assets/collectibles" { get = "collectibles_of_user" },
	endpoint "/v1/users/{userId}/can-view-inventory" { get = "can_view_inventory" },
	-- endpoint "/v1/users/{userId}/items/{itemType}/{itemTargetId}" { get = "inventory_of_user" },
	endpoint "/v1/users/{userId}/items/{itemType}/{itemTargetId}/is-owned" { get = "user_owns_item" },
	-- endpoint "/v1/users/{userId}/places/inventory" { get = "places_in_inventory_of_user" },

	-- Inventory v2
	endpoint "/v2/users/{userId}/inventory" { get = "inventory_of_user" },

	-- Presence v1
	endpoint "/v1/presence/users" { post = "get_user_presences" },

	-- Users v1
	endpoint "/v1/display-names/validate" { get = "validate_display_name" },
	endpoint "/v1/users/{userId}/display-names/validate" { get = "validate_display_name_for_user" },
	endpoint "/v1/users/{userId}/display-names" { patch = "set_display_name" },
	endpoint "/v1/users/{userId}" { get = "user_from_id" },
	endpoint "/v1/users/authenticated" { get = "self" },
	endpoint "/v1/users/authenticated/age-bracket" { get = "age_bracket" },
	endpoint "/v1/users/authenticated/country-code" { get = "country_code" },
	endpoint "/v1/users/authenticated/roles" { get = "public_roles" },
	endpoint "/v1/usernames/users" { post = "users_from_names" },
	endpoint "/v1/users" { post = "users_from_ids" },
	endpoint "/v1/users/{userId}/username-history" { get = "username_history" },
	endpoint "/v1/users/search" { get = "search_for_users" },

	-- Thumbnails
	endpoint "/v1/batch" { post = "thumbnails" },

	-- Badges (Cloud)
	endpoint "/legacy-badges/v1/badges/{badgeId}" { patch = "update_badge" },
	endpoint "/legacy-badges/v1/universes/{universeId}/badges" { post = "create_badge" },

	-- Data Stores (Cloud)
	endpoint "/cloud/v2/universes/{universe_id}/data-stores" { get = "list_data_stores" },
	endpoint "/cloud/v2/universes/{universe_id}/data-stores/{data_store_id}/entries" { get = "list_data_store_entries" },

	-- Generative AI (Cloud)
	endpoint "/cloud/v2/universes/{universe_id}:generateSpeech" { post = "generate_speech" },

	-- Universes (Cloud)
	endpoint "/cloud/v2/universes/{universe_id}:publishMessage" { post = "publish_message" },
	endpoint "/cloud/v2/universes/{universe_id}:restartServers" { post = "restart_servers" },
} :: { Mapping }
