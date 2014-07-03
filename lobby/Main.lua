local info = {
	Name        = 'Lobbyname',
	maxPlayers  = -1, -- -1 = unlimited
	minPlayers  = -1, -- -1 = no playerlimit for start
	spawns      = {
		--{x, y, z, rot}
	}
}

addEventHandler('onResourceStart', resourceRoot, 
	function()
		registerGamemode(info)
	end
)

addEventHandler('onResourceStop', resourceRoot,
	function()
		unregisterGamemode()
	end
)