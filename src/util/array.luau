local function array_map<T, U>(input: { T }, processor: (T) -> U): { U }
	local output = table.create(#input)
	for i = 1, #input do
		local v = processor(input[i])
		output[i] = v
	end
	return output
end

return {
	map = array_map,
}
