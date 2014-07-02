Object = {}

function Object:new(...)
	return new(self, ...)
end

function Object:delete(...)
	return delete(self, ...)
end

Object.__call = Object.new
setmetatable(Object, {__call = Object.__call})