Core = inherit(Singleton)

function Core:constructor()
	-- Initialize managers
	GamemodeManager:new()
	PlayerManager:new()
	
end

function Core:destructor()
	-- Release managers
	delete(GamemodeManager:getSingleton())
	delete(PlayerManager:getSingleton())
	
end