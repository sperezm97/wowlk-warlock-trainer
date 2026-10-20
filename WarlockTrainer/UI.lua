-- UI for WarlockTrainer (WoW 3.3.5a)
-- High-contrast, crystal clear UI compatible with Standard WoW and ElvUI
local addonName, WT = ...
WT = WT or {}

WT.UI = {}

local ROW_HEIGHT = 44
local NUM_ROWS = 7
local currentTab = "available"
local currentDisplayList = {}
local selectedQuest = nil

-- Create the main window
local mainFrame = CreateFrame("Frame", "WarlockTrainerMainFrame", UIParent)
WT.UI.MainFrame = mainFrame

mainFrame:SetSize(640, 535)
mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
mainFrame:SetMovable(true)
mainFrame:EnableMouse(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", mainFrame.StartMoving)
mainFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    local point, _, relPoint, x, y = self:GetPoint()
    if WarlockTrainerDB then
        WarlockTrainerDB.framePoint = point
        WarlockTrainerDB.frameRelative = relPoint
        WarlockTrainerDB.frameX = x
        WarlockTrainerDB.frameY = y
    end
end)
mainFrame:SetClampedToScreen(true)
mainFrame:Hide()

-- Allow Esc to close
tinsert(UISpecialFrames, "WarlockTrainerMainFrame")

-- Backdrop (High-contrast Dark Slate with Crisp Bronze Border)
mainFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 28,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
mainFrame:SetBackdropColor(0.06, 0.05, 0.09, 0.98)

-- Header Texture Banner (Background Layer so text is always in front)
local headerTexture = mainFrame:CreateTexture(nil, "BACKGROUND")
headerTexture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
headerTexture:SetSize(380, 64)
headerTexture:SetPoint("TOP", mainFrame, "TOP", 0, 12)

-- Title FontString (OVERLAY layer, bold, high contrast)
local titleText = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
titleText:SetPoint("TOP", headerTexture, "TOP", 0, -14)
titleText:SetText("|cffffd700Warlock Trainer|r |cffc4b5fd(3.3.5a)|r")

-- Subtitle
local subTitleText = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
subTitleText:SetPoint("TOP", mainFrame, "TOP", 0, -32)
subTitleText:SetText("|cffc4b5fdGestor de Habilidades, Entrenadores y Misiones de Brujo|r")

-- Close Button
local closeBtn = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -6, -6)

-- ==================== TOP INFO BOXES ====================

-- 1. Player Info & Money Frame
local playerBox = CreateFrame("Frame", nil, mainFrame)
playerBox:SetSize(295, 56)
playerBox:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 18, -54)
playerBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 14,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
playerBox:SetBackdropColor(0.10, 0.08, 0.15, 0.95)
playerBox:SetBackdropBorderColor(0.55, 0.45, 0.70, 0.9)

local playerInfoText = playerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
playerInfoText:SetPoint("TOPLEFT", playerBox, "TOPLEFT", 10, -7)

local playerMoneyText = playerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
playerMoneyText:SetPoint("TOPLEFT", playerBox, "TOPLEFT", 10, -23)

local costSummaryText = playerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
costSummaryText:SetPoint("TOPLEFT", playerBox, "TOPLEFT", 10, -38)

-- 2. Nearest Trainer Frame
local trainerBox = CreateFrame("Frame", nil, mainFrame)
trainerBox:SetSize(305, 56)
trainerBox:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -18, -54)
trainerBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 14,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
trainerBox:SetBackdropColor(0.10, 0.08, 0.15, 0.95)
trainerBox:SetBackdropBorderColor(0.55, 0.45, 0.70, 0.9)

local trainerTitleText = trainerBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
trainerTitleText:SetPoint("TOPLEFT", trainerBox, "TOPLEFT", 10, -7)
trainerTitleText:SetText("|cffffd700Entrenador más cercano:|r")

local trainerInfoText = trainerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
trainerInfoText:SetPoint("TOPLEFT", trainerBox, "TOPLEFT", 10, -23)
trainerInfoText:SetWidth(205)
trainerInfoText:SetJustifyH("LEFT")

-- Navigation Button (TomTom / Cartographer / Carbonite)
local navBtn = CreateFrame("Button", nil, trainerBox, "UIPanelButtonTemplate")
navBtn:SetSize(76, 24)
navBtn:SetPoint("RIGHT", trainerBox, "RIGHT", -8, 0)
navBtn:SetText("Ruta")
navBtn:SetScript("OnClick", function()
    local t = WT:GetNearestTrainer()
    WT:SetWaypoint(t)
end)
navBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:AddLine("Fijar Ruta / Waypoint", 1, 1, 1)
    GameTooltip:AddLine("Compatible con Cartographer, TomTom y Carbonite.", 0.7, 0.8, 1)
    GameTooltip:Show()
end)
navBtn:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)

-- ==================== TABS BAR ====================
local tabs = {}
local tabConfig = {
    { id = "available", width = 114, defaultLabel = "Disponibles" },
    { id = "next",      width = 118, defaultLabel = "Próximo Nivel" },
    { id = "all",       width = 110, defaultLabel = "Todos (1-80)" },
    { id = "learned",   width = 114, defaultLabel = "Aprendidos" },
    { id = "quests",    width = 136, defaultLabel = "Misiones" },
}

-- Content Frames
local spellsContentFrame = CreateFrame("Frame", "WarlockTrainerSpellsContent", mainFrame)
local questsContentFrame = CreateFrame("Frame", "WarlockTrainerQuestsContent", mainFrame)

local function SetActiveTab(tabId)
    currentTab = tabId
    if WarlockTrainerDB then
        WarlockTrainerDB.activeTab = tabId
    end

    for _, btn in pairs(tabs) do
        if btn.tabId == tabId then
            btn:LockHighlight()
        else
            btn:UnlockHighlight()
        end
    end

    if tabId == "quests" then
        spellsContentFrame:Hide()
        questsContentFrame:Show()
    else
        questsContentFrame:Hide()
        spellsContentFrame:Show()
        FauxScrollFrame_SetOffset(WarlockTrainerScrollFrame, 0)
        local scrollBar = _G["WarlockTrainerScrollFrameScrollBar"]
        if scrollBar then
            scrollBar:SetValue(0)
        end
    end

    WT.UI:Refresh()
end

-- Create Tab Buttons with visible default text
local tabXOffset = 18
for _, cfg in ipairs(tabConfig) do
    local tabBtn = CreateFrame("Button", "WarlockTrainerTab_" .. cfg.id, mainFrame, "UIPanelButtonTemplate")
    tabBtn:SetSize(cfg.width, 26)
    tabBtn:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", tabXOffset, -118)
    tabBtn.tabId = cfg.id
    tabBtn:SetText(cfg.defaultLabel)
    tabBtn:SetNormalFontObject("GameFontNormal")
    tabBtn:SetHighlightFontObject("GameFontHighlight")
    tabBtn:SetScript("OnClick", function(self)
        SetActiveTab(self.tabId)
    end)
    tabs[cfg.id] = tabBtn
    tabXOffset = tabXOffset + cfg.width + 6
end

-- ==================== SPELLS VIEW ====================
spellsContentFrame:SetSize(604, ROW_HEIGHT * NUM_ROWS)
spellsContentFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 18, -152)

local scrollFrame = CreateFrame("ScrollFrame", "WarlockTrainerScrollFrame", spellsContentFrame, "FauxScrollFrameTemplate")
scrollFrame:SetSize(575, ROW_HEIGHT * NUM_ROWS)
scrollFrame:SetPoint("TOPLEFT", spellsContentFrame, "TOPLEFT", 0, 0)
scrollFrame:SetFrameLevel(mainFrame:GetFrameLevel() + 1)

scrollFrame:EnableMouseWheel(true)
scrollFrame:SetScript("OnMouseWheel", function(self, delta)
    local scrollBar = _G["WarlockTrainerScrollFrameScrollBar"]
    if scrollBar and scrollBar:IsShown() then
        local current = scrollBar:GetValue()
        if delta < 0 then
            scrollBar:SetValue(current + (ROW_HEIGHT * 2))
        else
            scrollBar:SetValue(current - (ROW_HEIGHT * 2))
        end
    end
end)

-- Empty state message
local emptyStateText = spellsContentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
emptyStateText:SetPoint("CENTER", scrollFrame, "CENTER", 0, 0)
emptyStateText:SetWidth(480)
emptyStateText:SetJustifyH("CENTER")
emptyStateText:Hide()

local rows = {}

local function CreateSpellRow(index)
    local row = CreateFrame("Button", "WarlockTrainerSpellRow" .. index, spellsContentFrame)
    row:SetSize(570, ROW_HEIGHT - 3)
    row:SetPoint("TOPLEFT", spellsContentFrame, "TOPLEFT", 0, - (index - 1) * ROW_HEIGHT)
    row:SetFrameLevel(mainFrame:GetFrameLevel() + 3)
    
    -- High contrast row backdrop with crisp border
    row:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    
    -- Alternating contrast background
    if (index % 2 == 0) then
        row:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
    else
        row:SetBackdropColor(0.16, 0.13, 0.23, 0.90)
    end
    row:SetBackdropBorderColor(0.40, 0.35, 0.55, 0.8)

    -- Spell Icon
    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(34, 34)
    icon:SetPoint("LEFT", row, "LEFT", 6, 0)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    row.icon = icon

    -- Spell Name (Bright Gold / High contrast)
    local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("TOPLEFT", icon, "TOPRIGHT", 10, -2)
    nameText:SetJustifyH("LEFT")
    row.nameText = nameText

    -- Rank & Level (Bright Cyan / Light Blue)
    local infoText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    infoText:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 10, 3)
    infoText:SetJustifyH("LEFT")
    row.infoText = infoText

    -- Cost Text (Right aligned)
    local costText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    costText:SetPoint("RIGHT", row, "RIGHT", -120, 0)
    costText:SetJustifyH("RIGHT")
    row.costText = costText

    -- Status Badge (Far right)
    local statusText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("RIGHT", row, "RIGHT", -10, 0)
    statusText:SetJustifyH("RIGHT")
    row.statusText = statusText

    -- Hover highlight
    row:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.28, 0.20, 0.42, 0.98)
        self:SetBackdropBorderColor(0.80, 0.65, 0.30, 1)
        if self.spellId then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink("spell:" .. self.spellId)
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function(self)
        if (index % 2 == 0) then
            self:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
        else
            self:SetBackdropColor(0.16, 0.13, 0.23, 0.90)
        end
        self:SetBackdropBorderColor(0.40, 0.35, 0.55, 0.8)
        GameTooltip:Hide()
    end)

    row:EnableMouseWheel(true)
    row:SetScript("OnMouseWheel", function(self, delta)
        local scrollBar = _G["WarlockTrainerScrollFrameScrollBar"]
        if scrollBar and scrollBar:IsShown() then
            local current = scrollBar:GetValue()
            if delta < 0 then
                scrollBar:SetValue(current + (ROW_HEIGHT * 2))
            else
                scrollBar:SetValue(current - (ROW_HEIGHT * 2))
            end
        end
    end)

    return row
end

for i = 1, NUM_ROWS do
    rows[i] = CreateSpellRow(i)
end

local function RefreshSpellList()
    local numItems = #currentDisplayList
    FauxScrollFrame_Update(scrollFrame, numItems, NUM_ROWS, ROW_HEIGHT)
    local offset = FauxScrollFrame_GetOffset(scrollFrame)
    local playerMoney = GetMoney()
    local playerLevel = UnitLevel("player")

    if numItems == 0 then
        if currentTab == "available" then
            emptyStateText:SetText("|cff00ff88¡Estás al día!|r\n\nNo tienes hechizos pendientes para aprender en tu nivel actual.\nRevisa la pestaña |cffffd700[Próximo Nivel]|r para planificar tu viaje.")
        elseif currentTab == "next" then
            emptyStateText:SetText("|cffffd700No hay más hechizos en el próximo nivel.|r\n\n(O ya has alcanzado el nivel máximo 80).")
        elseif currentTab == "learned" then
            emptyStateText:SetText("|cffaaaaaaNo se detectaron hechizos aprendidos en tu libro aún.|r")
        else
            emptyStateText:SetText("|cffaaaaaaNo hay hechizos disponibles para mostrar.|r")
        end
        emptyStateText:Show()
    else
        emptyStateText:Hide()
    end

    for i = 1, NUM_ROWS do
        local rowIndex = offset + i
        local row = rows[i]
        if rowIndex <= numItems then
            local spell = currentDisplayList[rowIndex]
            row.spellId = spell.id

            local spellName = spell.name or spell.defaultName
            local spellRank = spell.rank or spell.defaultRank
            local spellIcon = spell.icon or spell.defaultIcon
            local isLearned = WT:IsSpellLearned(spell)
            local canLearn = (playerLevel >= spell.level) and not isLearned
            local hasMoney = playerMoney >= (spell.cost or 0)

            row.icon:SetTexture(spellIcon)
            row.nameText:SetText("|cffffd700" .. spellName .. "|r")

            local rankStr = (spellRank and spellRank ~= "") and ("(" .. spellRank .. ") - ") or ""
            row.infoText:SetText(string.format("|cff7dd3fc%sNivel %d|r", rankStr, spell.level))

            local costStr = WT:FormatMoney(spell.cost)
            if canLearn and not hasMoney then
                costStr = "|cffff4444" .. costStr .. "|r"
            end
            row.costText:SetText(costStr)

            if isLearned then
                row.statusText:SetText("|cff00ff88[✓ Aprendido]|r")
            elseif canLearn then
                if hasMoney then
                    row.statusText:SetText("|cff38bdf8[★ ¡Disponible!]|r")
                else
                    row.statusText:SetText("|cffff4444[✗ ¡Sin Oro!]|r")
                end
            else
                row.statusText:SetText(string.format("|cff94a3b8[🔒 Nivel %d]|r", spell.level))
            end

            row:Show()
        else
            row:Hide()
        end
    end
end

scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, ROW_HEIGHT, RefreshSpellList)
end)

-- ==================== QUESTS VIEW ====================
questsContentFrame:SetSize(604, 325)
questsContentFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 18, -152)
questsContentFrame:Hide()

-- Left: Quests List Frame (Width 230)
local questListFrame = CreateFrame("Frame", nil, questsContentFrame)
questListFrame:SetSize(230, 325)
questListFrame:SetPoint("TOPLEFT", questsContentFrame, "TOPLEFT", 0, 0)
questListFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 12,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
questListFrame:SetBackdropColor(0.08, 0.06, 0.12, 0.95)
questListFrame:SetBackdropBorderColor(0.50, 0.40, 0.65, 0.8)

local questListHeader = questListFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
questListHeader:SetPoint("TOPLEFT", questListFrame, "TOPLEFT", 10, -7)
questListHeader:SetText("|cffffd700Misiones de Clase del Brujo:|r")

-- Right: Quest Detail Panel (Width 365)
local questDetailFrame = CreateFrame("Frame", nil, questsContentFrame)
questDetailFrame:SetSize(365, 325)
questDetailFrame:SetPoint("TOPRIGHT", questsContentFrame, "TOPRIGHT", 0, 0)
questDetailFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 12,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
questDetailFrame:SetBackdropColor(0.08, 0.06, 0.12, 0.95)
questDetailFrame:SetBackdropBorderColor(0.50, 0.40, 0.65, 0.8)

-- Detail Panel Header Elements
local qIcon = questDetailFrame:CreateTexture(nil, "ARTWORK")
qIcon:SetSize(38, 38)
qIcon:SetPoint("TOPLEFT", questDetailFrame, "TOPLEFT", 10, -10)
qIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

local qTitleText = questDetailFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
qTitleText:SetPoint("TOPLEFT", qIcon, "TOPRIGHT", 10, 0)
qTitleText:SetPoint("RIGHT", questDetailFrame, "RIGHT", -10, 0)
qTitleText:SetJustifyH("LEFT")

local qStatusText = questDetailFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
qStatusText:SetPoint("TOPLEFT", qIcon, "TOPRIGHT", 10, -20)
qStatusText:SetJustifyH("LEFT")

-- Start NPC & Waypoint Container Box
local qNpcBox = CreateFrame("Frame", nil, questDetailFrame)
qNpcBox:SetSize(345, 42)
qNpcBox:SetPoint("TOPLEFT", qIcon, "BOTTOMLEFT", 0, -8)
qNpcBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 10,
    insets = { left = 2, right = 2, top = 2, bottom = 2 }
})
qNpcBox:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
qNpcBox:SetBackdropBorderColor(0.35, 0.30, 0.45, 0.7)

local qNpcText = qNpcBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
qNpcText:SetPoint("LEFT", qNpcBox, "LEFT", 8, 0)
qNpcText:SetWidth(245)
qNpcText:SetJustifyH("LEFT")

local qWayBtn = CreateFrame("Button", nil, qNpcBox, "UIPanelButtonTemplate")
qWayBtn:SetSize(80, 22)
qWayBtn:SetPoint("RIGHT", qNpcBox, "RIGHT", -6, 0)
qWayBtn:SetText("Ruta PNJ")
qWayBtn:SetScript("OnClick", function()
    if selectedQuest and selectedQuest.startNPC then
        WT:SetWaypoint(selectedQuest.startNPC)
    end
end)

-- Dedicated Step-by-Step Instructions Box (Height 108)
local qStepsBox = CreateFrame("Frame", nil, questDetailFrame)
qStepsBox:SetSize(345, 108)
qStepsBox:SetPoint("TOPLEFT", qNpcBox, "BOTTOMLEFT", 0, -6)
qStepsBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 10,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
qStepsBox:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
qStepsBox:SetBackdropBorderColor(0.35, 0.30, 0.45, 0.7)

local qStepsHeader = qStepsBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
qStepsHeader:SetPoint("TOPLEFT", qStepsBox, "TOPLEFT", 8, -6)
qStepsHeader:SetText("|cffffd700📋 Guía paso a paso:|r")

local qStepsText = qStepsBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
qStepsText:SetPoint("TOPLEFT", qStepsHeader, "BOTTOMLEFT", 0, -4)
qStepsText:SetWidth(330)
qStepsText:SetJustifyH("LEFT")

-- Dedicated Materials Box (Height 96)
local qMatsBox = CreateFrame("Frame", nil, questDetailFrame)
qMatsBox:SetSize(345, 96)
qMatsBox:SetPoint("TOPLEFT", qStepsBox, "BOTTOMLEFT", 0, -6)
qMatsBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 10,
    insets = { left = 3, right = 3, top = 3, bottom = 3 }
})
qMatsBox:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
qMatsBox:SetBackdropBorderColor(0.35, 0.30, 0.45, 0.7)

local qMatsHeader = qMatsBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
qMatsHeader:SetPoint("TOPLEFT", qMatsBox, "TOPLEFT", 8, -6)
qMatsHeader:SetText("|cffffd700🎒 Materiales requeridos (en tus bolsas):|r")

local qMatsText = qMatsBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
qMatsText:SetPoint("TOPLEFT", qMatsHeader, "BOTTOMLEFT", 0, -4)
qMatsText:SetWidth(330)
qMatsText:SetJustifyH("LEFT")

-- Quests buttons on left side
local questButtons = {}
local MAX_QUEST_ROWS = 7
local QUEST_ROW_HEIGHT = 41

local function ShowQuestDetail(quest)
    selectedQuest = quest
    if not quest then return end

    qIcon:SetTexture(quest.icon)
    qTitleText:SetText(string.format("|cffffd700%s|r |cffc4b5fd(Nivel %d)|r", quest.title, quest.level))

    -- Real-time completion check
    local status = WT:GetClassQuestStatus(quest)
    if status == "COMPLETED" then
        qStatusText:SetText("|cff00ff88✓ ¡Completada! (Habilidad ya aprendida)|r")
    elseif status == "IN_PROGRESS" then
        qStatusText:SetText("|cffffd700⚡ En progreso (Activa en tu registro de misiones)|r")
    elseif status == "AVAILABLE" then
        qStatusText:SetText("|cff38bdf8★ ¡Disponible! Puedes ir a tomarla ahora.|r")
    else
        qStatusText:SetText(string.format("|cff94a3b8🔒 Requiere Nivel %d|r", quest.level))
    end

    -- Start NPC info
    local npc = quest.startNPC
    if npc then
        local zoneStr = (GetLocale() == "esES" or GetLocale() == "esMX") and (npc.zoneEs or npc.zone) or npc.zone
        local nameStr = (GetLocale() == "esES" or GetLocale() == "esMX") and (npc.nameEs or npc.name) or npc.name
        qNpcText:SetText(string.format("|cffffffffInicio:|r |cffffd700%s|r\n|cff7dd3fc%s|r |cffaaaaaa(%.1f, %.1f)|r", 
            nameStr, zoneStr, npc.x, npc.y))
        qWayBtn:Show()
    else
        qNpcText:SetText("|cffaaaaaaSin PNJ especificado|r")
        qWayBtn:Hide()
    end

    -- Steps guide
    if quest.steps and #quest.steps > 0 then
        local stepStr = ""
        for _, s in ipairs(quest.steps) do
            stepStr = stepStr .. s .. "\n"
        end
        qStepsText:SetText(stepStr)
    else
        qStepsText:SetText("|cffaaaaaaSin pasos disponibles.|r")
    end

    -- Materials checklist (checking live bags)
    if quest.materials and #quest.materials > 0 then
        local matStr = ""
        for _, mat in ipairs(quest.materials) do
            local have = GetItemCount(mat.itemId)
            local matName = (GetLocale() == "esES" or GetLocale() == "esMX") and (mat.name or mat.nameEn) or (mat.nameEn or mat.name)
            if have >= mat.count then
                matStr = matStr .. string.format("|cff00ff88[✓] %d/%d %s (¡Listo!)|r\n", have, mat.count, matName)
            else
                local missing = mat.count - have
                matStr = matStr .. string.format("|cffff4444[✗] %d/%d %s|r |cffaaaaaa(Faltan %d - %s)|r\n", have, mat.count, matName, missing, mat.source or "")
            end
        end
        qMatsText:SetText(matStr)
    else
        qMatsText:SetText("|cff00ff88Esta misión no requiere materiales de profesiones u oro.|r\n|cffaaaaaa(Solo completar el combate o ritual indicado arriba).|r")
    end
end

local function CreateQuestButton(index)
    local btn = CreateFrame("Button", "WarlockTrainerQuestBtn" .. index, questListFrame)
    btn:SetSize(218, QUEST_ROW_HEIGHT - 3)
    btn:SetPoint("TOPLEFT", questListFrame, "TOPLEFT", 6, -26 - (index - 1) * QUEST_ROW_HEIGHT)
    
    btn:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    btn:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
    btn:SetBackdropBorderColor(0.35, 0.30, 0.45, 0.7)

    local icon = btn:CreateTexture(nil, "ARTWORK")
    icon:SetSize(30, 30)
    icon:SetPoint("LEFT", btn, "LEFT", 5, 0)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    btn.icon = icon

    local nameText = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    nameText:SetPoint("TOPLEFT", icon, "TOPRIGHT", 8, -2)
    nameText:SetPoint("RIGHT", btn, "RIGHT", -4, 0)
    nameText:SetJustifyH("LEFT")
    btn.nameText = nameText

    local statusText = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 8, 2)
    statusText:SetJustifyH("LEFT")
    btn.statusText = statusText

    btn:SetScript("OnClick", function(self)
        if self.questData then
            for _, b in ipairs(questButtons) do
                b:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
                b:SetBackdropBorderColor(0.35, 0.30, 0.45, 0.7)
            end
            self:SetBackdropColor(0.28, 0.20, 0.42, 0.98)
            self:SetBackdropBorderColor(0.80, 0.65, 0.30, 1)
            ShowQuestDetail(self.questData)
        end
    end)

    btn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(0.80, 0.65, 0.30, 1)
    end)
    btn:SetScript("OnLeave", function(self)
        if selectedQuest and self.questData == selectedQuest then
            self:SetBackdropBorderColor(0.80, 0.65, 0.30, 1)
        else
            self:SetBackdropBorderColor(0.35, 0.30, 0.45, 0.7)
        end
    end)

    return btn
end

for i = 1, MAX_QUEST_ROWS do
    questButtons[i] = CreateQuestButton(i)
end

function WT.UI:RefreshQuests()
    if not mainFrame:IsShown() or currentTab ~= "quests" then return end

    local questList = WT:GetFilteredClassQuests()
    local firstValidQuest = nil

    for i = 1, MAX_QUEST_ROWS do
        local btn = questButtons[i]
        local quest = questList[i]
        if quest then
            btn.questData = quest
            btn.icon:SetTexture(quest.icon)
            btn.nameText:SetText("|cffffffff" .. quest.title .. "|r")

            -- Real-time Status Check
            local status = WT:GetClassQuestStatus(quest)
            if status == "COMPLETED" then
                btn.statusText:SetText("|cff00ff88[✓ Completada]|r")
            elseif status == "IN_PROGRESS" then
                btn.statusText:SetText("|cffffd700[⚡ En progreso]|r")
            elseif status == "AVAILABLE" then
                btn.statusText:SetText("|cff38bdf8[★ Disponible]|r")
            else
                btn.statusText:SetText(string.format("|cff94a3b8[Nivel %d]|r", quest.level))
            end

            if not firstValidQuest then
                firstValidQuest = quest
            end
            btn:Show()
        else
            btn.questData = nil
            btn:Hide()
        end
    end

    if not selectedQuest and firstValidQuest then
        selectedQuest = firstValidQuest
    end
    if selectedQuest then
        ShowQuestDetail(selectedQuest)
        for _, b in ipairs(questButtons) do
            if b.questData == selectedQuest then
                b:SetBackdropColor(0.28, 0.20, 0.42, 0.98)
                b:SetBackdropBorderColor(0.80, 0.65, 0.30, 1)
            else
                b:SetBackdropColor(0.12, 0.10, 0.18, 0.90)
                b:SetBackdropBorderColor(0.35, 0.30, 0.45, 0.7)
            end
        end
    end
end

-- Bottom Bar Info (Tips & Shortcuts)
local bottomText = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
bottomText:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMLEFT", 22, 14)
bottomText:SetText("|cffc4b5fdPasa el ratón por los hechizos o revisa el estado de tus misiones de clase. Usa /wt.|r")

-- Function to refresh the money and summary boxes
function WT.UI:RefreshMoney()
    local playerMoney = GetMoney()
    local playerLevel = UnitLevel("player")
    local availList = WT:GetAvailableSpells()
    local totalNeeded = WT:GetTotalCost(availList)
    
    playerInfoText:SetText(string.format("%s |cffffd700%d|r |cffc4b5fd(Brujo)|r", WT.L.YOUR_LEVEL, playerLevel))
    playerMoneyText:SetText(string.format("%s %s", WT.L.YOUR_MONEY, WT:FormatMoney(playerMoney)))
    
    if totalNeeded > 0 then
        local costFormatted = WT:FormatMoney(totalNeeded)
        if playerMoney >= totalNeeded then
            costSummaryText:SetText(string.format("%s %s |cff00ff88(¡Alcanza!)|r", WT.L.TOTAL_NEEDED, costFormatted))
        else
            local diff = totalNeeded - playerMoney
            costSummaryText:SetText(string.format("%s %s |cffff4444(%s %s)|r", WT.L.TOTAL_NEEDED, costFormatted, WT.L.MONEY_MISSING, WT:FormatMoney(diff)))
        end
    else
        costSummaryText:SetText(string.format("%s |cff00ff880|r |cffaaaaaa(Al día)|r", WT.L.TOTAL_NEEDED))
    end
end

-- Refresh nearest trainer box
function WT.UI:RefreshTrainer()
    local trainer, dist, sameZone = WT:GetNearestTrainer()
    if trainer then
        local locationText = trainer.zone
        if trainer.subzone and trainer.subzone ~= "" then
            locationText = trainer.zone .. " (" .. trainer.subzone .. ")"
        end
        local distText = ""
        if dist then
            distText = string.format(" ~%.0f yd", dist)
        end
        trainerInfoText:SetText(string.format("|cff00ff88%s|r\n|cffffffff%s%s|r |cffaaaaaa(%.1f, %.1f)|r", 
            trainer.name, locationText, distText, trainer.x, trainer.y))
    else
        trainerInfoText:SetText("|cffaaaaaaNo identificado|r")
    end
end

-- Refresh Spells view
function WT.UI:RefreshSpells()
    if not mainFrame:IsShown() or currentTab == "quests" then return end

    if currentTab == "available" then
        currentDisplayList = WT:GetAvailableSpells()
    elseif currentTab == "next" then
        local nextSpells = WT:GetNextLevelSpells()
        currentDisplayList = nextSpells or {}
    elseif currentTab == "all" then
        currentDisplayList = WT.SpellsDatabase
    elseif currentTab == "learned" then
        currentDisplayList = WT:GetLearnedSpells()
    end

    RefreshSpellList()
end

-- Full Refresh (Updates titles, counters, money and active view)
function WT.UI:Refresh()
    if not mainFrame:IsShown() then return end
    
    titleText:SetText(WT.L.TITLE)
    subTitleText:SetText("|cffc4b5fd" .. WT.L.SUBTITLE .. "|r")
    trainerTitleText:SetText("|cffffd700" .. WT.L.TRAINER_LABEL .. "|r")

    WT.UI:RefreshMoney()
    WT.UI:RefreshTrainer()

    -- Update Tab Titles with Counters
    local availCount = #WT:GetAvailableSpells()
    local nextCount = #(WT:GetNextLevelSpells() or {})
    local allCount = #WT.SpellsDatabase
    local learnedCount = #WT:GetLearnedSpells()
    local questCount = #(WT:GetFilteredClassQuests() or {})

    if tabs["available"] then tabs["available"]:SetText(string.format("%s (%d)", WT.L.TAB_AVAILABLE, availCount)) end
    if tabs["next"] then tabs["next"]:SetText(string.format("%s (%d)", WT.L.TAB_NEXT, nextCount)) end
    if tabs["all"] then tabs["all"]:SetText(string.format("%s (%d)", WT.L.TAB_ALL, allCount)) end
    if tabs["learned"] then tabs["learned"]:SetText(string.format("%s (%d)", WT.L.TAB_LEARNED, learnedCount)) end
    if tabs["quests"] then tabs["quests"]:SetText(string.format("%s (%d)", WT.L.TOP_BTN_QUESTS, questCount)) end

    if currentTab == "quests" then
        WT.UI:RefreshQuests()
    else
        WT.UI:RefreshSpells()
    end
end

-- Toggle visibility
function WT.UI:Toggle()
    if mainFrame:IsShown() then
        mainFrame:Hide()
    else
        if WarlockTrainerDB and WarlockTrainerDB.framePoint then
            mainFrame:ClearAllPoints()
            mainFrame:SetPoint(WarlockTrainerDB.framePoint, UIParent, WarlockTrainerDB.frameRelative or "CENTER", WarlockTrainerDB.frameX or 0, WarlockTrainerDB.frameY or 0)
        end
        if WarlockTrainerDB and WarlockTrainerDB.activeTab then
            currentTab = WarlockTrainerDB.activeTab
        end
        mainFrame:Show()
        SetActiveTab(currentTab)
    end
end
