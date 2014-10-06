-- Account and Profile Service API
-- Author: Black_Spirit
-- Version 0.1.7

-- dependencies 
os.loadAPI("API/util")
os.loadAPI("API/log")

-- log object
logger = log.new("LOG/account.log")

-- authTokenGen()
-- generates an authToken
-- return authToken
function authTokenGen()
	return util.makeString(10)
end

-- authTokenInit()
-- generates the authTokens table
-- return success
function authInit()
	logger:logFile(2, "Init stage!")
	if fs.exists("accounts/accounts.table")then
		local accounts = util.fileTable("accounts/accounts.table")
		local authTokens = {}
		for key, value in pairs(accounts) do
			authTokens[key] = authTokenGen()
		end
		util.tableFile(authTokens, "accounts/authTokens.table")
	else
		print("First time run!")
		print("Prepearing default account!")
		local accounts = {}
		local authTokens = {}
		local userLevels = {}
		util.tableFile(accounts,"accounts/accounts.table")
		util.tableFile(authTokens,"accounts/authTokens.table")
		util.tableFile(userLevels,"accounts/userLevels.table")
		createAccount("Admin", "DAHACKER", 100)
	end
end

-- login( str username, str password)
-- login procedure
-- return str authtoken / error
function login(username, password)
	local accounts = util.fileTable("accounts/accounts.table")
	local authTokens = util.fileTable("accounts/authTokens.table")
	if accounts[username] ~= nil then
		if accounts[username] == password then
			return authTokens[username]
		else
			return "Invalid password!"
		end
	else
		return "This account does not exist!"
	end
end

-- authTokenUsername(str authToken)
-- converts authToken to username
-- return str username / nil
function authTokenUsername(authToken)
	local authTokens = util.fileTable( "accounts/authTokens.table")
	return util.searchElementIntable( authTokens, authToken)
end

-- authTokenLvl(str authToken)
-- finds and return the user level
-- 0 = Guest, 10 = Author, 25 = Moderator, 50 = Admin, 100 = Owner
-- return userLevel / error
function authTokenLvl(authToken)
	local username = authTokenUsername(authToken)
	local userLevels = util.fileTable( "accounts/userLevels.table")
	if username == nil then
--		return "User does not exist!"
		return 0
	else
		return userLevels[username]
	end
end

-- changePassword( str authToken, str oldPassword, str newPassword)
-- changes oldPassword with newPassword
-- return success / error
function changePassword(authToken, oldPassword, newPassword)
	local username = authTokenUsername(authToken)
	local accounts = util.fileTable( "accounts/accounts.table")
	if username == nil then
		return "Invalid user!"
	else
		if accounts[username] == oldPassword then
			accounts[username] = newPassword
			util.tableFile(accounts,"accounts/accounts.table")
			return "Success!"
		else
			return "oldPassword does not match"
		end
	end
end

-- updateProfile( str authToken, str password, str data)
-- updates profile data with new info
-- return success / error
function updateProfile(authToken, password, data)
	local username = authTokenUsername(authToken)
	local accounts = util.fileTable( "accounts/accounts.table")
	if username == nil then
		return "Invalid user!"
	else
		if accounts[username] == password then
			-- delete file <"accounts/profiles/"..username>
			util.writeData("accounts/profiles/"..username, data, 'w')
			return "Success!"
		else
			return "Invalid password!"
		end
	end
end

-- showProfile( str authToken, str username)
-- show usernames' profileData
-- return profileData/ error
function showProfile(authToken, username)
	local user = authTokenUsername(authToken)
	if user == nil then
		return "You are not logged in!"
	else
		if fs.exists("accounts/profiles/"..username) then
			return util.returnFile("accounts/profiles/"..username)
		else
			return "Profile data does not exist!"
		end
	end
end

-- createAccount( str username, str password, str userLevel)
-- add username account with userPassword as password and level userLevel
-- return success
function createAccount(username, password, userLevel)
	if not(isValidUser(username)) then
		local accounts = util.fileTable( "accounts/accounts.table")
		local authTokens = util.fileTable( "accounts/authTokens.table")
		local userLevels = util.fileTable( "accounts/userLevels.table")
		accounts[username] = password
		authTokens[username] = authTokenGen()
		userLevels[username] = userLevel
		util.tableFile(accounts,"accounts/accounts.table")
		util.tableFile(authTokens,"accounts/authTokens.table")
		util.tableFile(userLevels,"accounts/userLevels.table")
		fs.makeDir("mailFolder/"..username)
		return "Success!"
	else
		return "Username already exists!"
	end
end

-- addAccount(str authToken, str password, str username, str userPassword, int userLevel)
-- add username account with userPassword as password
-- return success / error
function addAccount(authToken, password, username, userPassword, userLevel)
	local user = authTokenUsername(authToken)
	local accounts = util.fileTable( "accounts/accounts.table")
	local authTokens = util.fileTable( "accounts/authTokens.table")
	local userLevels = util.fileTable( "accounts/userLevels.table")
	if user == nil then
		return "You are not logged in!"
	else
		if tonumber(authTokenLvl(authToken)) >= 25 then
			if accounts[user] == password then
				logger:logFile(2, user.." Added a new account with username:"..username)
				return createAccount(username, userPassword, userLevel)
			else
				return "Invalid password!"
			end
		else
			return "You are not authorized to do that!"
		end
	end
end

-- removeAccount(str authToken, str password, str username)
-- removes username account from server
-- return success / error
function removeAccount(authToken, password, username)
	local user = authTokenUsername(authToken)
	local accounts = util.fileTable( "accounts/accounts.table")
	local authTokens = util.fileTable( "accounts/authTokens.table")
	if user == nil then
		return "You are not logged in!"
	else
		if tonumber(authTokenLvl(authToken)) >= 50 then
			if accounts[user] == password then
				if isValidUser(username) then
					accounts[username] = nil
					authTokens[username] = nil
					util.tableFile(accounts,"accounts/accounts.table")
					util.tableFile(authTokens,"accounts/authTokens.table")
					logger:logFile(2, user.." Removed an existing account with username:"..username)
					return "Success!"
				else
					return "This username does not exist!"
				end
			else
				return "Invalid password!"
			end
		else
			return "You are not authorized to do that!"
		end
	end
end

-- changeProfile( str authToken, str password, str username, str data)
-- changes username profile data/info
-- return success / error
function changeProfile(authToken, password, username, data)
	local user = authTokenUsername(authToken)
	local accounts = util.fileTable( "accounts/accounts.table")
	local authTokens = util.fileTable( "accounts/authTokens.table")
	if user == nil then
		return "You are not logged in!"
	else
		if tonumber(authTokenLvl(authToken)) >= 25 then
			if accounts[user] == password then
				if isValidUser(username) then
					updateProfile(authTokens[username], accounts[username], data)
					logger:logFile(2, user.." Changed account data of username:"..username)
					return "Success!"
				else
					return "This username does not exist!"
				end
			else
				return "Invalid password!"
			end
		else
			return "You are not authorized to do that!"
		end
	end
end

-- changeUserPassword(str authToken, str password, str username, str newPassword)
-- changes username password to newPassword
-- return success / error
function changeUserPassword(authToken, password, username, newPassword)
	local user = authTokenUsername(authToken)
	local accounts = util.fileTable( "accounts/accounts.table")
	local authTokens = util.fileTable( "accounts/authTokens.table")
	if user == nil then
		return "You are not logged in!"
	else
		if tonumber(authTokenLvl(authToken)) >= 25 then
			if accounts[user] == password then
				if isValidUser(username) then
					changePassword(authTokens[username], accounts[username], newPassword)
					logger:logFile(2, user.." Changed password of username:"..username)
					return "Success!"
				else
					return "This username does not exist!"
				end
			else
				return "Invalid password!"
			end
		else
			return "You are not authorized to do that!"
		end
	end
end

-- isValidUser(str username)
-- checks if username is valid
-- return true / false
function isValidUser(username)
	local accounts = util.fileTable( "accounts/accounts.table")
	if accounts[username] ~= nil then
		return true
	else
		return false
	end
end

-- usernameAuthToken(str username)
-- return authToken / error
function usernameAuthToken(username)
	local authTokens = util.fileTable( "accounts/authTokens.table")
	if isValidUser(username) then
		return authTokens[username]
	else
		return "Invalid username!"
	end
end