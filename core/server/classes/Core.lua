Core = inherit(Singleton)

local lobbyInfo = {
	Name        = 'Freeroam',
	maxPlayers  = -1, -- -1 = unlimited
	minPlayers  = -1, -- -1 = no playerlimit for start
	spawns      = {
		--{x, y, z, rot}
	}
}

function Core:constructor()
	RPC:new()
	sql = Database:new('127.0.0.1', 'root', '', 'luxrp', 3306)
	
	self.m_Lobby = Lobby:new(resourceRoot, lobbyInfo)
end

function Core:destructor()
	delete(RPC:getSingleton())
	delete(sql)
end

function Core:registerGamemode(resource)
	local resName = getResourceName(resource)
	self.m_Gamemodes[resource] = {
		Resource  = resource,
		Info      = call(resource, "getGamemodeInfo")
	}
	self.m_Gamemodes[resource].Lobby = Lobby:new(resource, self.m_Gamemodes[resource].Info)
	outputServerLog(('[Core]: Added Gamemode %s (Resource: %s)'):format(resName, resName))
end

function Core:unregisterGamemode(resource)
	local Lobby  = self.m_Gamemodes[resource].Lobby
	
	for player in pairs(Lobby:getPlayers()) do 
		Lobby:removePlayer(player)
		self:getLobby():addPlayer(player)
	end
	--delete(Lobby)
	self.m_Gamemodes[resource] = nil
end

function Core:getLobby()
	return self.m_Lobby
end

function Core:getLobbyInfo(gamemode, data)
	
end

function Core:setLobbyInfo(gamemode, data, value)

end

function Core:getGamemodeInfo(gamemode, data)

end

function Core:setGamemodeInfo(gamemode, data, value)

end

function Core:setPlayerInfo(player, key, value)
	player:setInfo(self.m_Gamemodes[sourceResource].sqlName, key, value)
end

function Core:getPlayerInfo(player, key)
	player:getInfo(self.m_Gamemodes[sourceResource].sqlName, key)
end

export(Core, "setPlayerInfo")
export(Core, "getPlayerInfo")

export(Core, 'registerGamemode')
export(Core, 'unregisterGamemode')
