GamemodeManager = inherit(Singleton)

function GamemodeManager:constructor()
	-- some forward declaration 
	self.m_Gamemodes = {}
	
	-- register the waiting area ( hacky )
	self.m_Gamemodes[getThisResource()] = Gamemode:new(getThisResource(), false)
	
	-- move every player into the waiting area
	for _, player in pairs(getElementsByType("player")) do
		self:getGamemodeFromResource(getThisResource()):addPlayer(player)
	end
	
	-- add the event handlers
	addEventHandler("onResourceStart", root, bind(self.resourceStart, self))
	addEventHandler("onResourceStop", root, bind(self.resourceStop, self))
end

function GamemodeManager:destructor()
	-- release all created gamemodes
	for resource, gamemode in pairs(self.m_Gamemodes) do
		delete(gamemode)
	end
end

function GamemodeManager:getGamemodes()
	return self.m_Gamemodes
end

function GamemodeManager:getGamemodeFromResource(argument)
	if type(argument) == "string" then
		for resource in pairs(self.m_Gamemodes) do 
			if getResourceName(resource) == argument then
				return self.m_Gamemodes[resource]
			end
		end
		
	elseif type(argument) == "userdata" then
		return self.m_Gamemodes[argument]
		
	end
end

function GamemodeManager:registerGamemode(resource)
	if not self.m_Gamemodes[resource] then
		-- create a new gamemode
		self.m_Gamemodes[resource] = Gamemode:new(resource, true)
		outputServerLog(("[GamemodeManager]: Added Gamemode %s (Resource: %s)"):format(self:getGamemodeFromResource(resource).m_Name, getResourceName(resource)))
		
	end
end

function GamemodeManager:unregisterGamemode(resource)
	if self.m_Gamemodes[resource] then
		-- release the gamemode
		local currentGamemode = self:getGamemodeFromResource(resource)
		if currentGamemode then
			outputServerLog(("[GamemodeManager]: Removed Gamemode %s (Resource: %s)"):format(currentGamemode:getInfo("Name"), getResourceName(resource)))
			delete(currentGamemode)
			self.m_Gamemodes[resource] = nil
		end
	end
end

function GamemodeManager:resourceStart(resource)
	if getResourceInfo(resource, "type") == "mode" then
		-- register the gamemode
		self:registerGamemode(resource)
		
		if getResourceName(resource) == "lobby" then
			local waitingArea = self:getGamemodeFromResource(getThisResource())
			for player in pairs(waitingArea:getPlayers()) do
				waitingArea:removePlayer(player)
				self:getGamemodeFromResource(resource):addPlayer(player)
			end
		end
	end
end

function GamemodeManager:resourceStop(resource)
	if getResourceInfo(resource, "type") == "mode" then
	
		local targetGamemode = nil
		if getResourceName(resource) == "lobby" then
			targetGamemode = self:getGamemodeFromResource(getThisResource())
		else
			targetGamemode = self:getGamemodeFromResource("lobby")
		end
		
		local currentGamemode = self:getGamemodeFromResource(resource)
		
		if(currentGamemode and targetGamemode) then
			if currentGamemode:getPlayerCounter() >= 1 then
				for player in pairs(currentGamemode:getPlayers()) do 
					-- transfer all player into the new gamemode
					currentGamemode:removePlayer(player)
					targetGamemode:addPlayer(player)
				end
			end
		end
		-- unregister the gamemode
		self:unregisterGamemode(resource)
		
	end
end

-- BETA COMMANDS
addCommandHandler("jl",
	function(p, cmd, gm)
		p:getGamemode():removePlayer(p)
		GamemodeManager:getSingleton():getGamemodeFromResource(getResourceFromName(gm)):addPlayer(p)
	end
)

function getGamemodePlayers()
	local GM = GamemodeManager:getSingleton():getGamemodeFromResource(sourceResource)
	if GM then
		return GM:getPlayers()
	end
	return false
end