local oopWrapperCode = ''
local normalWrappercode = ''

local files = {
	shared = {
		--[["shared/classlib.lua",]]
	};
	server = {
		--"server/oopinclude/oopwrapper.lua",
		{false, "server/includes/nonoop/Player.lua"},
		{true, "server/includes/oop/Player.lua"},
	};
	client = {
	
	};
}


for typ, paths in pairs(files) do
	if((SERVER and typ == "server") or (not SERVER and typ == "client") or typ == "shared") then
		for _, path in pairs(paths) do
			
			if(DEBUG) then
				outputDebugString(("Lade %s Code: %s"):format((path[1] and "OOP" or ''), path[2]))
			end
			
			local file = fileOpen(path[2])
			local content = fileRead(file, fileGetSize(file))
			fileClose(file)
			
			if(path[1]) then
				oopWrapperCode = ("%s\n%s"):format(oopWrapperCode, content)
			else
				normalWrappercode = ("%s\n%s"):format(normalWrappercode, content)
			end
		end
	end
end

function getWrapperCode(oop)
	return (oop and oopWrapperCode or normalWrappercode)
end