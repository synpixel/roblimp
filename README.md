# Roblimp

An auto-generated wrapper around Roblox's API.

## Quick Start

```luau
local roblox = require("@lune/roblox")
local roblimp = require("@pkg/roblimp")

local COOKIE = assert(roblox.getAuthCookie(true))

local user = roblimp.users.authenticated(COOKIE):unwrap()
print(`logged in on @{user.name}`)

local memberships = roblimp.groups
	.rolesOf({
		userId = user.id,
		includeLocked = true,
		includeNotificationPreferences = false,
	})
	:unwrap()

print(`you're a member of {#memberships} groups`)
```
