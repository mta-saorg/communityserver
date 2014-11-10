PlayerManager = inherit(Singleton)

function PlayerManager:constructor()
	-- add event handlers
	addEventHandler("onPlayerConnect", root, bind(self.playerConnect, self), true, "high+99999")
	addEventHandler("onPlayerJoin", root, bind(self.playerJoin, self), true, "high+99999")
	addEventHandler("onPlayerQuit", root, bind(self.playerQuit, self), true, "high+99999")
	addEventHandler("onPlayerChat", root, bind(self.playerChat, self))
	
	addEvent("onPlayerDownloadComplete", true)
	addEventHandler("onPlayerDownloadComplete", resourceRoot, bind(self.onPlayerDownloadComplete, self))
end

function PlayerManager:destructor()
	for _, player in pairs(getElementsByType("player")) do
		Account:getSingleton():saveAccount(player)
	end
end

function PlayerManager:playerConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber, playerVersionString)

end

function PlayerManager:playerJoin()

end

function PlayerManager:playerQuit(quitType)
	local currentGM = source:getGamemode()
	if(currentGM) then
		currentGM:removePlayer(source)
	end
	
	Account:getSingleton():saveAccount(source)	
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

function PlayerManager:onPlayerDownloadComplete()
	Account:getSingleton():checkAccount()
end

function PlayerManager:onPlayerLogin(player)
	self:setPlayerDefaultGamemode(player)
	outputChatBox("Du hast dich erfolgreich angemeldet", player, 255, 100, 100)

end

function PlayerManager:onPlayerRegister(player)
	self:setPlayerDefaultGamemode(player)
	outputChatBox("Du hast dich erfolgreich registriert", player, 255, 100, 100)
end

function PlayerManager:setPlayerDefaultGamemode(player)
	if not GamemodeManager:getSingleton():getGamemodeFromResource("lobby") then
		GamemodeManager:getSingleton():getGamemodeFromResource(getThisResource()):addPlayer(player)
	else
		GamemodeManager:getSingleton():getGamemodeFromResource("lobby"):addPlayer(player)
	end	
end