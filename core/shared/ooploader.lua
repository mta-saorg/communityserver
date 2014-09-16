local oopWrapperCode = ""

local files = {
	shared = {
		--[["shared/classlib.lua",]]
	};
	server = {
		--"server/oopinclude/oopwrapper.lua",
		"server/oopinclude/Player.lua",
	};
	client = {
	
	};
}

for type, paths in pairs(files) do
	if (triggerClientEvent and type == "server") or (triggerServerEvent and type == "client") or type == "shared" then
		for k, path in pairs(paths) do
			outputDebugString("Lade OOP Wrapper: "..path)
			local fileHandle = fileOpen(path)
			local content = fileRead(fileHandle, fileGetSize(fileHandle))
			oopWrapperCode = oopWrapperCode.."\n"..content
			fileClose(fileHandle)
		end
	end
end

function getOOPWrapperCode()
	return oopWrapperCode
end