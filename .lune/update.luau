local net = require("@lune/net")
local fs = require("@lune/fs")

local DEFINITION_URL =
	"https://raw.githubusercontent.com/Roblox/creator-docs/refs/heads/main/content/en-us/reference/cloud/openapi.json"

local response = net.request(DEFINITION_URL)
if response.ok then
	fs.writeFile("json/openapi.json", response.body)
else
	error("Failed to fetch the Open API definition")
end
