-- UI for WarlockTrainer (WoW 3.3.5a)
local addonName, WT = ...
WT = WT or {}

WT.UI = {}

local ROW_HEIGHT = 42
local NUM_ROWS = 7
local currentTab = "available"
local currentDisplayList = {}

-- Create the main window
local mainFrame = CreateFrame("Frame", "WarlockTrainerMainFrame", UIParent)
WT.UI.MainFrame = mainFrame

mainFrame:SetSize(620, 520)
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

-- Backdrop (Classic WotLK Dialog Style with dark purple tint)
mainFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})
mainFrame:SetBackdropColor(0.08, 0.04, 0.12, 0.95)

-- Header Texture Banner
local headerTexture = mainFrame:CreateTexture(nil, "ARTWORK")
headerTexture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
headerTexture:SetSize(360, 64)
headerTexture:SetPoint("TOP", mainFrame, "TOP", 0, 12)

-- Title FontString
local titleText = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
titleText:SetPoint("TOP", headerTexture, "TOP", 0, -14)
titleText:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")

-- Subtitle
local subTitleText = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
subTitleText:SetPoint("TOP", mainFrame, "TOP", 0, -32)

-- Close Button
local closeBtn = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")
closeBtn:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -8, -8)

-- ==================== TOP INFO BOXES ====================

-- 1. Player Info & Money Frame
local playerBox = CreateFrame("Frame", nil, mainFrame)
playerBox:SetSize(280, 56)
playerBox:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -56)
playerBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 14,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
playerBox:SetBackdropColor(0.04, 0.02, 0.06, 0.8)
playerBox:SetBackdropBorderColor(0.4, 0.3, 0.5, 0.8)

local playerInfoText = playerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
playerInfoText:SetPoint("TOPLEFT", playerBox, "TOPLEFT", 8, -8)

local playerMoneyText = playerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
playerMoneyText:SetPoint("TOPLEFT", playerBox, "TOPLEFT", 8, -24)

local costSummaryText = playerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
costSummaryText:SetPoint("TOPLEFT", playerBox, "TOPLEFT", 8, -38)

-- 2. Nearest Trainer Frame
local trainerBox = CreateFrame("Frame", nil, mainFrame)
trainerBox:SetSize(290, 56)
trainerBox:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -20, -56)
trainerBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 14,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
trainerBox:SetBackdropColor(0.04, 0.02, 0.06, 0.8)
trainerBox:SetBackdropBorderColor(0.4, 0.3, 0.5, 0.8)

local trainerTitleText = trainerBox:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
trainerTitleText:SetPoint("TOPLEFT", trainerBox, "TOPLEFT", 8, -8)

local trainerInfoText = trainerBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
trainerInfoText:SetPoint("TOPLEFT", trainerBox, "TOPLEFT", 8, -24)
trainerInfoText:SetWidth(190)
trainerInfoText:SetJustifyH("LEFT")

-- Navigation Button (TomTom / Cartographer / Carbonite)
local navBtn = CreateFrame("Button", nil, trainerBox, "UIPanelButtonTemplate")
navBtn:SetSize(78, 24)
navBtn:SetPoint("RIGHT", trainerBox, "RIGHT", -6, 0)
navBtn:SetText("Ruta")
navBtn:SetScript("OnClick", function()
    local t = WT:GetNearestTrainer()
    WT:SetWaypoint(t)
end)
navBtn:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_TOP")
    GameTooltip:AddLine("Fijar Ruta / Waypoint", 1, 1, 1)
    GameTooltip:AddLine("Compatible con Cartographer, TomTom y Carbonite.", 0.7, 0.7, 0.7)
    GameTooltip:Show()
end)
navBtn:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)

-- ==================== TABS ====================
local tabs = {}
local tabKeys = { "available", "next", "all", "learned" }

local function SetActiveTab(tabId)
    currentTab = tabId
    if WarlockTrainerDB then
        WarlockTrainerDB.activeTab = tabId
    end
    FauxScrollFrame_SetOffset(WarlockTrainerScrollFrame, 0)
    local scrollBar = _G["WarlockTrainerScrollFrameScrollBar"]
    if scrollBar then
        scrollBar:SetValue(0)
    end
    for _, btn in pairs(tabs) do
        if btn.tabId == tabId then
            btn:LockHighlight()
        else
            btn:UnlockHighlight()
        end
    end
    WT.UI:Refresh()
end

for i, tabId in ipairs(tabKeys) do
    local tabBtn = CreateFrame("Button", "WarlockTrainerTab" .. i, mainFrame, "UIPanelButtonTemplate")
    tabBtn:SetSize(135, 26)
    tabBtn:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20 + (i - 1) * 144, -120)
    tabBtn.tabId = tabId
    tabBtn:SetScript("OnClick", function(self)
        SetActiveTab(self.tabId)
    end)
    tabs[tabId] = tabBtn
end

-- ==================== SCROLL LIST & ROWS ====================
local scrollFrame = CreateFrame("ScrollFrame", "WarlockTrainerScrollFrame", mainFrame, "FauxScrollFrameTemplate")
scrollFrame:SetSize(550, ROW_HEIGHT * NUM_ROWS)
scrollFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -156)
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
local emptyStateText = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
emptyStateText:SetPoint("CENTER", scrollFrame, "CENTER", 0, 0)
emptyStateText:SetWidth(460)
emptyStateText:SetJustifyH("CENTER")
emptyStateText:Hide()

local rows = {}

local function CreateSpellRow(index)
    -- IMPORTANT: Parent to mainFrame so WoW renders the button properly!
    local row = CreateFrame("Button", "WarlockTrainerSpellRow" .. index, mainFrame)
    row:SetSize(545, ROW_HEIGHT - 3)
    row:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 20, -156 - (index - 1) * ROW_HEIGHT)
    row:SetFrameLevel(mainFrame:GetFrameLevel() + 3)
    
    -- Row background
    row:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 10,
        insets = { left = 2, right = 2, top = 2, bottom = 2 }
    })
    row:SetBackdropColor(0.12, 0.08, 0.16, 0.6)
    row:SetBackdropBorderColor(0.3, 0.25, 0.38, 0.5)

    -- Spell Icon
    local icon = row:CreateTexture(nil, "ARTWORK")
    icon:SetSize(32, 32)
    icon:SetPoint("LEFT", row, "LEFT", 5, 0)
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    row.icon = icon

    -- Spell Name
    local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("TOPLEFT", icon, "TOPRIGHT", 8, -2)
    nameText:SetJustifyH("LEFT")
    row.nameText = nameText

    -- Rank & Level
    local infoText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    infoText:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 8, 2)
    infoText:SetJustifyH("LEFT")
    row.infoText = infoText

    -- Cost Text
    local costText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    costText:SetPoint("RIGHT", row, "RIGHT", -110, 0)
    costText:SetJustifyH("RIGHT")
    row.costText = costText

    -- Status Badge
    local statusText = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("RIGHT", row, "RIGHT", -10, 0)
    statusText:SetJustifyH("RIGHT")
    row.statusText = statusText

    -- Hover highlight & Tooltip
    row:SetScript("OnEnter", function(self)
        self:SetBackdropColor(0.25, 0.18, 0.35, 0.8)
        if self.spellId then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink("spell:" .. self.spellId)
            GameTooltip:Show()
        end
    end)
    row:SetScript("OnLeave", function(self)
        self:SetBackdropColor(0.12, 0.08, 0.16, 0.6)
        GameTooltip:Hide()
    end)

    -- Mouse wheel support when cursor is over row
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

-- Refresh Scroll Items
local function RefreshList()
    local numItems = #currentDisplayList
    FauxScrollFrame_Update(scrollFrame, numItems, NUM_ROWS, ROW_HEIGHT)
    local offset = FauxScrollFrame_GetOffset(scrollFrame)
    local playerMoney = GetMoney()
    local playerLevel = UnitLevel("player")

    if numItems == 0 then
        if currentTab == "available" then
            emptyStateText:SetText("|cff00ff00¡Estás al día!|r\n\nNo tienes hechizos pendientes para aprender en tu nivel actual.\nRevisa la pestaña |cffffff00[Próximo Nivel]|r para planificar tu viaje.")
        elseif currentTab == "next" then
            emptyStateText:SetText("|cffffff00No hay más hechizos en el próximo nivel.|r\n\n(O ya has alcanzado el nivel máximo).")
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
            row.nameText:SetText(spellName)

            local rankStr = (spellRank and spellRank ~= "") and ("(" .. spellRank .. ") - ") or ""
            row.infoText:SetText(string.format("%sNivel %d", rankStr, spell.level))

            -- Cost formatting
            local costStr = WT:FormatMoney(spell.cost)
            if canLearn and not hasMoney then
                costStr = "|cffff4444" .. costStr .. "|r"
            end
            row.costText:SetText(costStr)

            -- Status badge
            if isLearned then
                row.statusText:SetText(WT.L.STATUS_LEARNED)
                row.nameText:SetTextColor(0.5, 0.8, 0.5)
            elseif canLearn then
                if hasMoney then
                    row.statusText:SetText(WT.L.STATUS_AVAILABLE)
                    row.nameText:SetTextColor(1, 1, 0.4)
                else
                    row.statusText:SetText(WT.L.STATUS_NO_GOLD)
                    row.nameText:SetTextColor(1, 0.6, 0.6)
                end
            else
                row.statusText:SetText(string.format(WT.L.STATUS_LOCKED, spell.level))
                row.nameText:SetTextColor(0.6, 0.6, 0.6)
            end

            row:Show()
        else
            row:Hide()
        end
    end
end

scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, ROW_HEIGHT, RefreshList)
end)

-- Bottom Bar Info (Tips & Shortcuts)
local bottomText = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
bottomText:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMLEFT", 24, 18)
bottomText:SetText("|cff888888Pasa el ratón por un hechizo para ver su tooltip. Usa /wt para abrir o cerrar.|r")

-- Function to refresh the money and summary boxes
function WT.UI:RefreshMoney()
    local playerMoney = GetMoney()
    local playerLevel = UnitLevel("player")
    local availList = WT:GetAvailableSpells()
    local totalNeeded = WT:GetTotalCost(availList)
    
    playerInfoText:SetText(string.format("%s |cffffff00%d|r |cff9482c9(Brujo)|r", WT.L.YOUR_LEVEL, playerLevel))
    playerMoneyText:SetText(string.format("%s %s", WT.L.YOUR_MONEY, WT:FormatMoney(playerMoney)))
    
    if totalNeeded > 0 then
        local costFormatted = WT:FormatMoney(totalNeeded)
        if playerMoney >= totalNeeded then
            costSummaryText:SetText(string.format("%s %s |cff00ff00(¡Alcanza!)|r", WT.L.TOTAL_NEEDED, costFormatted))
        else
            local diff = totalNeeded - playerMoney
            costSummaryText:SetText(string.format("%s %s |cffff4444(%s %s)|r", WT.L.TOTAL_NEEDED, costFormatted, WT.L.MONEY_MISSING, WT:FormatMoney(diff)))
        end
    else
        costSummaryText:SetText(string.format("%s |cff00ff000|r (Al día)", WT.L.TOTAL_NEEDED))
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
        trainerInfoText:SetText(string.format("|cff00ff00%s|r\n|cffaaaaaa%s%s (%.1f, %.1f)|r", 
            trainer.name, locationText, distText, trainer.x, trainer.y))
    else
        trainerInfoText:SetText("|cffaaaaaaNo identificado|r")
    end
end

-- Full Refresh
function WT.UI:Refresh()
    if not mainFrame:IsShown() then return end
    
    titleText:SetText(WT.L.TITLE)
    subTitleText:SetText("|cff9482c9" .. WT.L.SUBTITLE .. "|r")
    trainerTitleText:SetText("|cffffff00" .. WT.L.TRAINER_LABEL .. "|r")

    WT.UI:RefreshMoney()
    WT.UI:RefreshTrainer()

    -- Filter list based on current active tab
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

    -- Update Tab Titles with Counters
    local availCount = #WT:GetAvailableSpells()
    local nextCount = #(WT:GetNextLevelSpells() or {})
    local allCount = #WT.SpellsDatabase
    local learnedCount = #WT:GetLearnedSpells()

    if tabs["available"] then tabs["available"]:SetText(string.format("%s (%d)", WT.L.TAB_AVAILABLE, availCount)) end
    if tabs["next"] then tabs["next"]:SetText(string.format("%s (%d)", WT.L.TAB_NEXT, nextCount)) end
    if tabs["all"] then tabs["all"]:SetText(string.format("%s (%d)", WT.L.TAB_ALL, allCount)) end
    if tabs["learned"] then tabs["learned"]:SetText(string.format("%s (%d)", WT.L.TAB_LEARNED, learnedCount)) end

    RefreshList()
end

-- Toggle visibility
function WT.UI:Toggle()
    if mainFrame:IsShown() then
        mainFrame:Hide()
    else
        -- Restore position if saved
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
