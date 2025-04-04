local BaseClass = { __base = script, __name = "Class" }

function BaseClass:__call(...)
	local o = setmetatable({}, self)
	o:new(...)
	return o
end

function BaseClass:__index(name)
	local source = self.__base:FindFirstChild(name)
	
	if not source then return end
	
	local class = require(source)
	
	class.__base = source
	class.__call = self.__call
	class.__index = class.__index or class
	class.__name = name
	class.__tostring = class.__tostring or self.__tostring
	
	setmetatable(class, self)
	
	self[name] = class
	
	return class
end

function BaseClass:__tostring()
	return self.__name or getmetatable(self).__name
end

return setmetatable(BaseClass, BaseClass)
