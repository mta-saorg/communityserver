Gamemode = inherit(Object)

function Gamemode:constructor(resource, bNeededProperties, iID)
	if bNeededProperties then
		-- take over the gamemode's properties
		local info = exports[resource]:getGamemodeInfo()
		for key, value in pairs(info) do 
			self["m_"..key] = value
		end
		
	else
		-- emergency/default properties
		self.m_Name = "None"
		self.m_Description = ""
		self.m_MaxPlayer = getMaxPlayers()
		self.m_MinPlayer = -1
		
	end
	
	-- member variables
	self.m_Resource = resource
	self.m_Players = {}
	self.m_PlayerCount = 0
	self.m_ID = iID
	
	if self.m_Blip then
		self.m_BlipElement = Blip.create(self.m_Position, self.m_Blip)
	end
	
	if self.m_Position then
		self.m_Position = Vector3(self.m_Position) -- 1.4 HACK (remove as soon as fix from r6648 is available)
		self.m_EnterMarker = Marker.create(self.m_Position, "cylinder", 2, 255, 90, 0)
			
		addEventHandler("onMarkerHit", self.m_EnterMarker,
			function(hitElement, matchingDimension)
				if getElementType(hitElement) == "player" and matchingDimension then
					if hitElement:getGamemode() ~= self then
						hitElement:triggerEvent("onGamemodeWindowOpen", self:getInfo(), self:getPlayers())
					else
						outputChatBox("Du bist bereits in diesem Gamemode!", hitElement, 255, 100, 100)
					end
				end
			end
		)
	end
end

function Gamemode:destructor()
	if self.m_EnterMarker then
		self.m_EnterMarker:destroy()
	end
	if self.m_BlipElement then
		self.m_BlipElement:destroy()
	end
end

function Gamemode:setInfo(key, val)
	if(type(key) == "string" and self["m_"..key]) then
		self["m_"..key] = val
	end
end

function Gamemode:getInfo(arg)
	if(type(arg) == 'string' and self["m_"..arg]) then
		return self["m_"..arg]
	end
	return {
		ID = self.m_ID,
		Name = self.m_Name,
		Author = self.m_Author,
		Description = self.m_Description,
		MaxPlayers = self.m_MaxPlayer,
		MinPlayers = self.m_MinPlayer
	}
end

function Gamemode:getResource()
	return self.m_Resource
end

function Gamemode:getPlayers()
	return self.m_Players
end

function Gamemode:addPlayer(player)
	if not self.m_Players[player] then
		self.m_Players[player] = {}
		self.m_PlayerCount = self.m_PlayerCount + 1
	end
	
	if self.m_PlayerCount < self.m_MaxPlayer then
		player:setGamemode(self)

		if getResourceName(self.m_Resource) ~= "core" then
			self:broadcastMessage(("#0678ee* #d9d9d9%s #d9d9d9has joined Gamemode #0678ee%s#d9d9d9 (%d/%d) #0678ee*"):format(player:getName(), self.m_Name, self.m_PlayerCount, self.m_MaxPlayer), 0, 0, 0, true)
			call(self:getResource(), "onPlayerJoinGamemode", player)
		end
		return true
	end
end

function Gamemode:broadcastMessage(msg, r, g, b, colorcoded)
	for player in pairs(self:getPlayers()) do
		outputChatBox(msg, player, r, g, b, colorcoded)
	end
end

function Gamemode:removePlayer(player)
	if self.m_Players[player] then
		self.m_Players[player] = nil
		self.m_PlayerCount = self.m_PlayerCount - 1
		
		if getResourceName(self.m_Resource) ~= "core" then
			self:broadcastMessage(("#0678ee* #d9d9d9%s #d9d9d9left the Gamemode #0678ee*"):format(player:getName()), 0, 0, 0, true)
			call(self:getResource(), "onPlayerQuitGamemode", player)
		end
	end
end