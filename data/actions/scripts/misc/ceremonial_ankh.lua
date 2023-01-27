local blessings = {
	{ key = 101, value = 1, name = 'Wisdom of Solitude' },
	{ key = 102, value = 1, name = 'Spark of the Phoenix' },
	{ key = 103, value = 3, name = 'Fire of the Suns' },
	{ key = 104, value = 1, name = 'Spiritual Shielding' },
	{ key = 105, value = 1, name = 'Embrace of Tibia' }
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local result, bless = 'Received blessings:'
	local countBlessGiven = 0
	for i = 1, #blessings do
		bless = blessings[i]
		if player:getStorageValue(bless.key) == 0 then
			player:setStorageValue(bless.key, bless.value)
			player:addBlessing(bless.value)
			countBlessGiven = countBlessGiven + 1
			result = result .. '\n' .. bless.name
		end
	end

	if countBlessGiven > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, result)
		item:remove()
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'No blessings received.')
	end
	return true
end