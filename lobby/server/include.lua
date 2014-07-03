function getGamemodeInfo()
	return {
		Name = "Default Gamemode",
		Desc = "Freeroam",
		MaxPlayer = 32,
		MinPlayer = 1
	}
end

function getPlayers()
	local res = getResourceFromName("core")
	if getResourceState(res) == "running" then
		return call(res, "getGamemodePlayers")
	end
	return false
end

