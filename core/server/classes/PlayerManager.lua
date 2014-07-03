PlayerManager = inherit(Singleton)

function PlayerManager:constructor()
	-- add event handlers
	addEventHandler("onPlayerConnect", root, bind(self.playerConnect, self), true, "high+99999")
	addEventHandler("onPlayerChat", root, bind(self.playerChat, self))
	
	for k, v in pairs(getElementsByType("player")) do 
		Player.constructor(v)
		GamemodeManager:getSingleton():getGamemodeFromResource("core"):addPlayer(v)
	end
	
end

function PlayerManager:playerConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber, playerVersionString)
	-- call the player constructor to extend the mta class
	Player.constructor(getPlayerFromName(playerNick))
	
	if not GamemodeManager:getSingleton():getGamemodeFromResource("lobby") then
		GamemodeManager:getSingleton():getGamemodeFromResource("core"):addPlayer(v)
	else
		GamemodeManager:getSingleton():getGamemodeFromResource("lobby"):addPlayer(v)
	end
	
end

function PlayerManager:playerChat(msg, mtype)
	-- NOTE: IF YOU HAVE FREEROAM ENABLED YOU MAY GET DOUBLE MESSAGES
	-- Check if the message type is a normal one
	if mtype == 0 then
		-- Cancel the event so the message isn't displayed for all
		cancelEvent()

		-- Get the sender gamemode & iterate over all players in the gamemode
		for player in pairs(source:getGamemode():getPlayers()) do
			outputChatBox(getPlayerName(source).."#E7D9B0: "..msg, player, 231, 217, 176, true)
		end
		
	end
end