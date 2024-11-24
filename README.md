# Roblimp

An auto-generated API wrapper for Roblox.

## Quick Start

```luau
local roblimp = require("@pkg/roblimp")

local user = roblimp.users.authenticated(COOKIE):unwrap()
local robux = roblimp.economy.robux(COOKIE):unwrap()

print(`@{user.name} has {robux} robux`)
```
