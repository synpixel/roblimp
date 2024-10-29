local users = require("./users")
local avatar = require("./avatar")
local trades = require("./trades")
local presence = require("./presence")
local privatemessages = require("./privatemessages")
local chat = require("./chat")
local friends = require("./friends")
local accountsettings = require("./accountsettings")
local groups = require("./groups")
local badges = require("./badges")
local games = require("./games")
local economy = require("./economy")
local followings = require("./followings")
local develop = require("./develop")

return {
	users = users,
	avatar = avatar,
	trades = trades,
	presence = presence,
	privatemessages = privatemessages,
	chat = chat,
	friends = friends,
	accountsettings = accountsettings,
	groups = groups,
	badges = badges,
	games = games,
	economy = economy,
	followings = followings,
	develop = develop,
}
