-- ****************************************************************************
-- *
-- *  PROJECT:     	Original: Open MTA:DayZ (MTA-SA The Crew)
-- *  FILE:        	Shared/classes/Language.lua
-- *  PURPOSE:     	Class to manage translations
-- *
-- ****************************************************************************
TranslationManager = {}

function TranslationManager:constructor()
    self.m_Translations = {}

    -- Load standard translations
    self:loadTranslation("en")
end

function TranslationManager:loadTranslation(locale)
    local path = "core/FILES/langs/"..(SERVER and "server" or "client").."."..locale..".po"
    if fileExists(path) then
        self.m_Translations[locale] = POParser:loadFile(path)
        return true
    end
    error("not found "..path)
    return false
end

function TranslationManager:translate(message, locale)
    if locale == "de" then
        return message
    end

    if not self.m_Translations[locale] then
        outputDebugString("[Language] The translation ("..locale..") is not loaded yet!")
        return message
    end

    if self.m_Translations[locale] then
        local translatedMsg = self.m_Translations[locale]:translate(message)
        if not translatedMsg then
            outputDebugString(("[Language] There's a missing translation. Please update the .po files (File: %s.%s.po)"):format(SERVER and "server" or "client", locale))
            outputDebugString("[Language] Missing string: "..message)
            return message
        end
        return translatedMsg
    end

    return message
end

if SERVER then
    function _(message, player)
        return TranslationManager:translate(message, player:getLocale())
    end
else
    function _(message)
        return TranslationManager:translate(message, localPlayer:getLocale())
    end
end

TranslationManager:constructor()