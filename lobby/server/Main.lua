function onPlayerJoinLobby(player)
	
	outputChatBox(("DEBUG: onPlayerJoinLobby (Resource: %s)"):format(getResourceName(getThisResource())))
	
	-- Tests
	--[[
	local players = getPlayers()
	if players then
		for player in pairs(players) do
			outputChatBox(getPlayerName(player))
		end
	end
	]]
end

function onPlayerQuitLobby(player)
	outputChatBox(("DEBUG: onPlayerQuitLobby (Resource: %s)"):format(getResourceName(getThisResource())))
end