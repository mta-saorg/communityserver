Core = inherit(Singleton)

function Core:constructor()
	-- Initialize managers
	PlayerManager:new()
	
end

function Core:destructor()
	-- Release managers
	delete(PlayerManager:getSingleton())
	
end