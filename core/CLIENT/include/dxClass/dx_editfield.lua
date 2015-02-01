dxEditfield = class ( 'dxEditfield', dxGUI )

function dxEditfield:create ( x, y, width, height, text, parent )
    local self = setmetatable({}, {__index = self})
    self.type = "editfield"
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.masked = false
    self.maxLength = false
    self.readOnly = false
    self.render = true
    self.caret = 0
    self.active = false
    self.visible = true
    self.text = text or ""
    self.color = {0, 0, 0, 255}
    self.backgroundColor = {255, 255, 255, 150 }
    self.size = 1
    self.font = ""

    if parent then
        self.render = false
        self.parent = parent
        table.insert(parent.childs, self)
    end

    table.insert(dxObjects, self)
    return self
end

function dxEditfield.getMax ( )
    return self.maxLength
end

function dxEditfield.setMax ( maxLength )
    self.maxLength = maxLength
end

function dxEditfield.getReadOnly ( )
    return self.readOnly
end

function dxEditfield.setReadOnly ( readOnly )
    self.readOnly = readOnly
end

function dxEditfield.setCaretIndex ( index )
    editfield.caret = index
end

function dxEditfield.getCaretIndex ( )
    return editfield.caret
end

function dxEditfield:draw ( )
    self.realText = ""
    if self.masked then
        for i = 1, #self.text do
            self.realText = "*"..self.realText
        end
    else
        self.realText = self.text
    end

    dxDrawRectangle(self.x, self.y, self.width, self.height, tocolor(unpack(self.backgroundColor)))
    dxDrawEmptyRec(self.x, self.y, self.width, self.height, tocolor(0, 0, 0, 255), 2)
    if self.active then
        dxDrawText(self.realText.."|", self.x + 3, (self.y+(self.height/2)), self.x, (self.y+(self.height/2)), tocolor(unpack(self.color)), self.size, self.font, "left", "center" )
    else
        dxDrawText(self.realText, self.x + 3, (self.y+(self.height/2)), self.x, (self.y+(self.height/2)), tocolor(unpack(self.color)), self.size, self.font, "left", "center" )
    end
end