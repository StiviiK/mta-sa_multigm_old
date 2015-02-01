Lobby = Gamemode{nil, "Lobby", "This is the Lobby", "StiviK", 0, getMaxPlayers(), 1, {}, {}} -- Register a new Gamemode

Lobby.Settings = {
    Spawn = {
        ["pos"] = Vector3(1717.84912, -1651.28259, 20.23014),
        ["int"] = {18},
        ["rot"] = {0, 0, 223.45709228516},
        ["alpha"] = {200}
    },
    downloadData = Downloadmanager:new("metafiles/meta_lobby.xml", Lobby);
}