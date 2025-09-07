# Roblimp

An auto-generated wrapper around Roblox's legacy and cloud APIs

## Installation

### pesde

```sh
pesde add synpixel/roblimp
```

## Usage

### Legacy

```luau
local client = roblimp.legacy(COOKIE)

local self = client:self():unwrap()
print(`my name's {self.name}`)

local builderman = client:user_from_id(156):unwrap()
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
