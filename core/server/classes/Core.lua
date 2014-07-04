Core = inherit(Singleton)

function Core:constructor()
	-- Initialize managers
	GamemodeManager:new()
	PlayerManager:new()

	RPC:new()
	sql = Database:new("127.0.0.1", "", "", "", 3306)
	
end

function Core:destructor()
	-- Release managers
	delete(GamemodeManager:getSingleton())
	delete(PlayerManager:getSingleton())

	delete(RPC:getSingleton())
	delete(sql)
end

function Core:setPlayerInfo(player, key, value)
	player:setInfo(GamemodeManager:getSingleton():getGamemodes()[sourceResource].sqlName, key, value)
end

function Core:getPlayerInfo(player, key)
	player:getInfo(GamemodeManager:getSingleton():getGamemodes()[sourceResource].sqlName, key)
end

export(Core, "setPlayerInfo")
export(Core, "getPlayerInfo")