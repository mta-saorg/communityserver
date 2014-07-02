Core = inherit(Singleton)

function Core:constructor()
	RPC:new()
	sql = Database:new('host', 'user', 'pass', 'database', port)
end

function Core:destructor()
	delete(RPC:getSingleton())
	delete(Database:getSingleton())
end

