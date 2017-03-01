-- Level
if not TukuiCF["datatext"].level == nil or TukuiCF["datatext"].level > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].level, Text)
   
	local int = 1

	local function Update(self, t)
	  int = int - t
	  if int < 0 then
		Text:SetText(hexa.."Level: "..hexb..UnitLevel("player"))
		int = 1
	  end     
	end

	Stat:RegisterEvent("PLAYER_LEVEL_UP")
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end

-- Spell Penetration
if TukuiCF["datatext"].spellpen and TukuiCF["datatext"].spellpen > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "LOW")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].spellpen, Text)
   
	local int = 1

	local function Update(self, t)
	  int = int - t
	  if int < 0 then
		Text:SetText(GetSpellPenetration()..hexa.." Spell Pen"..hexb)
		int = 1
	  end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end

-- Zone Text
if not TukuiCF["datatext"].zone == nil or TukuiCF["datatext"].zone > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].zone, Text)
   
	local int = 1

	local function Update(self, t)
	  int = int - t
	  if int < 0 then
		 if GetMinimapZoneText() == "Putricide's Laboratory of Alchemical Horrors and Fun" then
			Text:SetText(hexa.."Putricides's Laboratory"..hexb)
		 else
			Text:SetText(hexa..GetMinimapZoneText()..hexb)
		 end
		 int = 1
	  end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end

-- Player Honor
if not TukuiCF["datatext"].honor == nil or TukuiCF["datatext"].honor > 0 then
   local Stat = CreateFrame("Frame")

   local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
   Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
   TukuiDB.PP(TukuiCF["datatext"].honor, Text)
       
   local int = 1

   local function Update(self, t)
     int = int - t
     if int < 0 then
       Text:SetText(GetHonorCurrency().." "..hexa.."Honor"..hexb)
       int = 1
     end     
   end
   
   Stat:RegisterEvent("HONOR_CURRENCY_UPDATE")
   Stat:SetScript("OnUpdate", Update)
   Update(Stat, 10)
end

-- PVP Lifetime Kills
if not TukuiCF["datatext"].kills == nil or TukuiCF["datatext"].kills > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].kills, Text)
   
	local int = 1

	local function Update(self, t)
	  int = int - t
	  if int < 0 then
		 Text:SetText(GetPVPLifetimeStats().." "..hexa.."Kills"..hexb)
		 int = 1
	  end     
	end

	Stat:RegisterEvent("PLAYER_PVP_KILLS_CHANGED")
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
	
end

-- Player Hit Rating
if not TukuiCF["datatext"].hit == nil or TukuiCF["datatext"].hit > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].hit, Text)
    
	local int = 1

	local function Update(self, t)
	int = int - t
	local base, posBuff, negBuff = UnitAttackPower("player");
	local effective = base + posBuff + negBuff;
	local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player");
	local Reffective = Rbase + RposBuff + RnegBuff;

	Rattackpwr = Reffective
	spellpwr = GetSpellBonusDamage(7)
	attackpwr = effective

	if int < 0 then
			if attackpwr > spellpwr and select(2, UnitClass("Player")) ~= "HUNTER" then
				Text:SetText(format("%.2f", GetCombatRatingBonus(6)).."%"..hexa.." Hit"..hexb)
			elseif select(2, UnitClass("Player")) == "HUNTER" then
				Text:SetText(format("%.2f", GetCombatRatingBonus(7)).."%"..hexa.." Hit"..hexb)
			else
				Text:SetText(format("%.2f", GetCombatRatingBonus(8)).."%"..hexa.." Hit"..hexb)
			end
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end