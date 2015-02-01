MusicLobby = Gamemode{nil, "MusicLobby", "This is the Music-Lobby", "StiviK", 0, getMaxPlayers(), 1, {}, {}}

MusicLobby.Settings = {
    Spawn = {
        ["pos"] = Vector3(-2640.762939,1406.682006,906.460937),
        ["int"] = {3},
        ["rot"] = {0, 0, 223.45709228516},
        ["alpha"] = {255}
    },
    --downloadData = Downloadmanager:new("metafiles/MusicLobby.xml", MusicLobby);
    MusicStreams = {
        {1, "Houstime.fm", "http://mp3.ht-stream.net"},
        {2, "Technobase.fm", "http://dsl.tb-stream.net"}
    },
    barPeds = {
        toCreate = {
            {
                ["model"] = {math.random(171, 172)},
                ["pos"] = Vector3(-2655.50806, 1407.25476, 906.27344),
                ["int"] = {3},
                ["rot"] = {0, 0, -90},
                ["alpha"] = {255},
                ["anim"] = {nil}
            },
            {
                ["model"] = {math.random(171, 172)},
                ["pos"] = Vector3(-2655.50732, 1413.24805, 906.27344),
                ["int"] = {3},
                ["rot"] = {0, 0, -90},
                ["alpha"] = {255},
                ["anim"] = {nil}
            },
            {
                ["model"] = {math.random(171, 172)},
                ["pos"] = Vector3(-2662.84131, 1407.25476, 906.27344),
                ["int"] = {3},
                ["rot"] = {0, 0, 90},
                ["alpha"] = {255},
                ["anim"] = {nil}
            },
            {
                ["model"] = {math.random(171, 172)},
                ["pos"] = Vector3(-2662.84131, 1413.24805, 906.27344),
                ["int"] = {3},
                ["rot"] = {0, 0, 90},
                ["alpha"] = {255},
                ["anim"] = {nil}
            }
        },
        createdPeds = {}
    },
    noJumpZones = {
        denyJumpFunc = function (ele)
            if getElementType(ele) == "player" then
                toggleControl(ele, "jump", false)
            end
        end,
        allowJumpFunc = function (ele)
            if getElementType(ele) == "player" then
                toggleControl(ele, "jump", true)
            end
        end,
        toCreate = {
            {
                ["pos"] = Vector3(-2668.86206, 1400.27014, 904.27344),
                ["width"] = {20},
                ["depth"] = {20},
                ["heigth"] = {6},
                ["int"] = {3}
            }
        },
        createdZones = {}
    },
    drinks = {
        {
            ["name"] = "RockDaniels",
            ["model"] = {1520},
            ["bone"] = {12},
            ["offPos"] = {0.24, 0.03, 0.17},
            ["offRot"] = {0, -115, 0},
        }
    }
}

function MusicLobby:createBarPeds ()
    for i, v in ipairs(self:getSetting("barPeds")["toCreate"]) do
        local ped = createPed(unpack(v["model"]), v["pos"])
        setElementFrozen(ped, true)
        setElementRotation(ped, unpack(v["rot"]))
        setElementInterior(ped, unpack(v["int"]))
        setElementDimension(ped, self.Dimension)
        setElementAlpha(ped, unpack(v["alpha"]))

        if v["anim"][1] ~= nil then
            setPedAnimation(ped, unpack(v["anim"]))
        end

        self:getSetting("barPeds")["createdPeds"][i] = ped
    end
end

function MusicLobby:createNoJumpZones ()
    for i, v in ipairs(self:getSetting("noJumpZones")["toCreate"]) do
        local col = createColCuboid(v["pos"], unpack(v["width"]), unpack(v["depth"]), unpack(v["heigth"]))
        setElementInterior(col, unpack(v["int"]))
        setElementDimension(col, self.Dimension)

        addEventHandler("onColShapeHit", col, function (...) return self:getSetting("noJumpZones")["denyJumpFunc"](...) end)
        addEventHandler("onColShapeLeave", col, function (...) return self:getSetting("noJumpZones")["allowJumpFunc"](...) end)

        self:getSetting("noJumpZones")["createdZones"][i] = col
    end
end

function MusicLobby:attachDrink (element, drinkid)
    if isElement(element) then
        if isElement(element.attachedElement) then
            self:detachDrink(element)
        end

        local drinks = self:getSetting("drinks")
        if drinks[drinkid] then
            element.attachedElement = createObject(drinks[drinkid]["model"][1], 0, 0, 0)
            setElementDimension(element.attachedElement, self.Dimension)
            setElementInterior(element.attachedElement, unpack(self:getSetting("Spawn")["int"]))
            local x, y, z, rx, ry, rz = drinks[drinkid]["offPos"][1], drinks[drinkid]["offPos"][2], drinks[drinkid]["offPos"][3], drinks[drinkid]["offRot"][1], drinks[drinkid]["offRot"][2], drinks[drinkid]["offRot"][3]
            exports["bone_attach"]:attachElementToBone(element.attachedElement, element, drinks[drinkid]["bone"][1], x, y, z, rx, ry, rz)
        end
    end
end

function MusicLobby:detachDrink (element)
   if isElement(element.attachedElement) then
       destroyElement(element.attachedElement)
   end
end

function Player:attachDrink(...)
    if self:getGamemode() == MusicLobby then
        return MusicLobby:attachDrink(self, ...)
    end
end

function Player:detachDrink(...)
    if self:getGamemode() == MusicLobby then
        return MusicLobby:detachDrink(self, ...)
    end
end