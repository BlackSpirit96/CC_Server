-- client install script
-- Author: Black_Spirit
-- Version: 1.0

local application = 'j92gGHvG'
local account = 'dj6guVfZ'
local iNet = 'jLCtV9d1'
local mail = 'vawh3zAS'
local news = 'x8iV27vi'
local util = 'vzn7djBF'

if fs.exists("application") then
	shel.run("delete", "application")
	shel.run("delete", "API/account")
	shel.run("delete", "API/iNet")
	shel.run("delete", "API/mail")
	shel.run("delete", "API/news")
	shel.run("delete", "API/util")
end

shell.run("pastebin", "get", account, "API/account")
shell.run("pastebin", "get", iNet, "API/iNet")
shell.run("pastebin", "get", application, "application")
shell.run("pastebin", "get", news, "API/news")
shell.run("pastebin", "get", mail, "API/mail")
shell.run("pastebin", "get", util, "API/util")