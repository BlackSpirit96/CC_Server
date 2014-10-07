-- Log module
-- Author: Black_Spirit
-- Version: 1.2

local LEVELS = {"[DEBUG]", "[INFO]", "[WARN]", "[ERROR]", "[FATAL]"}

local logger = {
	path = "log.file",
	logFile = function(self, level, message)
		if type( self ) ~= "table" then
			error( 'Incorrect notation, use ":" instead of "."', 2 )
		end
		local logFile = fs.open(self.path, 'a')
		local dateString = os.day().." - "..os.time()..' '
		message = dateString..LEVELS[level].." "..message..'.\n'
		logFile.write(message)
		logFile.close()
	end,
	["log"] = function (self, level, rawMessage)
		if type( self ) ~= "table" then
			error( 'Incorrect notation, use ":" instead of "."', 2 )
		end
		local dateString = os.day().." - "..os.time()..' '
		local message = dateString..LEVELS[level].." "..rawMessage..'.'
		print(message)
		self:logFile(level,rawMessage)
	end,
	["debug"] = function(self, message) self:log(1, message) end,
	info = function(self,message) self:log(2, message) end,
	warn = function(self,message) self:log(3, message) end,
	["error"] = function(self,message) self:log(4, message) end,
	fatal = function(self,message) self:log(5, message) end
}

function new(filePath)
	local l = {path = filePath}
	setmetatable( l, { __index = logger } )
	return l
end