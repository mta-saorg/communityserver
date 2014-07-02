Lobby = inherit(Object)

function Lobby:constructor(res, info)
	self.m_Players = {}
	self.Info      = info
	
	outputServerLog(('[Core]: Started Lobby %s!'):format(info.Name));
end

function Lobby:destructor()

end

function Lobby:getPlayers()
	return self.m_Players
end

function Lobby:removePlayer(player)
	if self.m_Players[player] then
		self.m_Players[player] = player
	end
end

function Lobby:addPlayer(player)
	if not self.m_Players[player] then
		self.m_Players[player] = player
	end
end

function Lobby:setInfo()

end

function Lobby:getInfo()

end

function Lobby:sendMessage(msg, r, g, b, colorcoded)
	assert(type(msg) == 'string' and type(r) == 'number' and type(g) == 'number' and type(b) == 'number' and (type(colorcoded) == 'boolean' or 'nil'), 'Bad Argument @Lobby.sendMessage')
	if colorcoded == nil then colorcoded = false end
	
	for player in pairs(self:getPlayers()) do
		outputChatBox(msg, player, r, g, b, colorcoded)
	end
end
