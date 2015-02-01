Shader = {}

function Shader:newShader (sType, shader, texture, ...)
    local self = setmetatable({}, {__index = self})
    local args = {...}
    self.shader = dxCreateShader(shader)

    if self.shader and isElement(self.shader) then
        if sType == "mask" then
            if type(texture) == "string" then
               texture = dxCreateTexture(texture)
            end

            self.screenTexture = texture
            self.maskTexture = dxCreateTexture(args[1])

            if not self.screenTexture then
                error("[Shader] ScreenTexture is invalid.", 2)
                return;
            elseif not self.maskTexture then
                error("[Shader] Could not create the maskTexture.", 2)
                return;
            end

            dxSetShaderValue(self.shader, "ScreenTexture", self.screenTexture)
            dxSetShaderValue(self.shader, "MaskTexture", self.maskTexture)
        elseif sType == "blur" then
            if type(texture) == "string" then
                texture = dxCreateTexture(texture)
            end

            self.screenTexture = texture
            self.blurStrength = args[1]
            self.w = args[2]
            self.h = args[3]
            dxSetShaderValue(self.shader, "ScreenSource", self.screenTexture);
            dxSetShaderValue(self.shader, "BlurStrength", self.blurStrength);
            dxSetShaderValue(self.shader, "UVSize", self.w, self.h)
        end
    else
        error("[Shader] Could not create the Shader. Please use debugscript 3!", 2)
    end

    return self;
end

function Shader:draw (x, y, w, h, ...)
    if self.shader then
        dxDrawImage(x, y, w, h, self.shader, ...)
    end
end

function Shader:updateShaderValue (shaderValueType, value)
    dxSetShaderValue(self.shader, shaderValueType, value)
end

function Shader:destroy ()
    if isElement(self.shader) then
        destroyElement(self.shader)
    end

    for i, v in ipairs(self) do
        if isElement(v) then
            destroyElement(v)
        end
    end
end