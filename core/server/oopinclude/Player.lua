function Player:getInfo(key)
	return core:getPlayerInfo(self, key)
end

function Player:setInfo(key, value)
	core:setPlayerInfo(self, key, value)
end