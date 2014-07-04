PlayerManager = inherit(Singleton)

function PlayerManager:constructor()
	-- add event handlers
	addEventHandler("onPlayerConnect", root, bind(self.playerConnect, self), true, "high+99999")
	addEventHandler("onPlayerJoin", root, bind(self.playerJoin, self), true, "high+99999")
	addEventHandler("onPlayerQuit", root, bind(self.playerQuit, self), true, "high+99999")
	addEventHandler("onPlayerChat", root, bind(self.playerChat, self))
end

function PlayerManager:playerConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber, playerVersionString)
	local player = getPlayerFromName(playerNick)

	-- call the player constructor to extend the mta class
	Player.constructor(player)
end

function PlayerManager:playerJoin()
	if not GamemodeManager:getSingleton():getGamemodeFromResource("lobby") then
		GamemodeManager:getSingleton():getGamemodeFromResource(getThisResource()):addPlayer(source)
	else
		GamemodeManager:getSingleton():getGamemodeFromResource("lobby"):addPlayer(source)
	end
end

function PlayerManager:playerQuit(quitType)
	local currentGM = source:getGamemode()
	currentGM:removePlayer(source)
end

function PlayerManager:playerChat(msg, mtype)
	-- cancel Event to avoid sending any message from the player (/say, /teamsay & /me)
	cancelEvent()
	if not source:isMuted() then
		if mtype == 0 then -- /say
			source:getGamemode():broadcastMessage(("%s#E7D9B0: %s"):format(source:getName(), msg), 231, 217, 176, true)
		elseif mtype == 1 then -- /me
		
		elseif mtype == 2 then -- /teamsay
		
		end
	end
end