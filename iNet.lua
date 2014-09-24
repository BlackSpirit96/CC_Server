-- Powerful & Simple Networking API
-- Author: KingofGamesYami
-- Version 1.2
-- URL: http://www.computercraft.info/forums2/index.php?/topic/19940-inet-powerful-simple-networking/

--iNet 1.2
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
local net = {
  send = function( self, message )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":" instead of "."', 2 )
    end
    local packet = { protocol = self.protocol, sender = os.getComputerLabel() or os.getComputerID() }
    if self.encrypt then
      packet.message = self.encrypt( textutils.serialize( message ), self )
      packet.encrypt = true
    else
      packet.message = message
    end
    self.modem.transmit( self.channel, self.replyChannel, self.b64enc( textutils.serialize( packet ) ) )
  end,
  reply = function( self, message )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":" instead of "."', 2 )
    end
    local packet = { protocol = self.protocol, sender = os.getComputerLabel() or os.getComputerID() }
    if self.encrypt then
      packet.message = self.encrypt( textutils.serialize( message ), self )
      packet.encrypt = true
    else
      packet.message = message
    end
    self.modem.transmit( self.last, self.replyChannel, self.b64enc( textutils.serialize( packet ) ) )
  end,
  receive = function( self )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":" instead of "."', 2 )
    end
    while true do
      local event, side, channel, replyChannel, message, distance = os.pullEvent( "modem_message" )
      local info = textutils.unserialize( self.b64dec( message ) )
      if channel == self.replyChannel and self.protocol == info.protocol then
        self.last = replyChannel
        if info.encrypt and self.decrypt then
          if info.fileName then
            local file = fs.open( info.fileName, "w" )
            file.write( self.decrypt( info.message, self ) )
            file.close()
            return info.fileName, distance, info.sender
          else
            return self.decrypt( info.message, self ), distance, info.sender
          end
        elseif info.encrypt then
          error( "Message could not be decrypted", 2 )
        else
          if info.fileName then
            local file = fs.open( info.fileName, "w" )
            file.write( info.message )
            file.close()
            return info.fileName, distance, info.sender
          else
           return info.message, distance, info.sender
          end
        end
      end
    end
  end,
  ["repeat"] = function( self )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":", instead of "."', 2 )
    end
    while true do
      local event, side, channel, replyChannel, message, distance = os.pullEvent( "modem_message" )
      local info = textutils.unserialize( self.b64dec( message ) )
      if not info["repeat"] then
        info["repeat"] = { os.getComputerID() }
      elseif not info["repeat"][ os.getComputerID() ] then
        info["repeat"][ os.getComputerID() ] = true
        self.modem.transmit( channel, replyChannel, self.b64enc( textutils.serialize( info ) ) )
      end
    end
  end,
  setProtocol = function( self, protocol )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":", instead of "."', 2 )
    elseif type( protocol ) ~= "string" then
      error( 'Expected string, got ' .. type( protocol ), 2 )
    end
    self.protocol = protocol 
  end,
  setEncryption = function( self, en )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":", instead of "."', 2 )
    elseif type( en ) ~= "function" then
      error( 'Expected function, got ' .. type( en ), 2 )
    end
    self.encrypt = en
  end,
  setDecryption = function( self, de )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":", instead of "."', 2 )
    elseif type( de ) ~= "function" then
      error( 'Expected function, got ' .. type( de ), 2 )
    end
    self.decrypt = de
  end,
  removeEncryption = function( self )
    self.encrypt = nil
  end,
  removeDecryption = function( self )
    self.decrypt = nil
  end,
  sendFile = function( self, fileName )
    if type( self ) ~= "table" then
      error( 'Incorrect notation, use ":" instead of "."', 2 )
    end
    local file = fs.open( fileName, "r" )
    local message = file.readAll()
    file.close()
    local packet = { protocol = self.protocol, sender = os.getComputerLabel() or os.getComputerID(), fileName = fileName }
    if self.encrypt then
      packet.message = self.encrypt( textutils.serialize( message ), self )
      packet.encrypt = true
    else
      packet.message = message
    end
    self.modem.transmit( self.channel, self.replyChannel, self.b64enc( textutils.serialize( packet ) ) )
  end,
  b64enc = function(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
  end,
  b64dec = function(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
  end,
}

function open( channel, replyChannel, side )
  if not peripheral.isPresent( side ) or peripheral.getType( side ) ~= "modem" then
    error( "No modem connected on " .. side, 2 )
  end
  if type( channel ) ~= "number" or type( replyChannel ) ~= "number" then
  	error( "Expected number, number, side, got " .. type( channel ) .. ", " .. type( replyChannel ) .. ", " .. side )
  end
  local modem  = peripheral.wrap( side )
  if not modem.isOpen( replyChannel ) then
    modem.open( replyChannel )
  end
  if channel == replyChannel then
  	error( "channel and replyChannel cannot be the same value", 2 )
  end
  local t = { modem = modem, channel = channel, replyChannel = replyChannel }
  setmetatable( t, { __index = net } )
  return t
end

function waitForAny( ... )
  local get = {}
  local value
  for k, v in ipairs( { ... } ) do
    get[ k ] = function() value = { v:receive(), k } end
  end
  parallel.waitForAny( unpack( get ) )
  return unpack( value )
end

function waitForAll( ... )
  local get = {}
  local value = {}
  for k, v in ipairs( { ... } ) do
    get[ k ] = function() value[ k ] = { v:receive() } end
  end
  parallel.waitForAll( unpack( get ) )
  local toReturn = {}
  for k, v in ipairs( value ) do
    for x, y in ipairs( v ) do
      toReturn[ #toReturn + 1 ] = y
    end
  end
  return unpack( toReturn )
end