local oopWrapperCode = ""

local files = {
	shared = {
		--[["shared/classlib.lua",]]
	};
	server = {
		"serce/oopinclude/oopwrapper.lua",
	};
	client = {
	
	};
}

for type, paths in ipairs(files) do
	if (triggerClientEvent and type == "server") or (triggerServerEvent and type == "client") or type == "shared" then
		local fileHandle = fileOpen(path)
		local content = fileRead(fileHandle, fileGetSize(fileHandle))
		oopWrapperCode = oopWrapperCode.."\r\n"..content
		fileClose(fileHandle)
	end
end

function getOOPWrapperCode()
	return oopWrapperCode
end