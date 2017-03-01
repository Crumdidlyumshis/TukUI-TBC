-- ACTION BAR PANEL
TukuiDB.buttonsize = TukuiDB.Scale(27)
TukuiDB.buttonspacing = TukuiDB.Scale(4)
TukuiDB.petbuttonsize = TukuiDB.Scale(29)
TukuiDB.petbuttonspacing = TukuiDB.Scale(4)

-- set left and right info panel width
TukuiCF["panels"] = {["tinfowidth"] = 370}

-- INFO MIDDLE
local imiddle = CreateFrame("Frame", "TukuiInfoMiddle", UIParent)
TukuiDB.CreatePanel(imiddle, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), 23, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(10))
imiddle:SetFrameLevel(2)
imiddle:SetFrameStrata("BACKGROUND")

local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", imiddle, "TOP", 0, TukuiDB.Scale(3))
barbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
if TukuiCF["actionbar"].bottomrows == 2 then
	barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
else
	barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
end
barbg:SetFrameStrata("BACKGROUND")
barbg:SetFrameLevel(1)

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", barbg)
TukuiDB.CreatePanel(ileft, TukuiCF["panels"].tinfowidth, 23, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", TukuiDB.Scale(10), TukuiDB.Scale(10))
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")

-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", barbg)
TukuiDB.CreatePanel(iright, TukuiCF["panels"].tinfowidth, 23, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.Scale(-10), TukuiDB.Scale(10))
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")

-- CHAT LEFT
local chatleft = CreateFrame("Frame", "ChatLeft", TukuiInfoLeft)
TukuiDB.CreatePanel(chatleft, TukuiCF["panels"].tinfowidth, TukuiDB.Scale(139), "BOTTOM", TukuiInfoLeft, "TOP", 0, TukuiDB.Scale(3))
chatleft:SetFrameLevel(2)
chatleft:SetBackdropColor(.075,.075,.075,.7)
chatleft:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))

leftborder = CreateFrame("Frame", nil, UIParent)
leftborder:SetPoint("TOPLEFT", ChatLeft, "TOPLEFT", -1, 1)
leftborder:SetFrameStrata("BACKGROUND")
leftborder:SetBackdrop {
edgeFile = TukuiCF["media"].blank, edgeSize = 3,
insets = {left = 0, right = 0, top = 0, bottom = 0}
}
leftborder:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
leftborder:SetBackdropBorderColor(unpack(TukuiCF["media"].backdropcolor))
leftborder:SetPoint("BOTTOMRIGHT", ChatLeft, "BOTTOMRIGHT", 1, -1)

-- ADDON BOX
local chatright = CreateFrame("Frame", "ChatRight", TukuiInfoRight)
TukuiDB.CreatePanel(chatright, TukuiDB.Scale(220), TukuiDB.Scale(139), "BOTTOMLEFT", TukuiInfoRight, "TOPLEFT", 0, TukuiDB.Scale(3))
chatright:SetFrameLevel(2)
chatright:SetBackdropColor(.075,.075,.075,.7)
chatright:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
 
rightborder = CreateFrame("Frame", nil, UIParent)
rightborder:SetPoint("TOPLEFT", ChatRight, "TOPLEFT", -1, 1)
rightborder:SetFrameStrata("BACKGROUND")
rightborder:SetBackdrop {
edgeFile = TukuiCF["media"].blank, edgeSize = 3,
insets = {left = 0, right = 0, top = 0, bottom = 0}
}
rightborder:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
rightborder:SetBackdropBorderColor(unpack(TukuiCF["media"].backdropcolor))
rightborder:SetPoint("BOTTOMRIGHT", ChatRight, "BOTTOMRIGHT", 1, -1)

 -- BUTTON LEFT (for BG's)
local cubeleft = CreateFrame("Button", "Battleground Toggle", UIParent)
TukuiDB.CreatePanel(cubeleft, 10, 10, "RIGHT", TukuiInfoMiddle, "LEFT", TukuiDB.Scale(-3), 0)
cubeleft:SetFrameStrata("HIGH")
cubeleft:Hide()

 -- BUTTON LEFT (RELOAD UI)
local button1 = CreateFrame("Button", "tester1", UIParent)
TukuiDB.CreatePanel(button1, 10, 10, "RIGHT", TukuiInfoMiddle, "LEFT", TukuiDB.Scale(-3), 0)
button1:EnableMouse(true)
button1:HookScript("OnEnter", function(self)
	self:SetBackdropBorderColor(unpack(TukuiCF["menu"].bordercolor))
	GameTooltip:SetOwner(this, "ANCHOR_NONE", 0, TukuiDB.Scale(6));
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 0)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine("Reload UI")
	GameTooltip:Show()
end)
button1:HookScript("OnLeave", function(self)
	self:SetBackdropBorderColor(.2,.2,.2,1)
	GameTooltip:Hide()
end)
button1:RegisterForClicks("AnyUp")
	button1:SetScript("OnClick", function()
	ReloadUI()
end)

-- BUTTON RIGHT (TOGGLE MENU)
local button2 = CreateFrame("Button", "tester2", UIParent)
TukuiDB.CreatePanel(button2, 10, 10, "LEFT", TukuiInfoMiddle, "RIGHT", TukuiDB.Scale(3), 0)
button2:EnableMouse(true)
button2:HookScript("OnEnter", function(self)
self:SetBackdropBorderColor(unpack(TukuiCF["menu"].bordercolor))
	GameTooltip:SetOwner(this, "ANCHOR_NONE", 0, 0);
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 0)
	GameTooltip:ClearLines()
	GameTooltip:AddDoubleLine("Toggle Menu")
	GameTooltip:Show()
end)
button2:HookScript("OnLeave", function(self)
	self:SetBackdropBorderColor(.2,.2,.2,1)
	GameTooltip:Hide()
end)
button2:RegisterForClicks("AnyUp")
button2:SetScript("OnClick", function()
	if (MenuButton:IsVisible()) then
		MenuButton:Hide()
		MenuButton:Hide()
		MenuButton1:Hide()
		MenuButton2:Hide()
		MenuButton3:Hide()
		MenuButton4:Hide()
		MenuButton5:Hide()
		MenuButton6:Hide()
		MenuButton7:Hide()
	else
		MenuButton:Show()
	end	
end)

--RIGHT BAR BACKGROUND
if TukuiCF["actionbar"].enable == true or not (IsAddOnLoaded("Dominos") or IsAddOnLoaded("Bartender4") or IsAddOnLoaded("Macaroon")) then
	local barbgr = CreateFrame("Frame", "TukuiActionBarBackgroundRight", MultiBarRight)
	TukuiDB.CreatePanel(barbgr, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "BOTTOMRIGHT", TukuiMinimap, "TOPRIGHT", 0, TukuiDB.Scale(3))
	if TukuiCF["actionbar"].rightbars == 1 then
		barbgr:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	elseif TukuiCF["actionbar"].rightbars == 2 then
		barbgr:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	elseif TukuiCF["actionbar"].rightbars == 3 then
		barbgr:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	else
		barbgr:Hide()
	end

	local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", PetActionButton1)
	if TukuiCF["actionbar"].rightbars > 0 then
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "BOTTOMRIGHT", barbgr, "BOTTOMLEFT", TukuiDB.Scale(-3), 0)
	else
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "BOTTOMRIGHT", TukuiMinimap, "TOPRIGHT", 0, TukuiDB.Scale(3))
	end
end

--BATTLEGROUND STATS FRAME
if TukuiCF["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	TukuiDB.CreatePanel(bgframe, 1, 1, "CENTER", TukuiInfoLeft, "CENTER", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(3)
	bgframe:EnableMouse(true)
	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == "pvp") then
				cubeleft:Show()
				bgframe:Show()
			else
				cubeleft:Hide()
				bgframe:Hide()
			end
		end
	end
	bgframe:SetScript("OnEnter", function(self)
	local numScores = GetNumBattlefieldScores()
		for i=1, numScores do
			name, killingBlows, honorKills, deaths, honorGained, faction, rank, race, class, classToken, damageDone, healingDone  = GetBattlefieldScore(i);
			if ( name ) then
				if ( name == UnitName("player") ) then
					GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, TukuiDB.Scale(4));
					GameTooltip:ClearLines()
					GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.Scale(1))
					GameTooltip:ClearLines()
					GameTooltip:AddLine(tukuilocal.datatext_ttstatsfor.."[|cffCC0033"..name.."|r]")
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttkillingblows, killingBlows,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthonorkills, honorKills,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttdeaths, deaths,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthonorgain, honorGained,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_ttdmgdone, damageDone,1,1,1)
					GameTooltip:AddDoubleLine(tukuilocal.datatext_tthealdone, healingDone,1,1,1)
					--Add extra statistics to watch based on what BG you are in.
					if GetRealZoneText() == "Arathi Basin" then --
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
					elseif GetRealZoneText() == "Warsong Gulch" then --
						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagsreturned,GetBattlefieldStatData(i, 2),1,1,1)
					elseif GetRealZoneText() == "Eye of the Storm" then --
						GameTooltip:AddDoubleLine(tukuilocal.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
					elseif GetRealZoneText() == "Alterac Valley" then
						GameTooltip:AddDoubleLine(tukuilocal.datatext_graveyardsassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_graveyardsdefended,GetBattlefieldStatData(i, 2),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_towersassaulted,GetBattlefieldStatData(i, 3),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_towersdefended,GetBattlefieldStatData(i, 4),1,1,1)
					elseif GetRealZoneText() == "Strand of the Ancients" then
						GameTooltip:AddDoubleLine(tukuilocal.datatext_demolishersdestroyed,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_gatesdestroyed,GetBattlefieldStatData(i, 2),1,1,1)
					elseif GetRealZoneText() == "Isle of Conquest" then
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(tukuilocal.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
					end					
					GameTooltip:Show()
				end
			end
		end
	end) 
	bgframe:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
	bgframe:RegisterEvent("PLAYER_ENTERING_WORLD")
	bgframe:SetScript("OnEvent", OnEvent)
	
	-- this part is to enable left cube as a button for battleground stat panel.
	local function CubeLeftClick(self, event)
		if event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then
			cubeleft:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
			inInstance, instanceType = IsInInstance()
			if TukuiCF["datatext"].battleground == true and (inInstance and (instanceType == "pvp")) then
				cubeleft:EnableMouse(true)
			else
				cubeleft:EnableMouse(false)
			end
		end   
	end
	cubeleft:SetScript("OnMouseDown", function()
		if bgframe:IsShown() then
			bgframe:Hide()
			cubeleft:SetBackdropBorderColor(0,.8,1,1)
		else
			cubeleft:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
			bgframe:Show()
		end
	end)
	cubeleft:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	cubeleft:RegisterEvent("PLAYER_ENTERING_WORLD")
	cubeleft:SetScript("OnEvent", CubeLeftClick)
end