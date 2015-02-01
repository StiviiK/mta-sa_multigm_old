DEBUG = true
VERSION = "[0.7-dev]"

VERSION_NAME = "MTA:Multigamemode"
VERSION_NAME_SERVERL = "mta-multigamemode"

--[[ NOT USES ANYMORE
classes = {
	server = {
		{"Databasemanager",      "core/SERVER/classes/Database.lua",                 true},
		{"Playerclass",          "core/SERVER/classes/Player.lua",                   true},
		{"Playermanager",        "core/SERVER/classes/Playermanager.lua",            true},
		{"Gamemodemanager",      "core/SERVER/classes/Gamemode.lua",                 true},
		{"Elementmanager",       "core/SERVER/classes/Elementmanager.lua",           true},
		{"Permissionmanager",    "core/SERVER/classes/Permissionmanager.lua",        true},
		{"Mapmanager",           "core/SERVER/classes/Mapmanager.lua",               true},
		{"Downloadmanager",      "core/SERVER/classes/Downloadmanager.lua",          true},
		{"Reg-Login Management", "core/SERVER/management/management.reg-login.lua",  true},
		{"Statistics",           "core/SERVER/classes/Statistics.lua",               true},
	},
	client = {
		{"Versionamanger",       "core/CLIENT/classes/Version.lua",                  true},
		{"Playerclass",          "core/CLIENT/classes/localPlayer.lua",              true},
		{"Cursorclass",          "core/CLIENT/classes/Cursor.lua",                   true},
		{"Downloadmanager",      "core/CLIENT/classes/Downloadmanager.lua",          true},
		{"maskShader Class",     "core/CLIENT/classes/maskShader.lua",               true},
		{"dxUtil Class",         "core/CLIENT/classes/dxUtil.lua",                   true},
		{"Debugging Class",      "core/CLIENT/classes/Debug.lua",                    true},
		{"Debug Widget",         "core/CLIENT/widgets/widget.debug.lua",             true},
		{"HUD Widget",           "core/CLIENT/widgets/widget.hud.lua",               true},
		{"Register/Login Form",  "core/CLIENT/forms/form.login.lua",        true},
		{"dx_Libary",            "core/CLIENT/include/dxClass/dx_library.lua",       true},
		{"dx_Button",            "core/CLIENT/include/dxClass/dx_button.lua",        true},
		{"dx_Checkbox",          "core/CLIENT/include/dxClass/dx_checkbox.lua",      true},
		{"dx_Combobox",          "core/CLIENT/include/dxClass/dx_combobox.lua",      true},
		{"dx_Editfield",         "core/CLIENT/include/dxClass/dx_editfield.lua",     true},
		{"dx_Font",              "core/CLIENT/include/dxClass/dx_font.lua",          true},
		{"dx_Gridlist",          "core/CLIENT/include/dxClass/dx_gridlist.lua",      true},
		{"dx_Image",             "core/CLIENT/include/dxClass/dx_image.lua",         true},
		{"dx_Memo",              "core/CLIENT/include/dxClass/dx_memo.lua",          true},
		{"dx_Progressbar",       "core/CLIENT/include/dxClass/dx_progressbar.lua",   true},
		{"dx_Radiobutton",       "core/CLIENT/include/dxClass/dx_radiobutton.lua",   true},
		{"dx_Scrollbar",         "core/CLIENT/include/dxClass/dx_scrollbar.lua",     true},
		{"dx_Scrollpane",        "core/CLIENT/include/dxClass/dx_scrollpane.lua",    true},
		{"dx_Tabemenue",         "core/CLIENT/include/dxClass/dx_tab.lua",           true},
		{"dx_Tabpanel",          "core/CLIENT/include/dxClass/dx_tabpanel.lua",      true},
		{"dx_Text",              "core/CLIENT/include/dxClass/dx_text.lua",          true},
		{"dx_Treeview",          "core/CLIENT/include/dxClass/dx_treeview.lua",      true},
		{"dx_Window",            "core/CLIENT/include/dxClass/dx_window.lua",        true},
	},
	statistics = {
		{"Playerdata",           "core/SERVER/statistics/statistics.playerdata.lua", true}
	}
}
--]]