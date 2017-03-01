if not TukuiCF["unitframes"].combopoints == true then
	return
end

local combotex = "Interface\\Addons\\Tukui\\media\\textures\\normTex"
local blank = "Interface\\Addons\\Tukui\\media\\textures\\blank"
local aColor = { r = .230, g = .230, b = .230, a = 1 }
local bColor = { r = .075, g = .075, b = .075, a = 1 }

local fadeIn = 0.5
local fadeOut = 0.5
local frameFadeIn = 0.2
local frameFadeOut = 0.2
local hideooc = true
local hidenoenergy = true
local incombat = false
local visible = true
local powertype = nil
local unit = "player"
local points = 0

local comboFrame = CreateFrame("Frame", "eCombo", UIParent)
function comboFrame:new()
		self:ClearAllPoints()
		self:SetWidth(186)
		self:SetHeight(4)
		self:SetPoint("CENTER", oUF_Tukz_player, "CENTER", 0, -25)
		
		self.iborder = self:CreateTexture(nil, "overlay")
		self.iborder:ClearAllPoints()
		self.iborder:SetAllPoints(self)
		self.iborder:SetPoint("TOPLEFT", self, "TOPLEFT", -1, 1)
		self.iborder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 1, -1)
		self.iborder:SetTexture(blank)
		self.iborder:SetVertexColor(bColor.r, bColor.g, bColor.b)
		self.iborder:SetAlpha(bColor.a)

		self.oborder = self:CreateTexture(nil, "overlay")
		self.oborder:ClearAllPoints()
		self.oborder:SetAllPoints(self)
		self.oborder:SetPoint("TOPLEFT", self, "TOPLEFT", -2, 2)
		self.oborder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 2, -2)
		self.oborder:SetTexture(blank)
		self.oborder:SetVertexColor(aColor.r, aColor.g, aColor.b)
		self.oborder:SetAlpha(aColor.a)
		
		self.backdrop = self:CreateTexture(nil, "BACKGROUND")
		self.backdrop:ClearAllPoints()
		self.backdrop:SetAllPoints(self.oborder)
		self.backdrop:SetPoint("TOPLEFT", self.oborder, "TOPLEFT", -1, 1)
		self.backdrop:SetPoint("BOTTOMRIGHT", self.oborder, "BOTTOMRIGHT", 1, -1)
		self.backdrop:SetTexture(blank)
		self.backdrop:SetVertexColor(bColor.r, bColor.g, bColor.b)
		self.backdrop:SetAlpha(bColor.a)

		self.comboWidth = 182 / 5
	
	self.combos = {}
	self.CPoints = {}
	local cx = 0
		for i = 1, 5 do
		local combo = CreateFrame("Frame", nil, self)
		combo:ClearAllPoints()
		combo:SetPoint("TOPLEFT", self, "TOPLEFT", cx, 0)
		combo:SetPoint("BOTTOMRIGHT", self, "BOTTOMLEFT", cx + self.comboWidth, 0)
		self.CPoints[i] = combo:CreateTexture(nil, "BACKGROUND")
		self.CPoints[i]:ClearAllPoints()
		self.CPoints[i]:SetAllPoints(combo)
		self.CPoints[i]:SetTexture(combotex)
		combo:SetAlpha(0)
		self.combos[i] = combo

		cx = cx + self.comboWidth + 1
	end			
	self.CPoints[1]:SetVertexColor(0.69, 0.31, 0.31)		
	self.CPoints[2]:SetVertexColor(0.65, 0.42, 0.31)
	self.CPoints[3]:SetVertexColor(0.65, 0.63, 0.35)
	self.CPoints[4]:SetVertexColor(0.46, 0.63, 0.35)
	self.CPoints[5]:SetVertexColor(0.33, 0.63, 0.33)

	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("UNIT_DISPLAYPOWER")
	self:RegisterEvent("UNIT_COMBO_POINTS")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	if hideooc then
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	end
	self:RegisterEvent("UNIT_ENTERED_VEHICLE")
	self:RegisterEvent("UNIT_EXITED_VEHICLE")

	self:SetScript("OnEvent", self.event)
end

function comboFrame:toggleCombo()
	if not hideooc and not hidenoenergy then
		return
	end

	if hidenoenergy then
		if powertype == SPELL_POWER_ENERGY then
			if hideooc then
				if not visible and points > 0 then
					UIFrameFadeIn(self, frameFadeIn)
					visible = true
				end
			elseif not visible and points > 0 then
				UIFrameFadeIn(self, frameFadeIn)
				visible = true
			end
		else
			if visible then
				UIFrameFadeOut(self, frameFadeOut)
				visible = false
			end
			return
		end
	end
end

function comboFrame:updateCombo()
	local pt = GetComboPoints(unit)
	if pt == points then
		self:toggleCombo()
		return
	end
	
	if pt > points then
		for i = points + 1, pt do
			UIFrameFadeIn(self.combos[i], fadeIn)
		end
	else
		for i = pt + 1, points do
			UIFrameFadeOut(self.combos[i], fadeOut)
			UIFrameFadeOut(self, frameFadeOut)
			visible = false
		end
	end
	
	points = pt
	
	self:toggleCombo()
end

function comboFrame:event(event, ...)
	if event == "PLAYER_LOGIN" then
		if powertype ~= nil then return end

		powertype, _ = UnitPowerType("player")
		-- if UnitHasVehicleUI("player") then
		-- 	local powervehicle, _ = UnitPowerType("vehicle")
		-- 	if powervehicle == SPELL_POWER_ENERGY then
		-- 		unit = "vehicle"
		-- 		powertype = powervehicle
		-- 	end
		-- end

		if hideooc or (hidenoenergy and powertype ~= SPELL_POWER_ENERGY) then
			visible = false
			self:SetAlpha(0)
		end
	elseif event == "UNIT_COMBO_POINTS" then
		local curunit = select(1, ...)
		if curunit ~= unit then return end
		
		self:updateCombo()
	elseif event == "PLAYER_TARGET_CHANGED" then
		self:updateCombo()
	elseif event == "PLAYER_REGEN_DISABLED" then
		incombat = true

		self:toggleCombo()
	elseif event == "PLAYER_REGEN_ENABLED" then
		incombat = false

		self:toggleCombo()
	elseif event == "UNIT_DISPLAYPOWER" then
		local curunit = select(1, ...)
		if curunit ~= unit then return end
		
		powertype, _ = UnitPowerType(unit)

		self:toggleCombo()
	elseif event == "UNIT_ENTERED_VEHICLE" then
		local curunit = select(1, ...)
		if curunit ~= "player" then return end

		local powervehicle, _ = UnitPowerType("vehicle")
		if powervehicle == SPELL_POWER_ENERGY then
			unit = "vehicle"
			points = 0
			powertype = powervehicle

			self:toggleCombo()
		end
	elseif event == "UNIT_EXITED_VEHICLE" then
		local curunit = select(1, ...)
		if curunit ~= "player" then return end

		unit = "player"
		points = 0
		powertype, _ = UnitPowerType(unit)

		self:toggleCombo()
	end
end

comboFrame:new()