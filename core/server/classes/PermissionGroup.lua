PermissionGroup = inherit(Object)

function PermissionGroup:constructor(gName)
	-- Globale Variablen
	self.m_Permissions = {}
	self.m_groupName = gName
	self.m_Update = false
end

function PermissionGroup:destructor()
	if self.m_Update then
		-- Todo: Speicherung
	end
end

function PermissionGroup:getName()
	return self.m_groupName
end

function PermissionGroup:addPermission(permission)
	if not self.m_Permissions[permission] then
		outputServerLog(("[PermissionGroup]: Successfully added Permission \"%s\" to Group %s!"):format(permission, self:getName()))
		self.m_Permissions[permission] = true
		self.m_Update = true
	end
end

function PermissionGroup:removePermission(permission)
	if self.m_Permissions[permission] then
		self.m_Permissions[permission] = nil
		self.m_Update = true
	end
end

function PermissionGroup:hasEnoughtPermission(permission)
	assert(type(permission) == "string")
<<<<<<< HEAD
	return (self.m_Permissions[permission] or self.m_Permissions["*"]) ~= nil
=======
	return self.m_Permissions[permission] ~= nil
>>>>>>> 598fad11208277c69c7cc2a24e3a6d5fc52780b5
end
