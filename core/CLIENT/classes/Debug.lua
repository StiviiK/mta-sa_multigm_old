if DEBUG then
	Debug = {}


	function Debug:constructor ()
		self.DebugWindow1 = dxMoveable:createMoveable(259, 254, true)
		self.DebugWindow1.posX, self.DebugWindow1.posY = screenW - 269, 10

		addEventHandler("onClientRender", root, self.renderInformations)
		
		Version.debug_label = guiCreateLabel(1, screenH - 15, 500, 18, ("Debugging-Mode: %s ([unknown] FPS)"):format(DEBUG and _("Aktiviert"):lower() or "disabled"), false)
		guiSetAlpha(Version.debug_label, 0.53)
		
		if string.find(VERSION, "dev") then
			Version.info_label = guiCreateLabel(1, screenH - 15, 500, 18, ("%s (%s)"):format(_"WARNUNG: Auf diesem Server läuft eine Entwicklerversion!", VERSION), false)
			guiSetAlpha(Version.info_label, 0.53)
			guiSetPosition(Version.debug_label, 1, screenH - 30, false)
		end
	end
	
	function Debug:destructor ()
		removeEventHandler("onClientRender", root, self.renderInformations)
	end
end