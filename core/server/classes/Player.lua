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
		}
	)
end

function Player:setGamemode(gamemode)
	self.m_Gamemode = gamemode
end

function Player:getGamemode()
	return self.m_Gamemode
end

function Player:setInfo(gamemode, key, value)
	self.m_Info[gamemode][key] = value
end

function Player:getInfo(gamemode, key)
	return self.m_Info[gamemode][key]
end

function Player:isLoggedIn()
	-- Todo: Check
	return true
end

function Player:isMuted()
	-- Todo: Check
	return false
end


local lGroup = "Administrator"
-- Todo: Durch alle Spielers loopen und Permission Abfrage
function Player:hasPermission(perm)
	if PermissionManager:getSingleton():doesGroupExists(lGroup) then
		local cPermission = PermissionManager:getSingleton():getPermission(lGroup)
		return cPermission:hasEnoughtPermission(perm)
	end
end

