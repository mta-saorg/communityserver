local onResourceStart, onResourceStop

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

ENABLEOOP = false

function onPlayerJoinGamemode(player)
	--player:setInfo("myKey", "myValue")
	setPlayerInfo(player, "myKey", "myValue")
	--outputChatBox(player:getInfo("myKey"))
	outputChatBox(getPlayerInfo(player, "myKey"))
end

function onPlayerQuitGamemode(player)

end

function onResourceStart()
	-- core:getWrapperCode(ENABLEOOP) does not work for some reasons
	loadstring(exports.core:getWrapperCode(ENABLEOOP))()
end

function onResourceStop()

end

addEventHandler("onResourceStart", resourceRoot, onResourceStart)
addEventHandler("onResourceStop", resourceRoot, onResourceStop)
