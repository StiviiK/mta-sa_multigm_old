function MusicLobby:onGamemodeStart ()
    self:createBarPeds()
    self:createNoJumpZones()
end

function MusicLobby:onPlayerJoin (player)
    triggerClientEvent("onPlayerMusicLobbyJoin", root, player)

    toggleControl(player, "fire", false)
    --toggleControl(player, "jump", false)
    toggleControl(player, "aim_weapon", false)

    spawnPlayer(player, 0, 0, 0, 0, getElementModel(player))
    setElementDimension(player, self.Dimension)
    setElementInterior(player, unpack(self:getSetting("Spawn")["int"]))
    setElementPosition(player, self:getSetting("Spawn")["pos"])
    setElementRotation(player, unpack(self:getSetting("Spawn")["rot"]))
    setElementAlpha(player, unpack(self:getSetting("Spawn")["alpha"]))

    player:attachDrink(1)
end

function MusicLobby:onPlayerDownloadFinished ()
end

function MusicLobby:onPlayerLeft (player)
    player:detachDrink()
end

function MusicLobby:onPlayerDeath (player)
    player:detachDrink()

    self:onPlayerJoin(player)
end


MusicLobby:onGamemodeStart()