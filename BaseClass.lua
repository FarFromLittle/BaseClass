--[[

BaseClass is a lightweight module script that helps developers organize
classes in the Explorer window, automatically managing metatables. It also
serves as the root for all other classes.

GitHub:
https://github.com/FarFromLittle/BaseClass

DevForums:
https://devforum.roblox.com/t/baseclass-class-inheritance-made-easyier/3593627

MIT License

Copyright (c) 2025 FarFromLittle

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

]]--

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
