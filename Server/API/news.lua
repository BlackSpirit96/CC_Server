-- News Service API
-- Author: Black_Spirit
-- Version 0.1.3

-- dependencies 
os.loadAPI("API/util")
os.loadAPI("API/account")

-- readNews(str title)
-- return the article of title
function readNews(title)
	--if tonumber(account.authTokenLvl(authToken)) >= 1 then
	--	return util.returnFile("news/"..title)
	--else
	--	return "You must login in order to see the news!"
	--end
	if fs.exists("news/"..title) then
		return util.returnFile("news/"..title)
	else
		return "Invalid Title!"
	end
end

-- showNews()
-- return the list of available news
function showNews()
	if fs.exists("news") then
		local newsList = fs.list("news")
		local newsStr = ""
		for i=1, table.getn(newsList) do
			newsStr = newsStr..newsList[i].."\n"
		end
		return newsStr
	else
		return "There are no news!"
	end
end

-- addArticle( str authToken, str title, str text)
-- add the article to the news folder
-- return success / error
function addArticle(authToken, title, text)
	if tonumber(account.authTokenLvl(authToken)) >= 10 then
		util.writeData("news/"..title, text, 'w')
		return "Success!"
	else
		return "You are not authorized to do that!"
	end	
end

-- removeArticle( str authToken, str title)
-- removes the article from the news folder
-- return success / error
function removeArticle(authToken, title)
	if tonumber(account.authTokenLvl(authToken)) >= 10 then
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
	if tonumber(account.authTokenLvl(authToken)) >= 10 then
		if fs.exists("news/"..title) then
			util.writeData("news/"..title, '\n'..text..'\n', 'a')
			return "Success!"
		else
			return "Article does not exists!"
		end
	else
		return "You are not authorized to do that!"
	end	
end