function getGamemodeInfo()
	return {
		Name = "Example Gamemode",
		Description = "Ein Beispiel Gamemode",
		MaxPlayer = 32,
		MinPlayer = 1,
		Position = {-2417, -595.4, 131.7},
	}
end

function onPlayerJoinLobby(player)
	outputChatBox("DEBUG - onPlayerJoinLobby")
	
	player:setInfo("myKey", "myValue")
	outputChatBox(player:getInfo("myKey"))
end

function onPlayerQuitLobby(player)
	outputChatBox("DEBUG - onPlayerQuitLobby")
end