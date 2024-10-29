local runtime = if string.sub(string.lower(_VERSION), 1, 5) == "lune "
	then "lune"
	elseif typeof(script) == "Instance" then "roblox"
	else "unknown"

local function unknownImpl()
	error("unknown runtime")
end

return table.freeze({
	runtime = runtime,
	unknownImpl = unknownImpl,
})
