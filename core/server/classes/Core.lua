Core = inherit(Singleton)

function Core:constructor()
	RPC:new();
	Database:new('host', 'user', 'pass', 'database', port);
	
	if(Database:getSingleton():isConnected()) then
		outputDebugString('Successfully connected to MySQL Server');
	else
		outputDebugString('Couldnt connect to MySQL Server.');
	end
end

function Core:destructor()
	delete(RPC:getSingleton());
	delete(Database:getSingleton());
end

