local inventory = require("./inventory")
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

--- @class roblimp

--- @prop inventory inventory
--- @within roblimp

--- @prop catalog catalog
--- @within roblimp

--- @prop avatar avatar
--- @within roblimp

--- @prop premiumfeatures premiumfeatures
--- @within roblimp

--- @prop presence presence
--- @within roblimp

--- @prop chat chat
--- @within roblimp

--- @prop trades trades
--- @within roblimp

--- @prop accountsettings accountsettings
--- @within roblimp

--- @prop groups groups
--- @within roblimp

--- @prop economy economy
--- @within roblimp

--- @prop privatemessages privatemessages
--- @within roblimp

--- @prop develop develop
--- @within roblimp

--- @prop friends friends
--- @within roblimp

--- @prop badges badges
--- @within roblimp

--- @prop notifications notifications
--- @within roblimp

--- @prop users users
--- @within roblimp

--- @prop games games
--- @within roblimp

--- @prop followings followings
--- @within roblimp

return {
	inventory = inventory,
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
