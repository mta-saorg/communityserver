Core = inherit(Singleton)

function Core:constructor()
	sql = Database:new(DATABASE_HOST, DATABASE_USER, DATABASE_PASSWORD, DATABASE_NAME)
	
	-- Initialize managers
	GamemodeManager:new()
	PermissionManager:new()
	PlayerManager:new()
	if DEBUG then
		Debugging:new()
	end
	
	--Tests:
	local permHandle = PermissionManager:getSingleton()
	permHandle:createGroup("Full Administrator")
	permHandle:createGroup("Administrator")
	permHandle:createGroup("Moderator")
	permHandle:createGroup("Supporter")
	permHandle:createGroup("Spieler")
	permHandle:addPermissionToGroup("Administrator", "*")
	permHandle:createGroup("Administrator")
	permHandle:createGroup("Spieler")
	permHandle:addPermission("*")
	permHandle:addPermissionToGroup("Administrator", "*")
end

function Core:destructor()
	-- Release managers
	delete(GamemodeManager:getSingleton())
	delete(PlayerManager:getSingleton())
	delete(PermissionManager:getSingleton())
	
	delete(sql)
	
	if DEBUG then
		delete(Debugging:getSingleton())
	end
end

function Core:setPlayerInfo(player, key, value)
	outputChatBox(tostring(player))
	player:setInfo(GamemodeManager:getSingleton():getGamemodes()[sourceResource].sqlName, key, value)
end

function Core:getPlayerInfo(player, key)
	return player:getInfo(GamemodeManager:getSingleton():getGamemodes()[sourceResource].sqlName, key)
end

export(Core, "setPlayerInfo")
export(Core, "getPlayerInfo")
