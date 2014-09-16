function getGamemodeInfo()
	return {
		Name = "Example Gamemode",
		Description = "Ein Beispiel Gamemode",
		Author = "Dein Name",
		MaxPlayer = 32,
		MinPlayer = 1,
		Blip = 37,
		Position = Vector3(-2417, -595.4, 131.7),
	}
end

function onPlayerJoinGamemode(player)
	player:setInfo("myKey", "myValue")
	outputChatBox(player:getInfo("myKey"))
end

function onPlayerQuitGamemode(player)

end

addCommandHandler("testclasses",
	function(player)
		player:setInfo("myKey", "myValue")
		outputChatBox(player:getInfo("myKey"))
	end
)
