function getGamemodeInfo()
	return {
		Name = "Default Gamemode",
		MaxPlayer = 99,
		MinPlayer = 1
	}
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

core = import("core")

-- HACK, um OOP während der Laufzeit nachzuladen
loadstring(exports.core:getOOPWrapperCode())()