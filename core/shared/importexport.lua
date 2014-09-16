function export(class, funcname)
	assert(class, "Invalid class passed to export")
	_G["export_"..funcname] = function(...) return class[funcname](...) end
end

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
