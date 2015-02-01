ranslationManager = {}

function TranslationManager:constructor ()
	self.Translations = {}
	
	TranslationManager:loadTranslation("de")
	
	if SERVER then
		_G["_"] = function (msg, player) self:translate(msg, player:getLocale()) end
	elseif CLIENT then
		_G["_"] = function (msg) self:translate(msg, localPlayer:getLocale()) end
	end
end











--[[
	StiviK: de
	[CLIENT] _"Hello World"                                            --> "Hallo Welt"
	[SERVER] _("Hello World", getPlayerFromName("StiviK"):getLocale()) --> "Hallo Welt"
--]]