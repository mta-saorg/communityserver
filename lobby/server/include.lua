function getGamemodeInfo()
	return {
		Name = "Default Gamemode",
		MaxPlayer = 99,
		MinPlayer = 1
	}
end

addEvent('onPlayerJoinGamemode', true)
addEventHandler('onPlayerJoinGamemode', getResourceRootElement(getThisResource()), onPlayerJoinLobby)

