PlayerManager = inherit(Singleton)

function PlayerManager:constructor()
	self.m_Players = {}
	self.m_fPlayerWasted = bind(self.Event_onPlayerWasted, self)
end

function PlayerManager:addPlayer(player)
	if not self.m_Players[player] then
		self.m_Players[player] = true
	end
	
	-- ToDo: Spawnposition suchen
	spawnPlayer(player, -2405, -598, 132.65, 0, 244)
	giveWeapon(player, 10, 1, true)
	addEventHandler("onPlayerWasted", player, self.m_fPlayerWasted)
end

function PlayerManager:removePlayer(player) 
	if self.m_Players[player] then
		self.m_Players[player] = nil
	end	
	
	removeEventHandler("onPlayerWasted", player, self.m_fPlayerWasted)
end

function PlayerManager:Event_onPlayerWasted()
	spawnPlayer(source, -2405, -598, 132.65, 0, 244)
	giveWeapon(source, 10, 1, true)
end