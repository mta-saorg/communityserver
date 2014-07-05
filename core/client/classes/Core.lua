Core = inherit(Singleton)

function Core:constructor()
	if DEBUG then
		Debugging:new()
	end
	LobbyForm:new()
end

function Core:destructor()
	delete(RPC:getSingleton())
	
	if DEBUG then
		delete(Debugging:getSingleton())
	end
end
