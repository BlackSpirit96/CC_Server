-- client install script
-- Author: Black_Spirit
-- Version: 1.0

local application = 'j92gGHvG'
local iNet = 'jLCtV9d1'
local util = 'vzn7djBF'
local updater = 'RYHvbuyT'
local client_api = 'Ze3TiE14'
if fs.exists("application") then
	shell.run("delete", "application")
	shell.run("delete", "API/iNet")
	shell.run("delete", "API/util")
	shell.run("delete","updater")
	shell.run("delete","API/client_api")
end

shell.run("pastebin", "get", iNet, "API/iNet")
shell.run("pastebin", "get", application, "application")
shell.run("pastebin", "get", util, "API/util")
shell.run("pastebin", "get", updater, "updater")
shell.run("pastebin", "get", client_api, "API/client_api")

if not fs.exists('startup') then
	file = fs.open("startup",'w')
	local code = "shell.run('updater')\nshell.run('application')"
	file.write(code)
	file.close()
end