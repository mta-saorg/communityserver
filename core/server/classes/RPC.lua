RPC = inherit(Singleton)

function RPC:constructor()
	self.m_Functions = {}
	
	addEvent('onClientRPC', true)
	addEventHandler('onClientRPC', resourceRoot, bind(RPC.handleRequests, self))
end

function RPC:destructor()

end

function RPC:registerFunction(funcname, callback)
	assert(type(funcname) == 'string' and type(callback) == 'function', 'Bad Argument @RPC.registerFunction')
	
	if not self.m_Functions[funcname] then
		self.m_Functions[funcname] = callback
	end	
end

function RPC:removeFunction(funcname)
	assert(type(funcname) == 'string', 'Bad Argument @RPC.removeFunction')
	
	if self.m_Functions[funcname] then
		self.m_Functions[funcname] = nil
	end
end

function RPC:handleRequests(data)
	assert(type(data) == 'table', 'Bad Argument @RPC.handleRequests')
	
	if(#data >= 1) then
		local funcname = data[1]
		
		if self.m_Functions[funcname] then
			local tmp = {}
			
			for index, arg in pairs(data) do
				if index ~= 1 then
					tmp[index - 1] = arg
				end
			end
			
			self.m_Functions[funcname](unpack(tmp))
		end
	end
end

function RPC:callFunction(funcname, ...)
	assert(type(funcname) == 'string', 'Bad Argument @RPC.callFunction')
	if self.m_Functions[funcname] then
		self.m_Functions[funcname](...)
	end
end

function RPC:send(player, funcname, ...)
	assert(getElementType(player) == 'player' and type(funcname) == 'string', 'Bad Argument @RPC.send')
	
	if self.m_Functions[funcname] then
		local tmp = {}
		tmp[1] = funcname
		if #{...} >= 1 then
			for index, arg in pairs({...}) do
				tmp[index + 1] = arg
			end
		end
		
		triggerClientEvent(player, 'onServerRPC', resourceRoot, tmp)
	end
end

