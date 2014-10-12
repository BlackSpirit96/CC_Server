-- the complete client api
-- author: Black_Spirit
-- Version:1.1.1

-- Adaptor INIT stage
os.loadAPI("API/iNet")
local net = iNet.open(20, 15, "right")
net:setProtocol("DPRK_SERVER")

-- Account API

account = {
	login = function(username, password)
		net:send('login~'..username..'~'..password)
		local message, distance, sender = net:receive()
		return message
	end,
	changePassword = function(authToken, oldPassword, newPassword)
		net:send('changePassword~'..authToken..'~'..oldPassword..'~'..newPassword)
		local message, distance, sender = net:receive()
		return message
	end,
	updateProfile = function(authToken, password, data)
		net:send('updateProfile~'..authToken..'~'..password..'~'..data)
		local message, distance, sender = net:receive()
		return message
	end,
	showProfile = function(authToken, username)
		net:send('showProfile~'..authToken..'~'..username)
		local message, distance, sender = net:receive()
		return message
	end,
	addAccount = function(authToken, password, username, userPassword, userLVL)
		net:send('addAccount~'..authToken..'~'..password..'~'..username..'~'..userPassword..'~'..userLVL)
		local message, distance, sender = net:receive()
		return message
	end,
	removeAccount = function(authToken, password, username)
		net:send('removeAccount~'..authToken..'~'..password..'~'..username)
		local message, distance, sender = net:receive()
		return message
	end,
	changeProfile = function(authToken, password, username, data)
		net:send('changeProfile~'..authToken..'~'..password..'~'..username..'~'..data)
		local message, distance, sender = net:receive()
		return message
	end,
	changeUserPassword = function(authToken, password, username, newPassword)
		net:send('changeUserPassword~'..authToken..'~'..password..'~'..username..'~'..newPassword)
		local message, distance, sender = net:receive()
		return message
	end,
	authTokenLvl = function(authToken)
		net:send('authTokenLvl~'..authToken)
		local message, distance, sender = net:receive()
		return message
	end}

-- Mail API

mail = {
	sendMail = function(to, authToken, topic, body)
		net:send('sendMail~'..to..'~'..authToken..'~'..topic..'~'..body)
		local message, distance, sender = net:receive()
		return message
	end,
	showInboxHistory = function(authToken)
		net:send('showInboxHistory~'..authToken)
		local message, distance, sender = net:receive()
		return message
	end,
	showInbox = function(authToken)
		net:send('showInbox~'..authToken)
		local message, distance, sender = net:receive()
		return message
	end,
	readMail = function(authToken, mailName)
		net:send('readMail~'..authToken..'~'..mailName)
		local message, distance, sender = net:receive()
		return message
	end,
	deleteMail = function(authToken, mailName)
		net:send('deleteMail~'..authToken..'~'..mailName)
		local message, distance, sender = net:receive()
		return message
	end,
	showUserInbox = function(authToken, username)
		net:send('showUserInbox~'..authToken..'~'..username)
		local message, distance, sender = net:receive()
		return message
	end,
	showUserInboxHistory = function(authToken, username)
		net:send('showUserInboxHistory~'..authToken..'~'..username)
		local message, distance, sender = net:receive()
		return message
	end,
	readUserMail = function(authToken, username, mailName)
		net:send('readUserMail~'..authToken..'~'..username..'~'..mailName)
		local message, distance, sender = net:receive()
		return message
	end,
	deleteUserMail = function(authToken, username, mailName)
		net:send('deleteUserMail~'..authToken..'~'..username..'~'..mailName)
		local message, distance, sender = net:receive()
		return message
	end}

-- News API

news = {
	readNews = function(title)
		net:send('readNews~'..title)
		local message, distance, sender = net:receive()
		return message
	end,
	showNews = function()
		net:send('showNews')
		local message, distance, sender = net:receive()
		return message
	end,
	addArticle = function(authToken, title, text)
		net:send('addArticle~'..authToken..'~'..title..'~'..text)
		local message, distance, sender = net:receive()
		return message
	end,
	removeArticle = function(authToken, title)
		net:send('removeArticle~'..authToken..'~'..title)
		local message, distance, sender = net:receive()
		return message
	end,
	updateArticle = function(authToken, title, text)
		net:send('updateArticle~'..authToken..'~'..title..'~'..text)
		local message, distance, sender = net:receive()
		return message
	end}