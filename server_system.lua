-- Server Main System
-- Services: Mail, News, Profile
-- Author: Black_Spirit
-- Version: 0.1

-- API time !

os.loadAPI("news")
os.loadAPI("account")
os.loadAPI("mail")
os.loadAPI("iNet")
os.loadAPI("util")

-- Init stage
print("DPRK_SERVER 0.1"
print("Initializing the server!")

local net = iNet.open(1, 1, "right")
net:setProtocol("DPRK_SERVER")
net:setEncryption(net:b64enc)
net:setDecryption(net:b64dec)
account.authToken.Init()

print("Server initialization is complete!")

-- mail loop
print("Server working!")
while true do
	local data, distance, sender = net:receive()
	local command = util.split(data, ' ')
	if command[1] == 'login' and #command == 3 then
		data = account.login(command[2], command[3])
	elseif command[1] == 'sendMail' and #command == 5 then
		data == mail.sendMail(command[2], command[3], command[4], command[5])
	elseif command[1] == 'showInboxHistory' and #command == 2 then
		data = mail.showInboxHistory(command[2])
	elseif command[1] == 'showInbox' and #command == 2 then
		data = showInbox(command[2])
	elseif command[1] == 'readMail' and #command == 3 then
		data = readMail(command[2], command[3])
	elseif command[1] == 'deleteMail' and #command == 4 then
		data = deleteMail(command[2], command[3], command[4])
	elseif command[1] == 'showUserInbox' and #command == 3 then
		data = showUserInbox(command[2], command[3])
	elseif command[1] == 'readUserMail' and #command == 4 then
		data = readUserMail(command[2], command[3], command[4])
	elseif command[1] == 'deleteUserMail' and #command == 4 then
		data == deleteUserMail(command[2], command[3], command[4])
	else
		data = "Invalid command !"
	end
	net:reply(data)
end