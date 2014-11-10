function Player:triggerEvent(eventName, ...)
	triggerClientEvent(self, eventName, resourceRoot, ...)
end

function Player:setGamemode(gamemode)
	self.m_Gamemode = gamemode
end

function Player:getGamemode()
	return self.m_Gamemode
end

function Player:setInfo(key, value)
	if not self.m_Info then self.m_Info = {} end
	self.m_Info[key] = value
end

function Player:getInfo(key)
	return self.m_Info[key]
end

function Player:isLoggedIn()
	-- Todo: Check
	return true
end

function Player:isMuted()
	-- Todo: Check
	return false
end


--local lGroup = "Spieler"

local lGroup = "Administrator"
-- Todo: Durch alle Spielers loopen und Permission Abfrage
function Player:hasPermission(perm)
	if PermissionManager:getSingleton():doesGroupExists(lGroup) then
		local cPermission = PermissionManager:getSingleton():getPermission(lGroup)
		return cPermission:hasEnoughtPermission(perm)
	end
end

addCommandHandler("t", function(player, cmd)
	outputChatBox(tostring(player:hasPermission("cmd.bla")))
end)
