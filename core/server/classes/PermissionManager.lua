PermissionManager = inherit(Singleton)

function PermissionManager:constructor()
	-- Globale Variablen
	self.m_Permissions = {}
	self.m_Groups = {}

	self.m_Changed = false
	
	self:loadPermissions()
	self:loadGroups()
end

function PermissionManager:destructor()
	
end

function PermissionManager:loadPermissions()
	-- Todo
	--local result = sql:queryFetch("SELECT * FROM permissions")
	if result then
		for _, data in pairs(result) do
			
		end
	end
end

function PermissionManager:loadGroups()
	-- Todo
	
	--local result = sql:queryFetch("SELECT * FROM permission_groups")
	if result then
		for _, data in pairs(result) do
			
		end
	end
end

function PermissionManager:doesGroupExists(gName)
	assert(type(gName) == "string")
	return self.m_Groups[gName] ~= nil
end

function PermissionManager:createGroup(gName)
	assert(type(gName) == "string")
	
	if not self:doesGroupExists(gName) then
		self.m_Groups[gName] = PermissionGroup:new(gName)
		outputServerLog(("[PermissionManager]: Created Group %s!"):format(gName))
	end
end

function PermissionManager:deleteGroup(gName)
	assert(type(gName) == "string", "Bad Argument PermissionManager.createGroup")
	
	if self:doesGroupExists(gName) then
		local cPermission = self:getPermission(gName)
		if cPermission then
			outputServerLog(("[PermissionManager]: Deleted Group %s!"):format(cPermission:getName()))
			delete(cPermission)
			self.m_Groups[gName] = nil
		end
	end
end

function PermissionManager:getPermission(gName)
	assert(type(gName) == "string")
	if self:doesGroupExists(gName) then
		return self.m_Groups[gName]
	end
end

function PermissionManager:getPermissionList()
	return self.m_Permissions
end

function PermissionManager:addPermission(permission)
	assert(type(permission) == "string")
	
	if not self.m_Permissions[permission] then
		self.m_Permissions[permission] = true
		self.m_Changed = true
		outputServerLog(("[PermissionManager]: Added Permission \"%s\""):format(permission))
	end
end

function PermissionManager:removePermission(permission)
	if self.m_Permissions[permission] then
		self.m_Permissions[permission] = nil
	end	
end

function PermissionManager:doesPermissionAlreadyExist(permission)
	return self.m_Permissions[permission] ~= nil
end

function PermissionManager:addPermissionToGroup(gName, permission)
	assert(type(gName) == "string")
	assert(type(permission) == "string")
	
	if self:doesGroupExists(gName) then
<<<<<<< HEAD
=======
		outputChatBox('call')
>>>>>>> 598fad11208277c69c7cc2a24e3a6d5fc52780b5
		self:getPermission(gName):addPermission(permission)
	end
end

function PermissionManager:removePermissionFromGroup(gName, permission)
	assert(type(gName) == "string")
	assert(type(permission) == "string")
	
	if self:doesGroupExists(gName) then
		self:getPermission(gName):removePermission(permission)
	end
end

