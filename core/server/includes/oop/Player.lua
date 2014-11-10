function Player:getInfo(key)
	return core:getPlayerInfo(self, key)
end

function Player:setInfo(key, value)
	core:setPlayerInfo(self, key, value)
end

function Player:getMoney()
	return self:getInfo("Geld")
end

function Player:addMoney(amount)
	self:setInfo("Geld", (tonumber(self:getInfo("Geld")) or 0) + amount)
end

function Player:getPlayerPoints()
	return self:getInfo("Punkte")
end

function Player:addPlayerPoints(amount)
	self:setInfo("Punkte", (tonumber(self:getInfo("Punkte")) or 0) + amount)
end
