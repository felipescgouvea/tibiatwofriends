local bosses = {
	['ushuriel'] = 200,
	['zugurosh'] = 201,
	['madareth'] = 202,
	['latrivan'] = 203,
	['golgordan'] = 203,
	['annihilon'] = 204,
	['hellgorak'] = 205
}

function onKill(player, target)
	local targetMonster = target:getMonster()
	if not targetMonster then
		return true
	end

	local targetName = targetMonster:getName():lower()
	local bossStorage = bosses[targetName]
	if not bossStorage then
		return true
	end

	local newValue = 2
	if targetName == 'latrivan' or targetName == 'golgordan' then
		local currentValue = 0
		if Game.getStorageValue(bossStorage) then
			currentValue = Game.getStorageValue(bossStorage)
		end
		
		newValue = math.max(0, currentValue) + 1
	end
	Game.setStorageValue(bossStorage, newValue)

	if newValue >= 2 then
		player:say('You now have 3 minutes to exit this room through the teleporter. It will bring you to the next room.', TALKTYPE_MONSTER_SAY)
		addEvent(Game.setStorageValue, 3 * 60 * 1000, bossStorage, 0)
	end
	return true
end