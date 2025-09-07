local function dictionary_map<K, VI, VO>(input: { [K]: VI }, processor: (VI, K) -> (VO, K?)): { [K]: VO }
	local output = {}

	for k, v in input do
		local new_v, new_k = processor(v, k)
		if new_k then
			output[new_k] = new_v
		else
			output[k] = new_v
		end
	end

	return output
end

return {
	map = dictionary_map,
}
