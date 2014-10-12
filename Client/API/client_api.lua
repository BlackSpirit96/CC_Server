-- the complete client api
-- author: Black_Spirit
-- Version:1.1.1

-- Adaptor INIT stage
os.loadAPI("API/iNet")
local net = iNet.open(20, 15, "right")
net:setProtocol("DPRK_SERVER")

-- Account API

function login(username, password)
	net:send('login~'..username..'~'..password)
	local message, distance, sender = net:receive()
	return message
end

function changePassword(authToken, oldPassword, newPassword)
	net:send('changePassword~'..authToken..'~'..oldPassword..'~'..newPassword)
	local message, distance, sender = net:receive()
	return message
end

function updateProfile(authToken, password, data)
	net:send('updateProfile~'..authToken..'~'..password..'~'..data)
	local message, distance, sender = net:receive()
	return message
end

function showProfile(authToken, username)
	net:send('showProfile~'..authToken..'~'..username)
	local message, distance, sender = net:receive()
	return message
end

function addAccount(authToken, password, username, userPassword, userLVL)
	net:send('addAccount~'..authToken..'~'..password..'~'..username..'~'..userPassword..'~'..userLVL)
	local message, distance, sender = net:receive()
	return message
end

function removeAccount(authToken, password, username)
	net:send('removeAccount~'..authToken..'~'..password..'~'..username)
	local message, distance, sender = net:receive()
	return message
end

function changeProfile(authToken, password, username, data)
	net:send('changeProfile~'..authToken..'~'..password..'~'..username..'~'..data)
	local message, distance, sender = net:receive()
	return message
end

function changeUserPassword(authToken, password, username, newPassword)
	net:send('changeUserPassword~'..authToken..'~'..password..'~'..username..'~'..newPassword)
	local message, distance, sender = net:receive()
	return message
end

function authTokenLvl(authToken)
	net:send('authTokenLvl~'..authToken)
	local message, distance, sender = net:receive()
	return message
end

-- Mail API

function sendMail(to, authToken, topic, body)
	net:send('sendMail~'..to..'~'..authToken..'~'..topic..'~'..body)
	local message, distance, sender = net:receive()
	return message
end

function showInboxHistory(authToken)
	net:send('showInboxHistory~'..authToken)
	local message, distance, sender = net:receive()
	return message
end

function showInbox(authToken)
	net:send('showInbox~'..authToken)
	local message, distance, sender = net:receive()
	return message
end

function readMail(authToken, mailName)
	net:send('readMail~'..authToken..'~'..mailName)
	local message, distance, sender = net:receive()
	return message
end

function deleteMail(authToken, mailName)
	net:send('deleteMail~'..authToken..'~'..mailName)
	local message, distance, sender = net:receive()
	return message
end

function showUserInbox(authToken, username)
	net:send('showUserInbox~'..authToken..'~'..username)
	local message, distance, sender = net:receive()
	return message
end

function showUserInboxHistory(authToken, username)
	net:send('showUserInboxHistory~'..authToken..'~'..username)
	local message, distance, sender = net:receive()
	return message
end

function readUserMail(authToken, username, mailName)
	net:send('readUserMail~'..authToken..'~'..username..'~'..mailName)
	local message, distance, sender = net:receive()
	return message
end

function deleteUserMail(authToken, username, mailName)
	net:send('deleteUserMail~'..authToken..'~'..username..'~'..mailName)
	local message, distance, sender = net:receive()
	return message
end

-- News API

function readNews(title)
	net:send('readNews~'..title)
	local message, distance, sender = net:receive()
	return message
end

function showNews()
	net:send('showNews')
	local message, distance, sender = net:receive()
	return message
end

function addArticle(authToken, title, text)
	net:send('addArticle~'..authToken..'~'..title..'~'..text)
	local message, distance, sender = net:receive()
	return message
end

function removeArticle(authToken, title)
	net:send('removeArticle~'..authToken..'~'..title)
	local message, distance, sender = net:receive()
	return message
end

function updateArticle(authToken, title, text)
	net:send('updateArticle~'..authToken..'~'..title..'~'..text)
	local message, distance, sender = net:receive()
	return message
end