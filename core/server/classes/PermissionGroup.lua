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
	return self.m_Permissions[permission] ~= nil
end
