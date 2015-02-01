function Core:loginPlayer (usr, password, check)
	if Database:isConnected() then
		local row, affectedRows = Database:query("SELECT * FROM `userdata_securitydata` WHERE `name` = ?;", getPlayerName(usr))
		if affectedRows == 1 then
			if check == false then
				local row = row[1]
				if hash("sha1", getPlayerSerial(usr)) == row["serial"] then
					if hash("sha256", ("%s..%s..%s"):format(password, row["serial"], row["salt"])) == row["password"] then
						Database:execute("UPDATE `userdata_statistics_global` SET `last_login` = ? WHERE `id` = ?", getRealTime().timestamp, row["id"])
						usr:setInfo("UserID", row["id"])
						usr:createSession()

						return {"Success!"}
					else
						return self.errors["ERR_WRONG_PASSWORD"];
					end
				else
					return self.errors["ERR_SERIAL_NO_MATCH"];
				end
			else
				return false;
			end
		elseif affectedRows == 0 then
			return self.errors["ERR_PLAYER_NOT_FOUND"];
		elseif affectedRows > 1 then
			return self.errors["ERR_TOO_MUCH_ENTRYS"];
		end
	else
		return self.errors["ERR_NO_DATABASE_CONNECTION"];
	end
end

function Core:registerPlayer (usr, pass)
	local coreError = self:loginPlayer(usr, "", false)
	if coreError == self.errors["ERR_PLAYER_NOT_FOUND"] then -- Check if the player has an account.
		coreError = nil

		local pass, salt, serial = self:encryptData(usr, pass)
		local _, _, lastID = Database:query("INSERT INTO `userdata_securitydata` (`name`, `serial`, `password`, `salt`) VALUES (?, ?, ?, ?);", getPlayerName(usr), serial, pass, salt)
		Database:execute("INSERT INTO `userdata_statistics_global` (`id`, `reg_date`, `last_login`, `playtime`, `disconnects`, `joins`, `deaths`, `kills`) VALUES (?, ?, ?, '0', '0', '1', '0', '0');", lastID, getRealTime().timestamp, getRealTime().timestamp)
	else
		outputChatBox(toJSON(coreError))
	end
end

function Core:encryptData (usr, pass)
	local salt = hash("sha1", string.getRandom(math.random(5, 10)))
	local serial = hash("sha1", getPlayerSerial(usr))
	local pass = hash("sha256", ("%s..%s..%s"):format(pass, serial, salt))

	return pass, salt, serial
end

function Core:logoutPlayer (usr)
	--usr:destroySession()
end

function Core:changePlayerPassword ()
end

function Core:forcePlayerLogin ()
end

function Core:createPlayerSession (usr)
	local _, _, id = Database:query("INSERT INTO `userdata_sessions` (`token`, `session_start_time`, `user_id`, `ip`, `valid`) VALUES (?, ?, ?, ?, '1');", hash("md5", (getRealTime().timestamp + getTickCount() + usr:getInfo("UserID"))), getRealTime().timestamp, usr:getInfo("UserID"), getPlayerIP(usr))
	usr:setInfo("SessionID", id)
	usr:outputDebug(("[SessionManager] The User-Session has been successfully created! (ID: %s)"):format(id))

	return id;
end

function Core:destroyPlayerSession (usr)
	Database:execute("UPDATE `userdata_sessions` SET `session_end_time` = ? WHERE `id` = ? AND `user_id` = ?", getRealTime().timestamp, usr:getInfo("SessionID"), usr:getInfo("UserID"))
	Database:execute("UPDATE `userdata_sessions` SET `valid` = '0' WHERE `id` = ? AND `user_id` = ?", usr:getInfo("SessionID"), usr:getInfo("UserID"))

	usr:outputDebug(("[SessionManager] The User-Session has been successfully destroyed! (ID: %s)"):format(usr:getInfo("SessionID")))
	usr:setInfo("SessionID", nil)
end

function Core:destroyAllSessions ()
	Database:execute("UPDATE `userdata_sessions` SET `session_end_time` = ? WHERE `valid` = '1';", getRealTime().timestamp)
	Database:execute("UPDATE `userdata_sessions` SET `valid` = '0' WHERE `valid` = '1';")

	for _, v in ipairs(getElementsByType("player")) do
		v:setInfo("SessionID", nil)
	end

	outputDebug("[SessionManager] All User-Sessions were successfully destroyed!")
end

function Player:logIn (...) return Core:loginPlayer(self, ...); end
function Player:register (...) return Core:registerPlayer(self, ...); end
function Player:logOut (...) return Core:logoutPlayer(self, ...); end
function Player:changePassword (...) return Core:changePlayerPassword(self, ...); end
function Player:requestLogin (...) return Core:forcePlayerLogin(self, ...); end
function Player:createSession (...) return Core:createPlayerSession(self, ...) end
function Player:destroySession (...) return Core:destroyPlayerSession(self, ...) end