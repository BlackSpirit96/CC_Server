-- Mail Service API
-- Author: Black_Spirit
-- Version: 1.1.1

-- dependencies 
os.loadAPI("API/account")
os.loadAPI("API/util")
os.loadAPI("API/log")

-- log object
logger = log.new("LOG/mail.log")

-- sendMail( str to, str authToken, str topic, str body)
-- sends a mail to 'to'
-- return success / error
function sendMail(to, authToken, topic, body)
	local username = account.authTokenUsername(authToken)
	if username ~= nil then
		if account.isValidUser(to) then
			local mailID = util.makeString(6)
			local file = fs.open("mailFolder/"..to.."/"..mailID, 'w')
			local logFile = fs.open("mailFolder/"..to.."/logFile.log", 'a')
			file.write("From: ".. username..'\n')
			file.write("Topic: "..topic..'\n')
			file.write("Main Body:\n"..body)
			file.close()
			logFile.write("ID: \""..mailID.."\" Topic: \""..topic.."\" From: \""..username.."\" Time: \""..os.time().."\"\n")
			logFile.close()
			return "Success!"
		else
			return "The user you are trying to send the mail does not exist!"
		end
	else
		return "You are not logged in!"
	end
end

-- showInboxHistory(str authToken)
-- shows inbox history
-- return history / error
function showInboxHistory(authToken)
	local username = account.authTokenUsername(authToken)
	if username ~= nil then
		if fs.exists("mailFolder/"..username.."/logFile.log") then
			return util.returnFile("mailFolder/"..username.."/logFile.log")
		else
			return "File does not exist!"
		end
	else
		return "You are not logged in!"
	end
end

-- showInbox( str authToken)
-- shows all the mails
-- return mailList
function showInbox(authToken)
	local username = account.authTokenUsername(authToken)
	if username ~= nil then
		local mailList = fs.list("mailFolder/"..username)
		local mailListStr = ""
		for i=1, table.getn(mailList) do
			mailListStr = mailListStr..mailList[i].."\n"
		end
		return mailListStr
	else
		return "You are not logged in!"
	end
end

-- readMail(str authToken, str mailName)
-- checks if mailName exists and
-- return the content of mailName / error
function readMail(authToken, mailName)
	local username = account.authTokenUsername(authToken)
	if username ~= nil then
		if fs.exists("mailFolder/"..username..'/'..mailName) then
			return util.returnFile("mailFolder/"..username..'/'..mailName)
		else
			return "Invalid mailName!"
		end
	else
		return "You are not logged in!"
	end
end

-- deleteMail(str authToken, str mailName)
-- deletes mailName if mailName = "All" then it deletes all
-- return success / error
function deleteMail(authToken, mailName, adminAction)
	local username = account.authTokenUsername(authToken)
	if username ~= nil then
		if fs.exists("mailFolder/"..username..'/'..mailName) then
			if mailName ~= "All" then
				fs.delete("mailFolder/"..username..'/'..mailName)
				local logFile = fs.open("mailFolder/"..username.."/logFile.log", 'a')
				if not adminAction then
					logFile.write("DELETED - ID: \""..mailName.."\" Time: \""..os.time().."\"\n")
				else
					logFile.write("DELETED - ID: \""..mailName.."\" Time: \""..os.time().."\"".." - Admin Action\n")
				end
				logFile.close()
			else
				local mailList = fs.list("mailFolder/"..username)
				local logFile = fs.open("mailFolder/"..username.."/"..logFile.log, 'a')
				for i=1, table.getn(mailList) do
					if not adminActio then
						logFile.write("DELETED - ID: \""..mailList[i].."\" Time: \""..os.time())
					else
						logFile.write("DELETED - ID: \""..mailName.."\" Time: \""..os.time().."Admin Action")
					end
					fs.delete(mailList[i])
				end
				logFile.close()
			end
			return "Success!"
		else
			return "Invalid mailName!"
		end
	else
		return "You are not logged in!"
	end
end


-- showUserInbox(str authToken, str username)
-- shows username inbox
-- return inbox / error
function showUserInbox(authToken, username)
	local user = account.authTokenUsername(authToken)
	if user ~= nil then
		if tonumber(account.authTokenLvl(authToken)) >= 25 then
			logger:logFile(2, user.." Read "..username.." inbox")
			return showInbox(account.usernameAuthToken(username))
		else
			return "You are not authorized to do that!"
		end
	else
		return "You are not logged in!"
	end
end

-- readUserMail( str authToken, str username, str mailName)
-- read username mailName mail
-- return mail / error
function readUserMail(authToken, username, mailName)
	local user = account.authTokenUsername(authToken)
	if user ~= nil then
		if tonumber(account.authTokenLvl(authToken)) >= 25 then
			logger:logFile(2, user.." Read "..username.." mail with ID:"..mailName)
			return readMail(account.usernameAuthToken(username), mailName)
		else
			return "You are not authorized to do that!"
		end
	else
		return "You are not logged in!"
	end
end

-- deleteUserMail( str authToken, str username, str mailName)
-- deletes username mailName mail
-- return success / error
function deleteUserMail(authToken, username, mailName)
	local user = account.authTokenUsername(authToken)
	if user ~= nil then
		if tonumber(account.authTokenLvl(authToken)) >= 25 then
			logger:logFile(2, user.." Deleted "..username.." mail with ID:"..mailName)
			return deleteMail(account.usernameAuthToken(username), mailName, true)
		else
			return "You are not authorized to do that!"
		end
	else
		return "You are not logged in!"
	end
end

-- showUserInboxHistory(str authToken, str username)
-- shows username inbox history
-- return history / error
function showUserInboxHistory(authToken, username)
	local user = account.authTokenUsername(authToken)
	if user ~= nil then
		if tonumber(account.authTokenLvl(authToken)) >= 25 then
			logger:logFile(2, user.." Read "..username.." history")
			return showInboxHistory(account.usernameAuthToken(username))
		else
			return "You are not authorized to do that!"
		end
	else
		return "You are not logged in!"
	end
end