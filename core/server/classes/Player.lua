-- Extends MTA class
function Player:constructor()
	-- Note: This creates a table which automatically creates up to 2 subtables when accessed
	-- 		 e.g.: table["hello"]["world"] = 12 would be valid without ["hello"] ever being created
	self.m_Info = setmetatable({},
		{
			__index = function(self, key)
				self[key] = setmetatable({},	
					{
						__index = function(self, key)
							self[key] = {}
							return self[key]
						end
					})
				return self[key]
			end
		})
end

-- HACK: Make sure the constructor is called
addEventHandler("onPlayerConnect", root, function(name) Player.constructor(getPlayerFromName(name)) end, true, "high+99999")
for k, v in pairs(getElementsByType("player")) do Player.constructor(v) end

function Player:setGamemode()
	
end

function Player:getGamemode()
	
end

function Player:setInfo(gamemode, key, value)
	self.m_Info[gamemode][key] = value
end

function Player:getInfo(gamemode, key)
	return self.m_Info[gamemode][key]
end