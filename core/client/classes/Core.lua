Core = inherit(Singleton)

function Core:constructor()
	RPC:new()
	if DEBUG then
		Debugging:new()
	end
end

function Core:destructor()
	delete(RPC:getSingleton())
	
	if DEBUG then
		delete(Debugging:getSingleton())
	end
end
