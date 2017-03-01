if not TukuiCF["menu"].enable == true then return end

local font = TukuiCF["media"].uffont
local fontsize = TukuiCF["menu"].FontSize

local BorderColor = TukuiCF["menu"].bordercolor

local FrameDistance = -3
local FlyoutDistance = 3

-- Menu Button
local menu = CreateFrame("Button", "MenuButton", UIParent)
TukuiDB.CreatePanel(menu, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "TOP", UIParent, "TOP", 0, -15)
menu:EnableMouse(true)
menu:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu:RegisterForClicks("AnyUp")

-- Buttons
local menu1 = CreateFrame("Button", "MenuButton1", UIParent)
TukuiDB.CreatePanel(menu1, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "TOP", MenuButton, "BOTTOM", 0, TukuiDB.Scale(FrameDistance))
menu1:EnableMouse(true)
menu1:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu1:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu1:RegisterForClicks("AnyUp")
menu1:SetScript("OnClick", function() ReloadUI() end)

local menu2 = CreateFrame("Button", "MenuButton2", UIParent)
TukuiDB.CreatePanel(menu2, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "TOP", MenuButton1, "BOTTOM", 0, TukuiDB.Scale(FrameDistance))
menu2:EnableMouse(true)
menu2:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu2:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu2:RegisterForClicks("AnyUp")
-- menu2:SetScript("OnMouseDown", function() ToggleCalendar() end)

local menu3 = CreateFrame("Button", "MenuButton3", UIParent)
TukuiDB.CreatePanel(menu3, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "TOP", MenuButton2, "BOTTOM", 0,  TukuiDB.Scale(FrameDistance))
menu3:EnableMouse(true)
menu3:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu3:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu3:RegisterForClicks("AnyUp")
menu3:SetScript("OnMouseDown", function() ToggleKeyRing() end)

local menu4 = CreateFrame("Button", "MenuButton4", UIParent)
TukuiDB.CreatePanel(menu4, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "TOP", MenuButton3, "BOTTOM", 0,  TukuiDB.Scale(FrameDistance))
menu4:EnableMouse(true)
menu4:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu4:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu4:RegisterForClicks("AnyUp")

local menu5 = CreateFrame("Button", "MenuButton5", UIParent)
TukuiDB.CreatePanel(menu5, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "TOP", MenuButton4, "BOTTOM", 0,  TukuiDB.Scale(FrameDistance))
menu5:EnableMouse(true)
menu5:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu5:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu5:RegisterForClicks("AnyUp")

local menu6 = CreateFrame("Button", "MenuButton6", UIParent)
TukuiDB.CreatePanel(menu6, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "LEFT", MenuButton4, "RIGHT", TukuiDB.Scale(FlyoutDistance), 0)
menu6:EnableMouse(true)
menu6:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu6:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu6:RegisterForClicks("AnyUp")

local menu7 = CreateFrame("Button", "MenuButton7", UIParent)
TukuiDB.CreatePanel(menu7, TukuiCF["menu"].ButtonWidth, TukuiCF["menu"].ButtonHeight, "LEFT", MenuButton6, "RIGHT", TukuiDB.Scale(FlyoutDistance), 0)
menu7:EnableMouse(true)
menu7:HookScript("OnEnter", function(self) self:SetBackdropBorderColor(unpack(BorderColor)) end)
menu7:HookScript("OnLeave", function(self) self:SetBackdropBorderColor(.2,.2,.2,1) end)
menu7:RegisterForClicks("AnyUp")

-- Hide buttons
menu:Hide()
menu1:Hide()
menu2:Hide()
menu3:Hide()
menu4:Hide()
menu5:Hide()
menu6:Hide()
menu7:Hide()

-- Foof credit for this toggle
local function Toggle(frame)
	if (frame:IsVisible()) then
		frame:Hide()
	else
		frame:Show()
	end
end

-- Menu
local Text1  = MenuButton:CreateFontString(nil, "LOW")
	Text1:SetFont(font, fontsize)
	Text1:SetPoint("CENTER", MenuButton, 0, 0.5)
	Text1:SetText("Menu")

-- Reload UI
local Text2  = MenuButton1:CreateFontString(nil, "LOW")
	Text2:SetFont(font, fontsize)
	Text2:SetPoint("CENTER", menu1, 0, 0.5)
	Text2:SetText("Reload UI")

-- Calendar
local Text3  = MenuButton2:CreateFontString(nil, "LOW")
	Text3:SetFont(font, fontsize)
	Text3:SetPoint("CENTER", menu2, 0, 0.5)
	Text3:SetText("Calendar")

-- Keyring
local Text4  = MenuButton3:CreateFontString(nil, "LOW")
	Text4:SetFont(font, fontsize)
	Text4:SetPoint("CENTER", menu3, 0, 0.5)
	Text4:SetText("Keyring")

-- Layouts
local Text5  = MenuButton4:CreateFontString(nil, "LOW")
	Text5:SetFont(font, fontsize)
	Text5:SetPoint("CENTER", menu4, 0, 0.5)
	Text5:SetText("AddOns")

-- Close Menu
local Text6  = MenuButton5:CreateFontString(nil, "LOW")
	Text6:SetFont(font, fontsize)
	Text6:SetPoint("CENTER", menu5, 0, 0.5)
	Text6:SetText("Close Menu")

-- Flyouts
local Text7  = MenuButton6:CreateFontString(nil, "LOW")
	Text7:SetFont(font, fontsize)
	Text7:SetPoint("CENTER", menu6, 0, 0.5)
	Text7:SetText("Recount")

local Text8  = MenuButton7:CreateFontString(nil, "LOW")
	Text8:SetFont(font, fontsize)
	Text8:SetPoint("CENTER", menu7, 0, 0.5)
	Text8:SetText("Skada")

-- Show frames
menu:SetScript("OnClick", function()
	Toggle(menu1)
	Toggle(menu2)
	Toggle(menu3)
	Toggle(menu4)
	Toggle(menu5)
-- reset flyouts
	menu6:Hide()
	menu7:Hide()
	Text7:Hide()
	Text8:Hide()
end)

-- Hide frames
menu5:SetScript("OnClick", function()
	Toggle(menu)
	Toggle(menu1)
	Toggle(menu2)
	Toggle(menu3)
	Toggle(menu4)
	Toggle(menu5)
-- reset flyouts
	menu6:Hide()
	menu7:Hide()
	Text7:Hide()
	Text8:Hide()
end)

menu4:SetScript("OnClick", function()
	Toggle(menu6)
	Toggle(menu7)
	Toggle(Text7)
	Toggle(Text8)
end)

-- Recount
menu6:SetScript("OnMouseDown", function()
	if (IsAddOnLoaded("Recount")) then
		if (Recount.MainWindow:IsShown()) then
			Recount.MainWindow:Hide()
		else
			Recount.MainWindow:Show()
			Recount.RefreshMainWindow()
		end
	end

	if not (IsAddOnLoaded("Recount")) then
		print("|cff69ccf0Recount is not loaded.|r")
	end
end)

-- Skada
menu7:SetScript("OnMouseDown", function()
	if (IsAddOnLoaded("Skada")) then
		Skada:ToggleWindow()
	end

	if not (IsAddOnLoaded("Skada")) then
		print("|cff69ccf0Skada is not loaded.|r")
	end
end)
