function getGamemodeInfo()
	return {
		Name = "Lobby (Freeroam)",
		Description = "Dies ist das Hauptgamemode der Core Resource. Hier können Spielers durch die gegend Fahren oder einem anderem Gamemode beitreten",
		MaxPlayer = 32,
		MinPlayer = 1
	}
end

function onPlayerJoinGamemode(player)
	PlayerManager:getSingleton():addPlayer(player)
end

function onPlayerQuitGamemode(player)
	PlayerManager:getSingleton():removePlayer(player)
end