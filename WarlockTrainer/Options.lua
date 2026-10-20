-- Blizzard Interface Options Panel for WarlockTrainer (WoW 3.3.5a)
local addonName, WT = ...
WT = WT or {}

local optionsPanel = CreateFrame("Frame", "WarlockTrainerOptionsPanel", UIParent)
optionsPanel.name = "WarlockTrainer"
WT.OptionsPanel = optionsPanel

-- Title
local title = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("WarlockTrainer |cff9482c9(3.3.5a)|r")

-- Subtitle
local sub = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
sub:SetText("Configuración y estado para Brujos en Warmane (Lordaeron)")

-- 1. Checkbox: Auto Alert on Level Up
local cbAlert = CreateFrame("CheckButton", "WarlockTrainerOptAlert", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
cbAlert:SetPoint("TOPLEFT", sub, "BOTTOMLEFT", 0, -20)
_G[cbAlert:GetName() .. "Text"]:SetText(" Notificar en el chat y con sonido al subir a un nivel con nuevos hechizos")
cbAlert:SetScript("OnClick", function(self)
    local checked = self:GetChecked() and true or false
    if WarlockTrainerDB then
        WarlockTrainerDB.autoAlert = checked
    end
end)

-- 2. Checkbox: Show Minimap Button
local cbMinimap = CreateFrame("CheckButton", "WarlockTrainerOptMinimap", optionsPanel, "InterfaceOptionsCheckButtonTemplate")
cbMinimap:SetPoint("TOPLEFT", cbAlert, "BOTTOMLEFT", 0, -12)
_G[cbMinimap:GetName() .. "Text"]:SetText(" Mostrar botón en el minimapa")
cbMinimap:SetScript("OnClick", function(self)
    local checked = self:GetChecked() and true or false
    if WarlockTrainerDB then
        WarlockTrainerDB.minimapHide = not checked
    end
    if WT.MinimapButton then
        if checked then
            WT.MinimapButton:Show()
        else
            WT.MinimapButton:Hide()
        end
    end
end)

-- 3. Language Selector
local langLabel = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
langLabel:SetPoint("TOPLEFT", cbMinimap, "BOTTOMLEFT", 0, -20)
langLabel:SetText("Idioma / Language:")

local btnEs = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
btnEs:SetSize(90, 24)
btnEs:SetPoint("LEFT", langLabel, "RIGHT", 15, 0)
btnEs:SetText("Español")
btnEs:SetScript("OnClick", function()
    WT:SetLanguage("es")
end)

local btnEn = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
btnEn:SetSize(90, 24)
btnEn:SetPoint("LEFT", btnEs, "RIGHT", 8, 0)
btnEn:SetText("English")
btnEn:SetScript("OnClick", function()
    WT:SetLanguage("en")
end)

-- 4. Action Buttons
local actionBox = CreateFrame("Frame", nil, optionsPanel)
actionBox:SetSize(400, 40)
actionBox:SetPoint("TOPLEFT", langLabel, "BOTTOMLEFT", 0, -24)

local openBtn = CreateFrame("Button", nil, actionBox, "UIPanelButtonTemplate")
openBtn:SetSize(170, 28)
openBtn:SetPoint("TOPLEFT", actionBox, "TOPLEFT", 0, 0)
openBtn:SetText("Abrir Warlock Trainer")
openBtn:SetScript("OnClick", function()
    InterfaceOptionsFrame:Hide()
    if WT.UI then
        WT.UI:Toggle()
    end
end)

local navBtn = CreateFrame("Button", nil, actionBox, "UIPanelButtonTemplate")
navBtn:SetSize(170, 28)
navBtn:SetPoint("LEFT", openBtn, "RIGHT", 12, 0)
navBtn:SetText("Ruta al Entrenador")
navBtn:SetScript("OnClick", function()
    WT:SetWaypoint()
end)

-- 5. Status Info Box
local statusBox = CreateFrame("Frame", nil, optionsPanel)
statusBox:SetSize(450, 110)
statusBox:SetPoint("TOPLEFT", actionBox, "BOTTOMLEFT", 0, -20)
statusBox:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 14,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
statusBox:SetBackdropColor(0.04, 0.02, 0.06, 0.8)
statusBox:SetBackdropBorderColor(0.4, 0.3, 0.5, 0.8)

local statusTitle = statusBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
statusTitle:SetPoint("TOPLEFT", 10, -10)
statusTitle:SetText("|cffffff00Estado Actual del Personaje:|r")

local statusInfo = statusBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
statusInfo:SetPoint("TOPLEFT", 10, -32)
statusInfo:SetWidth(430)
statusInfo:SetJustifyH("LEFT")

local function UpdateStatus()
    local level = UnitLevel("player")
    local _, class = UnitClass("player")
    local isWl = (class == "WARLOCK")
    local avail = WT:GetAvailableSpells()
    local cost = WT:GetTotalCost(avail)
    local trainer = WT:GetNearestTrainer()
    
    local trainerText = trainer and (trainer.name .. " en " .. trainer.zone .. " (" .. string.format("%.1f, %.1f", trainer.x, trainer.y) .. ")") or "No disponible"
    
    local text = string.format("Clase: %s%s|r | Nivel: %d | Dinero: %s\n" ..
                               "Hechizos pendientes: %d (Coste total: %s)\n" ..
                               "Entrenador más cercano: |cff00ff00%s|r",
                               isWl and "|cff9482c9Brujo" or "|cffff4444" .. (class or "Desconocido"),
                               "", level, WT:FormatMoney(GetMoney()),
                               #avail, WT:FormatMoney(cost),
                               trainerText)
    statusInfo:SetText(text)
end

-- Refresh checkboxes on panel open
optionsPanel:SetScript("OnShow", function()
    if WarlockTrainerDB then
        cbAlert:SetChecked(WarlockTrainerDB.autoAlert ~= false)
        cbMinimap:SetChecked(not WarlockTrainerDB.minimapHide)
    else
        cbAlert:SetChecked(true)
        cbMinimap:SetChecked(true)
    end
    UpdateStatus()
end)

-- Register panel in Blizzard Interface Options
InterfaceOptions_AddCategory(optionsPanel)
