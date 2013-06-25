-- http://www.wowpedia.org/API
----------------------------
---- ROTATION FUNCTIONS ----
----------------------------
-- Get pet health
function MyPetBattle.hp(PetID,petOwner)
	if petOwner == nil then petOwner = LE_BATTLE_PET_ALLY end
	if PetID == nil or PetID == "active" then PetID = C_PetBattles.GetActivePet(petOwner) end
	return C_PetBattles.GetHealth(petOwner, PetID)/C_PetBattles.GetMaxHealth(petOwner, PetID)
end

-- Get pet species name
function MyPetBattle.petName(petIndex)
	if petIndex == nil then petIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY) end
	local name, speciesName = C_PetBattles.GetName(LE_BATTLE_PET_ALLY, petIndex)
	return speciesName
end

-- Check buff/debuff on player
function MyPetBattle.buff(auraName,petIndex)
	if petIndex == nil then petIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY) end
	local numAuras = C_PetBattles.GetNumAuras(LE_BATTLE_PET_ALLY, petIndex)
	-- Checking front pet buffs
	for auraIndex = 1,numAuras do 
		local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_ALLY, petIndex, auraIndex)
		local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(auraID)
		if name == auraName then  return true,turnsRemaining end
	end

	-- Checking team wide buffs
	local numTeamwideAuras = C_PetBattles.GetNumAuras(LE_BATTLE_PET_ALLY, PET_BATTLE_PAD_INDEX) or 0; -- Can be nil
	for auraIndex = 1, numTeamwideAuras do
		local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_ALLY, PET_BATTLE_PAD_INDEX, auraIndex)
		local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(auraID)
		if name == auraName then  return true,turnsRemaining end
	end
	
	return false
end

-- Check buff/debuff on enemy
function MyPetBattle.debuff(auraName,petIndex)
	if petIndex == nil then petIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY) end
	local numAuras = C_PetBattles.GetNumAuras(LE_BATTLE_PET_ENEMY, petIndex)

	-- Checking front pet buffs
	for auraIndex=1,numAuras do 
		local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_ENEMY, petIndex, auraIndex)
		local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(auraID)
		if name == auraName then  return true,turnsRemaining end
	end

	-- Checking team wide buffs
	local numTeamwideAuras = C_PetBattles.GetNumAuras(LE_BATTLE_PET_ENEMY, PET_BATTLE_PAD_INDEX) or 0; -- Can be nil
	for auraIndex = 1, numTeamwideAuras do
		local auraID, instanceID, turnsRemaining, isBuff = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_ENEMY, PET_BATTLE_PAD_INDEX, auraIndex)
		local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(auraID)
		if name == auraName then  return true,turnsRemaining end
	end

	return false
end

-- Check speed of player or enemy pet
function MyPetBattle.currentPetSpeed(petOwner) -- petOwner: 1 = player, 2 = enemy
	local petSpeed = C_PetBattles.GetSpeed(petOwner, C_PetBattles.GetActivePet(petOwner))
	return petSpeed
end

-- Check for weather effect
function MyPetBattle.currentWeather(weather)
	local auraID, instanceID, turnsRemaining, isBuff,_,_ = C_PetBattles.GetAuraInfo(LE_BATTLE_PET_WEATHER, PET_BATTLE_PAD_INDEX, 1)

	if auraID ~= nil then
		local id, currentWeather, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID(auraID)
		--	print("Current weather is: " .. currentWeather)

		if weather == currentWeather then return true end
	end
	return false		
end

-----------------------------
---- FRAMEWORK FUNCTIONS ----
-----------------------------
-- Check if we can cast the spell
function MyPetBattle.canCast(spell)
	if spell == nil then  return false end
	
	local petOwner = LE_BATTLE_PET_ALLY
	local activePetIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)

	-- Check if the spell is on the actionbar 
	for i_=1,3 do 
		local id, name, icon, maxCooldown, desc, numTurns, petType, noStrongWeakHints  = C_PetBattles.GetAbilityInfo(petOwner, activePetIndex, i_)
		if spell == name then
--			print("We have the spell on slot: ", i_)
			-- Check if the spell is on cooldown
			local isUsable, currentCooldown, currentLockdown = C_PetBattles.GetAbilityState(petOwner, activePetIndex, i_)
			if isUsable then
--				print("The spell is ready (not on cooldown)")
				return true
			else
--				print("Spell is on cooldown")
				return false
			end
		end
	end
--	print("We do not have the spell")
	return false
end

-- Check conditions in spellTable
function MyPetBattle.conditionsMatched(spell,conditions)
	-- nil
	if spell == nil then
		return false
	-- nil
	elseif conditions == nil then
		return true
	-- onCD
	elseif conditions == "onCD" then
		return true
	-- otherwise
	else
		return conditions
	end
end

-- Parse spellTable
function MyPetBattle.parseSpellTable(petSpellTable)
	local spell = nil
	local conditions = nil
	
	for _, spellTable in pairs(petSpellTable) do
		spell = spellTable[1] 
		conditions = spellTable[2]
		-- Return spell if conditions are true and spell is castable.
		if MyPetBattle.conditionsMatched(spell,conditions) and MyPetBattle.canCast(spell) then
			return spell
		end
	end
	return nil
end

-- Check if the spell is on the actionbar and in which slot number (1-3)
function MyPetBattle.getSpellSlotIndex(spell)
	if spell == nil then  return false end
	
	local petOwner = LE_BATTLE_PET_ALLY
	local activePetIndex = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)

	-- Check if the spell is on the actionbar 
	for i_=1,3 do 
		local id, name, icon, maxCooldown, desc, numTurns, petType, noStrongWeakHints  = C_PetBattles.GetAbilityInfo(petOwner, activePetIndex, i_)
		if spell == name then
--			print("Spell slot index: ", i_)
			return i_
		end
	end
end

-- Check if we can capture the rare we are fighting. Used to determine if we should capture or kill our enemy.
function MyPetBattle.canCaptureRare()
	local petOwner = LE_BATTLE_PET_ENEMY
	local activeEnemyPetIndex = C_PetBattles.GetActivePet(petOwner)
	local rarity = C_PetBattles.GetBreedQuality(petOwner, activeEnemyPetIndex)
	local trapIsUsable = C_PetBattles.IsTrapAvailable() -- Will not become usable if we are capped with the pet we are trying to capture (3/3)

	if trapIsUsable and (rarity == 4 or rarity == 5 or rarity == 6) then -- 4: "Rare", 5: "Epic", 6: "Legendary"
--		print("|cFF8A2BE2 We are trying to capture a rare!")
		return true
	end
	return false
end

-- New improved team setup
function MyPetBattle.setTeam(avgLevel)
--	print("Set team v2")
	-- /run MyPetBattle.setTeam(14)

	print("|cFF4169E1 Setting team...!")

	-- Check if string and convert to number
	if type(avgLevel) == "string" then avgLevel = tonumber(avgLevel) end

	-- Check if user has set a level for the team
	if avgLevel == "" or avgLevel == nil then 
		print("Please set a desired level for the team!") 
		return
	end

	-- Check level is not below 1 or above 25
	if avgLevel < 1 or avgLevel > 25 then 
		print("Level", avgLevel, "is not valid, please set a level between 1-25!") 
		return
	end

	-- Sort the pet journal
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true) -- Pets you have collected
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false) -- Pets you have set as favorites
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, false) -- Pets you have not collected
	
	-- Start to set the team	
	local numPets, numOwned = C_PetJournal.GetNumPets()
	local m_ = 1

	local pet1_set = false
	local pet2_set = false
	local pet3_set = false
	
	local pet1_guid, pet2_guid, pet3_guid

	-- LOAD HEALTH THRESHOLD FROM SAVED VARIABLES
	local healthThreshold = MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD -- Pets for the team must have above x.x health (0.0 -> 1.0)
	
	-- PET 1 SETUP
	-- Make sure we step in the right direction according to the saved variables in config
	local pet1_start, pet1_end, pet1_step
	if MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT < 0 then
		pet1_start = MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT
		pet1_end = 3
		pet1_step = 1
	elseif MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT == 0 then
		pet1_start = MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT
		pet1_end = 0
		pet1_step = 1

	elseif MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT > 0 then
		pet1_start = MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT
		pet1_end = -3
		pet1_step = -1
	end
	for p_ = pet1_start, pet1_end, pet1_step do
		if pet1_set or MPB_LOCK_PET1 then break end -- Also check if pet is locked
		for n_ = 1, numPets do			
			local petID, _, owned, _, level, _, isRevoked, speciesName, icon, petType, _, _, _, _, canBattle, _, _, obtainable = C_PetJournal.GetPetInfoByIndex(n_)
			local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)
			
			local healthPercent = health / maxHealth

			-- Check if we own the pet, it is a battle pet, it is alive and of rare quality
			if owned and canBattle and not isRevoked and healthPercent > healthThreshold and rarity == 4 and level == avgLevel+p_ then
				-- Set found pet to pet 1	
				C_PetJournal.SetPetLoadOutInfo(1, petID) -- Pet slot 1
				-- Save pet 1 guid
				pet1_guid = petID
				-- Update UI elements for pet 1
				Pet1_texture:SetTexture(icon)
				Pet1_level_string:SetText(level)
				-- Print to chat
--				print("Pet 1: Name: " .. speciesName .. " (Level: " .. level .. ")")
				pet1_set = true
				break -- break loop as we found a pet for pet 1
			end	
		end
	end		
		
	-- PET 2 SETUP	
	-- Make sure we step in the right direction according to the saved variables in config
	local pet2_start, pet2_end, pet2_step
	if MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT < 0 then
		pet2_start = MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT
		pet2_end = 3
		pet2_step = 1
	elseif MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT == 0 then
		pet2_start = MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT
		pet2_end = 0
		pet2_step = 1

	elseif MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT > 0 then
		pet2_start = MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT
		pet2_end = -3
		pet2_step = -1
	end
	for p_ = pet2_start, pet2_end, pet2_step do
		if pet2_set or MPB_LOCK_PET2 then break end -- Also check if pet is locked
		for n_ = 1, numPets do
			local petID, _, owned, _, level, _, isRevoked, speciesName, icon, petType, _, _, _, _, canBattle, _, _, obtainable = C_PetJournal.GetPetInfoByIndex(n_)
			local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)
			
			local healthPercent = health / maxHealth

			-- Check if we own the pet, it is a battle pet, it is alive and of rare quality
			if owned and canBattle and not isRevoked and healthPercent > healthThreshold and rarity == 4 and level == avgLevel+p_ and petID ~= pet1_guid then
				-- Set found pet to pet 2	
				C_PetJournal.SetPetLoadOutInfo(2, petID) -- Pet slot 2
				-- Save pet 1 guid
				pet2_guid = petID
				-- Update UI elements for pet 2
				Pet2_texture:SetTexture(icon)
				Pet2_level_string:SetText(level)
				-- Print to chat
--				print("Pet 2: Name: " .. speciesName .. " (Level: " .. level .. ")")
				pet2_set = true
				break -- break loop as we found a pet for pet 2
			end	
		end
	end		

	-- Pet 3 setup	
	-- Make sure we step in the right direction according to the saved variables in config
	local pet3_start, pet3_end, pet3_step
	if MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT < 0 then
		pet3_start = MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT
		pet3_end = 3
		pet3_step = 1
	elseif MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT == 0 then
		pet3_start = MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT
		pet3_end = 0
		pet3_step = 1
	elseif MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT > 0 then
		pet3_start = MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT
		pet3_end = -3
		pet3_step = -1
	end
	for p_ = pet3_start, pet3_end, pet3_step do
		if pet3_set or MPB_LOCK_PET3 then break end -- Also check if pet is locked
		for n_ = 1, numPets do
			local petID, _, owned, _, level, _, isRevoked, speciesName, icon, petType, _, _, _, _, canBattle, _, _, obtainable = C_PetJournal.GetPetInfoByIndex(n_)
			local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)
			
			local healthPercent = health / maxHealth

			-- Check if we own the pet, it is a battle pet, it is alive and of rare quality
			if owned and canBattle and not isRevoked and healthPercent > healthThreshold and rarity == 4 and level == avgLevel+p_ and petID ~= pet1_guid and petID ~= pet2_guid then
				-- Set found pet to pet 3	
				C_PetJournal.SetPetLoadOutInfo(3, petID) -- Pet slot 3
				-- Save pet 1 guid
				pet3_guid = petID
				-- Update UI elements for pet 3
				Pet3_texture:SetTexture(icon)
				Pet3_level_string:SetText(level)
				-- Print to chat
--				print("Pet 3: Name: " .. speciesName .. " (Level: " .. level .. ")")
				pet3_set = true
				break -- break loop as we found a pet for pet 3
			end	
		end
	end		
		
	-- Print to chat
	if (pet1_set or MPB_LOCK_PET1) and (pet2_set or MPB_LOCK_PET2) and (pet3_set or MPB_LOCK_PET3) then
		print("|cFFADFF2F Done setting team!")
	else
		print("|cFFFF0033 Could not set a team, please check health, levels or set the team manually!")
		if not pet1_set and not MPB_LOCK_PET1 then print("- Failed to set pet 1") end
		if not pet2_set and not MPB_LOCK_PET2 then print("- Failed to set pet 2") end
		if not pet3_set and not MPB_LOCK_PET3 then print("- Failed to set pet 3") end
	end

	-- Update the WoW pet journal UI with our new pets
	PetJournal_UpdatePetLoadOut() 
	
	return
end

function MyPetBattle.revive_and_heal_Pets()
	-- Check cooldowns and availability of revive spell and bandages
	local Revive_start, Revive_duration, Revive_enabled = GetSpellCooldown("Revive Battle Pets") -- Cooldown: 8 min. = 480 sec
	local Revive_spell_link, _ = GetSpellLink("Revive Battle Pets")
	local ReviveCooldown_Remaining = Revive_start+Revive_duration-GetTime()



	local Bandage_count = GetItemCount("Battle Pet Bandage", nil, nil)
	local _, Bandage_itemLink, _, _, _, _, _, _, _, Bandage_itemTexture, _ = GetItemInfo("Battle Pet Bandage")

	if MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT and Revive_start == 0 then
		-- Cast "Revive Battle Pets"
		CastSpellByName("Revive Battle Pets")
		print("Casting: ".. Revive_spell_link)
	elseif MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT and Bandage_count > 0 and ReviveCooldown_Remaining > 210 and ReviveCooldown_Remaining < 270 then	-- Of revive cooldown is between 3.5 and 4.5 min
		-- Use "Battle Pet Bandage"
		UseItemByName("Battle Pet Bandage")
		print("Using: \124T"..Bandage_itemTexture..":0\124t "..Bandage_itemLink )
	end
end

-- shouldIHide - return true if the enemy pet has an ability likely to hit
--               us hard. This might also be used to decide NOT to cast a
--               big ability given they are hit but another function might
--               be better given this is a 'hide', enemy hidden can also be
--               a wrap that doesn't end in a big hit (we'd just want to not
--               waste a big hit on that)
function MyPetBattle.shouldIHide()
    -- cannot check flying as it's also a buff when it's a bird. which is dumb
    -- local hidefrom={"Underwater","Flying"}
    local hidefrom={"Underwater","Underground","Chew"}
    for k,v in pairs(hidefrom) do
        t,d = MyPetBattle.debuff(v) 
        if t == true then
            return true
        end
    end
    return false
end
