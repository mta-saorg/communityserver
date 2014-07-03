Gamemode = inherit(Object)

function Gamemode:constructor(resource, bNeededProperties)
	if bNeededProperties then
		-- take over the gamemode's properties
		local info = exports[resource]:getGamemodeInfo()
		for key, value in pairs(info) do 
			self["m_"..key] = value
		end
		
	else
		-- emergency/default properties
		self.m_Name = "None"
		self.m_MaxPlayer = -1
		self.m_MinPlayer = -1
		
	end
	
	-- member variables
	self.m_Resource = resource
	self.m_Players = {}
	self.m_PlayerCount = 0
	
end

function Gamemode:destructor()
	
end

function Gamemode:getName()
	return self.m_Name
end

function Gamemode:getResource()
	return getResourceRootElement(self.m_Resource)
end

function Gamemode:getMaxPlayer()
	return self.m_MaxPlayer
end

function Gamemode:getPlayers()
	return self.m_Players
end

function Gamemode:getPlayerCounter()
	return self.m_PlayerCount
end

function Gamemode:addPlayer(player)
	if not self.m_Players[player] then
		self.m_Players[player] = {}
		self.m_PlayerCount = self.m_PlayerCount + 1
	end
	
	if self:getMaxPlayer() < self:getPlayerCounter() then
		player:setGamemode(self)
		self:broadcastMessage(('[Lobby]: %s has joined Lobby %s! (%d / %d)'):format(player:getName(), self.m_Name, self:getPlayerCounter(), self:getMaxPlayer()))
		-- ToDo: trigger the event "onPlayerJoinGamemode"
		triggerEvent('onPlayerJoinGamemode', self:getResource(), player)
		return true
	end
	
	return false
end

function Gamemode:broadcastMessage(msg, r, g, b, colorcoded)
	for player in pairs(self:getPlayers()) do
		outputChatBox(msg, player, r, g, b, colorcoded)
	end
end

function Gamemode:removePlayer(player)
	if self.m_Players[player] then
		self.m_Players[player] = nil
		self.m_PlayerCount = self.m_PlayerCount - 1
	end
	
	self:broadcastMessage(('[Lobby]: %s has lefted the Lobby!'):format(player:getName()))
	-- ToDo: trigger the event "onPlayerQuitGamemode"
end