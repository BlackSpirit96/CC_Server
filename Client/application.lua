-- Main client_side application
-- Designed for current server
-- Author: Black_Spirit
-- Version: 0.1

-- API Time!
os.loadAPI("API/account")
os.loadAPI("API/iNet")
os.loadAPI("API/mail")
os.loadAPI("API/news")
os.loadAPI("API/util")

-- Initialization
print("Opening application!")

local authToken = "guestUserX"
local net = iNet.open(20, 15, "right")
local username = "Guest"

-- userLvl(str authToken)
-- return the users current lvl
-- return userLvl
function userLvl(authToken)
	net:send(account.authTokenLvl(authToken))
	local message, distance, sender = net:receive()
	return message
end

-- account service functions

function login()
	print("Login proccess started!")
	term.write("Enter username:")
	local user = read()
	term.write("Enter password:")
	local password = read("*")
	net:send(account.login(user, password))
	local message, distance, sender = net:receive()
	if message ~= "Invalid password!" and message ~= "This account does not exist!" then
		authToken = message
		username = user
		print("Success!")
	else
		print(message)
	end
end

function changePassword()
	print("Change password proccess!")
	term.write("Enter current password:")
	local oldPassword = read("*")
	term.write("Enter new password:")
	local newPassword = read("*")
	term.write("Enter new password again:")
	local newPassword2 = read("*")
	if newPassword == newPassword2 then
		net:send(account.changePassword(authToken, oldPassword, newPassword))
		local message, distance, sender = net:receive()
		print(message)
	else
		print("You typed the new password wrong!")
	end
end

function updateProfile()
	print("You started the proccess to change your profile data.")
	term.write("Enter your password to procced:")
	local password = read("*")
	print("Enter your new profile data:")
	local data = read()
	if data ~= nil then
		net:send(account.updateProfile(authToken, password, data))
		local message, distance, sender = net:receive()
		print(message)
	else
		print("You cannot provide blank info.")
	end
end

function showProfile()
	term.write("Enter the username you want to show its profile data:")
	local username = read()
	net:send(account.showProfile(authToken, username))
	local message, distance, sender = net:receive()
	print(message)
end

function addAccount()
	print("Add account proccess!")
	term.write("Enter new accounts username:")
	local username = read()
	term.write("Enter new accounts password:")
	local userPassword = read("*")
	term.write("Enter new accounts LVL:")
	local userLVL = read()
	term.write("Enter your password to authorize the action.")
	local password = read("*")
	net:send(account.addAccount(authToken, password, username, userPassword, userLVL))
	local message, distance, sender = net:receive()
	print(message)
end

function removeAccount()
	print("Remove account proccess!")
	term.write("Enter the username of the user you want to delete:")
	local username = read()
	term.write("Enter your password to authorize the action:")
	local password = read("*")
	net:send(account.removeAccount(authToken, password, username))
	local message, distance, sender = net:receive()
	print(message)
end

function changeProfile()
	print("Change users profile data proccess!")
	term.write("Enter the username of the victim:")
	local username = read()
	print("Enter new profile data:")
	local data = read()
	term.write("Enter your password to authorize the action:")
	local password = read("*")
	net:send(account.changeProfile(authToken, password, username, data))
	local message, distance, sender = net:receive()
	print(message)
end

function changeUserPassword()
	print("Change users password proccess!")
	term.write("Enter the username of the victim:")
	local username = read()
	term.write("Enter the new victims password:")
	local newPassword = read("*")
	term.write("Enter your password to authorize the action:")
	local password = read("*")
	net:send(account.changeUserPassword(authToken, password, username, newPassword))
	local message, distance, sender = net:receive()
	print(message)
end

-- mail service functions

function sendMail()
	print("Send a mail proccess.")
	term.write("Enter receiver username:")
	local to = read()
	term.write("Enter mail topic:")
	local topic = read()
	print("Enter mail body:")
	local body = read()
	net:send(mail.sendMail(to, authToken, topic, body))
	local message, distance, sender = net:receive()
	print(message)
end

function showInboxHistory()
	print("Your inbox history.")
	net:send(mail.showInboxHistory(authToken))
	local message, distance, sender = net:receive()
	print(message)
end

function showInbox()
	print("Your inbox.")
	net:send(mail.showInbox(authToken))
	local message, distance, sender = net:receive()
	print(message)
end

function readMail()
	showInbox()
	term.write("Enter the mailName you want to read:")
	local mailName = read()
	net:send(mail.readMail(authToken, mailName))
	local message, distance, sender = net:receive()
	print(message)
end

function deleteMail()
	showInbox()
	term.write("Enter the mailName you want to delete:")
	local mailName = read()
	net:send(mail.deleteMail(authToken, mailName))
	local message, distance, sender = net:receive()
	print(message)
end

function showUserInbox()
	print("Show usename inbox proccess.")
	term.write("Enter username:")
	local username = read()
	net:send(mail.showUserInbox(authToken, username))
	local message, distance, sender = net:receive()
	print(message)
end

function showUserInboxHistory()
	print("Show usename inbox history proccess.")
	term.write("Enter username:")
	local username = read()
	net:send(mail.showUserInboxHistory(authToken, username))
	local message, distance, sender = net:receive()
	print(message)
end

function readUserMail()
	print("Read username mail proccess!")
	showUserInboxHistory()
	term.write("Re enter username:")
	local username = read()
	term.write("Enter mailName:")
	local mailName = read()
	net:send(mail.readUserMail(authToken, username, mailName))
	local message, distance, sender = net:receive()
	print(message)
end

function deleteUserMail()
	print("Delete users mail!")
	showUserInbox()
	term.write("Re enter username:")
	local username = read()
	term.write("Enter mailName:")
	local mailName = read()
	net:send(mail.deleteUserMail(authToken, username, mailName))
	local message, distance, sender = net:receive()
	print(message)
end

-- news service functions

function showNews()
	print("Current news!")
	net:send(news.showNews())
	local message, distance, sender = net:receive()
	print(message)
end

function readNews()
	showNews()
	term.write("Enter title to read:")
	local title = read()
	net:send(news.readNews(title))
	local message, distance, sender = net:receive()
	print(message)
end

function addArticle()
	print("Adding new article proccess.")
	term.write("Enter title:")
	local title = read()
	print("Enter article text:")
	local text = read()
	net:send(news.addArticle(authToken, title, text))
	local message, distance, sender = net:receive()
	print(message)
end

function removeArticle()
	print("Remove article proccess!")
	term.write("Enter article title:")
	local title = read()
	net:send(news.removeArticle(authToken, title))
	local message, distance, sender = net:receive()
	print(message)
end

function updateArticle()
	print("Update article procces!")
	term.write("Enter article title you want to update:")
	local title = read()
	term.write("Enter text you want to add to the article:")
	local text = read()
	net:send(news.updateArticle(authToken, title, text))
	local message, distance, sender = net:receive()
	print(message)
end

-- menu functions

function showAccountManagment()
	
	while true do
		print("Current user:"..username)
		print("Available options:")
		if authToken == nil or authToken == "guestUserX" then
			print(" [1] Login")
			print(" [2] Exit")
			term.write("> ")
			local choice = read()
			if choice == 1 then
				login()
			elseif choice == 2 then
				print("Good bye "..username.."!")
				break
			else
				print("Invalid choice!")
			end
		else
			print(" [1] Change Password")
			print(" [2] Update Profile")
			print(" [3] Show Profile")
			print(" [4] Exit")
			if userLvl(authToken) >= 25 then
				print("Admin Options!")
				print(" [5] Add Account")
				print(" [6] Remove Account")
				print(" [7] Change Profile Info")
				print(" [8] Change User Password")
			end
			term.while("> ")
			local choice = read()
			if choice == 1 then
				changePassword()
			elseif choice == 2 then
				updateProfile()
			elseif choice == 3 then
				showProfile()
			elseif choice == 4 then
				print("Good bye "..username.."!")
				break
			elseif choice == 5 and userLvl(authToken) >= 25 then
				addAccount()
			elseif choice == 6 userLvl(authToken) >= 25 then
				removeAccount()
			elseif choice == 7 userLvl(authToken) >= 25 then
				changeProfile()
			elseif choice == 8 userLvl(authToken) >= 25 then
				changeUserPassword()
			else
				print("Invalid choice!")
			end
		end
	end
end

function showMainMenu()
	print("Current user:"..username)
	print("Available options:")
	print(" [1] Account managment")
	print(" [2] Mail application")
	print(" [3] News application")
	print(" [4] Exit")
end

-- main loop
while true do
	showMainMenu()
	term.write("> ")
	local choice = read()
	if choice == 1 then
		showAccountManagment()
	elseif choice == 2 then
		showMailMenu()
	elseif choice == 3 then
		showNewsMenu()
	elseif choice == 4 then
		print("Good bye "..username.."!")
		break
	else
		print("Invalid choice!")
	end
end