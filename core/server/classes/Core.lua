Core = inherit(Singleton)

function Core:constructor()
	RPC:new();
	Database:new('host', 'user', 'pass', 'database', port);
	
	if(Database:getSingleton():isConnected()) then
		outputDebugString('Successfully connected to MySQL Server');
	else
		outputDebugString('Couldnt connect to MySQL Server.');
	end
end

function Core:destructor()
	delete(RPC:getSingleton());
	delete(Database:getSingleton());
end

function Core:registerGamemode(resource)
	self.m_Gamemodes[resource] = call(resource, "getGamemodeInfo")
end

function Core:unregisterGamemode(resource)
	local gm = self.m_Gamemodes[resource]
	
	for k, v in pairs(gm.players) do 
		gm:removePlayer(v)
		self:getLobby():addPlayer(v)
	end
	
	self.m_Gamemodes[resource] = nil
end

function Core:setPlayerInfo(player, key, value)
	player:setInfo(self.m_Gamemodes[sourceResource].sqlName, key, value)
end

function Core:getPlayerInfo(player, key)
	player:getInfo(self.m_Gamemodes[sourceResource].sqlName, key)
end

export(Core, "setPlayerInfo")
export(Core, "getPlayerInfo")