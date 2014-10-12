-- Updater script for DPRK Client
-- Author: Black_Spirit
-- Version: 1.1.1

print("Checking for new updates!")
fs.delete('version')
shell.run('pastebin','get','YGM8pRJM','version')
local file = fs.open('version','r')
local update = file.readLine()
local version = file.readLine()
if update == "true" then
	print("Updating to version:"..version)
	shell.run('install')
else
	print("You are running the latest version available!")
end
file.close()