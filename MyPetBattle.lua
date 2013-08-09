-----------------
-- MyPetBattle --
-----------------
MyPetBattle = {}
---------------
---- SETUP ----
---------------

-- INITIALIZATION -
mypetbattle_enabled = false
mypetbattle_join_pvp = false
mypetbattle_auto_forfeit = false
mypetbattle_wintrade_enabled = false

MPB_STATS_TABLE = {}

--[
MyPetBattleState = {}

--[[
Notes: 
The _AGAIN states are repeated by the one second loop. They are started from the immediate one-time state of the same name.
The flags cover a range of states.
--]]

MyPetBattleState.SET_TEAM_START                     = 200   -- begin setting team
    MyPetBattleState.FLAG_SET_TEAM_IN_PROGRESS      = false
        MyPetBattleState.TRANSFER_PET_LIST          = 201   -- send/receive pet list        :   send our pet list first time
        MyPetBattleState.TRANSFER_PET_LIST_AGAIN    = 202   -- send/receive pet list        :   send our pet list every second
        MyPetBattleState.RECIEVED_PET_LIST          = 203   -- received pet list            :   send pet list with acknowledge first time
        MyPetBattleState.RECIEVED_PET_LIST_AGAIN    = 204   -- received pet list            :   send pet list with acknowledge every second
        MyPetBattleState.RECIEVED_PET_LIST_ACK      = 205   -- received pet list with ack   :   time to set the team
        MyPetBattleState.SET_TEAM                   = 206   -- finish setting team          :   set the team
        MyPetBattleState.SET_TEAM_IN_PROGRESS       = 207
        MyPetBattleState.SET_TEAM_AGAIN             = 208   -- retry setting team           :   this may occur once during login if it's too early to set the team
    MyPetBattleState.SET_TEAM_DONE                  = 209

MyPetBattleState.BATTLE_OPENED                      = 400   -- battle opened                :   set at PET_BATTLE_OPENING_DONE
    MyPetBattleState.FLAG_BATTLE_IN_PROGRESS        = false
        MyPetBattleState.BATTLE_IN_PROGRESS         = 500   -- check forfeit                :   during this time, forfeit may occur - go to battle close state
            MyPetBattleState.FLAG_ALLOW_FORFEIT     = false
        MyPetBattleState.BATTLE_FORFEIT_DONE        = 501   -- forfeit timer gone           :   do nothing
        MyPetBattleState.BATTLE_CLOSED              = 600   -- battle closed                :   set at PET_BATTLE_CLOSE
        MyPetBattleState.BATTLE_CLOSED_IN_PROGRESS  = 601   --                              :   wait 5 seconds after closing
    MyPetBattleState.BATTLE_CLOSED_DONE             = 602   -- battle closed 2              :   do nothing

MyPetBattleVars = {}
MyPetBattleVars.state = MyPetBattleState.SET_TEAM_START
local MPB_onUpdate

function MyPetBattle.setState(state, immediate)
	if mypetbattle_debug then print("|cffff8000MPB|r: MyPetBattle.setState", state, immediate, self) end
	if not state then
		print("|cffff8000MPB|r: invalid state")
	else
		MyPetBattleVars.state = state
		if immediate then
			MPB_onUpdate(self,0)
		end
	end
end
--]

RegisterAddonMessagePrefix("MPB")

--------------------
---- SETUP DONE ----
--------------------

name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, currentPetID)

---------------------
-- EVENTS HANDLING --
---------------------
local mypetbattle_frame, events = CreateFrame("Frame"), {};


--------------------------------------------------------
-- LOAD A LOT OF STUFF WHEN THE ADDON HAS BEEN LOADED --
function events:ADDON_LOADED(...)
--	print("ADDON_LOADED")
	local addonName = ...
	if addonName == "MyPetBattle" then
		---------------------------------------------------------------
		-- SET SAVEDVARIABLES TO DEFAULT VALUES IF THEY DO NOT EXIST --
		-- TEAM SETUP OPTIONS
		if MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD == nil then
			MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD = 0.80
		end
		
		if MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT == nil then
			MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT = -2
		end
		
		if MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT == nil then
			MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT = -2
		end
		
		if MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT == nil then
			MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT = 2
		end
		
		-- PRE-COMBAT OPTIONS
		if MPB_CONFIG_PRE_COMBAT_ATTEMPT_STRONGEST_RANDOM_TEAM == nil then
			MPB_CONFIG_PRE_COMBAT_ATTEMPT_STRONGEST_RANDOM_TEAM = false
		end
		
		-- COMBAT OPTIONS
		if MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD == nil then
			MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD = 0.35
		end
		
		-- POST-COMBAT OPTIONS
		if MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT == nil then
			MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT = false
		end

		if not MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT == nil then
			MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT = false
		end

		if not MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT == nil then
			MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT = false
		end

		-- MISC OPTIONS
		if MPB_CONFIG_MISC_AUTOMATIC_RELEASE_NON_RARES == nil then
			MPB_CONFIG_MISC_AUTOMATIC_RELEASE_NON_RARES = false
		end		

		-- CAPTURE PETS OPTIONS
		if MPB_CAPTURE_RARES == nil then
			MPB_CAPTURE_RARES = false
		end

		if MPB_CAPTURE_COMMON_UNCOMMON == nil then
			MPB_CAPTURE_COMMON_UNCOMMON = false
		end
		-- TEAM PET LEVEL
		if MPB_EDITBOX_DESIRED_PET_LEVEL == nil then
			MPB_EDITBOX_DESIRED_PET_LEVEL = 1
		end
		-- FORFEIT TIMER
		if MPB_FORFEIT_TIMER == nil then
			MPB_FORFEIT_TIMER = 55
		end

		if MPB == nil then
			MPB = {}
		end
		
		if MPB.USE_NON_RARE == nil then
			-- Set this to true if you want to allow using non-rare pets. Higher quality pets are still given priority for the same level.
			MPB.USE_NON_RARE = false
		end
		
		if MPB.PRIORITIZE_LEVEL == nil then
			-- Set this to true if you want pets to be chosen first by rarity and second by level (within the selected allowable level range), instead of first by level and second by rarity.
			MPB.PRIORITIZE_LEVEL = false
		end
		
		if MPB.RANDOMIZE == nil then
			-- Set this to true if you want pets to be chosen randomly instead of name.
			MPB.RANDOMIZE = false
		end
		
		if MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL == nil then
			 -- This is a number between 0 and 9. The addon won't choose a pet of a level if you plan to win (are not forfeiting) if you only have this number of pets of that level.
			 -- 0 means you don't care about keeping pets at each level. However, if you don't have pets at a level, then you can't win-trade with a player that only has pets at that level.
			MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL = 0
		end
		
		if MPB.EQUIP_SAFARI_HAT == nil then
			 -- If this is enabled, then the Safari Hat is equipped when the battle starts and is unequipped when the battle ends so you get bonus XP for your pets.
			 -- If you have an heirloom helmet then you also get bonus XP for your character since the player XP is awarded after the Safari Hat is switched to the heirloom helmet.
			MPB.EQUIP_SAFARI_HAT = true
		end

		if MPB.MATCH_PET_LEVELS_DURING_WT == nil then
			 -- If this is enabled, and win-trading is also enabled, then this will cause pet levels to be matched with the other player's pet levels
			MPB.MATCH_PET_LEVELS_DURING_WT = false
		end

		--[
			-- Note that the player that is not auto-forfeiting actually controls the following settings. If both players are not auto-forfeiting then the leader controls the settings.
		
			if MPB.MATCH_PET_LEVELS_START_LEVEL == nil then
				-- The level that you want to start leveling pets from.
				MPB.MATCH_PET_LEVELS_START_LEVEL = 24
			end

			if MPB.MATCH_PET_LEVELS_LEVEL_STEP == nil then
			 	-- This is either -1 or +1. Use -1 if you want to work down the levels starting from the start level. Use +1 if you want to work up the levels instead.
				MPB.MATCH_PET_LEVELS_LEVEL_STEP = -1
			end
		--]

		---------------------------------------
		-- SET UI ELEMENTS TO SAVEDVARIABLES --
		-- TEAM SETUP
		EditBox_min_team_pet_health:SetText(tostring(MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD * 100)) 
		Slider_pet1_level:SetValue(MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT)
		Slider_pet2_level:SetValue(MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT)
		Slider_pet3_level:SetValue(MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT)
		CheckButtonIncludeOnlyRare:SetChecked(not MPB.USE_NON_RARE)
		CheckButtonPrioritizeLevel:SetChecked(MPB.PRIORITIZE_LEVEL)
		CheckButtonRandomize:SetChecked(MPB.RANDOMIZE)
		EditBoxLevelKeepMinimum:SetText(MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL)
	
		-- PRE-COMBAT
		CheckButton15:SetChecked(MPB_CONFIG_PRE_COMBAT_ATTEMPT_STRONGEST_RANDOM_TEAM)
		-- COMBAT
		EditBox_swap_pet_health_threshold:SetText(tostring(MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD * 100)) 
		CheckButtonEquipSafariHat:SetChecked(MPB.EQUIP_SAFARI_HAT)

		-- POST-COMBAT
		CheckButton12:SetChecked(MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT)
		CheckButton14:SetChecked(MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT)
		CheckButton11:SetChecked(MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT)

		-- MISC	
		CheckButton13:SetChecked(MPB_CONFIG_MISC_AUTOMATIC_RELEASE_NON_RARES)

		-- LOAD LAST USED DESIRED_PET_LEVEL FOR THE RANDOM TEAM GENERATION
		local loadLastUsedDesiredPetLevel = MPB_EDITBOX_DESIRED_PET_LEVEL
		EditBox_PetLevel:SetText(loadLastUsedDesiredPetLevel) 

		-- LOCK PETS FOR RANDOM TEAM GENERATION
		Check_lock_pet_1:SetChecked(MPB_LOCK_PET1)
		Check_lock_pet_2:SetChecked(MPB_LOCK_PET2)
		Check_lock_pet_3:SetChecked(MPB_LOCK_PET3)

		-- SET TEXTURE FOR CONFIG BUTTON (GEAR) MANUALLY AS THE XML FILE DO NOT WANT DO WHAT I WANT!
		MPB_Config_Button:SetNormalTexture("Interface\\Addons\\MyPetBattle\\Images\\icon-config")
		MPB_Config_Button:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")

		-- SET CAPTURE RARE/UNCOMMON/COMMON CHECKBOXES
		CheckButton3:SetChecked(MPB_CAPTURE_RARES)
		CheckButton4:SetChecked(MPB_CAPTURE_COMMON_UNCOMMON)

		-- SET FORFEIT TIMER
		EditBox_ForfeitTimer:SetText(MPB_FORFEIT_TIMER)

		-- LOAD WT MATCH LEVELS OPTIONS
		CheckButton_wt_match_levels:SetChecked(MPB.MATCH_PET_LEVELS_DURING_WT)
		EditBox_MatchLevel:SetText(MPB.MATCH_PET_LEVELS_START_LEVEL)
		EditBox_Direction:SetText((MPB.MATCH_PET_LEVELS_LEVEL_STEP > 0) and "+1" or "-1")
		
		-- CALL FUNCTION IN Frame.lua TO UPDATE THE POSITION OF THE MINIMAP BUTTON
		MPB_MMButton_UpdatePosition()

		-- SHOW/HIDE UI AT LOGIN ACCORDING TO CHARACTER SPECIFIC SAVEDVARIABLE
		if MPB_SHOW_UI == nil then MPB_SHOW_UI = true end -- Set variable to true the first time
		if MPB_SHOW_UI then MyPetBattleForm:Show() else MyPetBattleForm:Hide() end

		-- PRINT THAT WE ARE DONE LOADING
		print("Loaded |cffff8000MPB")
	end


end

function events:PLAYER_LOGIN(...)				-- 
--	print("PLAYER_LOGIN")
	print("\124cFFFF9933My Pet Battle ready for action")
	-- Set default text of textfield "PetLevel" for random team generation
end

function events:PLAYER_ENTERING_WORLD(...)				-- 
--	print("PLAYER_ENTERING_WORLD")
end

function events:PET_BATTLE_ABILITY_CHANGED(...)				-- 
--	print("PET_BATTLE_ABILITY_CHANGED")
end
function events:PET_BATTLE_ACTION_SELECTED(...)				-- Player selected a pet action
--	print("PET_BATTLE_ACTION_SELECTED")
end
function events:PET_BATTLE_AURA_APPLIED(...)				-- Aura applied e.g. Adrenaline for 3 turn (3 stacks)
--	print("PET_BATTLE_AURA_APPLIED")
end
function events:PET_BATTLE_AURA_CANCELED(...)				-- 
--	print("PET_BATTLE_AURA_CANCELED")
end
function events:PET_BATTLE_AURA_CHANGED(...)				-- Aura changed e.g. Adrenaline changed to 2 stacks
--	print("PET_BATTLE_AURA_CHANGED")
end
function events:PET_BATTLE_CAPTURED(...)					-- 
--	print("PET_BATTLE_CAPTURED")
--	print(...)
	local petOwner, petIndex = ...
	if (petOwner == LE_BATTLE_PET_ENEMY) then
		local name, speciesName = C_PetBattles.GetName(petOwner, petIndex)
--		local speciesId, petGUID = C_PetJournal.FindPetIDByName(speciesName)
--		local link = C_PetJournal.GetBattlePetLink(petGUID)

--		local petName = C_PetBattles.GetName(petOwner, petIndex);
--		local petIcon = C_PetBattles.GetIcon(petOwner, petIndex);
--		local quality = C_PetBattles.GetBreedQuality(petOwner, petIndex);
		-- ADD STATS TO STATS TABLE
		MyPetBattle.addStats(speciesName,1)
	end
end
function events:PET_BATTLE_CLOSE(...)						-- 
	if mypetbattle_debug then print("PET_BATTLE_CLOSE", ...) end
	if MyPetBattleState.FLAG_BATTLE_IN_PROGRESS then -- don't want to do this twice so check this flag
		MyPetBattle.setState(MyPetBattleState.BATTLE_CLOSED, true)
	end
end

function events:PET_BATTLE_FINAL_ROUND(...)					-- 
	if mypetbattle_debug then print("PET_BATTLE_FINAL_ROUND", ...) end
	if mypetbattle_debug then
		-- SHOWS THE SAME RESULT ALL THE TIME FOR PVP BATTLES REGARDLESS OF WHO WINS?!?!
		-- This only works if there was no forfeit. I think the parameter only indicates who performed the final action?
		if ... == LE_BATTLE_PET_ALLY then
			print("We won!")
			-- ADD STATS TO STATS TABLE
			MyPetBattle.addStats("Wins",1)
		elseif ... == LE_BATTLE_PET_ENEMY then
			print("We lost!")
			-- ADD STATS TO STATS TABLE
			MyPetBattle.addStats("Losses",1)
		else
			print("Not LE_BATTLE_PET_ALLY or LE_BATTLE_PET_ENEMY won?!")
		end
	end
end

function events:PET_BATTLE_HEALTH_CHANGED(...)				-- 
	-- petOwner, petIndex, healthChange
--	local myOutput1, myOutput2, myOutput3 = ...;
--	print("OUTPUT: " .. myOutput1 .. ", " .. myOutput2 .. ", " .. myOutput3)

--	print("PET_BATTLE_HEALTH_CHANGED")
	local petOwner, petIndex, healthChange = ...;
	local pet_name, pet_speciesName = C_PetBattles.GetName(petOwner, petIndex)
	local pet_icon = C_PetBattles.GetIcon(petOwner, petIndex)
	local pet_currentHealth = C_PetBattles.GetHealth(petOwner, petIndex)
	local pet_maxHealth = C_PetBattles.GetMaxHealth(petOwner, petIndex)
	local pet_healthPercentage = pet_currentHealth / pet_maxHealth * 100
	
	local textColor
	if pet_healthPercentage < 30 then
		textColor = "\124cFFFF0000" -- red
	elseif pet_healthPercentage < 75 then
		textColor = "\124cFFFFFF00" -- yellow
	elseif pet_healthPercentage <= 100 then
		textColor = "\124cFF00FF00" -- green
	end
	
	local textPetOwner
	if petOwner == 1 then
		textPetOwner = "Player: "
	else
		textPetOwner = "Enemy: "
	end
    if mypetbattle_debug then	
	    if healthChange > 0 then 
    --		print("gained " .. healthChange .. " health") 
		    print(textPetOwner.."\124T"..pet_icon..":0\124t |cFF0066FF[" .. pet_name .. "]|r gained \124cFF00FF00" .. healthChange .. "\124r health. Current health: " .. textColor .. pet_currentHealth .. "/" .. pet_maxHealth .. string.format(" (%2.0f%%)", pet_healthPercentage)) 
	    elseif healthChange < 0 then
    --		print("lost " .. abs(healthChange) .. " health") 
		    print(textPetOwner.."\124T"..pet_icon..":0\124t |cFF0066FF[" .. pet_name .. "]|r lost \124cFFFF0000" .. abs(healthChange) .. "\124r health. Current health: " .. textColor .. pet_currentHealth .. "/" .. pet_maxHealth .. string.format(" (%2.0f%%)", pet_healthPercentage)) 
	    end
    end
	
--	print(textPetOwner.."\124T"..pet_icon..":0\124t |cFF0066FF[" .. pet_name .. "]|r current health: " .. textColor .. pet_currentHealth .. "/" .. pet_maxHealth .. string.format(" (%2.0f%%)", pet_healthPercentage) .. " point") 

--	print("Pet number "..petIndex .. " health is: " .. C_PetBattles.GetHealth(petOwner, petIndex))

	currentPetID = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)
	currentPet_Health = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, currentPetID)
	currentPet_MAX_Health = C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, currentPetID)
	currentPet_Health_percentage = currentPet_Health / currentPet_MAX_Health * 100
	
--	currentPetID = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)
--	currentPet_Health = C_PetBattles.GetHealth(LE_BATTLE_PET_ALLY, currentPetID)
--	currentPet_MAX_Health = C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, currentPetID)
--	currentPet_Health_percentage = currentPet_Health / currentPet_MAX_Health * 100
	
	
--	print("|cff00ff00 Current pets health: " .. currentPet_Health .. "/" .. currentPet_MAX_Health .. string.format(" (%2.0f%%)", currentPet_Health_percentage) .. " points")
end

function events:PET_BATTLE_LEVEL_CHANGED(...)				-- 
	if mypetbattle_debug then print("PET_BATTLE_LEVEL_CHANGED", ...) end
	local petOwner, petIndex, newLevel = ...
	if petOwner == LE_BATTLE_PET_ALLY then
		local pet_name, pet_speciesName = C_PetBattles.GetName(petOwner, petIndex)
		local pet_icon = C_PetBattles.GetIcon(petOwner, petIndex)
		local pet_level = C_PetBattles.GetLevel(petOwner, petIndex)
		MyPetBattle.setPetLevel(petIndex, newLevel, pet_level)
		print("|cffff8000MPB|r: |cFF0066FF\124T"..pet_icon..":16\124t [" .. pet_name .. "]\124r is now level: " .. pet_level .."!") 
	end
end

function events:PET_BATTLE_LOOT_RECEIVED(...)				-- 
--	print("PET_BATTLE_LOOT_RECEIVED")

	local typeIdentifier, itemLink, quantity = ...;
	print("|cffff8000MPB|r: \124cFF00FF00Item won:\124r " .. quantity .. " x " .. itemLink)
	
	if ( typeIdentifier == "item" ) then
		local itemName, itemLink, _, _, _, _, _, _, _, itemIcon, _ = GetItemInfo(itemLink);
--		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink);
	elseif ( typeIdentifier == "currency" ) then
		local itemName, _, itemIcon, _, _, _, _, _ = GetCurrencyInfo(itemLink);
--		local currencyName, currencyQuantity, currencyIcon, earnedThisWeek, weeklyMax, maxQuantity, discovered, rarity = GetCurrencyInfo(itemLink);
	end

	-- ADD STATS TO STATS TABLE
	MyPetBattle.addStats(itemLink,quantity)
end

function MyPetBattle.addStats(key,value)
	-- Loot received
		-- items
		-- currency
	-- Pets caught: common, uncommon, rare, type etc.
	-- Pets fought
	-- PvP win/loose, streak
	-- XP from WT and other
	if MPB_STATS_TABLE[key] ~= nil then 
		MPB_STATS_TABLE[key] = MPB_STATS_TABLE[key] + value
	else
		MPB_STATS_TABLE[key] = value
	end	
end

function MyPetBattle.printStats()
	-- PRINT STATISTICS OF OUR BATTLES
	print("|cffff8000MPB|r: |cffff8000MPB stats for current session:|r")
	for key,value in pairs(MPB_STATS_TABLE) do 
		print(" - "..value.."x",key) 
	end
end

function events:PET_BATTLE_MAX_HEALTH_CHANGED(...)			-- 
--	print("PET_BATTLE_MAX_HEALTH_CHANGED")
end

function events:PET_BATTLE_OPENING_DONE(...)				-- OPENING DONE AND READY TO BATTLE
	if mypetbattle_debug then print("PET_BATTLE_OPENING_DONE", ...) end
	print("|cffff8000MPB|r: Opening done")
	MyPetBattle.setState(MyPetBattleState.BATTLE_OPENED, true)
end

function events:PET_BATTLE_OPENING_START(...)				-- 
	if mypetbattle_debug then print("PET_BATTLE_OPENING_START", ...) end
	print("|cffff8000MPB|r: |cFF00FFFFGame Starting!")

	player_level_start = UnitLevel("player")
	player_xp_max_start = UnitXPMax("player")

	-- Get pets level
	pet1_level_start = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY,1)
	pet2_level_start = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY,2)
	pet3_level_start = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY,3)

	pet1_xp_gained = 0
	pet2_xp_gained = 0
	pet3_xp_gained = 0
--[[
	-- Get pets current xp
	pet1_xp_start, pet1_maxXp_start = C_PetBattles.GetXP(1, 1)
	pet2_xp_start, pet2_maxXp_start = C_PetBattles.GetXP(1, 2)
	pet3_xp_start, pet3_maxXp_start = C_PetBattles.GetXP(1, 3)
--]]
end

function events:PET_BATTLE_OVER(...)						-- Pet battle over (someone won)
	if mypetbattle_debug then print("PET_BATTLE_OVER", ...) end
	
	-- Get pet names
	pet1_name, pet1_speciesName = C_PetBattles.GetName(1, 1)
	pet2_name, pet2_speciesName = C_PetBattles.GetName(1, 2)
	pet3_name, pet3_speciesName = C_PetBattles.GetName(1, 3)

	-- Get pet icons
	pet1_icon = C_PetBattles.GetIcon(1, 1)
	pet2_icon = C_PetBattles.GetIcon(1, 2)
	pet3_icon = C_PetBattles.GetIcon(1, 3)

--[[	
	-- Get xp after combat has ended
	pet1_xp_end, pet1_maxXp_end = C_PetBattles.GetXP(1, 1)
	pet2_xp_end, pet2_maxXp_end = C_PetBattles.GetXP(1, 2)
	pet3_xp_end, pet3_maxXp_end = C_PetBattles.GetXP(1, 3)

	-- Calculate xp gain -- This calculation is wrong if the pet gained a level!
	pet1_xp_gained = pet1_xp_end - pet1_xp_start
	pet2_xp_gained = pet2_xp_end - pet2_xp_start
	pet3_xp_gained = pet3_xp_end - pet3_xp_start
--]]

	-- Print xp change
	if pet1_xp_gained > 0 then print("|cffff8000MPB|r: |cFF0066FF\124T"..pet1_icon..":0\124t [" .. pet1_name .. "] |cFFFFFFFFgained " .. pet1_xp_gained .. " xp") end
	if pet2_xp_gained > 0 then print("|cffff8000MPB|r: |cFF0066FF\124T"..pet2_icon..":0\124t [" .. pet2_name .. "] |cFFFFFFFFgained " .. pet2_xp_gained .. " xp") end
	if pet3_xp_gained > 0 then print("|cffff8000MPB|r: |cFF0066FF\124T"..pet3_icon..":0\124t [" .. pet3_name .. "] |cFFFFFFFFgained " .. pet3_xp_gained .. " xp") end
	
	print("|cffff8000MPB|r: |cFF00FFFFGame Over!")
end

function events:UPDATE_SUMMONPETS_ACTION(...)					-- 
	if mypetbattle_debug then print("UPDATE_SUMMONPETS_ACTION", ...) end
	-- only one team gets this event so it's not useful if you want for each battle a random team or a team that matches the levels of the enemy team 
end

function events:COMPANION_UPDATE(...)					-- 
--	print("COMPANION_UPDATE")
end

function events:PET_JOURNAL_LIST_UPDATE(...)
--	print(PET_JOURNAL_LIST_UPDATE)
end

function events:PET_BATTLE_PET_CHANGED(...)					-- 
--	print("PET_BATTLE_PET_CHANGED")
end

function events:PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE(...)	-- 
	if mypetbattle_debug then print("PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE", ...) end
	local round = ...
	local roundstring = "|cffff8000MPB|r: Round " .. (round + 1) .. " - "
	
	local doMyPetBattle = mypetbattle_enabled or (mypetbattle_wintrade_enabled and round <= math.random(0,2)) -- ATTACK A RANDOM NUMBER OF TIMES BETWEEN 1-3 IF WE ARE DOING WT (0 AND 2 SINCE ROUND 0 EXISTS)
	
	if doMyPetBattle then
		-------------------------------------
		-- AUTO-SELECT FIRST AVAILABLE PET --
		if C_PetBattles.ShouldShowPetSelect() == true then
			for i=1,3 do
				if MyPetBattle.hp(i) > 0 then
					C_PetBattles.ChangePet(i)
				end
			end
		end
	end

	-------------------------------
	-- GET PET OWNER AND PET INFO --
	local petOwner = LE_BATTLE_PET_ALLY
	local petIndex = C_PetBattles.GetActivePet(petOwner)
	local petType = C_PetBattles.GetPetType(petOwner, petIndex)
	local petLevel = C_PetBattles.GetLevel(petOwner, petIndex)
	local petHealth = C_PetBattles.GetHealth(petOwner, petIndex)
	local petMaxHealth = C_PetBattles.GetMaxHealth(petOwner, petIndex)

	-------------------------------
	-- GET ENEMY PET OWNER AND PET INFO --
	local petOwnerEnemy = LE_BATTLE_PET_ENEMY
	local petIndexEnemy = C_PetBattles.GetActivePet(petOwnerEnemy)
	local petTypeEnemy = C_PetBattles.GetPetType(petOwnerEnemy, petIndexEnemy)
	local petLevelEnemy = C_PetBattles.GetLevel(petOwnerEnemy, petIndexEnemy)

	local numAlivePetsEnemy = 0
	for j=1,3 do
		if (C_PetBattles.GetHealth(petOwnerEnemy, j) or 0) > 0 then
			numAlivePetsEnemy = numAlivePetsEnemy + 1
		end
	end

	if doMyPetBattle then
		-----------------------------------------------------------------------------------------
		-- SKIP TURN IF POLYMORPHED, STUNNED ETC. BY ENEMY (MAYBE CHANGE PET IF LOW ON HEALTH) --
		if MyPetBattle.buff("Polymorphed") or MyPetBattle.buff("Asleep") or MyPetBattle.buff("Crystal Prison") or MyPetBattle.buff("Stunned") or MyPetBattle.buff("Drowsy") then 
			C_PetBattles.SkipTurn()
			return
		end
		--------------------------------------------------------------------------------
		-- SWITCH PET AT HEALTH THRESHOLD BEFORE IT DIES. CAN BE SET FROM CONFIG MENU --
		if MyPetBattle.hp(petIndex) < MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD then
			for j=1,3 do
				if MyPetBattle.hp(j) >= MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD then
					C_PetBattles.ChangePet(j)
					print(roundstring .. "|cFFFF3300Changing pet due to low health!")
					return
				end
			end
		end
		------------------------------------------------------------------
		-- CHECK IF WE SHOULD AND CAN CAPTURE RARE PETS WE ARE FIGHTING --
		-- THE FUNCTION canCaptureRare() IN MyPetBattle_data.lua WILL CHECK IF WE CAN CAPTURE THE RARE WE ARE FIGHTING
		if MPB_CAPTURE_RARES and MyPetBattle.canCaptureRare() and mypetbattle_enabled then
			print(roundstring .. "|cFF8A2BE2We are trying to capture a rare!")
			C_PetBattles.UseTrap() -- USE THE TRAP
			return
		end
		-------------------------------------------------------------------------
		-- CHECK IF WE SHOULD CAPTURE COMMON/UNCOMMON IF WE DO NOT OWN THE PET --
		if MPB_CAPTURE_COMMON_UNCOMMON and MyPetBattle.canCaptureCommon() and mypetbattle_enabled then
			print(roundstring .. "|cFF00FF00We do not have this pet (0/3), let us capture it (common/uncommon)!")
			C_PetBattles.UseTrap() -- USE THE TRAP
			return
		end
		-------------------------------------------
		-- CHECK IF WE SHOULD LET THE ENEMY LIVE --
		-- Forfeiter has levels 25,8,8. The winner has levels 8,8,25. If we are the forfeiter then we don't want our level 25 to kill the other's low level pets.
		if mypetbattle_wintrade_enabled and mypetbattle_auto_forfeit then
			if petLevel > petLevelEnemy + 3 or numAlivePetsEnemy <= 1 then
				if petHealth < petMaxHealth then
					for j=1,3 do
						if j ~= petIndex and MyPetBattle.hp(j) >= MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD then
							C_PetBattles.ChangePet(j)
							print(roundstring .. "|cFFFF3300Changing pet due to enemy low level!")
							return
						end
					end
				end
				print(roundstring .. "|cFFFF3300Skipping turn due to enemy low level!")
				C_PetBattles.SkipTurn()
				return
			end
		end
	end
	
	-----------------------------
	-- GETTING READY TO ATTACK --
	local spell = nil
	if petType == 1 then 		-- HUMANOID
		spell = humanoid()		
	elseif petType == 2 then 	-- DRAGONKIN
		spell = dragonkin()
	elseif petType == 3 then 	-- FLYING
		spell = flying()
	elseif petType == 4 then 	-- UNDEAD
		spell = undead()
	elseif petType == 5 then 	-- CRITTER
		spell = critter()
	elseif petType == 6 then 	-- MAGIC
		spell = magic()
	elseif petType == 7 then 	-- ELEMENTAL
		spell = elemental()
	elseif petType == 8 then 	-- BEAST
		spell = beast()
	elseif petType == 9 then 	-- WATER / AQUATIC
		spell = aquatic()
	elseif petType == 10 then 	-- MECHANICAL
		spell = mechanical()
	end

	if doMyPetBattle then
		----------------------------------------------
		-- IF WE HAVE SPELL WE CAN CAST, THEN CAST! --
		if spell ~= nil and spell ~= "UNKNOWN" then	
			local actionIndex = MyPetBattle.getSpellSlotIndex(spell)
			
			local spellID, spellName, spellIcon, _, _, _, _, _ = C_PetBattles.GetAbilityInfo(petOwner, petIndex, actionIndex)
				
			print(roundstring .. "|cffFF4500Casting\124r \124T"..spellIcon..":0\124t \124cff4e96f7\124HbattlePetAbil:"..spellID..":0:0:0\124h["..spell.."]\124h\124r");
--			print("actionIndex: ", actionIndex)
			C_PetBattles.UseAbility(actionIndex) -- USE PET ABILITY 
		-- IF THE PET IS UNKNOWN, THEN CAST THE FIRST AVAILABLE SPELL SO WE WILL AT LEAST ATTACK
		elseif spell == "UNKNOWN" then
			print("Pet is unknown, casting first spell available")
			C_PetBattles.UseAbility(1) -- USE PET ABILITY 1
		end
    elseif mypetbattle_debug then
        ------------------------------------------------------------------------------
		-- IF WE'RE NOT ENABLED BUT IN DEBUG MODE THEN SHOW WHAT WE WOULD HAVE CAST --
		print(roundstring .. "|cffFF4500Would be Casting: ", spell)
	end
end

function events:PET_BATTLE_PET_ROUND_RESULTS(...)			-- 
--	print("PET_BATTLE_PET_ROUND_RESULTS")
	local roundNumber = ...
	if roundNumber ~= 0 and mypetbattle_debug then
		print("Round "..roundNumber)
	end
end

function events:PET_BATTLE_PVP_DUEL_REQUESTED(...)			-- 
	print("PET_BATTLE_PVP_DUEL_REQUESTED")
end

function events:PET_BATTLE_PVP_DUEL_REQUEST_CANCEL(...)		-- 
	print("PET_BATTLE_PVP_DUEL_REQUEST_CANCEL")
end

function events:PET_BATTLE_QUEUE_PROPOSAL_ACCEPTED(...)		-- 
	if mypetbattle_debug then print("PET_BATTLE_QUEUE_PROPOSAL_ACCEPTED", ...) end
	print("|cffff8000MPB|r: Pet Battle PvP queue accepted")
end

function events:PET_BATTLE_QUEUE_PROPOSAL_DECLINED(...)		-- 
	if mypetbattle_debug then print("PET_BATTLE_QUEUE_PROPOSAL_DECLINED", ...) end
	print("|cffff8000MPB|r: Removed from pet battle PvP queue")
end

function events:PET_BATTLE_QUEUE_PROPOSE_MATCH(...)			-- 
	if mypetbattle_debug then print("PET_BATTLE_QUEUE_PROPOSE_MATCH", ...) end

	-- Sync setup for wt
	if mypetbattle_wintrade_enabled then
		MPB_SyncTimeSent = GetTime()
		if mypetbattle_debug then print("Queue popped, sending sync message: "..MPB_SyncTimeSent) end
		SendAddonMessage("MPB", "s"..MPB_SyncTimeSent, "PARTY")
	end
	
	-- Automatic accept PvP queue popup if enabled	
	if (mypetbattle_join_pvp and not mypetbattle_wintrade_enabled) then
		if mypetbattle_debug then print("Auto-accepting pet PvP match!") end
		C_PetBattles.AcceptQueuedPVPMatch()
	end
end

function events:PET_BATTLE_QUEUE_STATUS(...)				-- 
--	print("PET_BATTLE_QUEUE_STATUS")
end

function events:PET_BATTLE_TURN_STARTED(...)				-- 
	print("PET_BATTLE_TURN_STARTED")
end

function events:PET_BATTLE_XP_CHANGED(...)					-- 
	if mypetbattle_debug then print("PET_BATTLE_XP_CHANGED", ...) end

	local petOwner, petIndex, xpGained = ...
	if petOwner == LE_BATTLE_PET_ALLY then
		_G["pet"..petIndex.."_xp_gained"] = xpGained
	end
end

MyPetBattleVars.xpGains = {}
local function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0			-- iterator variable
	local iter = function ()	 -- iterator function
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end

function MyPetBattle:dumpXPGains(chatframenumber)
    for level,leveltable in pairsByKeys(MyPetBattleVars.xpGains) do
        --table.sort(leveltable,sortlevel)
        --print(level,leveltable)
        for xp, xptable in pairs(leveltable) do
            --print(xp,xptable)
            if xp ~= "xpmax" then
                local message = string.format("-- %2d %6d %7d %s", level, xp, leveltable.xpmax, xptable.percent)
                for team, count in pairs(xptable) do
                    -- print(team,count)
                    if team ~= "count" and team ~= "percent" then
                        message = message .. string.format(" %sx%d", team, count)
                    end
                end
                _G["ChatFrame" .. (chatframenumber or 1)]:AddMessage(message)
            end
        end
    end
end

function events:PLAYER_XP_UPDATE(...)
	if mypetbattle_debug then print("PLAYER_XP_UPDATE", ...) end
end

function events:CHAT_MSG_COMBAT_XP_GAIN(...)
	if mypetbattle_debug then print("CHAT_MSG_COMBAT_XP_GAIN", ...) end

	if player_level_start then
		if not MyPetBattleVars.xpGains[player_level_start] then
			MyPetBattleVars.xpGains[player_level_start] = {xpmax=player_xp_max_start}
		end

		local pattern = string.gsub(COMBATLOG_XPGAIN_FIRSTPERSON_UNNAMED, "%%d", "(%%d+)")
		message = ...
		local xpGained = tonumber(string.match(message, pattern))

		if not MyPetBattleVars.xpGains[player_level_start][xpGained] then
			MyPetBattleVars.xpGains[player_level_start][xpGained] = {percent=string.format("(%2.2f%%)", xpGained * 100 / player_xp_max_start), count=0}
		end
		MyPetBattleVars.xpGains[player_level_start][xpGained].count = MyPetBattleVars.xpGains[player_level_start][xpGained].count + 1
		local levelstring = (pet1_level_start or "") .. "," ..(pet2_level_start or "") .. "," ..(pet3_level_start or "")
		MyPetBattleVars.xpGains[player_level_start][xpGained][levelstring] = (MyPetBattleVars.xpGains[player_level_start][xpGained][levelstring] or 0) + 1
	end
end

function events:CHAT_MSG_ADDON(...)							-- 
--	print("CHAT_MSG_ADDON", ...)
	local prefix, message, channel, sender = ...
	-- CHECK IF MESSAGE COMES FROM MPB ADDON
	if prefix == "MPB" and channel == "PARTY" and sender ~= UnitName("player") then
		if (string.sub(message,1,1) == "s") then
			MPB_SyncTimeReceived = tonumber(string.sub(message,2))
			if mypetbattle_debug then print("We received sync message: "..MPB_SyncTimeReceived.." from "..prefix) end
		elseif (string.sub(message,1,1) == "m") then
			if MyPetBattleVars.state >= MyPetBattleState.TRANSFER_PET_LIST and MyPetBattleVars.state <= MyPetBattleState.RECIEVED_PET_LIST_AGAIN then
				MyPetBattleVars.petListEnemy = message
				MyPetBattle.setState(MyPetBattleState.RECIEVED_PET_LIST, true)
			end
		end
	end
end

function events:PLAYER_EQUIPMENT_CHANGED(...)
	if mypetbattle_debug then print("PLAYER_EQUIPMENT_CHANGED", ...) end
end

mypetbattle_frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

-- REGISTER ALL EVENTS FOR WHICH HANDLERS HAVE BEEN DEFINED
for k, v in pairs(events) do
 mypetbattle_frame:RegisterEvent(k); 
end

--------------------
--- TIMER FRAME ----
--------------------
MPB_timerTotal = 0 -- TIMER INIT FOR AUTOMATIC FORFEIT
MPB_timerOneSec = 0 -- 1 SEC TIMER INIT FOR DIFFERENT MECHANICS E.G. AUTO RE-QUEUE PVP

MPB_timerSetTeamCountdown = 0
MPB_timerSetTeamInterval = 1 -- 1 second timer for setting team

MPB_timerStartPVPMatchingCountdown = 0
MPB_timerStartPVPMatchingAfterSetTeamInterval = 2
MPB_timerStartPVPMatchingInterval = 5

MPB_timerAcceptPVPMatchmakingCountdown = 0
MPB_timerAcceptPVPMatchmakingInterval = 5

MPB_timerBattleCloseCountdown = 0
MPB_timerBattleCloseInterval = 5

if MPB_SyncTimeReceived == nil then MPB_SyncTimeReceived = 0 end
if MPB_SyncTimeSent == nil then MPB_SyncTimeSent = 0 end
MPB_syncCounter = 0

MPB_petguids = {0,0,0}

MPB_onUpdate = function (self,elapsed)

	--print("MPB_onUpdate", self, elapsed)

	-- update timers
	MPB_timerOneSec = MPB_timerOneSec + elapsed

	if MPB_timerStartPVPMatchingCountdown > 0 then
		MPB_timerStartPVPMatchingCountdown = MPB_timerStartPVPMatchingCountdown - elapsed
	end
	if MPB_timerAcceptPVPMatchmakingCountdown > 0 then
		MPB_timerAcceptPVPMatchmakingCountdown = MPB_timerAcceptPVPMatchmakingCountdown - elapsed
	end
	if MPB_timerSetTeamCountdown > 0 then
		MPB_timerSetTeamCountdown = MPB_timerSetTeamCountdown - elapsed
	end
	
	-- check states
	if MyPetBattleVars.state == MyPetBattleState.SET_TEAM_START then
		if mypetbattle_debug then print("MyPetBattleState.SET_TEAM_START") end
		MyPetBattleState.FLAG_SET_TEAM_IN_PROGRESS = true
		if mypetbattle_wintrade_enabled and MPB.MATCH_PET_LEVELS_DURING_WT then
			MyPetBattle.setState(MyPetBattleState.TRANSFER_PET_LIST, false)
		else
			MyPetBattle.setState(MyPetBattleState.SET_TEAM, false)
		end
	end

	if MyPetBattleVars.state == MyPetBattleState.TRANSFER_PET_LIST then
		if mypetbattle_debug then print("MyPetBattleState.TRANSFER_PET_LIST") end
		MPB_timerSetTeamCountdown = MPB_timerSetTeamInterval
		MyPetBattle.sendPetList() -- send our pet list
		print("|cffff8000MPB|r: |cFF4169E1Sent your pet list for the first time and waiting for the enemy's pet list.")
		MyPetBattle.setState(MyPetBattleState.TRANSFER_PET_LIST_AGAIN, false)
	end

	if MyPetBattleVars.state == MyPetBattleState.RECIEVED_PET_LIST then
		if mypetbattle_debug then print("MyPetBattleState.RECIEVED_PET_LIST") end
		MPB_timerSetTeamCountdown = MPB_timerSetTeamInterval
		MyPetBattle.sendPetList() -- send our pet list again but with acknowledge this time
		
		if string.sub(MyPetBattleVars.petListEnemy,2,2) == "a" then
			print("|cffff8000MPB|r: |cFF4169E1Recieved the enemy's pet list with acknowledgement of your pet list.")
			MyPetBattle.setState(MyPetBattleState.RECIEVED_PET_LIST_ACK, false)
		else
			print("|cffff8000MPB|r: |cFF4169E1Recieved the enemy's pet list and waiting for acknowledgement of your pet list.")
			MyPetBattle.setState(MyPetBattleState.RECIEVED_PET_LIST_AGAIN, false)
		end
	end

	if MyPetBattleVars.state == MyPetBattleState.RECIEVED_PET_LIST_ACK then
		if mypetbattle_debug then print("MyPetBattleState.RECIEVED_PET_LIST_ACK") end
		MyPetBattle.setState(MyPetBattleState.SET_TEAM, false)
	end

	if MyPetBattleVars.state == MyPetBattleState.SET_TEAM then
		if mypetbattle_debug then print("MyPetBattleState.SET_TEAM") end
		MyPetBattle.setState(MyPetBattleState.SET_TEAM_IN_PROGRESS, false)
		local desiredPetLevel = EditBox_PetLevel:GetText()  -- Get user input for desired pet level
		MyPetBattle.setTeam(desiredPetLevel)                -- Setup our team
		-- Save desired pet level for next time we log in
		MPB_EDITBOX_DESIRED_PET_LEVEL = desiredPetLevel
		-- Clear focus from the editbox
		EditBox_PetLevel:ClearFocus()                       
		local petGUID = C_PetJournal.GetPetLoadOutInfo(1)
		if not petGUID then
			MyPetBattle.setState(MyPetBattleState.SET_TEAM_AGAIN, false)
		else
			MyPetBattle.setState(MyPetBattleState.SET_TEAM_DONE, false)
			MyPetBattleState.FLAG_SET_TEAM_IN_PROGRESS = false
			MPB_timerStartPVPMatchingCountdown = MPB_timerStartPVPMatchingAfterSetTeamInterval -- wait a few seconds before queuing to make sure the team was loaded completely
		end
	end

	if MyPetBattleVars.state == MyPetBattleState.BATTLE_OPENED then
		if mypetbattle_debug then print("MyPetBattleState.BATTLE_OPENED") end
		MyPetBattleState.FLAG_BATTLE_IN_PROGRESS = true

		-- STOPWATCH FOR WT
		if mypetbattle_wintrade_enabled then
			if Stopwatch_IsPlaying() then Stopwatch_Clear() end
			Stopwatch_StartCountdown(0, 0, MPB_FORFEIT_TIMER+5) -- SET STOP WATCH TO COUNT DOWN FROM MPB_FORFEIT_TIMER + 5 SEC. +5 FOR MINOR ADJUSTMENT BECAUSE FORFEIT ANIMATION TAKES ABOUT 5 SEC
			Stopwatch_Play() -- STARTS THE STOP WATCH
			if mypetbattle_debug then print("Started Stopwatch") end
		end

		 -- equip the Safari Hat for pet XP gains
		if MPB.EQUIP_SAFARI_HAT then
			local headSlotId = GetInventorySlotInfo("headslot")
			MyPetBattleVars.currentEquippedHelmLink = GetInventoryItemLink("player", headSlotId)
			EquipItemByName(92738)
		end
		
		print("|cffff8000MPB|r: We have to fight " .. C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) .. " enemy pets")
		-- Auto-select first available pet
		if C_PetBattles.ShouldShowPetSelect() == true and (mypetbattle_enabled or mypetbattle_wintrade_enabled) then
			for i=1,3 do
				if MyPetBattle.hp(i) > 0 then
					C_PetBattles.ChangePet(i)
				end
			end
		end

		MPB_timerTotal = 0 -- Reset timer for automatic forfeit
		
		MyPetBattle.setState(MyPetBattleState.BATTLE_IN_PROGRESS, false)
		MyPetBattleState.FLAG_ALLOW_FORFEIT = true
	end

	if MPB_timerBattleCloseCountdown > 0 then
		MPB_timerBattleCloseCountdown = MPB_timerBattleCloseCountdown - elapsed
		if MPB_timerBattleCloseCountdown <= 0 then
			MyPetBattleState.FLAG_BATTLE_IN_PROGRESS = false
			MyPetBattle.setState(MyPetBattleState.BATTLE_CLOSED_DONE, false)

			MyPetBattle.revive_and_heal_Pets() -- function in MyPetBattle_data.lua

			-- Set new team after combat if MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT is true
			if MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT then
				MyPetBattleState.FLAG_SET_TEAM_IN_PROGRESS = true
				MyPetBattle.setState(MyPetBattleState.SET_TEAM_START, false)
			end
		end
	end

	if MyPetBattleVars.state == MyPetBattleState.BATTLE_CLOSED then
		if mypetbattle_debug then print("MyPetBattleState.BATTLE_CLOSED") end
		MyPetBattleState.FLAG_ALLOW_FORFEIT = false

		if MPB.EQUIP_SAFARI_HAT then
			 -- unequip the Safari Hat for player XP gains (if the player was wearing heirloom helmet)
			local headSlotId = GetInventorySlotInfo("headslot")
			if MyPetBattleVars.currentEquippedHelmLink then
				EquipItemByName(MyPetBattleVars.currentEquippedHelmLink)
			end
		end
		
		MyPetBattle.setState(MyPetBattleState.BATTLE_CLOSED_IN_PROGRESS, false)
		if ( StopwatchFrame:IsShown() ) then
			StopwatchFrame:Hide();
		end

		MPB_timerBattleCloseCountdown = MPB_timerBattleCloseInterval
	end

	if MyPetBattleState.FLAG_ALLOW_FORFEIT then
		--print("MyPetBattleState.BATTLE_IN_PROGRESS") -- happens several times a second
		-- AUTOMATIC FORFEIT TIMER
		MPB_timerTotal = MPB_timerTotal + elapsed
		if MPB_timerTotal >= MPB_FORFEIT_TIMER then -- DEFAULT: 55 SECONDS
			if mypetbattle_debug then  print((MPB_FORFEIT_TIMER+5).." sec. almost up!") end -- +5 ADJUSTMENT
			-- FORFEIT
			if mypetbattle_auto_forfeit then
				if mypetbattle_debug then  print("Forfeiting!") end
				C_PetBattles.ForfeitGame()
			end
			MyPetBattle.setState(MyPetBattleState.BATTLE_FORFEIT_DONE, false)
			MyPetBattleState.FLAG_ALLOW_FORFEIT = false
		end
	end

	if MPB_timerSetTeamCountdown <= 0 then
		if MyPetBattleVars.state == MyPetBattleState.TRANSFER_PET_LIST_AGAIN or MyPetBattleVars.state == MyPetBattleState.RECIEVED_PET_LIST_AGAIN then
			if mypetbattle_debug then print(MyPetBattleVars.state == MyPetBattleState.TRANSFER_PET_LIST_AGAIN and "MyPetBattleState.TRANSFER_PET_LIST_AGAIN" or "MyPetBattleState.RECIEVED_PET_LIST_AGAIN") end
		
			if mypetbattle_wintrade_enabled and MPB.MATCH_PET_LEVELS_DURING_WT then
				MPB_timerSetTeamCountdown = MPB_timerSetTeamInterval
				MyPetBattle.sendPetList()
				if MyPetBattleVars.state == MyPetBattleState.TRANSFER_PET_LIST_AGAIN then
					print("|cffff8000MPB|r: |cFF4169E1Sent your pet list again and waiting for the enemy's pet list.")
				else
					print("|cffff8000MPB|r: |cFF4169E1Recieved the enemy's pet list and still waiting for acknowledgement of your pet list.")
				end
			else
				print("|cffff8000MPB|r: |cFFFF0000Aborting team level match")
				MyPetBattle.setState(MyPetBattleState.SET_TEAM, false)
			end
		end
	end

	if not MyPetBattleState.FLAG_SET_TEAM_IN_PROGRESS and not MyPetBattleState.FLAG_BATTLE_IN_PROGRESS then
		if MPB_timerStartPVPMatchingCountdown <= 0 then
			-- CHECK IF WE SHOULD BE IN THE PVP MATCHMAKING QUEUE, BUT WE ARE NOT
			if mypetbattle_join_pvp and not C_PetBattles.IsInBattle() and (C_PetBattles.GetPVPMatchmakingInfo() == nil) then
				if mypetbattle_debug then print("timer StartPVPMatchmaking") end
				MPB_timerStartPVPMatchingCountdown = MPB_timerStartPVPMatchingInterval
				C_PetBattles.StartPVPMatchmaking()
			end
		end
	end

	-- 1 SEC TIMER CHECK
	if MPB_timerOneSec >= 1 then
		-- DISMISS PET SO WE DO NOT HAVE IT RUNNING AROUND
        local petGUID = C_PetJournal.GetSummonedPetGUID()
        if petGUID and petGUID == C_PetJournal.GetPetLoadOutInfo(1) then -- Check if we have a pet summoned already, or we will get an error
            C_PetJournal.SummonPetByGUID(petGUID) -- Dismiss pet
        end
		-- SET UI TEXTURES FOR CURRENT PET TEAM WHEN THE UI IS LOADED -- IS NOT NEEDED ANYMORE SINCE setTeam() IS CALLED ABOVE, AND THAT FUNCTION SETS THE TEXTURES
		-- MIGHT BE NEEDED ANYWAY, IF AUTO NEW TEAM IS ACTIVE, THEN THE TEXTURE WILL NOT BE LOADED ON LOGIN
		-- MOVED TEXTURE UPDATES TO THE TIMER, BECAUSE THE EVENTS USED BEFORE, WE CANNOT BE SURE THEY ARE ALWAYS CALLED WHEN WE WANT TO UPDATE
		for i_ = 1, 3 do
			local petGUID = C_PetJournal.GetPetLoadOutInfo(i_)
			if not petGUID then  break end -- BREAK THE LOOP IF THERE ARE NO PETS YET OR WE WILL GET AN ERROR

			local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique, obtainable = C_PetJournal.GetPetInfoByPetID(petGUID) 
			level = MyPetBattle.getPetLevel("MPB_onUpdate", petGUID, level)

			if MPB_petguids[i_] ~= petGUID then -- CHECK IF WE ALREADY HAVE THE PET, THEN NO NEED TO SET THE TEXTURE
				MPB_petguids[i_] = petGUID
				-- SET PET UI TEXTURE
				_G["Pet".. i_ .."_texture"]:SetTexture(icon) 
			end
			
			if level ~= tonumber(_G["Pet".. i_ .."_level_string"]:GetText()) then
				_G["Pet".. i_ .."_level_string"]:SetText(level)
			end
		end

		if MyPetBattleVars.state == MyPetBattleState.SET_TEAM_AGAIN then
			-- happens during login
			if mypetbattle_debug then print("MyPetBattleState.SET_TEAM_AGAIN") end
			MyPetBattle.setState(MyPetBattleState.SET_TEAM, false)
		end

		-- WT SYNC CHECK AND PVP ACCEPT
		local syncThreshold = 3 -- Seconds
		local syncDifference = abs(MPB_SyncTimeSent - MPB_SyncTimeReceived)
		-- GET PVP QUEUE INFORMATION
		local queueState, estimatedTime, queuedTime = C_PetBattles.GetPVPMatchmakingInfo()
		-- CHECK THAT WE ARE READY TO ACCEPT WHEN RECEIVING THE MESSAGE FROM OUR PARTNER
--		if mypetbattle_wintrade_enabled and not C_PetBattles.IsInBattle() and mypetbattle_debug then print("|cffff8000MPB|r sync: " .. syncDifference) end
		-- WHEN QUEUE POPS CHECK FOR SYNC
		if queueState == "proposal" then
			MPB_syncCounter = MPB_syncCounter + 1
			if mypetbattle_debug then print("Sync count "..MPB_syncCounter) end				-- FOR DEBUGGING
			if mypetbattle_debug then print("Sync difference is: "..syncDifference) end		-- FOR DEBUGGING

			-- IF SYNC RECEIVED AND WITHING THRESHOLD, THEN ACCEPT
			if syncDifference < syncThreshold then 
				if MPB_timerAcceptPVPMatchmakingCountdown <= 0 then
					if mypetbattle_debug then print("Sync is ok, accepting battle")	end			-- FOR DEBUGGING
					C_PetBattles.AcceptQueuedPVPMatch()
					-- RESET COUNTER AFTER ACCEPTING QUEUE
					MPB_syncCounter = 0
					 -- make sure we don't try AcceptQueuedPVPMatch or StartPVPMatchmaking for another 5 seconds
					MPB_timerAcceptPVPMatchmakingCountdown = MPB_timerAcceptPVPMatchmakingInterval
					MPB_timerStartPVPMatchingCountdown = MPB_timerStartPVPMatchingInterval
				end
			-- COUNT syncThreshold SECONDS BEFORE DECLINING
			elseif MPB_syncCounter >= syncThreshold then 
				if mypetbattle_debug then print("Not in sync, declining battle") end 		-- FOR DEBUGGING
				C_PetBattles.DeclineQueuedPVPMatch()
			end
		else
			-- IF NO QUEUE HAS POPPED YET MAKE SURE THE COUNTER IS 0
			MPB_syncCounter = 0
		end

		-- RESET THE TIMER
		MPB_timerOneSec = 0
	end

end
 
local f = CreateFrame("frame")
f:SetScript("OnUpdate", MPB_onUpdate)

--------------------
-- SLASH COMMANDS --
--------------------
SLASH_MYPETBATTLE1 = '/mypetbattle'
function SlashCmdList.MYPETBATTLE(msg, editbox)
	if msg == "" then
		mypetbattle_enabled = not mypetbattle_enabled
		if mypetbattle_enabled then status = "\124cFF00FF00Enabled" else status = "\124cFFFF0000Disabled" end
		print("|cffff8000MPB|r:", status)
		CheckButton1:SetChecked(mypetbattle_enabled)
	elseif msg == "join_pvp" then
		mypetbattle_join_pvp = not mypetbattle_join_pvp
		if mypetbattle_join_pvp then 
			status = "\124cFF00FF00PvP enabled"
			if mypetbattle_wintrade_enabled and MPB.MATCH_PET_LEVELS_DURING_WT then
				MyPetBattle.setState(MyPetBattleState.SET_TEAM_START, true)
			else
				-- Our timer will call StartPVPMatchmaking
			end
		else 
			status = "\124cFFFF0000PvP disabled"
			-- if C_PetBattles.GetPVPMatchmakingInfo ~= nil then
				C_PetBattles.StopPVPMatchmaking()
			-- end
		end
		print("|cffff8000MPB|r:", status)
	elseif msg == "capture_rares" then
		MPB_CAPTURE_RARES = not MPB_CAPTURE_RARES
		if MPB_CAPTURE_RARES then status = "\124cFF00FF00Automatic capture rare pets enabled" else status = "\124cFFFF0000Automatic capture rare pets disabled" end
		print("|cffff8000MPB|r:", status)
		CheckButton3:SetChecked(MPB_CAPTURE_RARES)
	elseif msg == "capture_common_uncommon" then
		MPB_CAPTURE_COMMON_UNCOMMON = not MPB_CAPTURE_COMMON_UNCOMMON
		if MPB_CAPTURE_COMMON_UNCOMMON then status = "\124cFF00FF00Automatic capture common/uncommon (0/3 owned) pets enabled" else status = "\124cFFFF0000Automatic capture common/uncommon pets (0/3 owned) disabled" end
		print("|cffff8000MPB|r:", status)
	elseif msg == "auto_forfeit" then
		mypetbattle_auto_forfeit = not mypetbattle_auto_forfeit
		if mypetbattle_auto_forfeit then status = "\124cFF00FF00Automatic forfeit after "..MPB_FORFEIT_TIMER.." sec enabled" else status = "\124cFFFF0000Automatic forfeit disabled" end
		print("|cffff8000MPB|r:", status)
	elseif msg == "wintrade_enable" then
		if GetNumGroupMembers() == 0 then -- MAKE SURE WE ARE IN A GROUP TO WT
			print("|cffff8000MPB|r: \124cFFFF0000You need to be in a party to use wt")
			mypetbattle_wintrade_enabled = false
			CheckButton_wintrade_enable:SetChecked(mypetbattle_wintrade_enabled)
		else
			mypetbattle_wintrade_enabled = not mypetbattle_wintrade_enabled
			if mypetbattle_wintrade_enabled then status = "\124cFF00FF00Automatic wintrade enabled" else status = "\124cFFFF0000Automatic wintrade disabled" end
			print("|cffff8000MPB|r:", status)
		end
	elseif msg == "wintrade_match_levels" then
		MPB.MATCH_PET_LEVELS_DURING_WT = not MPB.MATCH_PET_LEVELS_DURING_WT
		if MPB.MATCH_PET_LEVELS_DURING_WT then status = "\124cFF00FF00Automatic match levels during wintrade enabled" else status = "\124cFFFF0000Automatic match levels during wintrade disabled" end
		print("|cffff8000MPB|r:", status)
	elseif msg == "debug" then
		-- TURN OFF DEBUG MESSAGES AS REQUIRED
		mypetbattle_debug =  not mypetbattle_debug
		if mypetbattle_debug then status = "\124cFF00FF00Enabled" else status = "\124cFFFF0000Disabled" end
		print("Debugging:",status)
	elseif msg == "ui" then
		-- SHOW/HIDE UI
		MPB_SHOW_UI = not MPB_SHOW_UI
		if MPB_SHOW_UI then MyPetBattleForm:Show() else MyPetBattleForm:Hide() end
	elseif msg == "help" then
		-- SHOW HELP
		print("|==================================|")
		print("MPB command list:")
		print("  /MyPetBattle")
		print("  /MyPetBattle join_pvp")
		print("  /MyPetBattle capture_rares")
		print("  /MyPetBattle capture_common_uncommon")
		print("  /MyPetBattle wintrade_enable")
		print("  /MyPetBattle wintrade_match_levels")
		print("  /MyPetBattle debug")
		print("  /MyPetBattle ui")
		print("  /MyPetBattle help")
	else
		-- UNKNOWN COMMAND
		print("|cffff8000MPB|r: Unknown command ("..msg..")")
    end
end
