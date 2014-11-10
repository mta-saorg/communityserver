Core = inherit(Singleton)

function Core:constructor()
	if DEBUG then
		Debugging:new()
	end
	LobbyForm:new()
	Account:new()
	
	triggerServerEvent("onPlayerDownloadComplete", resourceRoot)
end

function Core:destructor()
	if DEBUG then
		delete(Debugging:getSingleton())
	end
end
