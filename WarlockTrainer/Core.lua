-- Core logic for WarlockTrainer (WoW 3.3.5a)
local addonName, WT = ...
WT = WT or {}

local L = WT.L

-- Addon frame for events
local eventFrame = CreateFrame("Frame", "WarlockTrainerEventFrame")
WT.eventFrame = eventFrame

-- Storage for learned spells lookup
WT.knownSpells = {}
WT.knownSpellIDs = {}

-- Initialize SavedVariables
local function InitDB()
    if not WarlockTrainerDB then
        WarlockTrainerDB = {
            minimapPos = 45,
            minimapHide = false,
            framePoint = "CENTER",
            frameRelative = "CENTER",
            frameX = 0,
            frameY = 0,
            activeTab = "available",
            autoAlert = true,
            language = "es",
        }
    end
    if WarlockTrainerDB.language and WT.Locales and WT.Locales[WarlockTrainerDB.language] then
        WT.L = WT.Locales[WarlockTrainerDB.language]
    else
        WT.L = WT.Locales.es
    end
end

-- Check if player is Warlock
function WT:IsWarlock()
    local _, class = UnitClass("player")
    return class == "WARLOCK"
end

-- Money formatting helper
function WT:FormatMoney(copper)
    if not copper or copper <= 0 then
        return WT.L.COST_FREE
    end
    local gold = math.floor(copper / 10000)
    local silver = math.floor((copper % 10000) / 100)
    local copperRem = copper % 100
    local result = ""
    if gold > 0 then
        result = result .. gold .. "|cffffd700g|r "
    end
    if silver > 0 or gold > 0 then
        result = result .. silver .. "|cffc7c7cfs|r "
    end
    result = result .. copperRem .. "|cffeda55fc|r"
    return result
end

-- Scan player spellbook for all learned spells and ranks
function WT:UpdateKnownSpells()
    wipe(WT.knownSpells)
    wipe(WT.knownSpellIDs)
    
    local numTabs = GetNumSpellTabs()
    local totalSpells = 0
    for tab = 1, numTabs do
        local _, _, _, numEntries = GetSpellTabInfo(tab)
        totalSpells = totalSpells + numEntries
    end
    
    for i = 1, totalSpells do
        local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
        if spellName then
            WT.knownSpells[spellName] = true
            if spellRank and spellRank ~= "" then
                WT.knownSpells[spellName .. " " .. spellRank] = true
                WT.knownSpells[spellName .. "(" .. spellRank .. ")"] = true
            end
            
            local link = GetSpellLink(i, BOOKTYPE_SPELL)
            if link then
                local id = link:match("spell:(%d+)")
                if id then
                    WT.knownSpellIDs[tonumber(id)] = true
                end
            end
        end
    end
end

-- Check if a specific spell from database is already learned
function WT:IsSpellLearned(spell)
    if not spell then return false end
    
    -- Check direct spell ID in spellbook
    if WT.knownSpellIDs[spell.id] then
        return true
    end
    
    -- Check native IsSpellKnown if available in 3.3.5a
    if IsSpellKnown and IsSpellKnown(spell.id) then
        return true
    end
    
    -- Check name + rank combo
    local name = spell.name or spell.defaultName
    local rank = spell.rank or spell.defaultRank
    if rank and rank ~= "" then
        if WT.knownSpells[name .. " " .. rank] or WT.knownSpells[name .. "(" .. rank .. ")"] then
            return true
        end
    else
        if WT.knownSpells[name] then
            return true
        end
    end
    
    return false
end

-- Filter spells available right now (level <= playerLevel and not learned)
function WT:GetAvailableSpells()
    local playerLevel = UnitLevel("player")
    local list = {}
    for _, spell in ipairs(WT.SpellsDatabase) do
        if spell.level <= playerLevel and not WT:IsSpellLearned(spell) then
            table.insert(list, spell)
        end
    end
    return list
end

-- Find next tier level of spells unlocking above current level
function WT:GetNextLevelSpells()
    local playerLevel = UnitLevel("player")
    local nextLevel = nil
    
    for _, spell in ipairs(WT.SpellsDatabase) do
        if spell.level > playerLevel then
            if not nextLevel or spell.level < nextLevel then
                nextLevel = spell.level
            end
        end
    end
    
    local list = {}
    if nextLevel then
        for _, spell in ipairs(WT.SpellsDatabase) do
            if spell.level == nextLevel then
                table.insert(list, spell)
            end
        end
    end
    return list, nextLevel
end

-- Get all spells already learned
function WT:GetLearnedSpells()
    local list = {}
    for _, spell in ipairs(WT.SpellsDatabase) do
        if WT:IsSpellLearned(spell) then
            table.insert(list, spell)
        end
    end
    return list
end

-- Get total cost of a list of spells
function WT:GetTotalCost(spellList)
    local total = 0
    if spellList then
        for _, spell in ipairs(spellList) do
            total = total + (spell.cost or 0)
        end
    end
    return total
end

-- Continent zone mappings to nearest capitals
local CONTINENT_CAPITALS = {
    -- Eastern Kingdoms
    [2] = {
        Alliance = { zone = "Stormwind City", name = "Demisette Cloven", x = 39.4, y = 84.8, subzone = "The Slaughtered Lamb" },
        Horde = { zone = "Undercity", name = "Richard Kerwin", x = 85.0, y = 16.0, subzone = "The Magic Quarter" },
    },
    -- Kalimdor
    [1] = {
        Alliance = { zone = "Ironforge", name = "Briarthorn", x = 51.0, y = 18.2, subzone = "Forlorn Cavern" }, -- closest or portal
        Horde = { zone = "Orgrimmar", name = "Zevrost", x = 48.4, y = 45.8, subzone = "Cleft of Shadows" },
    },
    -- Outland
    [3] = {
        Alliance = { zone = "Shattrath City", name = "Grik", x = 36.8, y = 40.2, subzone = "Aldor Rise" },
        Horde = { zone = "Shattrath City", name = "Vorrel", x = 43.6, y = 90.4, subzone = "Scryer's Tier" },
    },
    -- Northrend
    [4] = {
        Alliance = { zone = "Dalaran", name = "Carlin Songweaver", x = 48.6, y = 56.4, subzone = "The Underbelly" },
        Horde = { zone = "Dalaran", name = "Christopher Drake", x = 49.2, y = 57.0, subzone = "The Underbelly" },
    },
}

-- Zone to Continent Lookup (supports English and Spanish client zone names)
local ZONE_CONTINENTS = {
    -- Northrend (4)
    ["Borean Tundra"] = 4, ["Tundra Boreal"] = 4,
    ["Howling Fjord"] = 4, ["Fiordo Aquilonal"] = 4,
    ["Dragonblight"] = 4, ["Cementerio de Dragones"] = 4,
    ["Grizzly Hills"] = 4, ["Colinas Pardas"] = 4,
    ["Zul'Drak"] = 4,
    ["Sholazar Basin"] = 4, ["Cuenca de Sholazar"] = 4,
    ["The Storm Peaks"] = 4, ["Las Cumbres Tormentosas"] = 4,
    ["Icecrown"] = 4, ["Corona de Hielo"] = 4,
    ["Crystalsong Forest"] = 4, ["Bosque Canto de Cristal"] = 4,
    ["Dalaran"] = 4, ["Wintergrasp"] = 4, ["Conquista del Invierno"] = 4,
    ["Hrothgar's Landing"] = 4,

    -- Outland (3)
    ["Hellfire Peninsula"] = 3, ["Península del Fuego Infernal"] = 3,
    ["Zangarmarsh"] = 3, ["Marisma de Zangar"] = 3,
    ["Terokkar Forest"] = 3, ["Bosque de Terokkar"] = 3,
    ["Nagrand"] = 3,
    ["Blade's Edge Mountains"] = 3, ["Montañas Filospada"] = 3,
    ["Netherstorm"] = 3, ["Tormenta Abisal"] = 3,
    ["Shadowmoon Valley"] = 3, ["Valle Sombraluna"] = 3,
    ["Shattrath City"] = 3, ["Ciudad de Shattrath"] = 3,

    -- Kalimdor (1)
    ["Durotar"] = 1, ["The Barrens"] = 1, ["Los Baldíos"] = 1,
    ["Mulgore"] = 1, ["Ashenvale"] = 1, ["Vallefresno"] = 1,
    ["Stonetalon Mountains"] = 1, ["Sierra Espolón"] = 1,
    ["Desolace"] = 1, ["Feralas"] = 1,
    ["Dustwallow Marsh"] = 1, ["Marjal Revolcafango"] = 1,
    ["Thousand Needles"] = 1, ["Las Mil Agujas"] = 1,
    ["Tanaris"] = 1, ["Un'Goro Crater"] = 1, ["Cráter de Un'Goro"] = 1,
    ["Silithus"] = 1, ["Winterspring"] = 1, ["Cuna del Invierno"] = 1,
    ["Felwood"] = 1, ["Frondavil"] = 1, ["Moonglade"] = 1, ["Claro de la Luna"] = 1,
    ["Darkshore"] = 1, ["Costa Oscura"] = 1, ["Teldrassil"] = 1,
    ["Orgrimmar"] = 1, ["Thunder Bluff"] = 1, ["Cima del Trueno"] = 1,

    -- Eastern Kingdoms (2)
    ["Elwynn Forest"] = 2, ["Bosque de Elwynn"] = 2,
    ["Westfall"] = 2, ["Páramos de Poniente"] = 2,
    ["Redridge Mountains"] = 2, ["Montañas Crestagrana"] = 2,
    ["Duskwood"] = 2, ["Bosque del Ocaso"] = 2,
    ["Loch Modan"] = 2, ["Wetlands"] = 2, ["Los Humedales"] = 2,
    ["Dun Morogh"] = 2, ["Ironforge"] = 2, ["Forjaz"] = 2,
    ["Stormwind City"] = 2, ["Ciudad de Ventormenta"] = 2,
    ["Badlands"] = 2, ["Tierras Inhóspitas"] = 2,
    ["Swamp of Sorrows"] = 2, ["Pantano de las Penas"] = 2,
    ["Blasted Lands"] = 2, ["Las Tierras Devastadas"] = 2,
    ["Searing Gorge"] = 2, ["La Garganta de Fuego"] = 2,
    ["Burning Steppes"] = 2, ["Las Estepas Ardientes"] = 2,
    ["Hillsbrad Foothills"] = 2, ["Laderas de Trabalomas"] = 2,
    ["Alterac Mountains"] = 2, ["Montañas de Alterac"] = 2,
    ["Arathi Highlands"] = 2, ["Tierras Altas de Arathi"] = 2,
    ["The Hinterlands"] = 2, ["Tierras del Interior"] = 2,
    ["Western Plaguelands"] = 2, ["Tierras de la Peste del Oeste"] = 2,
    ["Eastern Plaguelands"] = 2, ["Tierras de la Peste del Este"] = 2,
    ["Tirisfal Glades"] = 2, ["Claros de Tirisfal"] = 2,
    ["Silverpine Forest"] = 2, ["Bosque de Argénteos"] = 2,
    ["Undercity"] = 2, ["Entrañas"] = 2,
    ["Eversong Woods"] = 2, ["Bosque Canción Eterna"] = 2,
    ["Ghostlands"] = 2, ["Tierras Fantasma"] = 2,
    ["Silvermoon City"] = 2, ["Ciudad de Lunargenta"] = 2,
    ["Isle of Quel'Danas"] = 2, ["Isla de Quel'Danas"] = 2,
    ["Stranglethorn Vale"] = 2, ["Vega de Tuercespina"] = 2,
}

-- Locate the nearest trainer for player
function WT:GetNearestTrainer()
    local playerFaction = UnitFactionGroup("player") or "Alliance"
    local playerLevel = UnitLevel("player")
    local currentZone = GetZoneText()
    local currentSubZone = GetSubZoneText()
    local px, py = GetPlayerMapPosition("player")
    px = px * 100
    py = py * 100
    
    local bestTrainer = nil
    local bestDistance = 999999
    
    -- 1. Check if we are in the exact same zone as any trainer
    for _, trainer in ipairs(WT.TrainersDatabase) do
        local factionMatch = (trainer.faction == "Both" or trainer.faction == playerFaction)
        local levelMatch = (not trainer.maxLevel) or (playerLevel <= trainer.maxLevel)
        
        if factionMatch and levelMatch then
            -- Match zone name in English or Spanish
            if trainer.zone == currentZone or trainer.zoneEs == currentZone then
                if px > 0 and py > 0 then
                    local dx = px - trainer.x
                    local dy = py - trainer.y
                    local dist = math.sqrt(dx * dx + dy * dy)
                    if dist < bestDistance then
                        bestDistance = dist
                        bestTrainer = trainer
                    end
                else
                    bestTrainer = trainer
                    bestDistance = 0
                    break
                end
            end
        end
    end
    
    if bestTrainer then
        return bestTrainer, math.floor(bestDistance * 10) / 10, true
    end
    
    -- 2. If not in the same zone, find capital/nearest hub for the continent
    local currentContinent = ZONE_CONTINENTS[currentZone]
    if not currentContinent and (not WorldMapFrame or not WorldMapFrame:IsShown()) then
        SetMapToCurrentZone()
        currentContinent = GetCurrentMapContinent()
    end
    
    if currentContinent and CONTINENT_CAPITALS[currentContinent] then
        local cap = CONTINENT_CAPITALS[currentContinent][playerFaction]
        if cap then
            return cap, nil, false
        end
    end
    
    -- Fallback default based on faction
    if playerFaction == "Horde" then
        return {
            name = "Zevrost",
            zone = "Orgrimmar",
            subzone = "Cleft of Shadows",
            x = 48.4, y = 45.8
        }, nil, false
    else
        return {
            name = "Demisette Cloven",
            zone = "Stormwind City",
            subzone = "The Slaughtered Lamb (The Mage Quarter)",
            x = 39.4, y = 84.8
        }, nil, false
    end
end

-- Set Waypoint supporting TomTom, Cartographer, or Carbonite
function WT:SetWaypoint(trainer)
    if not trainer then
        local t = WT:GetNearestTrainer()
        trainer = t
    end
    if not trainer then return end
    
    local zoneText = trainer.zone
    local x = trainer.x
    local y = trainer.y
    local desc = trainer.name .. " (" .. (trainer.subzone or "Trainer") .. ")"
    
    -- 1. TomTom
    if SlashCmdList["TOMTOM_WAY"] then
        SlashCmdList["TOMTOM_WAY"](string.format("%s %.1f %.1f %s", zoneText, x, y, desc))
        DEFAULT_CHAT_FRAME:AddMessage(string.format(WT.L.NAV_SET, trainer.name, zoneText, x, y))
        return
    elseif TomTom and TomTom.AddWaypoint then
        TomTom:AddWaypoint(0, x / 100, y / 100, { title = desc })
        DEFAULT_CHAT_FRAME:AddMessage(string.format(WT.L.NAV_SET, trainer.name, zoneText, x, y))
        return
    end

    -- 2. Cartographer_Waypoints
    if Cartographer_Waypoints and _G.SetWaypoint then
        local success = pcall(function()
            _G.SetWaypoint(zoneText, x / 100, y / 100, desc)
        end)
        if success then
            DEFAULT_CHAT_FRAME:AddMessage(string.format(WT.L.NAV_SET, trainer.name, zoneText, x, y))
            return
        end
    end

    -- 3. Carbonite
    if Nx and Nx.Map and Nx.Map.SetTarget then
        local success = pcall(function()
            Nx.Map:SetTarget(zoneText, x, y, desc)
        end)
        if success then
            DEFAULT_CHAT_FRAME:AddMessage(string.format(WT.L.NAV_SET, trainer.name, zoneText, x, y))
            return
        end
    end

    -- 4. Default message with coordinates
    DEFAULT_CHAT_FRAME:AddMessage(string.format(WT.L.NAV_NOT_FOUND, trainer.name, zoneText, x, y))
end

-- Backward compatibility alias
WT.SetTomTomWaypoint = WT.SetWaypoint

-- Handle Level Up notification
local function OnLevelUp(newLevel)
    if not WT:IsWarlock() then return end
    if not WarlockTrainerDB.autoAlert then return end
    
    local availableSpells = {}
    for _, spell in ipairs(WT.SpellsDatabase) do
        if spell.level == newLevel then
            table.insert(availableSpells, spell)
        end
    end
    
    if #availableSpells > 0 then
        local totalCost = WT:GetTotalCost(availableSpells)
        local costStr = WT:FormatMoney(totalCost)
        local trainer = WT:GetNearestTrainer()
        local trainerName = trainer and trainer.name or "Entrenador"
        local trainerZone = trainer and (trainer.subzone and (trainer.zone .. " - " .. trainer.subzone) or trainer.zone) or ""
        
        PlaySound("TellMessage")
        DEFAULT_CHAT_FRAME:AddMessage(string.format(WT.L.ALERT_LEVELUP, newLevel, #availableSpells, costStr, trainerName, trainerZone))
        
        if WT.UI and WT.UI.Refresh then
            WT.UI:Refresh()
        end
    end
end

-- Event Handling
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("SPELLS_CHANGED")
eventFrame:RegisterEvent("LEARNED_SPELL_IN_TAB")
eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
eventFrame:RegisterEvent("PLAYER_MONEY")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddon = ...
        if loadedAddon == addonName then
            InitDB()
            WT:InitializeSpells()
            WT:UpdateKnownSpells()
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        WT:InitializeSpells()
        WT:UpdateKnownSpells()
        if WT.UI and WT.UI.Refresh then
            WT.UI:Refresh()
        end
    elseif event == "SPELLS_CHANGED" or event == "LEARNED_SPELL_IN_TAB" then
        WT:UpdateKnownSpells()
        if WT.UI and WT.UI.Refresh then
            WT.UI:Refresh()
        end
    elseif event == "PLAYER_MONEY" then
        if WT.UI and WT.UI.RefreshMoney then
            WT.UI:RefreshMoney()
        end
    elseif event == "PLAYER_LEVEL_UP" then
        local newLevel = ...
        OnLevelUp(newLevel)
    end
end)

-- Slash Commands
SLASH_WARLOCKTRAINER1 = "/wt"
SLASH_WARLOCKTRAINER2 = "/warlock-train"
SLASH_WARLOCKTRAINER3 = "/wtrain"

SlashCmdList["WARLOCKTRAINER"] = function(msg)
    if not WT:IsWarlock() then
        DEFAULT_CHAT_FRAME:AddMessage(WT.L.NOT_A_WARLOCK)
    end
    
    msg = string.lower(strtrim(msg or ""))
    if msg == "help" then
        DEFAULT_CHAT_FRAME:AddMessage(WT.L.CMD_HELP)
    elseif msg == "es" then
        WT:SetLanguage("es")
    elseif msg == "en" then
        WT:SetLanguage("en")
    elseif msg == "way" or msg == "tomtom" or msg == "ruta" then
        WT:SetWaypoint()
    elseif msg == "trainer" or msg == "loc" then
        local trainer = WT:GetNearestTrainer()
        if trainer then
            DEFAULT_CHAT_FRAME:AddMessage(string.format("|cff9482c9[WarlockTrainer]|r %s: |cff00ff00%s|r en %s (%s) Coords: (%.1f, %.1f)", 
                WT.L.TRAINER_LABEL, trainer.name, trainer.zone, trainer.subzone or "", trainer.x, trainer.y))
        end
    else
        if WT.UI then
            WT.UI:Toggle()
        end
    end
end
