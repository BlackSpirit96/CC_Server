-- Updater script for DPRK Server
-- Author: Black_Spirit
-- Version: 1.1.1

print("Checking for new updates!")
fs.delete('version')
shell.run('pastebin','get','U1jbrXwv','version')
local file = fs.open('version','r')
local update = file.readLine()
local version = file.readLine()
if update == "true" then
	print("Updating to version:"..version)
	shell.run('install')
else
	print("You are running the lattest version available!")
end
file.close()