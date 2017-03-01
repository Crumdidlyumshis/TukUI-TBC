if not TukuiCF["unitframes"].enable == true then return end

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------

local db = TukuiCF["unitframes"]
local font1 = TukuiCF["media"].uffont
local font2 = TukuiCF["media"].font
local normTex = TukuiCF["media"].normTex

local backdrop = {
	bgFile = TukuiCF["media"].blank,
	insets = {top = -TukuiDB.mult, left = -TukuiDB.mult, bottom = -TukuiDB.mult, right = -TukuiDB.mult},
}

-- leave alone
local PostNamePosition = function(self)
	self.Info:ClearAllPoints()
	self.Info:SetPoint("TOPLEFT", health, "TOPLEFT", 1, -1)
end

local castbarcolor = {
	["DEATHKNIGHT"] = { 196/255,  30/255,  60/255, 0.8 },
	["DRUID"]	    = { 255/255, 125/255,  10/255, 0.8 },
	["HUNTER"]	    = { 171/255, 214/255, 116/255, 0.8 },
	["MAGE"]	    = { 104/255, 205/255, 255/255, 0.8 },
	["PALADIN"]	    = { 245/255, 140/255, 186/255, 0.8 },
	["PRIEST"]	    = { 212/255, 212/255, 212/255, 0.8 },
	["ROGUE"]       = { 255/255, 243/255,  82/255, 0.8 },
	["SHAMAN"]	    = {	  41/255, 79/255, 155/255, 0.8 },
	["WARLOCK"]	    = { 148/255, 130/255, 201/255, 0.8 },
	["WARRIOR"]	    = { 199/255, 156/255, 110/255, 0.8 },
}

------------------------------------------------------------------------
--	Layout
------------------------------------------------------------------------

local function Shared(self, unit)
	-- set our own colors
	self.colors = TukuiDB.oUF_colors
	
	-- register click
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	-- menu
	self.menu = TukuiDB.SpawnMenu
	self:SetAttribute('type2', 'menu')

	-- backdrop for every units
	self:SetBackdrop(backdrop)
	self:SetBackdropColor(0, 0, 0)
	
	------------------------------------------------------------------------
	--	Player and Target units layout (mostly mirror'd)
	------------------------------------------------------------------------
	
	if (unit == "player" or unit == "target") then
		-- anchor for reputation/experience
		local repexp = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(repexp, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), 23, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(10))
		repexp:SetFrameLevel(2)
		repexp:SetFrameStrata("BACKGROUND")
		self.repexp = repexp
		
		-- anchor
		local focuscb = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(focuscb, 370, 23, "CENTER", TukuiInfoRight, "CENTER", 0, 0)
		focuscb:SetFrameLevel(2)
		focuscb:SetFrameStrata("BACKGROUND")
		self.focuscb = focuscb
	
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(24))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
				
		-- health bar background
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
	
		health.value = TukuiDB.SetFontString(health, font1, 12)
		health.value:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", TukuiDB.Scale(-1), TukuiDB.Scale(1))
		health.PostUpdate = TukuiDB.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG

		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorTapping = true	
			health.colorClass = true
			health.colorReaction = true			
		end

		-- health border
		local healthborder = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(healthborder, 1, 1, "CENTER", health, "CENTER", 0, 0)
		healthborder:ClearAllPoints()
		healthborder:SetPoint("TOPLEFT", health, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		healthborder:SetPoint("BOTTOMRIGHT", health, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		healthborder:SetFrameStrata("MEDIUM")
		
		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(5))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
		power:SetStatusBarTexture(normTex)
		
		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = TukuiDB.SetFontString(health, font1, 12)
		power.value:SetPoint("BOTTOMLEFT", health, "BOTTOMLEFT", TukuiDB.Scale(1), TukuiDB.Scale(1))
		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		power.frequentUpdates = true
		power.colorDisconnected = false

		if db.showsmooth == true then
			power.Smooth = true
		end
		
		if db.unicolor == true then
			power.colorTapping = true
			power.colorClass = true
			powerBG.multiplier = 0.1				
		else
			power.colorPower = true
		end

		-- power border
		local powerborder = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(powerborder, 1, 1, "CENTER", health, "CENTER", 0, 0)
		powerborder:ClearAllPoints()
		powerborder:SetPoint("TOPLEFT", power, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		powerborder:SetPoint("BOTTOMRIGHT", power, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		powerborder:SetFrameStrata("MEDIUM")
		
		-- name
		if unit ~= "player" then
			self.Info = TukuiDB.SetFontString(health, font1, 12)
			self.Info:SetPoint("TOPLEFT", health, "TOPLEFT", 1, 0)
			self:Tag(self.Info, "[Tukui:getnamecolor][Tukui:nameverylong]")
		end

		-- weapon enchants
		if db.weaponenchants == true and unit == "player" then			
			local enchant = CreateFrame("Frame", "oUF_Tukz_" .. tostring(unit) .. "_weaponEnchants", self)								
			enchant:SetHeight(21.5)
			enchant:SetWidth(21.5)
			enchant.size = 21.5
			enchant.showCD = db.auratimer
			enchant.spacing = 2
			
			enchant:SetPoint("LEFT", self, "TOPLEFT", -26, -10)	
			enchant["growth-y"] = RIGHT
			-- enchant["growth-x"] = DOWN
			enchant.initialAnchor = "LEFT"
			enchant.PostCreateEnchantIcon = TukuiDB.PostCreateEnchantIcon
			enchant.PostUpdateEnchantIcons = TukuiDB.PostUpdateEnchantIcons

			self.Enchant = enchant
		end
		
		-- portraits
		if (db.charportrait == true) then
			local portrait = CreateFrame("PlayerModel", nil, self)
			portrait:SetFrameLevel(8)
			portrait:SetHeight(32)
			portrait:SetWidth(44)
			portrait:SetAlpha(1)
			if unit == "player" then
				local portbg = CreateFrame("Frame", nil, self)
				TukuiDB.CreatePanel(portbg, 48, 36, "RIGHT", self, "LEFT", -6, 0)
				self.portbg = portbg
				portrait:SetPoint("CENTER", portbg, "CENTER", 0,0)
			elseif unit == "target" then
				local portbg = CreateFrame("Frame", nil, self)
				TukuiDB.CreatePanel(portbg, 48, 36, "LEFT", self, "RIGHT", 6, 0)
				self.portbg = portbg
				portrait:SetPoint("CENTER", portbg, "CENTER", 0,0)
			end
			table.insert(self.__elements, TukuiDB.HidePortrait)
			self.Portrait = portrait
		end

		if (unit == "player") then
			-- combat icon
			local Combat = health:CreateTexture(nil, "OVERLAY")
			Combat:SetHeight(TukuiDB.Scale(19))
			Combat:SetWidth(TukuiDB.Scale(19))
			Combat:SetPoint("TOPRIGHT",2,3)
			Combat:SetVertexColor(0.69, 0.31, 0.31)
			self.Combat = Combat

			-- custom info (low mana warning)
			FlashInfo = CreateFrame("Frame", "FlashInfo", self)
			FlashInfo:SetScript("OnUpdate", TukuiDB.UpdateManaLevel)
			FlashInfo.parent = self
			FlashInfo:SetToplevel(true)
			FlashInfo:SetAllPoints(health)
			FlashInfo.ManaLevel = TukuiDB.SetFontString(FlashInfo, font1, 12)
			FlashInfo.ManaLevel:SetPoint("CENTER", health, "CENTER", 0, -5)
			self.FlashInfo = FlashInfo
			
			-- pvp status text
			local status = TukuiDB.SetFontString(health, font1, 12)
			status:SetPoint("TOP", health, "TOP", 0, 0)
			status:SetTextColor(0.69, 0.31, 0.31, 0)
			self.Status = status
			self:Tag(status, "[pvp]")
			
			-- script for pvp status and low mana
			self:SetScript("OnEnter", function(self) FlashInfo.ManaLevel:Hide() status:SetAlpha(1) UnitFrame_OnEnter(self) end)
			self:SetScript("OnLeave", function(self) FlashInfo.ManaLevel:Show() status:SetAlpha(0) UnitFrame_OnLeave(self) end)
			
			-- leader icon
			local Leader = health:CreateTexture(nil, "OVERLAY")
			Leader:SetHeight(TukuiDB.Scale(14))
			Leader:SetWidth(TukuiDB.Scale(14))
			Leader:SetPoint("TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(8))
			self.Leader = Leader
			
			-- master looter
			local MasterLooter = health:CreateTexture(nil, "OVERLAY")
			MasterLooter:SetHeight(TukuiDB.Scale(14))
			MasterLooter:SetWidth(TukuiDB.Scale(14))
			self.MasterLooter = MasterLooter
			self:RegisterEvent("PARTY_LEADER_CHANGED", TukuiDB.MLAnchorUpdate)
			self:RegisterEvent("PARTY_MEMBERS_CHANGED", TukuiDB.MLAnchorUpdate)

						
			-- the threat bar on info left panel
			if (db.showthreat == true) then
				local ThreatBar = CreateFrame("StatusBar", self:GetName()..'_ThreatBar', TukuiInfoLeft)
				ThreatBar:SetFrameLevel(5)
				ThreatBar:SetPoint("TOPLEFT", TukuiInfoLeft, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				ThreatBar:SetPoint("BOTTOMRIGHT", TukuiInfoLeft, TukuiDB.Scale(-2), TukuiDB.Scale(2))
			  
				ThreatBar:SetStatusBarTexture(normTex)
				--ThreatBar:GetStatusBarTexture():SetHorizTile(false)
				ThreatBar:SetBackdrop(backdrop)
				ThreatBar:SetBackdropColor(0, 0, 0, 0)
		   
				ThreatBar.Text = TukuiDB.SetFontString(ThreatBar, font2, 12)
				ThreatBar.Text:SetPoint("RIGHT", ThreatBar, "RIGHT", TukuiDB.Scale(-30), 0 )
		
				ThreatBar.Title = TukuiDB.SetFontString(ThreatBar, font2, 12)
				ThreatBar.Title:SetText(tukuilocal.unitframes_ouf_threattext)
				ThreatBar.Title:SetPoint("LEFT", ThreatBar, "LEFT", TukuiDB.Scale(30), 0 )
					  
				ThreatBar.bg = ThreatBar:CreateTexture(nil, 'BORDER')
				ThreatBar.bg:SetAllPoints(ThreatBar)
				ThreatBar.bg:SetTexture(0.1,0.1,0.1)
		   
				ThreatBar.useRawThreat = false
				self.ThreatBar = ThreatBar
			end
			
			-- experience bar on player via mouseover for player currently levelling a character
			if TukuiDB.level ~= MAX_PLAYER_LEVEL then
				local Experience = CreateFrame("StatusBar", self:GetName().."_Experience", self)
				Experience:SetStatusBarTexture(normTex)
				Experience:SetStatusBarColor(0, 0.4, 1, .8)
				Experience:SetBackdrop(backdrop)
				Experience:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
				Experience:SetWidth(repexp:GetWidth() - TukuiDB.Scale(4))
				Experience:SetHeight(repexp:GetHeight() - TukuiDB.Scale(4))
				Experience:SetPoint("TOPLEFT", repexp, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				Experience:SetPoint("BOTTOMRIGHT", repexp, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				Experience:SetFrameLevel(10)
				Experience:SetAlpha(0)				
				Experience:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
				Experience:HookScript("OnLeave", function(self) self:SetAlpha(0) end)
				Experience.Tooltip = true						
				Experience.Rested = CreateFrame('StatusBar', nil, self)
				Experience.Rested:SetParent(Experience)
				Experience.Rested:SetAllPoints(Experience)
				self.Experience = Experience
			end
			
			-- reputation bar for max level character
			if TukuiDB.level == MAX_PLAYER_LEVEL then
				local Reputation = CreateFrame("StatusBar", self:GetName().."_Reputation", self)
				Reputation:SetStatusBarTexture(normTex)
				Reputation:SetBackdrop(backdrop)
				Reputation:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
				Reputation:SetWidth(repexp:GetWidth() - TukuiDB.Scale(4))
				Reputation:SetHeight(repexp:GetHeight() - TukuiDB.Scale(4))
				Reputation:SetPoint("TOPLEFT", repexp, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				Reputation:SetPoint("BOTTOMRIGHT", repexp, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				Reputation:SetFrameLevel(10)
				Reputation:SetAlpha(0)

				Reputation:HookScript("OnEnter", function(self) self:SetAlpha(1) end)
				Reputation:HookScript("OnLeave", function(self) self:SetAlpha(0) end)

				Reputation.PostUpdate = TukuiDB.UpdateReputationColor
				Reputation.Tooltip = true
				self.Reputation = Reputation
			end
			
			-- show druid mana when shapeshifted in bear, cat or whatever
			if TukuiDB.myclass == "DRUID" then
				CreateFrame("Frame"):SetScript("OnUpdate", function() TukuiDB.UpdateDruidMana(self) end)
				local DruidMana = TukuiDB.SetFontString(health, font1, 12)
				DruidMana:SetTextColor(1, 0.49, 0.04)
				self.DruidMana = DruidMana
			end

			-- deathknight runes
			if TukuiDB.myclass == "DEATHKNIGHT" and db.runebar == true then
				local Runes = CreateFrame("Frame", nil, self)
				Runes:SetPoint("BOTTOMLEFT", ChatLeft, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
				Runes:SetHeight(4)
				Runes:SetWidth(TukuiDB.Scale(361))
				Runes:SetBackdrop(backdrop)
				Runes:SetBackdropColor(0, 0, 0)

				for i = 1, 6 do
					Runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
					Runes[i]:SetHeight(4)
					Runes[i]:SetWidth(TukuiDB.Scale(361) / 6)
					if (i == 1) then
						Runes[i]:SetPoint("BOTTOMLEFT", ChatLeft, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
					else
						Runes[i]:SetPoint("TOPLEFT", Runes[i-1], "TOPRIGHT", TukuiDB.Scale(1), 0)
					end
					Runes[i]:SetStatusBarTexture(normTex)
					--Runes[i]:GetStatusBarTexture():SetHorizTile(false)
					
					-- rune border
					local runeborder = CreateFrame("Frame", nil, self)
					TukuiDB.CreatePanel(runeborder, 370, 8, "BOTTOM", ChatLeft, "TOP", 0, TukuiDB.Scale(3))
				end

				self.Runes = Runes
			end
			
			-- shaman totem bar
			if TukuiDB.myclass == "SHAMAN" and db.totemtimer == true then
				local TotemBar = {}
				TotemBar.Destroy = true
				for i = 1, 4 do
					TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, self)
					if (i == 1) then
					   TotemBar[i]:SetPoint("BOTTOMLEFT", ChatLeft, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
					else
					   TotemBar[i]:SetPoint("TOPLEFT", TotemBar[i-1], "TOPRIGHT", TukuiDB.Scale(1), 0)
					end
					TotemBar[i]:SetStatusBarTexture(normTex)
					TotemBar[i]:SetHeight(4)
					TotemBar[i]:SetWidth(363 / 4)
					TotemBar[i]:SetBackdrop(backdrop)
					TotemBar[i]:SetBackdropColor(0, 0, 0)
					TotemBar[i]:SetMinMaxValues(0, 1)

					TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
					TotemBar[i].bg:SetAllPoints(TotemBar[i])
					TotemBar[i].bg:SetTexture(normTex)
					TotemBar[i].bg.multiplier = 0.3
					
					-- totem border
					local totemborder = CreateFrame("Frame", nil, self)
					TukuiDB.CreatePanel(totemborder, 370, 8, "BOTTOM", ChatLeft, "TOP", 0, TukuiDB.Scale(3))
				end
				self.TotemBar = TotemBar
			end
		end

		if (unit == "target" and db.targetauras) or (unit == "player" and db.playerauras) then
			local buffs = CreateFrame("Frame", "oUF_Tukz_" .. tostring(unit) .. "_buffs", self)
			local debuffs = CreateFrame("Frame", "oUF_Tukz_" .. tostring(unit) .. "_debuffs", self)
			
			buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 27)	
			buffs:SetHeight(21.5)
			buffs:SetWidth(186)
			buffs.size = 21.5
			buffs.num = 8
				
			debuffs:SetHeight(21.5)
			debuffs:SetWidth(186)
			debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", 0, 2)
			debuffs.size = 21.5	
			debuffs.num = 24
						
			buffs.spacing = 2
			buffs.initialAnchor = 'TOPLEFT'
			buffs.PostCreateIcon = TukuiDB.PostCreateAura
			buffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Buffs = buffs	
						
			debuffs.spacing = 2
			debuffs.initialAnchor = 'TOPRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.onlyShowPlayer = db.playerdebuffsonly
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
		
		-- cast bar for player and target
		if (db.unitcastbar == true) then
		local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
		castbar:SetStatusBarTexture(normTex)
		
		if unit == "player" then
			castbar.bg = castbar:CreateTexture(nil, "BORDER")
			castbar.bg:SetAllPoints(castbar)
			castbar.bg:SetTexture(normTex)
			castbar.bg:SetVertexColor(.075, .075, .075)
			castbar:SetFrameLevel(10)
			castbar:SetPoint("TOPLEFT", repexp, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			castbar:SetPoint("BOTTOMRIGHT", repexp, TukuiDB.Scale(-2), TukuiDB.Scale(2))
			
			castbar.CustomTimeText = TukuiDB.CustomCastTimeText
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.PostCastStart
			castbar.PostChannelStart = TukuiDB.PostCastStart
			castbar:RegisterEvent('UNIT_SPELLCAST_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)
			castbar:RegisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)

			castbar.time = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.time:SetPoint("RIGHT", repexp, "RIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(1))
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.Text:SetPoint("CENTER", repexp, "CENTER", 0, 1)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			if (unit == "player" or unit == "target" or unit == "focus") and (TukuiCF["castbar"].classcolor == true) then
			local _, targetClass = UnitClass(unit)
				if (targetClass ~= nil) then
					castbar:SetStatusBarColor(unpack(castbarcolor[targetClass]))
				else
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"][unit]))
				end
			else
				if (unit == "player" or unit == "target" or unit == "focus") then
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"][unit]))
				else
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"].other))
				end
			end
			
		elseif unit == "target" then
			castbar.bg = CreateFrame("Frame", nil, castbar)
			TukuiDB.SetTemplate(castbar.bg)
			castbar.bg:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
			castbar.bg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
			castbar.bg:SetFrameLevel(2)
			castbar:SetFrameLevel(6)
			castbar:SetHeight(19)
			castbar:SetWidth(250)
			castbar:SetPoint("TOP", UIParent, "CENTER", 0, TukuiDB.Scale(-200))
		
			castbar.CustomTimeText = TukuiDB.CustomCastTimeText
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.PostCastStart
			castbar.PostChannelStart = TukuiDB.PostCastStart
			castbar:RegisterEvent('UNIT_SPELLCAST_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)
			castbar:RegisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)

			castbar.time = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(1))
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 1)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			if (unit == "player" or unit == "target" or unit == "focus") and (TukuiCF["castbar"].classcolor == true) then
				if (targetClass ~= nil) then
					castbar:SetStatusBarColor(unpack(castbarcolor[targetClass]))
				else
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"][unit]))
				end
			else
				if (unit == "player" or unit == "target" or unit == "focus") then
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"][unit]))
				else
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"].other))
				end
			end
		end	
			
			if db.cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetHeight(TukuiDB.Scale(26))
				castbar.button:SetWidth(TukuiDB.Scale(26))
				TukuiDB.SetTemplate(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("TOPLEFT", castbar.button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				castbar.icon:SetPoint("BOTTOMRIGHT", castbar.button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			
				if unit == "player" then
					castbar.button:SetPoint("LEFT", -46.5, 26.5)
				elseif unit == "target" then
					castbar.button:SetPoint("RIGHT", 46.5, 26.5)				
				end
			end
			
			-- cast bar latency on player
			if unit == "player" and db.cblatency == true then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(normTex)
				castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
				castbar.SafeZone = castbar.safezone
			end
					
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
		
		-- add combat feedback support
		if db.combatfeedback == true then
			local CombatFeedbackText 
			CombatFeedbackText = TukuiDB.SetFontString(health, font1, 12, "OUTLINE")
			CombatFeedbackText:SetPoint("CENTER", 0, 1)
			CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
			self.CombatFeedbackText = CombatFeedbackText
		end
		
		-- player aggro
		if db.playeraggro == true then
			table.insert(self.__elements, TukuiDB.UpdateThreat)
			self:RegisterEvent('PLAYER_TARGET_CHANGED', TukuiDB.UpdateThreat)
			-- self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', TukuiDB.UpdateThreat)
			-- self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', TukuiDB.UpdateThreat)
		end
		
		-- fixing vehicle/player frame when exiting an instance while on a vehicle
		self:RegisterEvent("UNIT_PET", TukuiDB.updateAllElements)
					
		-- set width and height of player and target
		self:SetAttribute('initial-width', TukuiDB.Scale(186))
		self:SetAttribute('initial-height', TukuiDB.Scale(32))			
	end
	
	------------------------------------------------------------------------
	--	Target of Target unit layout
	------------------------------------------------------------------------
	
	if (unit == "targettarget") then
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(18))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		health.value = TukuiDB.SetFontString(health, font1, 12)
		health.value:SetPoint("RIGHT", health, "RIGHT", TukuiDB.Scale(-3), 0)
		health.PostUpdate = TukuiDB.PostUpdateHealth
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true			
		end
		
		-- health border
		local healthborder = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(healthborder, 1, 1, "CENTER", health, "CENTER", 0, 0)
		healthborder:ClearAllPoints()
		healthborder:SetPoint("TOPLEFT", health, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		healthborder:SetPoint("BOTTOMRIGHT", health, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		healthborder:SetFrameStrata("MEDIUM")
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, TukuiDB.Scale(1))
		Name:SetFont(font1, 12)
		Name:SetJustifyH("CENTER")

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = Name
		
		if db.totdebuffs == true and TukuiDB.lowversion ~= true then
			local debuffs = CreateFrame("Frame", nil, health)
			debuffs:SetHeight(20)
			debuffs:SetWidth(127)
			debuffs.size = 20
			debuffs.spacing = 2
			debuffs.num = 6

			debuffs:SetPoint("TOPLEFT", health, "TOPLEFT", -0.5, 24)
			debuffs.initialAnchor = "TOPLEFT"
			debuffs["growth-y"] = "UP"
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
		
		-- width and height of target of target
		self:SetAttribute("initial-height", TukuiDB.Scale(18))
		self:SetAttribute("initial-width", TukuiDB.Scale(186))
	end
	
	------------------------------------------------------------------------
	--	Pet unit layout
	------------------------------------------------------------------------
	
	if (unit == "pet") then
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(14))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
				
		self.Health = health
		self.Health.bg = healthBG
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true	
			health.colorClass = true
			health.colorReaction = true	
			if TukuiDB.myclass == "HUNTER" then
				health.colorHappiness = true
			end
		end
		
		-- health border
		local healthborder = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(healthborder, 1, 1, "CENTER", health, "CENTER", 0, 0)
		healthborder:ClearAllPoints()
		healthborder:SetPoint("TOPLEFT", health, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		healthborder:SetPoint("BOTTOMRIGHT", health, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		healthborder:SetFrameStrata("MEDIUM")
		
		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(1))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if db.showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- power border
		local powerborder = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(powerborder, 1, 1, "CENTER", power, "CENTER", 0, 0)
		powerborder:ClearAllPoints()
		powerborder:SetPoint("TOPLEFT", power, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		powerborder:SetPoint("BOTTOMRIGHT", power, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		powerborder:SetFrameStrata("MEDIUM")
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", self, "CENTER", 0, TukuiDB.Scale(1))
		Name:SetFont(font1, 12)
		Name:SetJustifyH("CENTER")

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]')
		self.Name = Name
		
		-- update pet name, this should fix "UNKNOWN" pet names on pet unit.
		self:RegisterEvent("UNIT_PET", TukuiDB.UpdatePetInfo)
		
		-- width and height of pet
		self:SetAttribute("initial-height", TukuiDB.Scale(18))
		self:SetAttribute("initial-width", TukuiDB.Scale(186))
	end


	------------------------------------------------------------------------
	--	Focus unit layout
	------------------------------------------------------------------------
	
	if (unit == "focus") then
		-- create health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetPoint("TOPLEFT")
		health:SetPoint("BOTTOMRIGHT")
		health:SetStatusBarTexture(normTex)
		--health:GetStatusBarTexture():SetHorizTile(false)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		health.value = TukuiDB.SetFontString(health, font1, 12)
		health.value:SetPoint("RIGHT", health, "RIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(1))
		health.PostUpdate = TukuiDB.PostUpdateHealth
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("LEFT", health, "LEFT", TukuiDB.Scale(4), TukuiDB.Scale(1))
		Name:SetJustifyH("LEFT")
		Name:SetFont(font1, 12)
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]')
		self.Name = Name
		
		self:SetAttribute("initial-height", TukuiInfoRight:GetHeight() - TukuiDB.Scale(4))
		self:SetAttribute("initial-width", TukuiInfoRight:GetWidth() - TukuiDB.Scale(4))

		-- create focus debuff feature
		if db.focusdebuffs == true then
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs:SetHeight(26)
			debuffs:SetWidth(TukuiCF["panels"].tinfowidth - 10)
			debuffs.size = 26
			debuffs.spacing = 2
			debuffs.num = 40
						
			debuffs:SetPoint("TOPRIGHT", self, "TOPRIGHT", 2, 38)
			debuffs.initialAnchor = "TOPRIGHT"
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Debuffs = debuffs
		end
		
		-- focus cast bar in the center of the screen
		if db.unitcastbar == true then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetHeight(TukuiInfoRight:GetHeight() - 4)
			castbar:SetWidth(TukuiInfoRight:GetWidth() - 4)
			castbar:SetStatusBarTexture(normTex)
			castbar:SetFrameStrata("HIGH")
			castbar:SetFrameLevel(10)
			castbar:SetPoint("CENTER", TukuiInfoRight, "CENTER", 0, 0)		
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			TukuiDB.SetTemplate(castbar.bg)
			castbar.bg:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
			castbar.bg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))
			castbar.bg:SetFrameLevel(5)
			
			castbar.time = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", TukuiDB.Scale(-4), TukuiDB.Scale(1))
			castbar.time:SetTextColor(0.84, 0.75, 0.65)
			castbar.time:SetJustifyH("RIGHT")
			castbar.CustomTimeText = CustomCastTimeText

			castbar.Text = TukuiDB.SetFontString(castbar, font1, 12)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", 4, 1)
			castbar.Text:SetTextColor(0.84, 0.75, 0.65)
			
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.CheckCast
			castbar.PostChannelStart = TukuiDB.CheckChannel
			
			if (unit == "player" or unit == "target" or unit == "focus") and (TukuiCF["castbar"].classcolor == true) then
				if (targetClass ~= nil) then
					castbar:SetStatusBarColor(unpack(castbarcolor[targetClass]))
				else
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"][unit]))
				end
			else
				if (unit == "player" or unit == "target" or unit == "focus") then
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"][unit]))
				else
					castbar:SetStatusBarColor(unpack(TukuiCF["castbar"]["color"].other))
				end
			end
			
			if db.cbicons == true then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetHeight(TukuiDB.Scale(40))
				castbar.button:SetWidth(TukuiDB.Scale(40))
				castbar.button:SetPoint("CENTER", 0, TukuiDB.Scale(50))
				TukuiDB.SetTemplate(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("TOPLEFT", castbar.button, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				castbar.icon:SetPoint("BOTTOMRIGHT", castbar.button, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			end

			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
	end
	
	------------------------------------------------------------------------
	--	Focus target unit layout
	------------------------------------------------------------------------

	-- not done lol?
	if (unit == "focustarget") then
		-- create panel if higher version
		local panel = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(panel, 129, 17, "BOTTOM", self, "BOTTOM", 0, TukuiDB.Scale(0))
		panel:SetFrameLevel(2)
		panel:SetFrameStrata("MEDIUM")
		panel:SetBackdropBorderColor(unpack(TukuiCF["media"].altbordercolor))
		self.panel = panel
		
		-- health bar
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(18))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
		
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true			
		end
		
		-- Unit name
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", panel, "CENTER", 0, TukuiDB.Scale(1))
		Name:SetFont(font1, 12)
		Name:SetJustifyH("CENTER")

		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]')
		self.Name = Name
		
		-- width and height of target of target
		self:SetAttribute("initial-height", TukuiDB.Scale(36))
		self:SetAttribute("initial-width", TukuiDB.Scale(129))
	end

	------------------------------------------------------------------------
	--	Arena or boss units layout (both mirror'd)
	------------------------------------------------------------------------
	
	if (unit and unit:find("arena%d") and TukuiCF["arena"].unitframes == true) or (unit and unit:find("boss%d") and db.showboss == true) then
		-- Right-click focus on arena or boss units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(22))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)

		health.frequentUpdates = true
		health.colorDisconnected = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		health.colorClass = true
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)

		health.value = TukuiDB.SetFontString(health, font1,12, "OUTLINE")
		health.value:SetPoint("LEFT", TukuiDB.Scale(2), TukuiDB.Scale(1))
		health.PostUpdate = TukuiDB.PostUpdateHealth
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)		
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
	
		-- power
		local power = CreateFrame('StatusBar', nil, self)
		power:SetHeight(TukuiDB.Scale(6))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(normTex)
		
		power.frequentUpdates = true
		power.colorPower = true
		if db.showsmooth == true then
			power.Smooth = true
		end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(normTex)
		powerBG.multiplier = 0.3
		
		power.value = TukuiDB.SetFontString(health, font1, 12, "OUTLINE")
		power.value:SetPoint("RIGHT", TukuiDB.Scale(-2), TukuiDB.Scale(1))
		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
				
		self.Power = power
		self.Power.bg = powerBG
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, TukuiDB.Scale(1))
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, '[Tukui:getnamecolor][Tukui:namelong]')
		self.Name = Name
		
		-- create buff at left of unit if they are boss units
		if (unit and unit:find("boss%d")) then
			local buffs = CreateFrame("Frame", nil, self)
			buffs:SetHeight(26)
			buffs:SetWidth(252)
			buffs:SetPoint("RIGHT", self, "LEFT", TukuiDB.Scale(-4), 0)
			buffs.size = 26
			buffs.num = 3
			buffs.spacing = 2
			buffs.initialAnchor = 'RIGHT'
			buffs["growth-x"] = "LEFT"
			buffs.PostCreateIcon = TukuiDB.PostCreateAura
			buffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			self.Buffs = buffs
		end

		-- create debuff for both arena and boss units
		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:SetPoint('LEFT', self, 'RIGHT', TukuiDB.Scale(4), 0)
		debuffs.size = 26
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = 'LEFT'
		debuffs["growth-x"] = "LEFT"
		debuffs.PostCreateIcon = TukuiDB.PostCreateAura
		debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
		debuffs.onlyShowPlayer = db.playerdebuffsonly
		self.Debuffs = debuffs	
		
		
		if (unit and unit:find("arena%d")) or (unit and unit:find("boss%d")) then
			if (unit and unit:find("boss%d")) then
				self.Buffs:SetPoint("RIGHT", self, "LEFT", -4, 0)
				self.Buffs.num = 3
				self.Buffs.numBuffs = 3
				self.Buffs.initialAnchor = "RIGHT"
				self.Buffs["growth-x"] = "LEFT"
			end
			self.Debuffs.num = 5
			self.Debuffs.size = 26
			self.Debuffs:SetPoint('LEFT', self, 'RIGHT', 4, 0)
			self.Debuffs.initialAnchor = "LEFT"
			self.Debuffs["growth-x"] = "RIGHT"
			self.Debuffs["growth-y"] = "DOWN"
			self.Debuffs:SetHeight(26)
			self.Debuffs:SetWidth(200)
			self.Debuffs.onlyShowPlayer = db.playerdebuffsonly
		end	
		
		-- trinket feature via trinket plugin
		if not IsAddOnLoaded("Gladius") then
			if (unit and unit:find('arena%d')) then
				local Trinketbg = CreateFrame("Frame", nil, self)
				Trinketbg:SetHeight(26)
				Trinketbg:SetWidth(26)
				Trinketbg:SetPoint("RIGHT", self, "LEFT", -6, 0)				
				TukuiDB.SetTemplate(Trinketbg)
				Trinketbg:SetFrameLevel(0)
				self.Trinketbg = Trinketbg
				
				local Trinket = CreateFrame("Frame", nil, Trinketbg)
				Trinket:SetAllPoints(Trinketbg)
				Trinket:SetPoint("TOPLEFT", Trinketbg, TukuiDB.Scale(2), TukuiDB.Scale(-2))
				Trinket:SetPoint("BOTTOMRIGHT", Trinketbg, TukuiDB.Scale(-2), TukuiDB.Scale(2))
				Trinket:SetFrameLevel(1)
				Trinket.trinketUseAnnounce = true
				self.Trinket = Trinket
			end
		end
		
		self:SetAttribute("initial-height", TukuiDB.Scale(29))
		self:SetAttribute("initial-width", TukuiDB.Scale(200))
	end

	------------------------------------------------------------------------
	--	Main tanks and Main Assists layout (both mirror'd)
	------------------------------------------------------------------------
	
	if(self:GetParent():GetName():match"oUF_MainTank" or self:GetParent():GetName():match"oUF_MainAssist") then
		-- Right-click focus on maintank or mainassist units
		self:SetAttribute("type2", "focus")
		
		-- health 
		local health = CreateFrame('StatusBar', nil, self)
		health:SetHeight(TukuiDB.Scale(20))
		health:SetPoint("TOPLEFT")
		health:SetPoint("TOPRIGHT")
		health:SetStatusBarTexture(normTex)
		
		local healthBG = health:CreateTexture(nil, 'BORDER')
		healthBG:SetAllPoints()
		healthBG:SetTexture(.1, .1, .1)
				
		self.Health = health
		self.Health.bg = healthBG
		
		health.frequentUpdates = true
		if db.showsmooth == true then
			health.Smooth = true
		end
		
		if db.unicolor == true then
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.250, .250, .250, 1)
			healthBG:SetVertexColor(.1, .1, .1, 1)
		else
			health.colorDisconnected = true
			health.colorClass = true
			health.colorReaction = true	
		end
		
		-- names
		local Name = health:CreateFontString(nil, "OVERLAY")
		Name:SetPoint("CENTER", health, "CENTER", 0, TukuiDB.Scale(1))
		Name:SetJustifyH("CENTER")
		Name:SetFont(font1, 12, "OUTLINE")
		Name:SetShadowColor(0, 0, 0)
		Name:SetShadowOffset(1.25, -1.25)
		
		self:Tag(Name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = Name
			
		self:SetAttribute("initial-height", TukuiDB.Scale(20))
		self:SetAttribute("initial-width", TukuiDB.Scale(100))	
	end

	------------------------------------------------------------------------
	--	Features we want for all units at the same time
	------------------------------------------------------------------------
	
	-- here we create an invisible frame for all element we want to show over health/power.
	-- because we can only use self here, and self is under all elements.
	local InvFrame = CreateFrame("Frame", nil, self)
	InvFrame:SetFrameStrata("HIGH")
	InvFrame:SetFrameLevel(5)
	InvFrame:SetAllPoints()
	
	-- symbols, now put the symbol on the frame we created above.
	local RaidIcon = InvFrame:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\raidicons.blp") -- thx hankthetank for texture
	RaidIcon:SetHeight(20)
	RaidIcon:SetWidth(20)
	RaidIcon:SetPoint("TOP", 0, 8)
	self.RaidIcon = RaidIcon
	
	return self
end

------------------------------------------------------------------------
--	Default position of Tukui unitframes
------------------------------------------------------------------------

-- for lower reso
local adjustXY = 0
local totdebuffs = 0
if TukuiDB.lowversion then adjustXY = 24 end
if db.totdebuffs then totdebuffs = 24 end

oUF:RegisterStyle('Tukz', Shared)

oUF:SetActiveStyle('Tukz')
oUF:Spawn('player', "oUF_Tukz_player"):SetPoint("BOTTOMLEFT", TukuiActionBarBackground, "TOPLEFT", -2, 39)
oUF:Spawn('focus', "oUF_Tukz_focus"):SetPoint("CENTER", TukuiInfoRight, "CENTER")
oUF:Spawn('target', "oUF_Tukz_target"):SetPoint("BOTTOMRIGHT", TukuiActionBarBackground, "TOPRIGHT", 2, 39)
oUF:Spawn("targettarget", "oUF_Tukz_targettarget"):SetPoint("TOP", oUF_Tukz_target, "BOTTOM", 0,-8)
oUF:Spawn("pet", "oUF_Tukz_pet"):SetPoint("TOP", oUF_Tukz_player, "BOTTOM", 0,-8)
if db.showfocustarget == true then oUF:Spawn("focustarget", "oUF_Tukz_focustarget"):SetPoint("BOTTOM", 0, 224) end

if TukuiCF.arena.unitframes then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			arena[i]:SetPoint("BOTTOM", UIParent, "BOTTOM", 252, 260)
		else
			arena[i]:SetPoint("BOTTOM", arena[i-1], "TOP", 0, 10)
		end
	end
end

-- if db.showboss then
-- 	for i = 1,MAX_BOSS_FRAMES do
-- 		local t_boss = _G["Boss"..i.."TargetFrame"]
-- 		t_boss:UnregisterAllEvents()
-- 		t_boss.Show = TukuiDB.dummy
-- 		t_boss:Hide()
-- 		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
-- 		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
-- 	end

-- 	local boss = {}
-- 	for i = 1, MAX_BOSS_FRAMES do
-- 		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
-- 		if i == 1 then
-- 			boss[i]:SetPoint("BOTTOM", UIParent, "BOTTOM", 252, 260)
-- 		else
-- 			boss[i]:SetPoint('BOTTOM', boss[i-1], 'TOP', 0, 10)             
-- 		end
-- 	end
-- end

if db.maintank == true then
	local tank = oUF:SpawnHeader("oUF_MainTank", nil, 'raid, party, solo', 
		"showRaid", true, "groupFilter", "MAINTANK", "yOffset", 5, "point" , "BOTTOM",
		"template", "oUF_tukzMtt"
	)
	tank:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
end

if db.mainassist == true then
	local assist = oUF:SpawnHeader("oUF_MainAssist", nil, 'raid, party, solo', 
		"showRaid", true, "groupFilter", "MAINASSIST", "yOffset", 5, "point" , "BOTTOM",
		"template", "oUF_tukzMtt"
	)
	assist:SetPoint("CENTER", UIParent, "CENTER", 0, -100)
end

local party = oUF:SpawnHeader("oUF_noParty", nil, "party", "showParty", true)

------------------------------------------------------------------------
--	Just a command to test buffs/debuffs alignment
------------------------------------------------------------------------

local testui = TestUI or function() end
TestUI = function()
	testui()
	UnitAura = function()
		-- name, rank, texture, count, dtype, duration, timeLeft, caster
		return 'penancelol', 'Rank 2', 'Interface\\Icons\\Spell_Holy_Penance', random(5), 'Magic', 0, 0, "player"
	end
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if(v.UNIT_AURA) then
				v:UNIT_AURA("UNIT_AURA", v.unit)
			end
		end
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"

------------------------------------------------------------------------
-- Right-Click on unit frames menu. 
-- Doing this to remove SET_FOCUS eveywhere.
-- SET_FOCUS work only on default unitframes.
-- Main Tank and Main Assist, use /maintank and /mainassist commands.
------------------------------------------------------------------------

-- do
-- 	UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "LEAVE", "CANCEL" };
-- 	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
-- 	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
-- 	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
-- 	UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
-- 	UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" }
-- 	UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" }
-- 	UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" }
-- 	UnitPopupMenus["ARENAENEMY"] = { "CANCEL" }
-- 	UnitPopupMenus["FOCUS"] = { "RAID_TARGET_ICON", "CANCEL" }
-- 	UnitPopupMenus["BOSS"] = { "RAID_TARGET_ICON", "CANCEL" }
-- end

do
	-- TBC VALUES!
	UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "LEAVE", "CANCEL" };
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "LOOT_PROMOTE", "UNINVITE", "INSPECT", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
	UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" };
	UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" };
	UnitPopupMenus["FRIEND"] = { "WHISPER", "INVITE", "TARGET", "IGNORE", "REPORT_SPAM", "GUILD_PROMOTE", "GUILD_LEAVE", "CANCEL" };
	UnitPopupMenus["TEAM"] = { "WHISPER", "INVITE", "TARGET", "TEAM_PROMOTE", "TEAM_KICK", "TEAM_LEAVE", "CANCEL" };
	UnitPopupMenus["RAID_TARGET_ICON"] = { "RAID_TARGET_1", "RAID_TARGET_2", "RAID_TARGET_3", "RAID_TARGET_4", "RAID_TARGET_5", "RAID_TARGET_6", "RAID_TARGET_7", "RAID_TARGET_8", "RAID_TARGET_NONE" };
	UnitPopupMenus["CHAT_ROSTER"] = { "WHISPER", "TARGET", "MUTE", "UNMUTE", "CHAT_SILENCE", "CHAT_UNSILENCE", "CHAT_PROMOTE", "CHAT_DEMOTE", "CHAT_OWNER", "CANCEL"  };
end