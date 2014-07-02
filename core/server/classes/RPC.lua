RPC = inherit(Singleton)

function RPC:constructor()
	self.tFunctions = {};
	
	addEvent('onClientRPC', true);
	addEventHandler('onClientRPC', resourceRoot, bind(RPC.handleRequests, self));
end

function RPC:destructor()

end

function RPC:registerFunction(funcname, callback)
	assert(type(funcname) == 'string', 'Argument provided to funcname is not a string');
	assert(type(callback) == 'function', 'Argument provided to callback is not a function');
	assert(_G[callback], 'Callback is not declared');
	
	if(not self.tFunctions[funcname]) then
		self.tFunctions[funcname] = callback;
	end	
end

function RPC:removeFunction(funcname)
	assert(type(funcname) == 'string', 'Argument provided to funcname is not a string');
	
	if(self.tFunctions[funcname]) then
		self.tFunctions[funcname] = nil;
	end
end

function RPC:handleRequests(data)
	assert(type(data) == 'table', 'Bad data provided');
	
	if(#data >= 1) then
		local funcname = data[1];
		
		if(self.tFunctions[funcname]) then
			local tmp = {};
			
			for index, arg in pairs(data) do
				if(index ~= 1) then
					tmp[index - 1] = arg;
				end
			end
			
			self.tFunctions[funcname](unpack(tmp));
		end
	end
end

function RPC:callFunction(funcname, ...)
	assert(type(funcname) == 'string', 'Bad Argument provied to funcname');
	if(self.tFunctions[funcname]) then
		self.tFunctions[funcname](...);
	end
end

function RPC:send(player, funcname, ...)
	assert(getElementType(player) == 'player');
	assert(type(funcname) == 'string');

	local tmp = {};
	tmp[1] = funcname;
	if(#{...} >= 1) then
		for index, arg in pairs({...}) do
			tmp[index + 1] = arg;
		end
	end
	
	triggerClientEvent(player, 'onServerRPC', resourceRoot, tmp);
end

