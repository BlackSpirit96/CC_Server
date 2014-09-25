-- install script
-- Author: Black_Spirit
-- Version: 1.0

local account = 'w0u7sTEW'
local iNet = 'jLCtV9d1'
local server_system = 'GtE4da0t'
local news = 'r90LatEH'
local mail = 'GYNn63bC'
local util = 'vzn7djBF'

shell.run("delete", "account")
shell.run("delete", "iNet")
shell.run("delete", "server_system")
shell.run("delete", "news")
shell.run("delete", "mail")
shell.run("delete", "util")


shell.run("pastebin", "get", account, "account")
shell.run("pastebin", "get", iNet, "iNet")
shell.run("pastebin", "get", server_system, "server_system")
shell.run("pastebin", "get", news, "news")
shell.run("pastebin", "get", mail, "mail")
shell.run("pastebin", "get", util, "util")