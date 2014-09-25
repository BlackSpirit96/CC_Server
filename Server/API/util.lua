-- Basic utilities that I use over my programs
-- Version 1.1.6


-- tableFile( table tbl, str path, str file)
-- converts table to file
-- return success / error
function tableFile( tbl, path)
	local file = fs.open(tbl,"w")
	file.write(textutils.serialize(tbl))
	file.close()
end

-- fileTable( str path)
-- converts file to table
-- return table
function fileTable(path)
	local file = fs.open(path,"r")
	local data = file.readAll()
	file.close()
	return textutils.unserialize(data)
end

-- writeData(str path, str data, str mode)
-- writes data to file with mode
function writeData(path, data, mode)
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

-- searchElementIntable(table tbl, str element)
-- search tbl to find element
-- return key where element is located or nil if not
function searchElementIntable(tbl, element)
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

-- split( str inputstr, str sep)
-- split a string based on sep
-- return table
function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}; i = 1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end
 
-- getArgs( table table, int start)
-- gets the args from a given table
-- return the str of arguments
function getArgs(table, start)
  local message = ""
  for i = start, #table do
    message = message ..table[i] ..' '
  end
  return message
end