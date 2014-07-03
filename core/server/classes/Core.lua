Core = inherit(Singleton)

function Core:constructor()
	-- Initialize managers
	GamemodeManager:new()
	
end

function Core:destructor()
	-- Release managers
	delete(GamemodeManager:getSingleton())
	
end