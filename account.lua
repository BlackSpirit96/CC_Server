-- login API / Account and Profile management
-- Author: Black_Spirit
-- Version 0.1

-- table.file( table tbl, str path, str file)
-- converts table to file
-- return success / error
function table.file( tbl, path)
	local file = fs.open(tbl,"w")
	file.write(textutils.serialize(tbl))
	file.close()
end

-- file.table( str path)
-- converts file to table
-- return table
function file.table(path)
	local file = fs.open(path,"r")
	local data = file.readAll()
	file.close()
	return textutils.unserialize(data)
end

-- file.writeData(str path, str data, str mode)
-- writes data to file with mode
function file.writeData(path, data, mode)
	local file = fs.open(path, mode)
	file.write(data)
	file.close(file)
end

-- returnFile(str path)
-- return file content
function returnFile(path)
	local file = fs.open(path)
	local data =  file.readAll()
	file.close()
	return data
end

-- searchElement.table(table tbl, str element)
-- search tbl to find element
-- return key where element is located or nil if not
function searchElement.table(tbl, element)
	for key, value in pairs(tbl) do
		if value == element then
			return key
		end
	end
end

-- makeString(int length)
-- generates a random string
-- return random string
function makeString(l)
    if l < 1 then return nil end -- Check for l < 1
    local s = "" -- Start string
    for i = 1, l do
        s = s .. string.char(math.random(33, 126)) -- Generate random number from 32 to 126, turn it into character and add to string
    end
    return s -- Return string
end

-- authToken.Gen()
-- generates an authToken
-- return authToken
function authToken.Gen()
	return makeString(10)
end

-- authToken.Init()
-- generates the authTokens table
-- return success
function authToken.Init()
	local accounts = file.table("accounts/accounts.table")
	local authTokens = {}
	for key, value in accounts do
		authTokens[key] = authToken.Gen()
	end
	table.file(authTokens, "accounts/authTokens.table")
end

-- login( str username, str password)
-- login procedure
-- return str authtoken / error
function login(username, password)
	local accounts = file.table("accounts/accounts.table")
	local authTokens = file.table("accounts/authTokens.table")
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

-- authToken.username(str authToken)
-- converts authToken to username
-- return str username / nil
function authToken.username(authToken)
	local authTokens = file.table( "accounts/authTokens.table")
	return searchElement.table( authTokens, authToken)
end

-- authToken.lvl(str authToken)
-- finds and return the user level
-- 0 = Guest, 10 = Author, 25 = Moderator, 50 = Admin, 100 = Owner
-- return userLevel / error
function authToken.lvl(authToken)
	local username = authToken.username(authToken)
	local userLevels = file.table( "accounts/userLevels.table")
	if username == nil then
		return "User does not exist!"
	else
		return userLevels[username]
	end
end

-- changePassword( str authToken, str oldPassword, str newPassword)
-- changes oldPassword with newPassword
-- return success / error
function changePassword(authToken, oldPassword, newPassword)
	local username = authToken.username(authToken)
	local accounts = file.table( "accounts/accounts.table")
	if username == nil then
		return "Invalid user!"
	else
		if accounts[username] == oldPassword then
			accounts[username] = newPassword
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
	local username = authToken.username(authToken)
	local accounts = file.table( "accounts/accounts.table")
	if username == nil then
		return "Invalid user!"
	else
		if accounts[username] == password then
			-- delete file <"accounts/profiles/"..username>
			file.writeData("accounts/profiles/"..username, data, 'w')
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
	local user = authToken.username(authToken)
	if user = nil then
		return "You are not logged in!"
	else
		return returnFile("accounts/profiles/"..username)
	end
end

-- addAccount(str authToken, str password, str username, str userPassword, int userLevel)
-- add username account with userPassword as password
-- return success / error
function addAccount(authToken, password, username, userPassword, userLevel)
	local user = authToken.username(authToken)
	local accounts = file.table( "accounts/accounts.table")
	local authTokens = file.table( "accounts/authTokens.table")
	local userLevels = file.table( "accounts/userLevels.table")
	if user == nil then
		return "You are not logged in!"
	else
		if authToken.lvl(authToken) >= 25 then
			if accounts[user] == password then
				accounts[username] = userPassword
				authTokens[username] = authToken.Gen()
				userLevels[username] = userLevel
				table.file(accounts,"accounts/accounts.table")
				table.file(authTokens,"accounts/authTokens.table")
				table.file(userLevels,"accounts/userLevels.table")
				fs.makeDir("mailFolder/"..username)
				--file.writeData("accounts/accounts.table", ????, 'a')
				--file.writeData("accounts/authTokens.table", ????, 'a')
				return "Success!"
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
	local user = authToken.username(authToken)
	local accounts = file.table( "accounts/accounts.table")
	local authTokens = file.table( "accounts/authTokens.table")
	if user == nil then
		return "You are not logged in!"
	else
		if authToken.lvl(authToken) >= 50 then
			if accounts[user] == password then
				if isValidUser(username) then
					accounts[username] = nil
					authTokens[username] = nil
					table.file(accounts,"accounts/accounts.table")
					table.file(authTokens,"accounts/authTokens.table")
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
	local user = authToken.username(authToken)
	local accounts = file.table( "accounts/accounts.table")
	local authTokens = file.table( "accounts/authTokens.table")
	if user == nil then
		return "You are not logged in!"
	else
		if authToken.lvl(authToken) >= 25 then
			if accounts[user] == password then
				if isValidUser(username) then
					updateProfile(authTokens[username], accounts[username], data)
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
	local user = authToken.username(authToken)
	local accounts = file.table( "accounts/accounts.table")
	local authTokens = file.table( "accounts/authTokens.table")
	if user == nil then
		return "You are not logged in!"
	else
		if authToken.lvl(authToken) >= 25 then
			if accounts[user] == password then
				if isValidUser(username) then
					changePassword(authTokens[username], accounts[username], newPassword)
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
	local accounts = file.table( "accounts/accounts.table")
	if accounts[username] ~= nil then
		return true
	else
		return false
	end
end

-- username.authToken(str username)
-- return authToken / error
function username.authToken(username)
	local authTokens = file.table( "accounts/authTokens.table")
	if isValidUser(username) then
		return authTokens[username]
	else
		return "Invalid username!"
	end
end