-- Minimap Button for WarlockTrainer (WoW 3.3.5a)
local addonName, WT = ...
WT = WT or {}

local L = WT.L

local button = CreateFrame("Button", "WarlockTrainerMinimapButton", Minimap)
WT.MinimapButton = button

button:SetSize(31, 31)
button:SetFrameStrata("MEDIUM")
button:SetFrameLevel(8)
button:EnableMouse(true)
button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
button:RegisterForDrag("LeftButton")
button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-Button-Highlight")

-- Icon
local icon = button:CreateTexture(nil, "BACKGROUND")
icon:SetSize(20, 20)
icon:SetPoint("CENTER", 0, 0)
icon:SetTexture("Interface\\Icons\\Spell_Shadow_DeathCoil")
button.icon = icon

-- Border
local border = button:CreateTexture(nil, "OVERLAY")
border:SetSize(52, 52)
border:SetPoint("TOPLEFT", 0, 0)
border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

-- Update Button Position around Minimap
local function UpdatePosition(angle)
    local radius = 80
    local rad = math.rad(angle)
    local x = math.cos(rad) * radius
    local y = math.sin(rad) * radius
    button:ClearAllPoints()
    button:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

-- Dragging logic
button:SetScript("OnDragStart", function(self)
    self.isDragging = true
    self:SetScript("OnUpdate", function(self)
        local mx, my = Minimap:GetCenter()
        local cx, cy = GetCursorPosition()
        local scale = Minimap:GetEffectiveScale()
        cx, cy = cx / scale, cy / scale
        local angle = math.deg(math.atan2(cy - my, cx - mx))
        if angle < 0 then angle = angle + 360 end
        WarlockTrainerDB.minimapPos = angle
        UpdatePosition(angle)
    end)
end)

button:SetScript("OnDragStop", function(self)
    self.isDragging = false
    self:SetScript("OnUpdate", nil)
end)

-- Tooltip & Clicks
button:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:AddLine(L.MINIMAP_TOOLTIP_TITLE, 0.58, 0.51, 0.79)
    GameTooltip:AddLine(" ")
    
    local avail = WT:GetAvailableSpells()
    local count = #avail
    local cost = WT:GetTotalCost(avail)
    
    GameTooltip:AddLine(string.format(L.MINIMAP_AVAILABLE_SPELLS, count), 1, 1, 1)
    if count > 0 then
        GameTooltip:AddLine(string.format(L.MINIMAP_TOTAL_COST, WT:FormatMoney(cost)), 1, 1, 1)
    end
    
    local trainer = WT:GetNearestTrainer()
    if trainer then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(string.format("%s |cff00ff00%s|r", L.TRAINER_LABEL, trainer.name), 1, 1, 1)
        GameTooltip:AddLine(string.format("%s (%.1f, %.1f)", trainer.zone, trainer.x, trainer.y), 0.7, 0.7, 0.7)
    end
    
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(L.MINIMAP_TOOLTIP_LCLICK, 0.2, 1, 0.2)
    GameTooltip:AddLine(L.MINIMAP_TOOLTIP_RCLICK, 0.2, 1, 0.2)
    GameTooltip:Show()
end)

button:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
end)

button:SetScript("OnClick", function(self, btn)
    if btn == "LeftButton" then
        if WT.UI then
            WT.UI:Toggle()
        end
    elseif btn == "RightButton" then
        local trainer = WT:GetNearestTrainer()
        if trainer then
            DEFAULT_CHAT_FRAME:AddMessage(string.format("|cff9482c9[WarlockTrainer]|r %s: |cff00ff00%s|r en %s (%s) Coords: (%.1f, %.1f)", 
                L.TRAINER_LABEL, trainer.name, trainer.zone, trainer.subzone or "", trainer.x, trainer.y))
        end
    end
end)

-- Initialize position after ADDON_LOADED
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function()
    local angle = (WarlockTrainerDB and WarlockTrainerDB.minimapPos) or 45
    UpdatePosition(angle)
    if WarlockTrainerDB and WarlockTrainerDB.minimapHide then
        button:Hide()
    else
        button:Show()
    end
end)
