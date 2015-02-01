--
-- Project: MTASA CommunityCoding
-- User: StiviK
-- Date: 27.12.2014
-- Time: 13:48
--
sX, sY = guiGetScreenSize()

-- Best values
-- Heigth = 17
-- Width = 35
-- Width/Heigth = 2,058823529411765


Login = {
    upperPos = Vector3(2039.3671875, 2399.7641601563, 113.847793579102),
    lowerPos = Vector3(2039.3671875, 2399.7641601563, 96.847793579102),
    frontPos = Vector3(2038.3671875, 2399.7641601563, 96.847793579102),
    width = 35,
    renderTarget = dxCreateRenderTarget(sX, sY, true),
    color = tocolor(255, 255, 255, 255),
    avatarInfos = {
        ["default"] = {"gamemodes/lobby/FILES/images/account/default.jpg", {255, 255, 255, 125}},
        ["StiviK"] = {"core/FILES/images/avatar/stivik.jpg", {255, 0, 0, 125}},
        ["Vandam"]  = {"core/FILES/images/avatar/vandam.png", {0, 0, 255, 125}},
        ["sbx320"]  = {"core/FILES/images/avatar/sbx320.png", {0, 0, 255, 125}},
        ["Doneasty"] = {"core/FILES/images/avatar/doneasty.png", {255, 0, 0, 125}},
        ["Noneatme"] = {"core/FILES/images/avatar/noneatme.jpg", {0, 255, 0, 125}},
        ["MasterM"] = {"core/FILES/images/avatar/masterm.png", {0, 255, 0, 125}},
        ["Jusonex"] = {"core/FILES/images/avatar/jusonex.png", {255, 255, 255, 125}},
        ["Schlumpf"] = {"core/FILES/images/avatar/schlumpf.png", {255, 255, 255, 125}},
        ["Shape"] = {"core/FILES/images/avatar/shape.png", {255, 255, 255, 125}},
        ["Dawi"] = {"core/FILES/images/avatar/dawi.png", {255, 215, 0, 125}},
        ["Poof"] = {"core/FILES/images/avatar/poof.png", {255, 255, 255, 125}},
        ["Harrikan"] = {"core/FILES/images/avatar/harrikan.jpg", {255, 255, 255, 125}},
        ["LuXORION"] = {"core/FILES/images/avatar/luxorion.jpg", {255, 255, 255, 125}}
    }
}

function Login:createLogin ()
    setFarClipDistance(5000)
    setPlayerHudComponentVisible("all", false)

    self:drawStuff()
    self.renderFunc = function (...) return Login:renderStuff(...) end
    self.restoreFunc = function (...) return Login:drawStuff(...) end

    addEventHandler("onClientRender", root, self.renderFunc)
    addEventHandler("onClientRestore", root, self.restoreFunc)
end

function Login:destroyLogin ()
    resetFarClipDistance()

    removeEventHandler("onClientRender", root, self.renderFunc)
    removeEventHandler("onClientRestore", root, self.restoreFunc)

    self.renderFunc = nil
    self.restoreFunc = nil
end

function Login:drawStuff ()
    dxSetRenderTarget(self.renderTarget, true)
    if self.avatarInfos[localPlayer:getName()] and fileExists(self.avatarInfos[localPlayer:getName()][1]) then
        dxDrawRectangle(0, 0, sX, sY, tocolor(unpack(self.avatarInfos[localPlayer:getName()][2])))
        dxDrawImage(50, 50, sX/2 - 100, sY - 100, self.avatarInfos[localPlayer:getName()][1])
    else
        dxDrawRectangle(0, 0, sX, sY, tocolor(unpack(self.avatarInfos["default"][2])))
        dxDrawImage(50, 50, sX/2 - 100, sY - 100, self.avatarInfos["default"][1])
    end

    if localPlayer:getName() == "Doneasty" then
        dxDrawText("Welcome God.", sX/2, 50, (sX/2 + (sX/2 - 50)), 300, tocolor(255, 255, 255, 255), 7, "default", "left", "bottom", true)
    else
        dxDrawText("Welcome.", sX/2, 50, (sX/2 + (sX/2 - 50)), 300, tocolor(255, 255, 255, 255), 8, "default", "left", "bottom", true)
    end

    dxDrawRectangle(sX/2, 350, sX/2 - 50, 100)
    dxDrawText(localPlayer:getName(), sX/2 + 5, 350, sX/2 + (sX/2 - 55), 450, tocolor(0, 0, 0, 255), 5, "default", "left", "center", true)

    dxDrawRectangle(sX/2, 550, sX/2 - 50, 100)
    dxDrawRectangle(sX/2 + (sX/2 - 125), 550, 75, 100, tocolor(254, 100, 0, 255))
    dxDrawImage(sX/2 + (sX/2 - 115), 560, 55, 80, "core/FILES/images/stuff/arrow.png", tocolor(255, 255, 255, 255))
    dxDrawText("*******", sX/2 + 5, 550, (sX/2 + (sX/2 - 130)), 650, tocolor(0, 0, 0, 255), 5, "default", "left", "center", true)
    dxSetRenderTarget()
end

function Login:renderStuff ()
    if DEBUG then
        dxDrawLine3D(self.upperPos, self.lowerPos, tocolor(125, 0, 0, 255), 2)
        dxDrawLine3D(self.upperPos, self.frontPos, tocolor(0, 125, 0, 255), 2)
        dxDrawLine3D(self.frontPos, self.lowerPos, tocolor(0, 0, 125, 255), 2)
    end

    dxDrawMaterialLine3D(self.upperPos, self.lowerPos,  self.renderTarget, self.width, self.color, self.frontPos)
end