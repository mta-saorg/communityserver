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
	
end

function Gamemode:destructor()
	
end

function Gamemode:getPlayers()
	return self.m_Players
end

function Gamemode:addPlayer(player)
	if not self.m_Players[player] then
		self.m_Players[player] = {}
	end
	
	player:setGamemode(self)
	outputChatBox(getPlayerName(player) .. " joined the gamemode ( " .. self.m_Name .. " ) ")
	-- ToDo: trigger the event "onPlayerJoinGamemode"
end

function Gamemode:removePlayer(player)
	if self.m_Players[player] then
		self.m_Players[player] = nil
	end
	
	outputChatBox(getPlayerName(player) .. " left the gamemode ( " .. self.m_Name .. " ) ")
	-- ToDo: trigger the event "onPlayerQuitGamemode"
end