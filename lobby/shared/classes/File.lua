File = inherit(Object)

function FileOpen(file, create)
	return new(File, file, create)
end

function FileClose(handle)
	if handle then
		delete(handle)
	end
end

function File:constructor(filepath, create)
	self.m_fileHandle = false
	
	if(create and not fileExists(filepath))then
		self.m_fileHandle = fileCreate(filepath)
	else
		self.m_fileHandle = fileOpen(filepath)
	end
end

function File:destructor()
	if self.m_fileHandle then
		fileClose(self.m_fileHandle)
	end
end

function File:getSize()
	if self.m_fileHandle then
		return fileGetSize(self.m_fileHandle)
	end
	return -1;
end

function File:read()
	if self.m_fileHandle then
		local size = self:getSize()
		if size == 0 then return '' end
		return fileRead(self.m_fileHandle)
	end
	return ''
end

function File:write(text)
	if self.m_fileHandle then
		return fileWrite(self.m_fileHandle, text) ~= 0
	end
	return false
end

function File:flush()
	if self.m_fileHandle then
		return fileFlush(self.m_fileHandle)
	end
	return false
end