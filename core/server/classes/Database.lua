Database = inherit(Singleton);

function Database:constructor(host, user, pass, database, port)
	assert(type(host) == 'string');
	assert(type(user) == 'string');
	assert(type(pass) == 'string');
	assert(type(database) == 'string');
	
	self.cConnection = dbConnect('mysql', ('dbname=%s;host=%s;port=%d'):format(database, host, (type(port) == 'number' and port or 3306)), user, pass);
end

function Database:destructor()

end

function Database:query(query, ...)
	assert(type(query) == 'string');

	if(self:isConnected()) then
		query = dbQuery(self.cConnection, query, ...);
		local result = dbPoll(query, -1);
		
		if(not result and result == nil) then
			dbFree(query);
			return false;
		end
		
		return result;
	end
	
	return false;
end

function Database:queryEx(query, ...)
	assert(type(query) == 'string');
	
	if(self:isConnected()) then
		return dbExec(self.cConnection, query, ...);
	end
	
	return false;
end

function Database:isConnected()
	return (self.cConnection and true or false);
end