-- News Service API
-- Author: Black_Spirit
-- Version 0.1.2

-- loads the account API for account management 
os.loadAPI("account")

-- returnFile(str path)
-- return file content
function returnFile(path)
	local file = fs.open(path)
	local data =  file.readAll()
	file.close()
	return data
end

-- writeData(str path, str data, str mode)
-- writes data to file with mode
function writeData(path, data, mode)
	local file = fs.open(path, mode)
	file.write(data)
	file.close(file)
end

-- readNews(str title)
-- return the article of title
function readNews(title)
	--if account.authTokenLvl(authToken) >= 1 then
	--	return returnFile("news/"..title)
	--else
	--	return "You must login in order to see the news!"
	--end
	return returnFile("news/"..title)
end

-- showNews()
-- return the list of available news
function showNews()
	local newsList = fs.list("news")
	local newsStr = ""
	for i=1, table.getn(newsList) do
		newsStr = newsStr..newsList[i].."\n"
	end
	return newsStr
end

-- addArticle( str authToken, str title, str text)
-- add the article to the news folder
-- return success / error
function addArticle(authToken, title, text)
	if account.authTokenLvl(authToken) >= 10 then
		writeData("news/"..title, text, 'w')
		return "Success!"
	else
		return "You are not authorized to do that!"
	end	
end

-- removeArticle( str authToken, str title)
-- removes the article from the news folder
-- return success / error
function removeArticle(authToken, title)
	if account.authTokenLvl(authToken) >= 10 then
		if fs.exists("news/"..title) then
			fs.delete("news/"..title)
			return "Success!"
		else
			return "Article does not exists!"
		end
	else
		return "You are not authorized to do that!"
	end	
end

-- updateArticle( str authToken, str title, str text)
-- add aditional text to the title article
-- return success / error
function updateArticle(authToken, title, text)
	if account.authTokenLvl(authToken) >= 10 then
		if fs.exists("news/"..title) then
			writeData("news/"..title, text..'\n', 'a')
			return "Success!"
		else
			return "Article does not exists!"
		end
	else
		return "You are not authorized to do that!"
	end	
end