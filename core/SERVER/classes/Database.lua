-- This is the Database manager class for a MultiGamemode
Database = {};

function Database:connect(host, user, pass, database, port)
	self.m_dbHandle = Connection("mysql", ("dbname=%s;host=%s;port=%d"):format(database, host, (tonumber(port) or 3306)), user, pass)
	if(not self.m_dbHandle) then
		outputServerLog("Couldnt connect to MySQL Server")
		stopResource(getThisResource())
	end
end

function Database:destructor()
	if(self:isConnected()) then destroyElement(self.m_dbHandle); end
end

function Database:query(query, ...)
	if(type(query) ~= "string" or not self:isConnected()) then return false end
	local queryHandle     = self.m_dbHandle:query(query, ...)
	local result, r1, r2  = queryHandle:poll(-1)
	if result == false then
		outputServerLog(("Query failed: errCode: %d - errMsg: %s"):format(r1, r2))
		return false
	end
	return result, r1, r2
end

function Database:execute(query, ...)
	return (self:isConnected() and self.m_dbHandle:exec(query, ...) or false);
end

function Database:isConnected()
	return self.m_dbHandle ~= false
end

--[[
function Database:connect (host, user, pass, database, settings)
	--assert(type(host) == "string" and type(user) == "string" and type(pass) == "string" and type(database) == "string" and type(settings) == "string", "Bad Argument @ Database.connect [Invalid Arguments given!]")
	Check("Database.connect", "string", host, "Host", "string", user, "Username", "string", pass, "Password", "string", database, "Database-Name", "string", settings, "Settings")
	self.Connection = dbConnect("mysql", ("dbname=%s;host=%s"):format(database, host), user, pass, settings)

	if (not self.Connection) then
		outputDebug("Database Connection failed! Stopping resource...")
		stopResource(getThisResource())
	end
end

function Database:destructor ()
	if self:isConnected()  then
		destroyElement(self.Connection)
	end
end

function Database:isConnected ()
	return type(self.Connection) == "userdata";
end

function Database:query (...)
	local query = self.Connection:query(...)
	if query then
		local arg1, arg2, arg3 = query:poll(-1)

		if (not arg1) then
			local args = {...}
			outputDebug(("[Database] Query failed! Errormessage: %s [%d] (%s)"):format(arg3, arg2, args[1]))
			return false;
		end

		return arg1, arg2, arg3;
	else
		return false, false, false
	end
end

function Database:execute (...)
	return self.Connection:exec(...);
end
--]]