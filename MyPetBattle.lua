-----------------
-- MyPetBattle --
-----------------
MyPetBattle = {}
---------------
---- SETUP ----
---------------
	-- Set SavedVariables to default values if they do not exist

		-- TEAM SETUP
--		if (not MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD) then
--			MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD = 0.60
--		end
--		
--		if (not MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT) then
--			MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT = -2
--		end
--		
--		if (not MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT) then
--			MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT = -2
--		end
--		
--		if (not MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT) then
--			MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT = 2
--		end
--		
--		-- PRE-COMBAT
--		if (not MPB_CONFIG_PRE_COMBAT_ATTEMPT_STRONGEST_RANDOM_TEAM) then
--			MPB_CONFIG_PRE_COMBAT_ATTEMPT_STRONGEST_RANDOM_TEAM = false
--		end
--		
--		-- COMBAT
--		if (not MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD) then
--			MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD = 0.35
--		end
--		
--		-- POST-COMBAT
--		if (not MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT) then
--			MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT = true
--		end
--
--		if (not MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT) then
--			MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT = false
--		end
--
--		if (not MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT) then
--			MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT = true
--		end
--
--		-- MISC
--		if (not MPB_CONFIG_MISC_AUTOMATIC_RELEASE_NON_RARES) then
--			MPB_CONFIG_MISC_AUTOMATIC_RELEASE_NON_RARES = false
--		end		


-- INITIALIZATION -
mypetbattle_enabled = false
mypetbattle_join_pvp = false
mypetbattle_capture_rares = false

-- Variable used to make sure we only call the heal function 1 time after combat.
-- It will be set to "false" on events:PET_BATTLE_OPENING_DONE
-- and set back to "true" on events:UPDATE_SUMMONPETS_ACTION
mypetbattle_hasHealedAfterCombat = true

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
--	local arg1, arg2 = ...
--	print(arg1, arg2)
--	if ... == "MyPetBattle" then
--		print("Loaded MPB")
--	end

	-- Set UI elements to SavedVariables
	-- TEAM SETUP
	EditBox_min_team_pet_health:SetText(tostring(MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD * 100)) 
	Slider_pet1_level:SetValue(MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT)
	Slider_pet2_level:SetValue(MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT)
	Slider_pet3_level:SetValue(MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT)
	
	-- PRE-COMBAT
	CheckButton15:SetChecked(MPB_CONFIG_PRE_COMBAT_ATTEMPT_STRONGEST_RANDOM_TEAM)
	-- COMBAT
	EditBox_swap_pet_health_threshold:SetText(tostring(MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD * 100)) 

	-- POST-COMBAT
	CheckButton12:SetChecked(MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT)
	CheckButton14:SetChecked(MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT)
	CheckButton11:SetChecked(MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT)

	-- MISC	
	CheckButton13:SetChecked(MPB_CONFIG_MISC_AUTOMATIC_RELEASE_NON_RARES)

	-- LOAD LAST USED DESIRED_PET_LEVEL FOR THE RANDOM TEAM GENERATION
	local loadLastUsedDesiredPetLevel = MPB_EDITBOX_DESIRED_PET_LEVEL
	EditBox_PetLevel:SetText(loadLastUsedDesiredPetLevel) 
--	EditBox_PetLevel:SetText("25") 
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
end
function events:PET_BATTLE_CLOSE(...)						-- 
--	print("PET_BATTLE_CLOSE")
end

function events:PET_BATTLE_FINAL_ROUND(...)					-- 
--	print("PET_BATTLE_FINAL_ROUND")
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
	
	if healthChange > 0 then 
--		print("gained " .. healthChange .. " health") 
		print(textPetOwner.."\124T"..pet_icon..":0\124t |cFF0066FF[" .. pet_name .. "]|r gained \124cFF00FF00" .. healthChange .. "\124r health. Current health: " .. textColor .. pet_currentHealth .. "/" .. pet_maxHealth .. string.format(" (%2.0f%%)", pet_healthPercentage)) 
	elseif healthChange < 0 then
--		print("lost " .. abs(healthChange) .. " health") 
		print(textPetOwner.."\124T"..pet_icon..":0\124t |cFF0066FF[" .. pet_name .. "]|r lost \124cFFFF0000" .. abs(healthChange) .. "\124r health. Current health: " .. textColor .. pet_currentHealth .. "/" .. pet_maxHealth .. string.format(" (%2.0f%%)", pet_healthPercentage)) 
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
--	print("PET_BATTLE_LEVEL_CHANGED")
	local petOwner, petIndex = ...;
	local pet_name, pet_speciesName = C_PetBattles.GetName(petOwner, petIndex)
	local pet_icon = C_PetBattles.GetIcon(petOwner, petIndex)
	local pet_level = C_PetBattles.GetLevel(petOwner, petIndex)
	print("|cFF0066FF\124T"..pet_icon..":16\124t [" .. pet_name .. "]\124r is now level: " .. pet_level .."!") 

	--	print("|cffffff00 Your pet is now level: " .. C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY,1) .. "!")	
end

function events:PET_BATTLE_LOOT_RECEIVED(...)				-- 
--	print("PET_BATTLE_LOOT_RECEIVED")

	local typeIdentifier, itemLink, quantity = ...;
	print("\124cFF00FF00Item won:\124r " .. quantity .. " x " .. itemLink)

	--if ( typeIdentifier == "item" ) then
	--	LootWonAlertFrame_ShowAlert(itemLink, quantity);
	--elseif ( typeIdentifier == "money" ) then
	--	MoneyWonAlertFrame_ShowAlert(quantity);
	--end


end

function events:PET_BATTLE_MAX_HEALTH_CHANGED(...)			-- 
--	print("PET_BATTLE_MAX_HEALTH_CHANGED")
end

function events:PET_BATTLE_OPENING_DONE(...)				-- Opening done and ready to battle
--	print("PET_BATTLE_OPENING_DONE")
	print("We have to fight " .. C_PetBattles.GetNumPets(LE_BATTLE_PET_ENEMY) .. " enemy pets")
	-- Auto-select first available pet
	if C_PetBattles.ShouldShowPetSelect() == true and mypetbattle_enabled then
		for i=1,3 do
			if MyPetBattle.hp(i) > 0 then
				C_PetBattles.ChangePet(i)
			end
		end
	end

	-- Setting global variable to false so we will heal after combat if needed
	mypetbattle_hasHealedAfterCombat = false
end

function events:PET_BATTLE_OPENING_START(...)				-- 
--	print("PET_BATTLE_OPENING_START")
	print("|cFF00FFFF Game Starting!")

	-- Get pets level
	pet1_level_start = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY,1)
	pet2_level_start = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY,2)
	pet3_level_start = C_PetBattles.GetLevel(LE_BATTLE_PET_ALLY,3)

	-- Get pets current xp
	pet1_xp_start, pet1_maxXp_start = C_PetBattles.GetXP(1, 1)
	pet2_xp_start, pet2_maxXp_start = C_PetBattles.GetXP(1, 2)
	pet3_xp_start, pet3_maxXp_start = C_PetBattles.GetXP(1, 3)
	
end

function events:PET_BATTLE_OVER(...)						-- Pet battle over (someone won)
--	print("PET_BATTLE_OVER")
	
	-- Get pet names
	pet1_name, pet1_speciesName = C_PetBattles.GetName(1, 1)
	pet2_name, pet2_speciesName = C_PetBattles.GetName(1, 2)
	pet3_name, pet3_speciesName = C_PetBattles.GetName(1, 3)

	-- Get pet icons
	pet1_icon = C_PetBattles.GetIcon(1, 1)
	pet2_icon = C_PetBattles.GetIcon(1, 2)
	pet3_icon = C_PetBattles.GetIcon(1, 3)

	-- Get xp after combat has ended
	pet1_xp_end, pet1_maxXp_end = C_PetBattles.GetXP(1, 1)
	pet2_xp_end, pet2_maxXp_end = C_PetBattles.GetXP(1, 2)
	pet3_xp_end, pet3_maxXp_end = C_PetBattles.GetXP(1, 3)
	
	-- Calculate xp gain
	pet1_xp_gained = pet1_xp_end - pet1_xp_start
	pet2_xp_gained = pet2_xp_end - pet2_xp_start
	pet3_xp_gained = pet3_xp_end - pet3_xp_start

	-- Print xp change
	if pet1_xp_gained > 0 then print("|cFF0066FF\124T"..pet1_icon..":0\124t [" .. pet1_name .. "] |cFFFFFFFFgained " .. pet1_xp_gained .. " xp") end
	if pet2_xp_gained > 0 then print("|cFF0066FF\124T"..pet2_icon..":0\124t [" .. pet2_name .. "] |cFFFFFFFFgained " .. pet2_xp_gained .. " xp") end
	if pet3_xp_gained > 0 then print("|cFF0066FF\124T"..pet3_icon..":0\124t [" .. pet3_name .. "] |cFFFFFFFFgained " .. pet3_xp_gained .. " xp") end
	
	print("|cFF00FFFF Game Over!")
end

function events:UPDATE_SUMMONPETS_ACTION(...)					-- 
--	print("UPDATE_SUMMONPETS_ACTION")

	-- Set new team after combat if MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT is true
	if MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT then
		local desiredPetLevel = EditBox_PetLevel:GetText()  -- Get user input for desired pet level
		MyPetBattle.setTeam(desiredPetLevel)                -- Setup our team
		-- Save desired pet level for next time we log in
		MPB_EDITBOX_DESIRED_PET_LEVEL = desiredPetLevel
		-- Clear focus from the editbox
		EditBox_PetLevel:ClearFocus()       
	end

	-- Setting global variable to false so we will heal after combat if needed
	if mypetbattle_hasHealedAfterCombat == false then
		MyPetBattle.revive_and_heal_Pets() -- function in MyPetBattle_data.lua
		mypetbattle_hasHealedAfterCombat = true
	end

	-- Set UI textures for current pet team when the UI is loaded -- IS NOT NEEDED ANYMORE SINCE setTeam() IS CALLED ABOVE, AND THAT FUNCTION SETS THE TEXTURES
	-- MIGHT BE NEEDED ANYWAY, IF AUTO NEW TEAM IS ACTIVE, THEN THE TEXTURE WILL NOT BE LOADED ON LOGIN
	for i_ = 1, 3 do
		local petGUID = C_PetJournal.GetPetLoadOutInfo(i_)
		local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique, obtainable = C_PetJournal.GetPetInfoByPetID(petGUID) 

		-- Set pet 1 UI texture
		if i_ == 1 then 
			Pet1_texture:SetTexture(icon) 
			Pet1_level_string:SetText(level)
		end
		-- Set pet 2 UI texture
		if i_ == 2 then 
			Pet2_texture:SetTexture(icon) 
			Pet2_level_string:SetText(level)
		end
		-- Set pet 3 UI texture
		if i_ == 3 then 
			Pet3_texture:SetTexture(icon) 
			Pet3_level_string:SetText(level)
		end
	end

end

function events:PET_JOURNAL_LIST_UPDATE(...)
	-- Set UI textures for current pet team when the UI is loaded -- IS NOT NEEDED ANYMORE SINCE setTeam() IS CALLED ABOVE, AND THAT FUNCTION SETS THE TEXTURES
	-- MIGHT BE NEEDED ANYWAY, IF AUTO NEW TEAM IS ACTIVE, THEN THE TEXTURE WILL NOT BE LOADED ON LOGIN
	for i_ = 1, 3 do
		local petGUID = C_PetJournal.GetPetLoadOutInfo(i_)
		local speciesID, customName, level, xp, maxXp, displayID, isFavorite, name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique, obtainable = C_PetJournal.GetPetInfoByPetID(petGUID) 

		-- Set pet 1 UI texture
		if i_ == 1 then 
			Pet1_texture:SetTexture(icon) 
			Pet1_level_string:SetText(level)
		end
		-- Set pet 2 UI texture
		if i_ == 2 then 
			Pet2_texture:SetTexture(icon) 
			Pet2_level_string:SetText(level)
		end
		-- Set pet 3 UI texture
		if i_ == 3 then 
			Pet3_texture:SetTexture(icon) 
			Pet3_level_string:SetText(level)
		end
	end

end

function events:PET_BATTLE_PET_CHANGED(...)					-- 
--	print("PET_BATTLE_PET_CHANGED")
end

function events:PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE(...)	-- 
--	print("PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE")
	-- Auto-select first available pet
	if C_PetBattles.ShouldShowPetSelect() == true and mypetbattle_enabled then
		for i=1,3 do
			if MyPetBattle.hp(i) > 0 then
				C_PetBattles.ChangePet(i)
			end
		end
	end

	-- Skip turn if polymorphed, stunned etc. by enemy (maybe change pet if low on health)
	if MyPetBattle.buff("Polymorphed") or MyPetBattle.buff("Asleep") or MyPetBattle.buff("Crystal Prison") or MyPetBattle.buff("Stunned") or MyPetBattle.buff("Drowsy") then 
		C_PetBattles.SkipTurn()
	end

	-- Stop what we are doing if fighting a rare UNLESS automatic capture is enabled
	local isNPC = C_PetBattles.IsPlayerNPC(2) -- wild pet battle and not PvP/other player
	local rarity = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY))
	
	if isNPC and (rarity == 4 or rarity == 5 or rarity == 6) and not mypetbattle_capture_rares then -- 4: "Rare", 5: "Epic", 6: "Legendary"
		mypetbattle_enabled = false
		CheckButton1:SetChecked(false)
		print("|cFF8A2BE2 WE FOUND A RARE!")
	end	

	-- Check if we should and can capture rare pets
	if mypetbattle_capture_rares and MyPetBattle.canCaptureRare() and mypetbattle_enabled then
		print("|cFF8A2BE2 We are trying to capture a rare!")
		C_PetBattles.UseTrap() -- Use the trap
	end

	if mypetbattle_enabled then
		local spell = nil
		local petOwner = LE_BATTLE_PET_ALLY
		local petIndex = C_PetBattles.GetActivePet(petOwner)
		local petType = C_PetBattles.GetPetType(petOwner, petIndex)

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

		-- Switch pet at health threshold before it dies. CAN BE SET FROM CONFIG MENU
		if MyPetBattle.hp(petIndex) < MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD then
			for j=1,3 do
				if MyPetBattle.hp(j) >= MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD then
					C_PetBattles.ChangePet(j)
					print("|cFFFF3300.. Changing pet due to low health! ..")
				end
			end
		end	

		-- If we have spell we can cast, then cast!
		if spell ~= nil then	
			actionIndex = MyPetBattle.getSpellSlotIndex(spell)
			print("|cffFF4500 Casting: ", spell)
--			print("actionIndex: ", actionIndex)
			C_PetBattles.UseAbility(actionIndex)	-- Use pet ability 
		end
	end
end

function events:PET_BATTLE_PET_ROUND_RESULTS(...)			-- 
--	print("PET_BATTLE_PET_ROUND_RESULTS")
	local roundNumber = ...
	if roundNumber ~= 0 then
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
--	print("PET_BATTLE_QUEUE_PROPOSAL_ACCEPTED")
	print("Pet Battle PvP queue accepted")
end

function events:PET_BATTLE_QUEUE_PROPOSAL_DECLINED(...)		-- 
--	print("PET_BATTLE_QUEUE_PROPOSAL_DECLINED")
	print("Removed from pet battle PvP queue")
end

function events:PET_BATTLE_QUEUE_PROPOSE_MATCH(...)			-- 
--	print("PET_BATTLE_QUEUE_PROPOSE_MATCH")
	print("Auto-accepting pet PvP match!")
	C_PetBattles.AcceptQueuedPVPMatch()
end

function events:PET_BATTLE_QUEUE_STATUS(...)				-- 
--	print("PET_BATTLE_QUEUE_STATUS")
end

function events:PET_BATTLE_TURN_STARTED(...)				-- 
	print("PET_BATTLE_TURN_STARTED")
end

function events:PET_BATTLE_XP_CHANGED(...)					-- 
--	print("PET_BATTLE_XP_CHANGED")
end

mypetbattle_frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);

-- Register all events for which handlers have been defined
for k, v in pairs(events) do
 mypetbattle_frame:RegisterEvent(k); 
end


--------------------
-- SLASH COMMANDS --
--------------------
SLASH_MYPETBATTLE1 = '/mypetbattle'
function SlashCmdList.MYPETBATTLE(msg, editbox)
	if msg == "" then
		mypetbattle_enabled = not mypetbattle_enabled
		if mypetbattle_enabled then status = "\124cFF00FF00Enabled" else status = "\124cFFFF0000Disabled" end
	elseif msg == "join_pvp" then
		mypetbattle_join_pvp = not mypetbattle_join_pvp
		if mypetbattle_join_pvp then 
			status = "\124cFF00FF00PvP enabled"
			-- if C_PetBattles.GetPVPMatchmakingInfo == nil then
				C_PetBattles.StartPVPMatchmaking()
			-- end
		else 
			status = "\124cFFFF0000PvP disabled"
			-- if C_PetBattles.GetPVPMatchmakingInfo ~= nil then
				C_PetBattles.StopPVPMatchmaking()
			-- end
		end
	elseif msg == "capture_rares" then
		mypetbattle_capture_rares = not mypetbattle_capture_rares
		if mypetbattle_capture_rares then status = "\124cFF00FF00Automatic capture rare pets enabled" else status = "\124cFFFF0000Automatic capture rare pets disabled" end
	end
	print("My pet battle:", status)
end