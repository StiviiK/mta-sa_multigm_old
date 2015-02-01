Settings                        = {}

-- Database
Settings.DATABASE_Host		= "178.254.29.25"
Settings.DATABASE_Name		= "db_87"
Settings.DATABASE_Pass		= "multigamemode"
Settings.DATABASE_DBName	= "db_87"
Settings.DATABASE_Settings	= "share=1"

-- Custom Events
addEvent("onPlayerGamemodeJoin", true)
addEvent("onPlayerGamemodeLeft", true)
addEvent("onGamemodeMinimumPlayerReached", true)

-- Experimental
RPC:addListeningEvent("onPlayerGamemodeJoin")
RPC:addListeningEvent("onPlayerGamemodeLeft")
RPC:addListeningEvent("onGamemodeMinimumPlayerReached")

-- Core errors
Core.errors = {
	ERR_NO_DATABASE_CONNECTION = {0, "login_register", "There was not database connection established"},
	ERR_PLAYER_NOT_FOUND = {1, "login", "The requested user was not found!"},
	ERR_WRONG_PASSWORD = {2, "login", "The used password is wrong!"},
	ERR_PLAYER_ALLREADY_REGISTERED = {3, "register", "The requested user is already registered!"},
	ERR_PASSWORD_TO_SHORT = {4, "register", "The password is to short."},
	ERR_SERIAL_NO_MATCH = {5, "login", "The Serial don't matches with the account Serial"},
	ERR_TOO_MUCH_ENTRYS = {6, "login", ""}
}