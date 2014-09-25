-- Server Main System
-- Services: Mail, News, Profile
-- Author: Black_Spirit
-- Version: 0.1.7

-- API time !

os.loadAPI("API/news")
os.loadAPI("API/account")
os.loadAPI("API/mail")
os.loadAPI("API/iNet")
os.loadAPI("API/util")

-- Init stage
print("DPRK_SERVER 0.1")
print("Initializing the server!")

local net = iNet.open(15, 20, "right")
net:setProtocol("DPRK_SERVER")
account.authTokenInit()

print("Server initialization is complete!")

-- main loop
print("Server working!")
while true do
	local data, distance, sender = net:receive()
	local command = util.split(data, ' ')
	-- Account service part
	if command[1] == 'login' and table.getn(command) == 3 then
		data = account.login(command[2], command[3])
	elseif command[1] == 'changePassword'  and table.getn(command) == 4 then
		data = account.changePassword(command[2], command[3], command[4])
	elseif command[1] == 'updateProfile' and table.getn(command) == 4 then
		data = account.updateProfile(command[2], command[3], command[4])
	elseif command[1] == 'showProfile' and table.getn(command) == 3 then
		data = account.showProfile(command[2], command[3])
	elseif command[1] == 'addAccount' and table.getn(command) == 6 then
		data = account.addAccount(command[2], command[3], command[4], command[5], command[6])
	elseif command[1] == 'removeAccount' and table.getn(command) == 4 then
		data = account.removeAccount(command[2], command[3], command[4])
	elseif command[1] == 'changeProfile' and table.getn(command) == 5 then
		data = account.changeProfile(command[2], command[3], command[4], command[5])
	elseif command[1] == 'changeUserPassword' and table.getn(command) == 5 then
		data = account.changeUserPassword(command[2], command[3], command[4], command[5])
	-- Mail service part
	elseif command[1] == 'sendMail' and table.getn(command) == 5 then
		data = mail.sendMail(command[2], command[3], command[4], command[5])
	elseif command[1] == 'showInboxHistory' and table.getn(command) == 2 then
		data = mail.showInboxHistory(command[2])
	elseif command[1] == 'showInbox' and table.getn(command) == 2 then
		data = mail.showInbox(command[2])
	elseif command[1] == 'readMail' and table.getn(command) == 3 then
		data = mail.readMail(command[2], command[3])
	elseif command[1] == 'deleteMail' and table.getn(command) == 3 then
		data = mail.deleteMail(command[2], command[3], false)
	elseif command[1] == 'showUserInbox' and table.getn(command) == 3 then
		data = mail.howUserInbox(command[2], command[3])
	elseif command[1] == 'showUserInboxHistory' and table.getn(command) == 3 then
		data = mail.showUserInboxHistory(command[2], command[3]))
	elseif command[1] == 'readUserMail' and table.getn(command) == 4 then
		data = mail.readUserMail(command[2], command[3], command[4])
	elseif command[1] == 'deleteUserMail' and table.getn(command) == 4 then
		data = mail.deleteUserMail(command[2], command[3], command[4])
	-- News service part
	elseif command[1] == 'readNews' and table.getn(command) == 2 then
		data = news.readNews(command[2])
	elseif command[1] == 'showNews' and table.getn(command) == 1 then
		data = news.showNews()
	elseif command[1] == 'addArticle' and table.getn(command) == 4 then
		data = news.addArticle(command[2], command[3], command[4])
	elseif command[1] == 'removeArticle' and table.getn(command) == 3 then
		data = news.removeArticle(command[2], command[3])
	elseif command[1] == 'updateArticle' and table.getn(command) == 4 then
		data = news.updateArticle(command[2], command[3], command[4])
	else
		data = "Invalid command !"
	end
	net:reply(data)
end