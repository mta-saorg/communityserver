Core = inherit(Singleton)

function Core:constructor()
	RPC:new();
end

function Core:destructor()

end
