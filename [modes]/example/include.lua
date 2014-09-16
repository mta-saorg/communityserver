function import(resource)
	return 
	setmetatable(
	{ 
		name = resource;
	},
	{
		__index = function(self, k)
			local res = getResourceFromName(self.name)
			local key = k
			assert(getResourceState(res) == "running", "Call to non running resource")
			return function(...) return call(res, "export_"..key, ...) end
		end;
		__newindex = error
	}
	)
end

core = import("core")

-- HACK, um OOP während der Laufzeit nachzuladen
outputChatBox(exports.core:getOOPWrapperCode())
loadstring(exports.core:getOOPWrapperCode())()