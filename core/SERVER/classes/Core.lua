Core = {}

function Core:constructor ()
	core = self
	
	-- playerdata storage
	self.playerdata = {}
	
	-- set the fps limit
	setFPSLimit(50)
	
	-- set the game type
	setGameType(("%s %s"):format(VERSION_NAME_SERVERL, VERSION or "[unknown build]"))
	
	-- starting the classes
	Database:connect(Settings.DATABASE_Host, Settings.DATABASE_Name, Settings.DATABASE_Pass, Settings.DATABASE_DBName, Settings.DATABASE_Settings)
	Playermanager:constructor()
	Gamemode:constructor()
	Statistics:constructor()
	Debugging:constructor()

	return self
end

function Core:destructor ()
	if self ~= core then return end

	self:destroyAllSessions()

	Debugging:destructor()
	Statistics:destructor()
	Gamemode:destructor()
	Playermanager:destructor()

	-- delete the core
	self.destructor = false
	core = nil
end