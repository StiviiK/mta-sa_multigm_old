-- Client Version
localPlayer.version = getVersion()

-- Count FPS
localPlayer.fps  = false
function localPlayer:getFPS() -- Setup the useful function
    if not self.fps then return "0" end
    return self.fps
end

local function updateFPS(msSinceLastFrame)
    -- FPS are the frames per second, so count the frames rendered per milisecond using frame delta time and then convert that to frames per second.
    localPlayer.fps = (1 / msSinceLastFrame) * 1000
end
addEventHandler("onClientPreRender", root, updateFPS)

function localPlayer:getLocale ()
    return "en";
end