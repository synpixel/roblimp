local users = require("./users")
local trades = require("./trades")
local avatar = require("./avatar")
local privatemessages = require("./privatemessages")
local presence = require("./presence")
local games = require("./games")
local chat = require("./chat")
local friends = require("./friends")
local accountsettings = require("./accountsettings")
local groups = require("./groups")
local badges = require("./badges")
local notifications = require("./notifications")
local economy = require("./economy")
local followings = require("./followings")
local develop = require("./develop")

return {
	users = users,
	trades = trades,
	avatar = avatar,
	privatemessages = privatemessages,
	presence = presence,
	games = games,
	chat = chat,
	friends = friends,
	accountsettings = accountsettings,
	groups = groups,
	badges = badges,
	notifications = notifications,
	economy = economy,
	followings = followings,
	develop = develop,
}
