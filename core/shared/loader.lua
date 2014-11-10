local oopWrapperCode = ''
local normalWrappercode = ''

local files = {
	shared = {
		--[["shared/classlib.lua",]]
	};
	server = {
		--"server/oopinclude/oopwrapper.lua",
		"server/includes/nonoop/Player.lua",
	};
	client = {
	
	};
}

local oopfiles = {
	shared = {
		--[["shared/classlib.lua",]]
	};
	server = {
		--"server/oopinclude/oopwrapper.lua",
		"server/includes/oop/Player.lua",
	};
	client = {
	
	};
}

for type, paths in pairs(files) do
	if (triggerClientEvent and type == "server") or (triggerServerEvent and type == "client") or type == "shared" then
		for k, path in pairs(paths) do
			outputDebugString("Lade Wrapper: "..path)
			local fileHandle = fileOpen(path)
			local content = fileRead(fileHandle, fileGetSize(fileHandle))
			normalWrappercode = normalWrappercode.."\n"..content
			fileClose(fileHandle)
		end
	end
end

for type, paths in pairs(oopfiles) do
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

function getWrapperCode(oop)
	return oop and oopWrapperCode or normalWrappercode
end