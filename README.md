# Roblimp

Auto-generated wrapper around Roblox's legacy and cloud APIs

## Why

Roblimp is an API wrapper with very minimal abstraction that keeps simplicity, type safety and error handling. The tool generates Luau code from Roblox's OpenAPI definition, mappings are written manually and contributions are more than welcome.

## Installation

### pesde

```sh
pesde add synpixel/roblimp
```

## Usage

### Legacy

```luau
local client = roblimp.legacy(COOKIE)

local me = client:me():unwrap()
print(`my name's {me.name}`)

local builderman = client:user(156):unwrap()
print(`{builderman.name} joined on {builderman.created}`)
```

### Cloud

```luau
local client = roblimp.cloud(API_KEY)
local universe_id = "..."

client
	:publish_message {
		universe_id = universe_id,
		topic = "announcement",
		message = "hello, world!",
	}
	:unwrap()
```
