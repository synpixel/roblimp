# Roblimp

Auto-generated wrapper around Roblox's legacy and cloud APIs

## Motivation

Roblox API wrappers are often abstracted and while that may be what some people are looking for, it wasn't what I wanted. I wanted a simple wrapper with minimal abstraction while keeping type safety and error handling. Roblimp generates Luau code from Roblox's OpenAPI definition to achieve that goal, and I think it does it pretty well. Mappings are written manually and contributions are more than welcome.

## Installation

### pesde

```sh
pesde add synpixel/roblimp
```

## Usage

### roblimp

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
