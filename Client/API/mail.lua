-- Mail Service API
-- Author: Black_Spirit
-- Version: 0.1

function sendMail(to, authToken, topic, body)
	return 'sendMail~'..to..'~'..authToken..'~'..topic..'~'..body
end

function showInboxHistory(authToken)
	return 'showInboxHistory~'..authToken
end

function showInbox(authToken)
	return 'showInbox~'..authToken
end

function readMail(authToken, mailName)
	return 'readMail~'..authToken..'~'..mailName
end

function deleteMail(authToken, mailName)
	return 'deleteMail~'..authToken..'~'..mailName
end

function showUserInbox(authToken, username)
	return 'showUserInbox~'..authToken..'~'..username
end

function showUserInboxHistory(authToken, username)
	return 'showUserInboxHistory~'..authToken..'~'..username
end

function readUserMail(authToken, username, mailName)
	return 'readUserMail~'..authToken..'~'..username..'~'..mailName
end

function deleteUserMail(authToken, username, mailName)
	return 'deleteUserMail~'..authToken..'~'..username..'~'..mailName
end