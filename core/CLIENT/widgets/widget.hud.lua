widget_defaultHUD = {}

function widget_defaultHUD:create ()
	--self.skin = maskShader:create("gamemodes/lobby/FILES/images/account/default.jpg", "core/FILES/shader/mask/mask_images/mask_round_big.png")
	self.skin = Shader:newShader("mask", "core/FILES/shader/mask/maskShader.fx", "gamemodes/lobby/FILES/images/account/default.jpg", "core/FILES/shader/mask/mask_images/mask_round_big.png")
	
	setPlayerHudComponentVisible("all", false)
	showChat(false)
	
	--self.renderTarget = dxCreateRenderTarget(305, 120, true)
	self.renderTarget = dxMoveable:createMoveable(305*px, 100*py, true)
	self.renderTarget.posX, self.renderTarget.posY = 10*px, 10*py
		
	self.renderFunc = function () self:render() end
	addEventHandler("onClientRender", root, self.renderFunc)
end

function widget_defaultHUD:render ()
	localPlayer.level = localPlayer.level or 25
	localPlayer.currEXP = localPlayer.currEXP or 55522
	localPlayer.nextlvlEXP = localPlayer.nextlvlEXP or 70000
	localPlayer.percentEXP = localPlayer.percentEXP or (localPlayer.nextlvlEXP / localPlayer.currEXP) * 100

	if fileExists(("gamemodes/lobby/FILES/images/account/skins/%s.jpg"):format(getElementModel(localPlayer))) then
		--self.skin:update(("gamemodes/lobby/FILES/images/account/skins/%s.jpg"):format(getElementModel(localPlayer)), false)
		if isElement(self.skin.screenTexture) then
			destroyElement(self.skin.screenTexture)
		end
		self.skin.screenTexture = dxCreateTexture(("gamemodes/lobby/FILES/images/account/skins/%s.jpg"):format(getElementModel(localPlayer)))
		self.skin:updateShaderValue("ScreenTexture", self.skin.screenTexture)
	elseif fileExists("gamemodes/lobby/FILES/images/account/default.jpg") then
		--self.skin:update("gamemodes/lobby/FILES/images/account/default.jpg", false)
		if isElement(self.skin.screenTexture) then
			destroyElement(self.skin.screenTexture)
		end
		self.skin.screenTexture = dxCreateTexture("gamemodes/lobby/FILES/images/account/default.jpg")
		self.skin:updateShaderValue("ScreenTexture", self.skin.screenTexture)
	end
	
	dxSetRenderTarget(self.renderTarget.renderTarget, true)
		dxSetBlendMode("modulate_add")
	
		--self.skin:render(0*px, 0*py, 100*px, 100*py)
		self.skin:draw(0*px, 0*py, 100*px, 100*py)
		dxDrawText(getMainTime(), 104*px, 0*py, 176*px, 30*py, tocolor(255, 255, 255, 255), 2.00*px, "sans", "left", "bottom", false, false, false, false, false)
		dxDrawLine(104*px, 27*py, 285*px, 27*py, tocolor(255, 255, 255, 255), 1, false)
		if DEBUG then
			dxDrawText(("%s ( %sms )"):format(localPlayer.name, localPlayer.ping), 176*px, 9*py, 286*px, 27*py, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "center", true, false, false, false, false)
		else
			dxDrawText(("%s"):format(localPlayer.name), 176*px, 9*py, 286*px, 27*py, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "center", true, false, false, false, false)
		end
		dxDrawRectangle(104*px, 46*py, 182*px, 14*py, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(104*px, 46*py, ((182 / localPlayer.percentEXP) * 100)*px, 14*py, tocolor(254, 138, 0, 189), false)
		dxDrawText(("Level: %s"):format(localPlayer.level), 104*px, 30*py, 286*px, 44*py, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "bottom", true, false, false, false, false)
		dxDrawText(("%s $"):format((localPlayer.money)), 104*px, 30*py, 286*px, 44*py, tocolor(255, 255, 255, 255), 1.00, "default-bold", "right", "bottom", true, false, false, false, false)
		dxDrawText(("%s / %s EXP"):format(localPlayer.currEXP, localPlayer.nextlvlEXP), 104*px, 46*py, 286*px, 60*py, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
		--dxDrawText("", 124, 80, 306, 94, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false) -- "+ 3999 EXP"
		dxDrawRectangle(104*px, 65*py, 182*px, 14*py, tocolor(0, 0, 0, 137), false)
		dxDrawRectangle(104*px, 65*py, ((182 * localPlayer.health) / 100)*px, 14*py, (localPlayer.health > 20 and tocolor(0, 125, 0, 189) or tocolor(125, 0, 0, 255)), false)
		dxDrawRectangle(104*px, 65*py, ((182 * localPlayer.armor) / 100)*px, 14*py, tocolor(0, 0, 125, 189), false)
		dxDrawText(("%s %s"):format(math.round(localPlayer.health), "%"), 104*px, 65*py, 286*px, 79*py, tocolor(255, 254, 254, 255), 0.80, "default-bold", "center", "center", false, false, false, false, false)
		
		dxSetBlendMode("blend")
	dxSetRenderTarget()
	
	dxDrawImage(self.renderTarget.posX, self.renderTarget.posY, self.renderTarget.w, self.renderTarget.h, self.renderTarget.renderTarget)
end

function widget_defaultHUD:destroy ()
	self.skin:destroy()
	
	setPlayerHudComponentVisible("all", true)
	showChat(true)
	
	removeEventHandler("onClientRender", root, self.renderFunc)
end