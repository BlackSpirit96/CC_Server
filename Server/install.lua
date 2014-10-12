-- server install script
-- Author: Black_Spirit
-- Version: 1.1.1

local account = 'w0u7sTEW'
local iNet = 'jLCtV9d1'
local server_system = 'GtE4da0t'
local news = 'r90LatEH'
local mail = 'GYNn63bC'
local util = 'vzn7djBF'
local logger = 'p0yzCfdJ'
local updater = 'YPrJnhHP'

if fs.exists("server_system") then
	shell.run("delete", "API/account")
	shell.run("delete", "API/iNet")
	shell.run("delete", "server_system")
	shell.run("delete", "API/news")
	shell.run("delete", "API/mail")
	shell.run("delete", "API/util")
	shell.run("delete", "API/log")
	shell.run("delete", "updater")
end

shell.run("pastebin", "get", account, "API/account")
shell.run("pastebin", "get", iNet, "API/iNet")
shell.run("pastebin", "get", server_system, "server_system")
shell.run("pastebin", "get", news, "API/news")
shell.run("pastebin", "get", mail, "API/mail")
shell.run("pastebin", "get", util, "API/util")
shell.run("pastebin", "get", logger, "API/log")
shell.run("pastebin", "get", updater, "updater")

if not fs.exists('startup') then
	file = fs.open("startup",'w')
	local code = "shell.run('updater')\nshell.run('server_system')"
	file.write(code)
	file.close()
end