-- News Service API
-- Author: Black_Spirit
-- Version: 1.1.1

function readNews(title)
	return 'readNews~'..title
end

function showNews()
	return 'showNews'
end

function addArticle(authToken, title, text)
	return 'addArticle~'..authToken..'~'..title..'~'..text
end

function removeArticle(authToken, title)
	return 'removeArticle~'..authToken..'~'..title
end

function updateArticle(authToken, title, text)
	return 'updateArticle~'..authToken..'~'..title..'~'..text
end