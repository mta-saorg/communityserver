Core = inherit(Singleton)

function Core:constructor()
	RPC = RPC:new();
end

function Core:destructor()

end
