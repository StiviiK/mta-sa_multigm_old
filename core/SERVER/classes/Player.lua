function Player:getGamemode ()
	return self.Gamemode;
end

function Player:setGamemode (gamemode)
	self.Gamemode = gamemode;
end

function Player:sendMessage (msg, r, g, b, cc)
	outputChatBox(msg, self, r, g, b, cc)
end

function Player:setInfo (key, value)
	if not self.userInfo then
		self.userInfo = {}
	end

	if (type(key) == "string") then
		self.userInfo[key] = value;
	end
end

function Player:getInfo (key)
	if not self.userInfo then
		self.userInfo = {}
	end

	if (type(key) == "string") and (self.userInfo[key] ~= nil) then
		return self.userInfo[key];
	end

	return self.userInfo;
end

function Player:getGamemodeData (data)
	if self:getGamemode() ~= nil then
		if self:getGamemode().Players[self] ~= nil then
			if self:getGamemode().Players[self][data] ~= nil then
				return self:getGamemode().Players[self][data]
			end
		end
	end
	
	return nil
end

function Player:setGamemodeData (data, value)
	if self:getGamemode() ~= nil then
		if self:getGamemode().Players[self] ~= nil then
			self:getGamemode().Players[self][data] = value
			
			return true
		end
	end

	return false
end

function Player:triggerEvent (...)
	return triggerClientEvent(self, ...);
end

function Player:triggerLatentEvent (...)
	return triggerLatentClientEvent(self, ...);
end

function Player:cancelLatentEvent (...)
	return cancelLatentEvent(self, ...);
end

function Player:getLatentEventHandles ()
	return getLatentEventHandles(self);
end

function Player:outputDebug (...)
	local arg = {...}
	outputDebug(("[%s] %s"):format(self:getName(), arg[1]), 0, 0, 125, 255)
end

function Player:getLocale ()
	return "en";
end

--_("hihi", getRandomPlayer())
--getRandomPlayer():outputDebug("[TEST] Hallo", 0, 255, 3, 125)