--Lobby:createMarker(1712.0999755859, -1639.9000244141, 19.200000762939, "cylinder", 1, 0, 4, 100)

local marker = Lobby:createMarker(1726.93713, -1638.32935, 20.29, "corona", 1, 125, 0, 0)
setElementInterior(marker, 18)
addEventHandler("onMarkerHit", marker, function (hitele, dim)
	if (getElementType(hitele) == "player" and dim) then
		kickPlayer(hitele, "Server", "Du hast den Server erfolgreich verlassen.")
	end
end)

function Lobby:onPlayerJoin (player)
    self:getSetting("downloadData"):sendToClient(player)
    --Lobby:onPlayerDownloadFinished(player)
end

function Lobby:onPlayerDownloadFinished (player, bool)
    if not bool then
        local result = player:logIn("lel", false)
        if result[1] == 1 then
            player:register("lel")
            player:logIn("lel", false)
        end
    end

    triggerClientEvent("onPlayerLobbyJoin", root, player)

    spawnPlayer(player, 0, 0, 0, 0, math.random(312))
    fadeCamera(player, true)
    setCameraTarget(player, player)

    toggleControl(player, "fire", false)
    toggleControl(player, "jump", false)
    toggleControl(player, "aim_weapon", false)

    if (getPlayerName(player) == "StiviK") then
        setElementModel(player, 62)
    end

    setElementInterior(player, unpack(self:getSetting("Spawn")["int"]))
    setElementAlpha(player, unpack(self:getSetting("Spawn")["alpha"]))
    setElementPosition(player, self:getSetting("Spawn")["pos"])
    setElementRotation(player, unpack(self:getSetting("Spawn")["rot"]))
end

function Lobby:onPlayerLeft (player)
    triggerClientEvent("onPlayerLobbyLeft", root, player)

    toggleControl(player, "fire", true)
    toggleControl(player, "jump", true)
    toggleControl(player, "aim_weapon", true)

    setElementAlpha(player, 255)

    -- Todo: Stuff.
end

function Lobby:onPlayerDeath (player)
    self:onPlayerDownloadFinished(player, true)
end

addCommandHandler("music", function (player) player:getGamemode():removePlayer(player) Gamemode:getGamemodeFromID(2):addPlayer(player) end)

require("gamemodes/lobby/SERVER/testf.lua")