if TukuiCF["duels"].ignore == true then
	local duel = CreateFrame("frame")
	duel:RegisterEvent("DUEL_REQUESTED")
	duel:SetScript("OnEvent", function(self, event)
		if (event == "DUEL_REQUESTED") then
			CancelDuel()
			ChatFrame1:AddMessage("Duel auto-declined.", 0, .8, 1)
		end
	end)
end