Database = inherit(Object)

function Database:constructor(host, user, pass, database, port)
	assert(type(host) == "string" and type(user) == "string" and type(pass) == "string" and type(database) == "string", "Bad argument @ Database.constructor")
	self.m_DbHandle = Connection("mysql", ("dbname=%s;host=%s;port=%d"):format(database, host, tonumber(port) or 3306), user, pass)
	if not self.m_DbHandle then
		outputServerLog("Could not establish a connection to the database. Stopping resource...")
		stopResource(getThisResource())
	end
end

function Database:destructor()
	if self.m_DbHandle then
		destroyElement(self.m_DbHandle)
	end
end

function Database:queryFetch(query, ...)
	local queryHandle = self.m_DbHandle:query(query, ...)
	local result, rtn2, rtn3 = queryHandle:poll(-1)
	
	if result == false then
		outputDebugString(("Database error: Errorcode: %d, Errormessage: %s"):format(rtn2, rtn3))
		return false
	end
	
	return result, rtn2, rtn3 -- result, affectedRows, lastInstertId
end

function Database:queryExec(query, ...)
	return self.m_DbHandle:exec(query, ...)
end

function Database:isConnected()
	return self.m_DbHandle ~= false
end
