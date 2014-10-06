-- Log module
-- Author: Black_Spirit
-- Version: 0.1

os.loadAPI("API/util")

local LEVELS = {"[DEBUG]", "[INFO]", "[WARN]", "[ERROR]", "[FATAL]")

local logger = (
	path = "log.file",
	log = function (self, level, message)
		if type( self ) ~= "table" then
			error( 'Incorrect notation, use ":" instead of "."', 2 )
		end
		local dateString = os.day().." - "..os.time()..' '
		message = dateString..LEVELS[level].." "..message..'.\n'
		print(message)
		util.writeData(self.path, message, 'a')
	end,
	["debug"] = function(message) log(1, message) end,
	info = function(message) log(2, message) end,
	warn = function(message) log(3, message) end,
	["error"] = function(message) log(4, message) end,
	fatal = function(message) log(5, message) end
)

function new(filePath)
	local l = (path = filePath}
	setmetatable( l, { __index = logger } )
	return l
end