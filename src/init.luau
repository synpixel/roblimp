local catalog = require("./catalog")
local avatar = require("./avatar")
local premiumfeatures = require("./premiumfeatures")
local presence = require("./presence")
local chat = require("./chat")
local trades = require("./trades")
local accountsettings = require("./accountsettings")
local groups = require("./groups")
local economy = require("./economy")
local privatemessages = require("./privatemessages")
local develop = require("./develop")
local friends = require("./friends")
local badges = require("./badges")
local notifications = require("./notifications")
local users = require("./users")
local games = require("./games")
local followings = require("./followings")

return {
	catalog = catalog,
	avatar = avatar,
	premiumfeatures = premiumfeatures,
	presence = presence,
	chat = chat,
	trades = trades,
	accountsettings = accountsettings,
	groups = groups,
	economy = economy,
	privatemessages = privatemessages,
	develop = develop,
	friends = friends,
	badges = badges,
	notifications = notifications,
	users = users,
	games = games,
	followings = followings,
}
