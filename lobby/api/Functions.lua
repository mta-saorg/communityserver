

function registerGamemode(info)
	local coreRes  = getResourceFromName('core')
	local thisRes  = getResourceName(getThisResource()) 
	if(coreRes and getResourceState(coreRes) == 'running') then
		--call(coreRes, 'registerGamemode', info)
	else
		outputServerLog(('[%s]: Failed to register Gamemode'):format(thisRes));
	end	
end

function unregisterGamemode()
	local coreRes  = getResourceFromName('core')
	local thisRes  = getResourceName(getThisResource()) 
	if(coreRes and getResourceState(coreRes) == 'running') then
		--call(coreRes, 'unregisterGamemode')
	else
		outputServerLog(('[%s]: Failed to unregister Gamemode'):format(thisRes));
	end
end