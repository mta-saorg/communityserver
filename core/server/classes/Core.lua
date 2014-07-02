Core = inherit(Singleton)

function Core:constructor()
	RPC:new();
	Database:new('127.0.0.1', 'root', '', 'luxrp');
	
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

