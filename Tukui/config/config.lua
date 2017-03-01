TukuiCF["general"] = {
	["autoscale"] = false,                  -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.71,                    -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,         -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = true,         -- i don't recommend this because of shitty border but, voila!
}

TukuiCF["unitframes"] = {
	-- general options
	["enable"] = true,                     -- do i really need to explain this?
	["enemyhcolor"] = false,               -- enemy target (players) color by hostility, very useful for healer.
	["unitcastbar"] = true,                -- enable tukui castbar
	["cblatency"] = false,                 -- enable castbar latency
	["cbicons"] = false,                   -- enable icons on castbar
	["auratimer"] = true,                  -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = true,               -- enable auras
	["targetauras"] = true,                -- enable auras on target unit frame
	["highThreshold"] = 80,                -- hunter high threshold
	["lowThreshold"] = 20,                 -- global low threshold, for low mana warning.
	["targetpowerpvponly"] = false,        -- enable power text on pvp target only
	["totdebuffs"] = true,                -- enable tot debuffs (high reso only)
	["focusdebuffs"] = false,              -- enable focus debuffs 
	["showfocustarget"] = false,           -- show focus target
	["showtotalhpmp"] = true,             -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                 -- enable smooth bar
	["showthreat"] = false,                -- enable the threat bar anchored to info left panel.
	["charportrait"] = false,               -- do i really need to explain this?
	["maintank"] = false,                  -- enable maintank
	["mainassist"] = false,                -- enable mainassist
	["unicolor"] = true,                  -- enable unicolor theme
	["combatfeedback"] = false,            -- enable combattext on player and target.
	["playeraggro"] = false,               -- color player border to red if you have aggro on current target.
	["positionbychar"] = true,             -- save X, Y position with /uf (movable frame) per character instead of per account.
	["disbaleReverseCircle"] = true,	   -- decides if the cooldown circle goes from black to white or white to black

	-- weapon enchant
	["weaponenchants"] = true,				-- Enables weapon enchant icons.
	
	-- raid layout
	["showrange"] = true,                  -- show range opacity on raidframes
	["healcomm"] = false,                  -- enable healcomm4 support on healer layout.
	["raidalphaoor"] = 0.5,                -- alpha of unitframes when unit is out of range
	["gridonly"] = true,                   -- enable grid only mode for all healer mode raid layout.
	["showsymbols"] = true,	               -- show symbol.
	["aggro"] = false,                      -- show aggro on all raids layouts
	["raidunitdebuffwatch"] = true,        -- track important spell to watch in pve for grid mode.
	["gridhealthvertical"] = true,         -- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = true,          -- show my player frame in party
	["gridscale"] = 1,                     -- set the healing grid scaling
	
	-- boss frames
	["showboss"] = false,                   -- enable boss unit frames for PVELOL encounters.

	-- priest only plugin
	["ws_show_time"] = false,              -- show time on weakened soul bar
	["ws_show_player"] = false,            -- show weakened soul bar on player unit
	["ws_show_target"] = false,            -- show weakened soul bar on target unit
	
	-- death knight only plugin
	["runebar"] = true,                    -- enable tukui runebar plugin

	-- rogue only plugin
	["combopoints"] = true,                -- combo points plugin
	
	-- shaman only plugin
	["totemtimer"] = true,                 -- enable tukui totem timer plugin

	--
}

TukuiCF["arena"] = {
	["unitframes"] = true,                 -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
	["spelltracker"] = true,               -- enable tukz enemy spell tracker (an afflicted3 or interruptbar alternative)
}

TukuiCF["actionbar"] = {
	["enable"] = true,                     -- enable tukz action bars
	["hotkey"] = true,                     -- enable hotkey display because it was a lot requested
	["rightbarmouseover"] = false,         -- enable right bars on mouse over
	["shapeshiftmouseover"] = false,       -- enable shapeshift or totembar on mouseover
	["hideshapeshift"] = false,            -- hide shapeshift or totembar because it was a lot requested.
	["bottomrows"] = 2,                    -- numbers of row you want to show at the bottom (select between 1 and 2 only)
	["rightbars"] = 2,                     -- numbers of right bar you want
	["showgrid"] = true,                   -- show grid on empty button
}

TukuiCF["nameplate"] = {
	["enable"] = true,                     -- enable nice skinned nameplates that fit into tukui
}

TukuiCF["bags"] = {
	["enable"] = true,                     -- enable an all in one bag mod that fit tukui perfectly
	["soulbag"] = true,                    -- show warlock soulbag slot on bag.
}

TukuiCF["map"] = {
	["enable"] = true,                     -- reskin the map to fit tukui
}

TukuiCF["loot"] = {
	["lootframe"] = true,                  -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,              -- reskin the roll frame to fit tukui
	["autogreed"] = false,                  -- auto-dez or auto-greed item at max level.
}

TukuiCF["cooldown"] = {
	["enable"] = true,                     -- do i really need to explain this?
	["treshold"] = 8,                      -- show decimal under X seconds and text turn red
}

TukuiCF["datatext"] = {
	["fps_ms"] = 0,                        -- show fps and ms on panels
	["mem"] = 0,                           -- show total memory on panels
	["bags"] = 7,                          -- show space used in bags on panels
	["gold"] = 9,                          -- show your current gold on panels
	["wowtime"] = 4,                       -- show time on panels
	["guild"] = 6,                         -- show number on guildmate connected on panels
	["dur"] = 3,                           -- show your equipment durability on panels.
	["friends"] = 5,                       -- show number of friends connected.
	["dps_text"] = 0,                      -- show a dps meter on panels
	["hps_text"] = 0,                      -- show a heal meter on panels
	["power"] = 1,                         -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["arp"] = 0,                           -- show your armor penetration rating on panels.
	["haste"] = 0,                         -- show your haste rating on panels.
	["crit"] = 2,                          -- show your crit rating on panels.
	["avd"] = 0,                           -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,						-- show your armor value against the level mob you are currently targeting

	-- Hydra Extras
	["honor"] = 0, 						   -- show the current amount of honor earned.
	["kills"] = 0,                         -- show lifetime honorable kills.
	["zone"] = 8,                          -- show current player zone text.
	["level"] = 0,                         -- don't ask
	["spellpen"] = 0,                      -- show spell penetration
	["hit"] = 0,                           -- show player hit rating.

	-- Color Datatext
	["classcolor"] = true,                 -- classcolored datatexts
	["color"] = "|cff00AAFF",              -- datatext color if classcolor = false (|cffFFFFFF = white)	
	
	["battleground"] = true,               -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = true,                    -- set time to 24h format.
	["localtime"] = false,                 -- set time to local time instead of server time.
	["fontsize"] = 14,                     -- font size for panels.
}

TukuiCF["castbar"] = {
	["classcolor"] = true, 				   -- enable classcolored castbars
	["color"] =  {                         -- if classcolor is false, use these colors
		player = { 0.3, 0.3, 0.3, 1 },     -- Color of player castbar
		target = { 0.3, 0.3, 0.3, 1 },     -- Color of target castbar
		focus =  { 0.3, 0.3, 0.3, 1 },     -- Color of focus castbar
		other =  { 0.3, 0.3, 0.3, 1 },     -- Color of other castbars
	},
}

TukuiCF["chat"] = {
	["enable"] = true,                     -- blah
	["whispersound"] = true,               -- play a sound when receiving whisper
}

TukuiCF["tooltip"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	["hidecombat"] = false,                -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,               -- always hide action bar buttons tooltip.
	["hideuf"] = false,                    -- hide tooltip on unitframes
	["cursor"] = false,                    -- tooltip via cursor only
}

TukuiCF["merchant"] = {
	["sellgrays"] = true,                  -- automaticly sell grays?
	["autorepair"] = true,                 -- automaticly repair?
}

TukuiCF["error"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	filter = {                             -- what messages to not hide
		["Inventory is full."] = true,     -- inventory is full will not be hidden by default
	},
}

TukuiCF["invite"] = { 
	["autoaccept"] = false,                 -- auto-accept invite from guildmate and friends.
}

TukuiCF["watchframe"] = { 
	["movable"] = true,                    -- disable this if you run "Who Framed Watcher Wabbit" from seerah.
}

TukuiCF["buffreminder"] = {
	["enable"] = true,                     -- this is now the new innerfire warning script for all armor/aspect class.
	["sound"] = true,                      -- enable warning sound notification for reminder.
}

TukuiCF["others"] = {
	["pvpautorelease"] = true,             -- enable auto-release in bg or wintergrasp. (not working for shaman, sorry)
}

TukuiCF["duels"] = {
	["ignore"] = false,                    -- Auto decline duels
}

TukuiCF["menu"] = { 					   -- In-game toggle menu
	["enable"] = true,                     -- Enable menu
	["bordercolor"] = { 0,.8,1,1 },        -- Panel border color on mouse over
	["ButtonWidth"] = 100,                 -- Width of menu buttons
	["ButtonHeight"] = 20,                 -- Height of menu buttons
	["FontSize"] = 12,                     -- Size of menu font
}

----------------------------
-- Custom config for Hydra
----------------------------

if realm == "Spirestone" and locale == "enUS" and reso == "1280x1024" then
	if user == "Ukahh" and class == "ROGUE" then
		TukuiCF["actionbar"].rightbars = 0
		TukuiCF["datatext"].classcolor = false
	end

	if user == "Sertraline" and class == "PRIEST" then
		TukuiCF["datatext"].classcolor = false
		TukuiCF["datatext"].dur = 0
		TukuiCF["datatext"].wowtime = 6
		TukuiCF["datatext"].guild = 5
		TukuiCF["datatext"].friends = 0
		TukuiCF["datatext"].hit = 4
		TukuiCF["datatext"].spellpen = 3
	end

	if user == "Hydrazine" and class == "ROGUE" or user == "Dioxin" and class == "SHAMAN" or user == "Sertraline" and class == "PRIEST" then
		TukuiCF["unitframes"].gridscale = 1.3
		TukuiCF["duels"].ignore = true
	end

	if user == "Hydrazine" and class == "ROGUE" then
		TukuiCF["datatext"].classcolor = false
		TukuiCF["datatext"].kills = 0
		TukuiCF["datatext"].honor = 0
		TukuiCF["datatext"].gold = 9
		TukuiCF["datatext"].arp = 7
	end
	
	if user == "Dioxyde" and class == "PRIEST" then
		TukuiCF["datatext"].classcolor = false
		TukuiCF["datatext"].wowtime = 0
		TukuiCF["datatext"].level = 4
		TukuiCF["buffreminder"].enable = false
	end
end