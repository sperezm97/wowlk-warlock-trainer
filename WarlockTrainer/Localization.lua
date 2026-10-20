-- Localization for WarlockTrainer (WoW 3.3.5a)
local addonName, WT = ...
WT = WT or {}

WT.Locales = {}

WT.Locales.es = {
    -- Window Titles & Labels
    TITLE = "Warlock Trainer |cff9482c9(3.3.5a)|r",
    SUBTITLE = "Gestor de Habilidades y Entrenadores para Brujos",
    YOUR_LEVEL = "Tu Nivel:",
    YOUR_MONEY = "Tu Dinero:",
    TOTAL_NEEDED = "Coste Pendiente:",
    MONEY_MISSING = "Faltan:",
    TRAINER_LABEL = "Entrenador más cercano:",
    COORDINATES = "Coords:",
    ZONE = "Zona:",
    DISTANCE = "Distancia aprox.:",
    NAV_BTN = "Ruta / Waypoint",
    NAV_SET = "|cff9482c9[WarlockTrainer]|r Flecha / Waypoint fijado hacia %s en %s (%.1f, %.1f)",
    NAV_NOT_FOUND = "|cff9482c9[WarlockTrainer]|r Entrenador más cercano: %s en %s (%.1f, %.1f)",
    
    -- Filter Tabs
    TAB_AVAILABLE = "Disponibles",
    TAB_NEXT = "Próximo Nivel",
    TAB_ALL = "Todos (1-80)",
    TAB_LEARNED = "Aprendidos",
    
    -- Spell Row Status
    STATUS_LEARNED = "|cff00ff00Aprendido|r",
    STATUS_AVAILABLE = "|cffffff00¡Disponible!|r",
    STATUS_NO_GOLD = "|cffff5555¡Sin Oro!|r",
    STATUS_LOCKED = "|cff888888Requiere nivel %d|r",
    COST_FREE = "|cff00ff00Gratis|r",
    
    -- Level Up & Alerts
    ALERT_LEVELUP = "|cff9482c9[WarlockTrainer]|r: ¡Felicidades por alcanzar el nivel %d! Tienes |cffffff00%d nuevos hechizos|r para aprender en el instructor. Coste estimado: %s. El entrenador más cercano es |cff00ff00%s|r (%s).",
    ALERT_REMINDER = "|cff9482c9[WarlockTrainer]|r: Tienes |cffffff00%d hechizos disponibles|r para tu nivel sin aprender. Coste: %s. Entrenador más cercano: |cff00ff00%s|r.",
    
    -- Tooltip & Minimap
    MINIMAP_TOOLTIP_TITLE = "Warlock Trainer",
    MINIMAP_TOOLTIP_LCLICK = "|cff00ff00Clic izquierdo:|r Abrir/Cerrar panel",
    MINIMAP_TOOLTIP_RCLICK = "|cff00ff00Clic derecho:|r Localizar entrenador en chat",
    MINIMAP_AVAILABLE_SPELLS = "Hechizos disponibles para aprender: |cffffff00%d|r",
    MINIMAP_TOTAL_COST = "Coste total pendiente: %s",
    
    -- Commands
    CMD_HELP = "|cff9482c9[WarlockTrainer]|r Comandos: |cffffff00/wt|r o |cffffff00/warlock-train|r para abrir ventana. |cffffff00/wt es|r o |cffffff00/wt en|r para cambiar idioma.",
    NOT_A_WARLOCK = "|cff9482c9[WarlockTrainer]|r Aviso: Tu personaje actual no es un Brujo.",
    LANG_CHANGED = "|cff9482c9[WarlockTrainer]|r Idioma cambiado a: Español",
}

WT.Locales.en = {
    TITLE = "Warlock Trainer |cff9482c9(3.3.5a)|r",
    SUBTITLE = "Warlock Spell & Trainer Manager",
    YOUR_LEVEL = "Your Level:",
    YOUR_MONEY = "Your Money:",
    TOTAL_NEEDED = "Remaining Cost:",
    MONEY_MISSING = "Missing:",
    TRAINER_LABEL = "Nearest Trainer:",
    COORDINATES = "Coords:",
    ZONE = "Zone:",
    DISTANCE = "Approx. Distance:",
    NAV_BTN = "Route / Waypoint",
    NAV_SET = "|cff9482c9[WarlockTrainer]|r Waypoint / Arrow set to %s in %s (%.1f, %.1f)",
    NAV_NOT_FOUND = "|cff9482c9[WarlockTrainer]|r Nearest trainer: %s in %s (%.1f, %.1f)",
    
    TAB_AVAILABLE = "Available",
    TAB_NEXT = "Next Level",
    TAB_ALL = "All (1-80)",
    TAB_LEARNED = "Learned",
    
    STATUS_LEARNED = "|cff00ff00Learned|r" ,
    STATUS_AVAILABLE = "|cffffff00Available!|r",
    STATUS_NO_GOLD = "|cffff5555No Gold!|r",
    STATUS_LOCKED = "|cff888888Requires Level %d|r",
    COST_FREE = "|cff00ff00Free|r",
    
    ALERT_LEVELUP = "|cff9482c9[WarlockTrainer]|r: Congrats on reaching level %d! You have |cffffff00%d new spells|r to train. Estimated cost: %s. Nearest trainer: |cff00ff00%s|r (%s).",
    ALERT_REMINDER = "|cff9482c9[WarlockTrainer]|r: You have |cffffff00%d available spells|r to learn. Cost: %s. Nearest trainer: |cff00ff00%s|r.",
    
    MINIMAP_TOOLTIP_TITLE = "Warlock Trainer",
    MINIMAP_TOOLTIP_LCLICK = "|cff00ff00Left-Click:|r Toggle window",
    MINIMAP_TOOLTIP_RCLICK = "|cff00ff00Right-Click:|r Locate nearest trainer in chat",
    MINIMAP_AVAILABLE_SPELLS = "Available spells to train: |cffffff00%d|r",
    MINIMAP_TOTAL_COST = "Total remaining cost: %s",
    
    CMD_HELP = "|cff9482c9[WarlockTrainer]|r Commands: |cffffff00/wt|r or |cffffff00/warlock-train|r to toggle window. |cffffff00/wt es|r or |cffffff00/wt en|r to change language.",
    NOT_A_WARLOCK = "|cff9482c9[WarlockTrainer]|r Note: Your current character is not a Warlock.",
    LANG_CHANGED = "|cff9482c9[WarlockTrainer]|r Language changed to: English",
}

-- Default to Spanish (or player preference)
WT.L = WT.Locales.es

function WT:SetLanguage(lang)
    if WT.Locales[lang] then
        WT.L = WT.Locales[lang]
        if WarlockTrainerDB then
            WarlockTrainerDB.language = lang
        end
        DEFAULT_CHAT_FRAME:AddMessage(WT.L.LANG_CHANGED)
        if WT.UI and WT.UI.MainFrame and WT.UI.MainFrame:IsShown() then
            WT.UI:Refresh()
        end
    end
end
