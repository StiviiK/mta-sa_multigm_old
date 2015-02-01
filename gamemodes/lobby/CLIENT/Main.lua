addEvent("onPlayerLobbyJoin", true)
addEvent("onPlayerLobbyLeft", true)

function onPlayerLobbyJoin (player)
	setDevelopmentMode(true)

	widget_defaultHUD:create()
	--Login:createLogin()

	for _, v in ipairs(getElementsByType("player")) do
		setElementCollidableWith(player, v, false)
	end
end
addEventHandler("onPlayerLobbyJoin", root, onPlayerLobbyJoin)

function onPlayerLobbyLeft (player)
	widget_defaultHUD:destroy()


	for _, v in ipairs(getElementsByType("player")) do
		setElementCollidableWith(player, v, true)
	end
end
addEventHandler("onPlayerLobbyLeft", root, onPlayerLobbyLeft)