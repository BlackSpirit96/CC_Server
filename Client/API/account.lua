-- Account Service API
-- Author: Black_Spirit
-- Version: 0.1

function login(username, password)
	return 'login '..username..' '..password
end

function changePassword(authToken, oldPassword, newPassword)
	return 'changePassword '..authToken..' '..oldPassword..' '..newPassword
end

function updateProfile(authToken, password, data)
	return 'updateProfile '..authToken..' '..password..' '..data
end

function showProfile(authToken, username)
	return 'showProfile '..authToken..' '..username
end

function addAccount(authToken, password, username, userPassword, userLVL)
	return 'addAccount '..authToken..' '..password..' '..username..' '..userPassword..' '..userLVL
end

function removeAccount(authToken, password, username)
	return 'removeAccount '..authToken..' '..password..' '..username
end

function changeProfile(authToken, password, username, data)
	return 'changeProfile '..authToken..' '..password..' '..username..' '..data
end

function changeUserPassword(authToken, password, username, newPassword)
	return 'changeUserPassword '..authToken..' '..password..' '..username..' '..newPassword
end