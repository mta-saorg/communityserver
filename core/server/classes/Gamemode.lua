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
		self.m_Desc = ""
		self.m_MaxPlayer = getMaxPlayers()
		self.m_MinPlayer = -1
		
	end
	
	-- member variables
	self.m_Resource = resource
	self.m_Players = {}
	self.m_PlayerCount = 0
	
end

function Gamemode:destructor()
	
end

function Gamemode:setInfo(key, val)
	if(type(key) == "string" and self["m_"..key]) then
		self["m_"..key] = val
	end
end

function Gamemode:getInfo(arg)
	if(type(arg) == 'string' and self["m_"..arg]) then
		return self["m_"..arg]
	end
	return {
		Name = self.m_Name,
		Desc = self.m_Desc,
		maxPlayer = self.m_MaxPlayer,
	}
end

function Gamemode:getResource()
	return self.m_Resource
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
	
	if self:getPlayerCounter() < self:getMaxPlayer() then
		player:setGamemode(self)
		self:broadcastMessage(("#0678ee[Lobby]: #d9d9d9%s #d9d9d9has joined Lobby \"#0678ee%s#d9d9d9\"! (%d/%d)"):format(player:getName(), self.m_Name, self:getPlayerCounter(), self:getMaxPlayer()), 0, 0, 0, true)

		if getResourceName(self:getResource()) ~= "core" then
			call(self:getResource(), "onPlayerJoinLobby", player)
		end
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
		
		self:broadcastMessage(("#0678ee[Lobby]: #d9d9d9%s #d9d9d9left the Lobby!"):format(player:getName()), 0, 0, 0, true)
		if getResourceName(self:getResource()) ~= "core" then
			call(self:getResource(), "onPlayerQuitLobby", player)
		end
	end
end