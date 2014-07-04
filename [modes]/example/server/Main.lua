function onPlayerJoinLobby(player)
	outputChatBox("DEBUG - onPlayerJoinLobby")
	
	player:setInfo("myKey", "myValue")
	outputChatBox(player:getInfo("myKey"))
end

function onPlayerQuitLobby(player)
	outputChatBox("DEBUG - onPlayerQuitLobby")
end