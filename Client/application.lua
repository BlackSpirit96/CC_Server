-- Main client_side application
-- Designed for current server
-- Author: Black_Spirit
-- Version: 1.1.1

-- API Time!
os.loadAPI("API/client_api")
os.loadAPI("API/util")
local account = client_api.account
local news = client_api.news
local mail = client_api.mail

-- Initialization
print("Opening application!")

local authToken = "guestUserX"
local username = "Guest"

-- userLvl(str authToken)
-- return the users current lvl
-- return userLvl
function userLvl(authToken)
	local message = account.authTokenLvl(authToken)
	return message
end

-- printPause(string message)
-- prints message and then pauses the screen
function printPause(message)
	print(message)
	io.write("Press <Enter> to continue...")
	io.read()
end

-- account service functions

function login()
	print("Login proccess started!")
	term.write("Enter username:")
	local user = read()
	term.write("Enter password:")
	local password = read("*")
	local message = account.login(user, password)
	if message ~= "Invalid password!" and message ~= "This account does not exist!" then
		authToken = message
		username = user
		printPause("Success!")
	else
		printPause(message)
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
		local message = account.changePassword(authToken, oldPassword, newPassword)
		printPause(message)
	else
		printPause("You typed the new password wrong!")
	end
end

function updateProfile()
	print("You started the proccess to change your profile data.")
	term.write("Enter your password to procced:")
	local password = read("*")
	print("Enter your new profile data:")
	local data = read()
	if data ~= nil then
		local message = account.updateProfile(authToken, password, data)
		printPause(message)
	else
		printPause("You cannot provide blank info.")
	end
end

function showProfile()
	term.write("Enter the username you want to show its profile data:")
	local username = read()
	local message = account.showProfile(authToken, username)
	printPause(message)
end

function addAccount()
	print("Add account proccess!")
	term.write("Enter new accounts username:")
	local username = read()
	term.write("Enter new accounts password:")
	local userPassword = read("*")
	term.write("Enter new accounts LVL:")
	local userLVL = read()
	term.write("Enter your password to authorize the action:")
	local password = read("*")
	local message = account.addAccount(authToken, password, username, userPassword, userLVL)
	printPause(message)
end

function removeAccount()
	print("Remove account proccess!")
	term.write("Enter the username of the user you want to delete:")
	local username = read()
	term.write("Enter your password to authorize the action:")
	local password = read("*")
	local message = account.removeAccount(authToken, password, username)
	printPause(message)
end

function changeProfile()
	print("Change users profile data proccess!")
	term.write("Enter the username of the victim:")
	local username = read()
	print("Enter new profile data:")
	local data = read()
	term.write("Enter your password to authorize the action:")
	local password = read("*")
	local message = account.changeProfile(authToken, password, username, data)
	printPause(message)
end

function changeUserPassword()
	print("Change users password proccess!")
	term.write("Enter the username of the victim:")
	local username = read()
	term.write("Enter the new victims password:")
	local newPassword = read("*")
	term.write("Enter your password to authorize the action:")
	local password = read("*")
	local message = account.changeUserPassword(authToken, password, username, newPassword)
	printPause(message)
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
	local message = mail.sendMail(to, authToken, topic, body)
	printPause(message)
end

function showInboxHistory()
	print("Your inbox history.")
	local message = mail.showInboxHistory(authToken)
	printPause(message)
end

function showInbox()
	print("Your inbox.")
	local message = mail.showInbox(authToken)
	printPause(message)
end

function readMail()
	showInbox()
	term.write("Enter the mailName you want to read:")
	local mailName = read()
	local message = mail.readMail(authToken, mailName)
	printPause(message)
end

function deleteMail()
	showInbox()
	term.write("Enter the mailName you want to delete:")
	local mailName = read()
	local message = mail.deleteMail(authToken, mailName)
	printPause(message)
end

function showUserInbox()
	print("Show usename inbox proccess.")
	term.write("Enter username:")
	local username = read()
	local message = mail.showUserInbox(authToken, username)
	printPause(message)
end

function showUserInboxHistory()
	print("Show usename inbox history proccess.")
	term.write("Enter username:")
	local username = read()
	local message = mail.showUserInboxHistory(authToken, username)
	printPause(message)
end

function readUserMail()
	print("Read username mail proccess!")
	showUserInboxHistory()
	term.write("Re enter username:")
	local username = read()
	term.write("Enter mailName:")
	local mailName = read()
	local message = mail.readUserMail(authToken, username, mailName)
	printPause(message)
end

function deleteUserMail()
	print("Delete users mail!")
	showUserInbox()
	term.write("Re enter username:")
	local username = read()
	term.write("Enter mailName:")
	local mailName = read()
	local message = mail.deleteUserMail(authToken, username, mailName)
	printPause(message)
end

-- news service functions

function showNews()
	print("Current news!")
	local message = news.showNews()
	printPause(message)
end

function readNews()
	showNews()
	term.write("Enter title to read:")
	local title = read()
	local message = news.readNews(title)
	printPause(message)
end

function addArticle()
	print("Adding new article proccess.")
	term.write("Enter title:")
	local title = read()
	print("Enter article text:")
	local text = read()
	local message = news.addArticle(authToken, title, text)
	printPause(message)
end

function removeArticle()
	print("Remove article proccess!")
	term.write("Enter article title:")
	local title = read()
	local message = news.removeArticle(authToken, title)
	printPause(message)
end

function updateArticle()
	print("Update article procces!")
	term.write("Enter article title you want to update:")
	local title = read()
	term.write("Enter text you want to add to the article:")
	local text = read()
	local message = news.updateArticle(authToken, title, text)
	printPause(message)
end

-- menu functions

function showAccountManagment()
	while true do
		print("Current user:"..username)
		print("Available options:")
		if authToken == nil or authToken == "guestUserX" then
			print(" [1] Login")
			print(" [Q] Exit")
			term.write("> ")
			local choice = read()
			if choice == '1' then
				login()
			elseif choice == 'Q' then
				printPause("Leaving Account Management!")
				break
			else
				printPause("Invalid choice!")
			end
		else
			print(" [1] Change Password")
			print(" [2] Update Profile")
			print(" [3] Show Profile")
			print(" [Q] Exit")
			if tonumber(userLvl(authToken)) >= 25 then
				print("Admin Options!")
				print(" [4] Add Account")
				print(" [5] Remove Account")
				print(" [6] Change Profile Info")
				print(" [7] Change User Password")
			end
			term.write("> ")
			local choice = read()
			if choice == '1' then
				changePassword()
			elseif choice == '2' then
				updateProfile()
			elseif choice == '3' then
				showProfile()
			elseif choice == 'Q' then
				printPause("Leaving Account Management!")
				break
			elseif choice == '4' and tonumber(userLvl(authToken)) >= 25 then
				addAccount()
			elseif choice == '5' and tonumber(userLvl(authToken)) >= 25 then
				removeAccount()
			elseif choice == '6' and  tonumber(userLvl(authToken)) >= 25 then
				changeProfile()
			elseif choice == '7' and  tonumber(userLvl(authToken)) >= 25 then
				changeUserPassword()
			else
				printPause("Invalid choice!")
			end
		end
	end
end

function showMailMenu()
	while true do
		print("Current user:"..username)
		print("Available options:")
		if authToken == nil or authToken == "guestUserX" then
			print(" [1] Login")
			print(" [Q] Exit")
			term.write("> ")
			local choice = read()
			if choice == '1' then
				login()
			elseif choice == 'Q' then
				printPause("Leaving Main Service!")
				break
			else
				printPause("Invalid choice!")
			end
		else
			print(" [1] Send Mail")
			print(" [2] Show Inbox History")
			print(" [3] Show Inbox")
			print(" [4] Read Mail")
			print(" [5] Delete Mail")
			print(" [Q] Exit")
			if tonumber(userLvl(authToken)) >= 25 then
				print("Admin Options!")
				print(" [6] Show User Inbox")
				print(" [7] Show User Inbox History")
				print(" [8] Read User Mail")
				print(" [9] Delete User Mail")
			end
			term.write("> ")
			local choice = read()
			if choice == '1' then
				sendMail()
			elseif choice == '2'then
				showInboxHistory()
			elseif choice == '3' then
				showInbox()
			elseif choice == '4' then
				readMail()
			elseif choice == '5' then
				deleteMail()
			elseif choice == 'Q' then
				printPause("Leaving Mail Service!")
				break
			elseif choice == '6' and tonumber(userLvl(authToken)) >= 25 then
				showUserInbox()
			elseif choice == '7' and tonumber(userLvl(authToken)) >= 25 then
				showUserInboxHistory()
			elseif choice == '8' and tonumber(userLvl(authToken)) >= 25 then
				readUserMail()
			elseif choice == '9' and tonumber(userLvl(authToken)) >= 25 then
				deleteUserMail()
			else
				printPause("Invalid choice!")
			end
		end
	end
end

function showNewsMenu()
	while true do
		print("Current user:"..username)
		print("Available options:")
		if tonumber(userLvl(authToken)) >= 10 then
			print(" [1] Show News")
			print(" [2] Read News")
			print(" [Q] Exit")
			print("Author Options!")
			print(" [3] Add Article")
			print(" [4] Remove Article")
			print(" [5] Update Article")
			term.write("> ")
			local choice = read()
			if choice == '1' then
				showNews()
			elseif choice == '2' then
				readNews()
			elseif choice == '3' then
				addArticle()
			elseif choice == '4' then
				removeArticle()
			elseif choice == '5' then
				updateArticle()
			elseif choice == 'Q' then
				printPause("Leaving News Service!")
				break
			else
				printPause("Invalid choice!")
			end
		else
			print(" [1] Login")
			print(" [2] Show News")
			print(" [3] Read News")
			print(" [Q] Exit")
			term.write("> ")
			local choice = read()
			if choice == '1' then
				login()
			elseif choice == '2' then
				showNews()
			elseif choice == '3' then
				readNews()
			elseif choice == 'Q' then
				printPause("Leaving News Service!")
				break
			else
				printPause("Invalid choice!")
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
	print(" [Q] Exit")
end

-- main loop
while true do
	showMainMenu()
	term.write("> ")
	local choice = read()
	if choice == '1' then
		showAccountManagment()
	elseif choice == '2' then
		showMailMenu()
	elseif choice == '3' then
		showNewsMenu()
	elseif choice == 'Q' then
		print("Good bye "..username.."!")
		break
	else
		printPause("Invalid choice!")
	end
end