addEvent("onPlayerMusicLobbyJoin", true)
addEvent("onPlayerMusicLobbyLeft", true)

function onPlayerMusicLobbyJoin (player)
	for _, v in ipairs(getElementsByType("player")) do
		setElementCollidableWith(player, v, false)
	end

	if player == localPlayer then
		localPlayer.cancleEvent = function () return cancelEvent(); end
		addEventHandler("onClientPlayerDamage", localPlayer, localPlayer.cancleEvent)
	end
end
addEventHandler("onPlayerMusicLobbyJoin", root, onPlayerMusicLobbyJoin)

function onPlayerMusicLobbyLeft (player)
	for _, v in ipairs(getElementsByType("player")) do
		setElementCollidableWith(player, v, true)
	end

	if player == localPlayer then
		removeEventHandler("onClientPlayerDamage", localPlayer, localPlayer.cancleEvent)
	end
end
addEventHandler("onPlayerMusicLobbyLeft", root, onPlayerMusicLobbyLeft)