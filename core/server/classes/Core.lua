Core = inherit(Singleton)

function Core:constructor()
	RPC:new()
	--sql = Database:new("127.0.0.1", "root", "", "luxrp", 3306)
	
	-- Initialize managers
	GamemodeManager:new()
	PermissionManager:new()
	PlayerManager:new()
	
	--Tests:
	local permHandle = PermissionManager:getSingleton()
	permHandle:createGroup("Full Administrator")
	permHandle:createGroup("Administrator")
	permHandle:createGroup("Moderator")
	permHandle:createGroup("Supporter")
	permHandle:createGroup("Spieler")
	permHandle:addPermissionToGroup("Administrator", "*")
	PermissionManager:getSingleton():createGroup("Administrator")
	PermissionManager:getSingleton():createGroup("Spieler")
	PermissionManager:getSingleton():addPermission("*")
	PermissionManager:getSingleton():addPermissionToGroup("Administrator", "*")
end

function Core:destructor()
	-- Release managers
	delete(GamemodeManager:getSingleton())
	delete(PlayerManager:getSingleton())
	delete(PermissionManager:getSingleton())
	
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