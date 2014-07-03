PlayerManager = inherit(Singleton)

function PlayerManager:constructor()
	-- add event handlers
	addEventHandler("onPlayerConnect", root, bind(self.playerConnect, self), true, "high+99999")
	addEventHandler("onPlayerChat", root, bind(self.playerChat, self))
end

function PlayerManager:playerConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber, playerVersionString)
	-- call the player constructor to extend the mta class
	Player.constructor(getPlayerFromName(playerNick))
	
	if not GamemodeManager:getSingleton():getGamemodeFromResource("lobby") then
		GamemodeManager:getSingleton():getGamemodeFromResource(getThisResource()):addPlayer(v)
	else
		GamemodeManager:getSingleton():getGamemodeFromResource("lobby"):addPlayer(v)
	end
	
end

function PlayerManager:playerChat(msg, mtype)
	-- cancel Event to avoid sending any message from the player (/say, /teamsay & /me)
	cancelEvent()

	if mtype == 0 then -- /say
		if not source:isMuted() then
			source:getGamemode():broadcastMessage(("%s#E7D9B0: %s"):format(source:getName(), msg), 231, 217, 176, true)
		end
	elseif mtype == 1 then -- /me
	
	elseif mtype == 2 then -- /teamsay
	
	end
end