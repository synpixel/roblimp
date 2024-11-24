# Roblimp

An auto-generated wrapper around Roblox's API.

## Installation

### pesde

```sh
pesde add synpixel/roblimp
```

## Quick Start

```luau
local roblox = require("@lune/roblox")
local roblimp = require("@pkg/roblimp")

local COOKIE = assert(roblox.getAuthCookie(true))

local you = roblimp.users.authenticated(COOKIE):unwrap()
print(`name: {you.name}`)

local details = roblimp.users.get(you.id):unwrap()
print(`bio: "{details.description}"`)
print(`join date: {details.created}`)
print(`verified: {details.hasVerifiedBadge}`)
```
