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
	if numAuras == nil then return false end -- Return false if nil, e.g. when NOT in battle

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
	if numAuras == nil then return false end -- Return false if nil, e.g. when NOT in battle

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

-- Check if a spell is strong against our current target
function MyPetBattle.abilityIsStrong(spell)
	local activePetSlot = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)
	local enemyPetSlot = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)
	local enemyType = C_PetBattles.GetPetType(LE_BATTLE_PET_ENEMY, enemyPetSlot)
	-- Check if the spell is on the actionbar 
	for i_=1,3 do 
		local abilityName, abilityType, noHints
		_, abilityName, _, _, _, _, abilityType, noHints = C_PetBattles.GetAbilityInfo(LE_BATTLE_PET_ALLY, activePetSlot, i_)
		if spell == abilityName then
			local modifier = C_PetBattles.GetAttackModifier(abilityType, enemyType)
			if(modifier < 1) then
--				print(abilityName .. " is weak against enemy")
				return false
			elseif(modifier > 1) then
--				print(abilityName .. " is strong against enemy")
				return true
			else
--				print(abilityName .. " is normal strength against enemy")
				return false
			end
		end
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

-- Check if we can capture the common/uncommon we are fighting. Used to determine if we should capture or kill our enemy.
function MyPetBattle.canCaptureCommon()
	local petOwner = LE_BATTLE_PET_ENEMY
	local activeEnemyPetIndex = C_PetBattles.GetActivePet(petOwner)
	local rarity = C_PetBattles.GetBreedQuality(petOwner, activeEnemyPetIndex)
	local trapIsUsable = C_PetBattles.IsTrapAvailable() -- Check if we can use trap e.g. pet is at low health

	local speciesID = C_PetBattles.GetPetSpeciesID(petOwner, activeEnemyPetIndex)
	local numCollected, limit = C_PetJournal.GetNumCollectedInfo(speciesID)

	if numCollected == 0 and limit > 0 and trapIsUsable and (rarity == 2 or rarity == 3) then -- 2: "Common", 3: "Uncommon"
--		print("|cFF8A2BE2 We are trying to capture a common/uncommon!")
		return true
	end
	return false
end


MyPetBattleVars.levelUpdate = {}
MyPetBattleVars.levelUpdate.mismatchedSet = {}
--MyPetBattleVars.levelUpdate.mismatchedGet = {} -- this mismatch happens often, so we'll just count them:
MyPetBattleVars.levelUpdate.mismatchedGetCount = 0
MyPetBattleVars.levelUpdate.mismatchedGetGreater = {}
MyPetBattleVars.levelUpdate.nullGet = {}
MyPetBattleVars.levelUpdate.updatedLevels = {}

function MyPetBattle.setPetLevel(petIndex, newLevel, currentLevel)
	local petGUID = C_PetJournal.GetPetLoadOutInfo(petIndex)
	if newLevel ~= currentLevel then
		table.insert(MyPetBattleVars.levelUpdate.mismatchedSet, {pet=petGUID, current=currentLevel, new=newLevel})
	end
	MyPetBattleVars.levelUpdate.updatedLevels[petGUID] = newLevel
end

function MyPetBattle.getPetLevel(whereMessage, petGUID, currentLevel)
	newLevel = MyPetBattleVars.levelUpdate.updatedLevels[petGUID]
	if not newLevel then
		if not currentLevel then
			table.insert(MyPetBattleVars.levelUpdate.nullGet, {where=whereMessage, pet=petGUID, current=currentLevel, new=newLevel})
		end
		return currentLevel
	elseif newLevel == currentLevel then
		MyPetBattleVars.levelUpdate.updatedLevels[petGUID] = nil
		return currentLevel
	else
		-- table.insert(MyPetBattleVars.levelUpdate.mismatchedGet, {where=whereMessage, pet=petGUID, current=currentLevel, new=newLevel})
		MyPetBattleVars.levelUpdate.mismatchedGetCount = MyPetBattleVars.levelUpdate.mismatchedGetCount + 1
		if newLevel > currentLevel then
			return newLevel
		else
			table.insert(MyPetBattleVars.levelUpdate.mismatchedGetGreater, {where=whereMessage, current=currentLevel, new=newLevel})
			return currentLevel
		end
	end
end


--[
-- following code from PetJournalEnhanced for sorting a table by arbitrary number of column fields
local ASCENDING = 1
local DESCENDING = 2

function MyPetBattle.getCompareFunc(var,func,direction)
	return function(a,b)
		local avar = a[var]
		local bvar = b[var]
		if type(avar) == "boolean" then 
			avar = avar and 1 or 0
			bvar = bvar and 1 or 0 
		end

		if avar == bvar and func then
			return func(a,b)
		end

		if direction then
			if direction == ASCENDING then
				return avar < bvar
			elseif  direction == DESCENDING then
				return avar > bvar
			end
		end
	end
end

function MyPetBattle.composeSortFunction(funcstart, ...)
	local args = {...}
	local func = funcstart
	for i=#args,1,-2 do
		local name = args[i-1];
		local direction = args[i]
		--print ("composeSortFunction", name, direction, func)
		func = MyPetBattle.getCompareFunc(name,func,direction)
	end
	return func
end
--]

function MyPetBattle.loopPets(handler)
-- Note: you must call countPets first
	local rarity_end
	rarity_end = MPB.USE_NON_RARE and 1 or 4
	local numPets, numOwned = C_PetJournal.GetNumPets()

	for n_ = 1, numPets do
		local pet = {}
		local _
		pet.petID, pet.speciesID, pet.owned, _, pet.level, _, pet.isRevoked, pet.speciesName, pet.icon, _, _, _, _, _, pet.canBattle = C_PetJournal.GetPetInfoByIndex(n_)
		pet.level = MyPetBattle.getPetLevel("loopPets", pet.petID, pet.level)

		-- Check if we own the pet, it is a battle pet, it is alive and of appropriate quality
		if pet.owned and pet.canBattle and not pet.isRevoked and not MyPetBattleVars.used_petguids[pet.petID] then
			local petIsSummonable = C_PetJournal.PetIsSummonable(pet.petID) -- Check if we can actually summon the pet e.g. alliance/horde only (also works for revoked)
			if petIsSummonable then
				pet.health, pet.maxHealth, pet.power, pet.speed, pet.rarity = C_PetJournal.GetPetStats(pet.petID)
				
				if pet.rarity >= rarity_end then
					handler(pet)
				end
			end
		end
	end
end

function MyPetBattle.countPets()
	MyPetBattleVars.lockedpetlevels = {0,0,0}
	MyPetBattleVars.used_petguids = {}
	for s_ = 1, 3 do
		if _G["MPB_LOCK_PET"..s_] then -- Check if pet is locked
			local petGUID = C_PetJournal.GetPetLoadOutInfo(s_)
			local _, _, level = C_PetJournal.GetPetInfoByPetID(petGUID)
			level = MyPetBattle.getPetLevel("countPets", petGUID, level)
			MyPetBattleVars.lockedpetlevels[s_] = level
			MyPetBattleVars.used_petguids[petGUID] = s_
		end
	end

	-- count the number of pets at each level
	MyPetBattleVars.petLevels = {}; for n_ = 1, 25 do MyPetBattleVars.petLevels[n_] = {r=0,n=0,t=0,ur=0,un=0} end -- rare, non-rare, both (if non-rare is enabled, else rare), useable (has enough health) rare/non-rare

	-- LOAD HEALTH THRESHOLD FROM SAVED VARIABLES
	local healthThreshold = MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD

	local function countPetsHandler(pet)
		local petLevel = MyPetBattleVars.petLevels[pet.level]
		petLevel.t = petLevel.t + 1
		petLevel[pet.rarity == 4 and "r" or "n"] = petLevel[pet.rarity == 4 and "r" or "n"] + 1 -- these counts aren't actually used anywhere
		local healthPercent = pet.health / pet.maxHealth
		if healthPercent > healthThreshold then -- Pets for the team must have above x.x health (0.0 -> 1.0)
			petLevel[pet.rarity == 4 and "ur" or "un"] = petLevel[pet.rarity == 4 and "ur" or "un"] + 1
		end
	end

	MyPetBattle.loopPets(countPetsHandler)
end


-- New improved team setup
function MyPetBattle.setTeam(avgLevel)
--	print("Set team v2")
	-- /run MyPetBattle.setTeam(14)

	print("|cffff8000MPB|r: |cFF4169E1Setting team...!")

	local petGUID = C_PetJournal.GetPetLoadOutInfo(1)
	if not petGUID then
		print("|cffff8000MPB|r: |cFFFF0033Not ready to set team!") 
		return
	end

	-- Check if string and convert to number
	if type(avgLevel) == "string" then avgLevel = tonumber(avgLevel) end

	-- Check if user has set a level for the team
	if avgLevel == "" or avgLevel == nil then 
		print("|cffff8000MPB|r: |cFFFF0033Please set a desired level for the team!") 
		return
	end

	-- Check level is not below 1 or above 25
	if avgLevel < 1 or avgLevel > 25 then 
		print("|cffff8000MPB|r: |cFFFF0033Level " .. avgLevel .. " is not valid, please set a level between 1-25!") 
		return
	end

	-- Sort the pet journal
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true) -- Pets you have collected
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false) -- Pets you have set as favorites
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, false) -- Pets you have not collected
	
	-- Start to set the team	

	local pet_set = {false,false,false} -- slot 1 to 3: true if we successfully set the pet
	
	MyPetBattleVars.petList = {} -- For each slot, contains a sorted table of possible pets for each slot. the first pet is chosen for the slot.

	-- LOAD HEALTH THRESHOLD FROM SAVED VARIABLES
	local healthThreshold = MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD -- Pets for the team must have above x.x health (0.0 -> 1.0)

	MyPetBattle.countPets()

	MyPetBattleVars.levelRange = {step = MPB.MATCH_PET_LEVELS_LEVEL_STEP}
	local levelRange = MyPetBattleVars.levelRange
	local prioritize = {level = MPB.PRIORITIZE_LEVEL}

	MyPetBattleVars.neededLevels = {}
	MyPetBattleVars.neededLevelsEnemy = {}
	MyPetBattleVars.commonLevels = {}

	local enemyIsLeader, enemyUseNonRare, enemyAutoForfeit, enemyNumKeepOfLevel
		
	local doMatchLevels = mypetbattle_wintrade_enabled and MPB.MATCH_PET_LEVELS_DURING_WT
	if doMatchLevels then

        -- MATCH_POS_ constants:
        local MATCH_POS_MATCH                   = 1  -- m=match
        local MATCH_POS_ACK                     = 2  --  a=acknowledge
        local MATCH_POS_FORFEIT                 = 3  --   f=forfeit
        local MATCH_POS_LEADER                  = 4  --    L=Leader (leader of the party UnitIsGroupLeader("player"))
        local MATCH_POS_PRIORITIZE_LEVEL        = 5  --     1=MPB.PRIORITIZE_LEVEL
        local MATCH_POS_USE_NON_RARE            = 6  --      1=MPB.USE_NON_RARE
        local MATCH_POS_SLOT_1_LOCK             = 8  --        ##=slot 1 locked level
        local MATCH_POS_SLOT_2_LOCK             = 10 --          ##=slot 2 locked level
        local MATCH_POS_SLOT_3_LOCK             = 12 --            ##=slot 3 locked level
        local MATCH_POS_START_LEVEL             = 15 --               ##=levelRange.start
        local MATCH_POS_LEVEL_STEP              = 17 --                 ?=level_step +/-
        local MATCH_POS_MIN_KEEP                = 18 --                  #=number to keep of each level
        local MATCH_POS_LEVELS                  = 20 --                    ###=count (0-9) of pets for each level (1-25)
                                                     --                    #=total count for a level
                                                     --                     #=useable non_rare count
                                                     --                      #=useable rare count

                                                     -- mafL10 121200 24-1 111222333444555666777888999000111222333444555666777888999000111222333444555
                                                     -- m...01 000025 01+3 111222333444555666777888999000111222333444555666777888999000111222333444555

		enemyAutoForfeit = string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_FORFEIT, MATCH_POS_FORFEIT) == "f"
		levelRange.startEnemy = tonumber(string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_START_LEVEL, MATCH_POS_START_LEVEL + 1))
		levelRange.stepEnemy = tonumber(string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_LEVEL_STEP, MATCH_POS_LEVEL_STEP).."1")
		enemyUseNonRare = string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_USE_NON_RARE, MATCH_POS_USE_NON_RARE) == "1"
		enemyNumKeepOfLevel = tonumber(string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_MIN_KEEP, MATCH_POS_MIN_KEEP))
		prioritize.levelEnemy = string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_PRIORITIZE_LEVEL, MATCH_POS_PRIORITIZE_LEVEL) == "1"

		if mypetbattle_auto_forfeit ~= enemyAutoForfeit then
			enemyIsLeader = mypetbattle_auto_forfeit
		elseif mypetbattle_auto_forfeit then
			print("|cffff8000MPB|r: |cFFFF0033Both players can't auto forfeit! Change the auto forfeit option.")
			return
		elseif UnitIsGroupLeader("player") ~= (string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_LEADER, MATCH_POS_LEADER) == "L") then
			enemyIsLeader = not UnitIsGroupLeader("player")
		else
			print("|cffff8000MPB|r: |cFFFF0033Could not determine the leader! Change the auto forfeit option or promote yourself or the enemy to leader.")
			return
		end

		-- calculate the allowed level range
		levelRange.start = MPB.MATCH_PET_LEVELS_START_LEVEL
		
		for _, suffix in pairs({"", "Enemy"}) do
			if levelRange["step"..suffix] > 0 then
				levelRange["lowest"..suffix] = levelRange["start"..suffix]
				levelRange["highest"..suffix] = 25
			else
				levelRange["lowest"..suffix] = 1
				levelRange["highest"..suffix] = levelRange["start"..suffix]
			end
		end
		
		-- populate the array that keeps count of the enemy pets
		MyPetBattleVars.petLevelsEnemy = {}
		for n_ = 1,25 do
			MyPetBattleVars.petLevelsEnemy[n_] = {
				t = tonumber(string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_LEVELS + n_ * 3 - 3, MATCH_POS_LEVELS + n_ * 3 - 3)),
				un = tonumber(string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_LEVELS + n_ * 3 - 2, MATCH_POS_LEVELS + n_ * 3 - 2)),
				ur = tonumber(string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_LEVELS + n_ * 3 - 1, MATCH_POS_LEVELS + n_ * 3 - 1))
			}
		end

		-- check the list of pets the enemy has locked, we need to match these levels
		for s_ = 1,3 do
			local enemyLockedLevel = tonumber(string.sub(MyPetBattleVars.petListEnemy, MATCH_POS_SLOT_1_LOCK + s_ * 2 - 2, MATCH_POS_SLOT_1_LOCK + s_ * 2 - 1))
			if enemyLockedLevel > 0 then
				print("|cffff8000MPB|r: Enemy Pet " .. s_ .. ": Locked Level: " .. enemyLockedLevel)
				table.insert(MyPetBattleVars.neededLevels, enemyLockedLevel)
			end
		end

		-- but we don't need a match if we have a locked pet of the same level
		for s_ = 1,3 do
			if _G["MPB_LOCK_PET"..s_] then
				local foundMatch = false
				for s2 = 1,#MyPetBattleVars.neededLevels do
					if MyPetBattleVars.lockedpetlevels[s_] == MyPetBattleVars.neededLevels[s2] then
						table.insert(MyPetBattleVars.commonLevels, MyPetBattleVars.neededLevels[s2])
						table.remove(MyPetBattleVars.neededLevels, s2)
						foundMatch = true
						break
					end
				end
				if not foundMatch then
					table.insert(MyPetBattleVars.neededLevelsEnemy, MyPetBattleVars.lockedpetlevels[s_])
				end
			end
		end
		
		if #MyPetBattleVars.neededLevels + #MyPetBattleVars.neededLevelsEnemy + #MyPetBattleVars.commonLevels > 3 then
			print("|cffff8000MPB|r: |cFFFF0033There are too many locked pets on both teams! Unlock some pets.")
			return
		end
		
		local function HandleLockedPets(suffix, autoForfeit, numKeepOfLevel, useNonRare, failMessage)
			--print ("HandleLockedPets", "suffix", suffix, "autoForfeit", autoForfeit, "numKeepOfLevel", numKeepOfLevel, "useNonRare", useNonRare, "prioritize.level"..suffix, prioritize["level"..suffix], "levelRange.step"..suffix, levelRange["step"..suffix])
			--print('======================')
			local sortFunction
			if prioritize["level"..suffix] then
				sortFunction = MyPetBattle.composeSortFunction(nil, "levelOutOfRange",ASCENDING,"leveldiff",ASCENDING,"rarityGroup",DESCENDING,"level",levelRange["step"..suffix] > 0 and ASCENDING or DESCENDING)
			else
				sortFunction = MyPetBattle.composeSortFunction(nil, "levelOutOfRange",ASCENDING,"rarityGroup",DESCENDING,"leveldiff",ASCENDING,"level",levelRange["step"..suffix] > 0 and ASCENDING or DESCENDING)
			end
		
			for i_ = 1,#MyPetBattleVars["neededLevels"..suffix] do
				local neededLevel = MyPetBattleVars["neededLevels"..suffix][i_]
				MyPetBattleVars.petList["neededLevels" .. suffix .. i_] = {}
				for n_ = levelRange["lowest"..suffix], 25 do
					if (n_ <= levelRange["highest"..suffix] or n_ == 25) and (autoForfeit or MyPetBattleVars["petLevels"..suffix][n_].t > numKeepOfLevel) and (MyPetBattleVars["petLevels"..suffix][n_].ur + (useNonRare and MyPetBattleVars["petLevels"..suffix][n_].un or 0) > 0) then
						local theleveldiff = math.abs(n_ - neededLevel)
						if theleveldiff <= 1 then
							local pet = {
								level = n_,
								leveldiff = theleveldiff,
								levelOutOfRange = (n_ > levelRange["highest"..suffix]),
								rarityGroup = (MyPetBattleVars["petLevels"..suffix][n_].ur > 0 and 4) or 1
							}
							table.insert(MyPetBattleVars.petList["neededLevels" .. suffix .. i_], pet)
						end
					end
				end
				table.sort(MyPetBattleVars.petList["neededLevels" .. suffix .. i_], sortFunction)
				if #MyPetBattleVars.petList["neededLevels" .. suffix .. i_] > 0 then
					local pet = MyPetBattleVars.petList["neededLevels" .. suffix .. i_][1]
					MyPetBattleVars["petLevels"..suffix][pet.level].t = MyPetBattleVars["petLevels"..suffix][pet.level].t - 1
					MyPetBattleVars["petLevels"..suffix][pet.level][pet.rarityGroup == 4 and "ur" or "un"] = MyPetBattleVars["petLevels"..suffix][pet.level][pet.rarityGroup == 4 and "ur" or "un"] - 1
				else
					print("|cffff8000MPB|r: |cFFFF0033"..failMessage.." " .. neededLevel .. " within the allowable level range.")
					return false
				end
			end
			return true
		end
		
		-- remove neededLevels from the enemy list
		if not HandleLockedPets("Enemy", enemyAutoForfeit, enemyNumKeepOfLevel, enemyUseNonRare,
				"The enemy doesn't have a pet to match your team's locked pet level") then
			return
		end

		-- choose our neededLevels and remove them from our list
		if not HandleLockedPets("", mypetbattle_auto_forfeit, MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL, MPB.USE_NON_RARE,
				"You don't have a pet to match the enemy team's locked pet level") then
			return
		end

		--print('======================')
		local sortFunction
		for _, suffix in pairs({enemyIsLeader and "" or "Enemy", enemyIsLeader and "Enemy" or ""}) do
			--print("prioritize.level"..suffix, prioritize["level"..suffix])
			if prioritize["level"..suffix] then
				sortFunction = MyPetBattle.composeSortFunction(sortFunction, "levelOutOfRange",ASCENDING,"leveldiff",ASCENDING,"rarityGroup"..suffix,DESCENDING,"level"..suffix,levelRange["step"..suffix] > 0 and ASCENDING or DESCENDING)
			else
				sortFunction = MyPetBattle.composeSortFunction(sortFunction, "levelOutOfRange",ASCENDING,"rarityGroup"..suffix,DESCENDING,"leveldiff",ASCENDING,"level"..suffix,levelRange["step"..suffix] > 0 and ASCENDING or DESCENDING)
			end
		end
		
		-- Choose our remaining slot levels and remove them from both lists.
		-- As a last resort, try pets of level 25 since they won't gain a level anyway.
		for i_ = #MyPetBattleVars.neededLevels + 1,3 do
			MyPetBattleVars.petList["matchLevels" .. i_] = {}
			for n_ = levelRange.lowest, 25 do
				if (n_ <= levelRange.highest or n_ == 25) and (mypetbattle_auto_forfeit or MyPetBattleVars.petLevels[n_].t > MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL) and (MyPetBattleVars.petLevels[n_].ur + (MPB.USE_NON_RARE and MyPetBattleVars.petLevels[n_].un or 0) > 0) then
					for n2_ = levelRange.lowestEnemy, 25 do
						if (n2_ <= levelRange.highestEnemy or n2_ == 25) and (enemyAutoForfeit or MyPetBattleVars.petLevelsEnemy[n2_].t > enemyNumKeepOfLevel) and (MyPetBattleVars.petLevelsEnemy[n2_].ur + (enemyUseNonRare and MyPetBattleVars.petLevelsEnemy[n2_].un or 0) > 0) then
							local theleveldiff = math.abs(n_ - n2_)
							if theleveldiff <= 1 then
								local pet = {
									level = n_,
									levelEnemy = n2_,
									leveldiff = theleveldiff,
									levelOutOfRange = (n_ > levelRange.highest or n2_ > levelRange.highestEnemy),
									rarityGroup = (MyPetBattleVars.petLevels[n_].ur > 0 and 4) or 1,
									rarityGroupEnemy = (MyPetBattleVars.petLevelsEnemy[n2_].ur > 0 and 4) or 1
								}
								table.insert(MyPetBattleVars.petList["matchLevels" .. i_], pet)
							end
						end
					end
				end
			end
			table.sort(MyPetBattleVars.petList["matchLevels" .. i_], sortFunction)
			if #MyPetBattleVars.petList["matchLevels" .. i_] > 0 then
				local pet = MyPetBattleVars.petList["matchLevels" .. i_][1]
				
				for _, suffix in pairs({"", "Enemy"}) do
					local level = pet["level"..suffix]
					local rarityGroup = pet["rarityGroup"..suffix]
					local petLevels = MyPetBattleVars["petLevels"..suffix]
					petLevels[level].t = petLevels[level].t - 1
					petLevels[level][rarityGroup == 4 and "ur" or "un"] = petLevels[level][rarityGroup == 4 and "ur" or "un"] - 1
				end
			else
				print("|cffff8000MPB|r: |cFFFF0033You don't have a pet to match the levels of any of the enemy's pets.")
				return
			end
		end

	end

	--print('======================')

	local matchCount = 0
	for s_ = 1, 3 do
		-- print ("doing slot " .. s_)
		MyPetBattleVars.petList[s_] = {}
		wipe(MyPetBattleVars.petList[s_])

		if _G["MPB_LOCK_PET"..s_] then

		else
			-- PET slot SETUP
			-- Make sure we step in the right direction according to the saved variables in config
		
			if doMatchLevels then
				matchCount = matchCount + 1
				local pet
				if matchCount <= #MyPetBattleVars.neededLevels then
					pet = MyPetBattleVars.petList["neededLevels"..matchCount][1];
				else
					pet = MyPetBattleVars.petList["matchLevels"..matchCount][1];
				end
				levelRange["start"..s_] = pet.level
				levelRange["lowest"..s_] = levelRange["start"..s_]
				levelRange["highest"..s_] = levelRange["start"..s_]
				levelRange["step"..s_] = levelRange.step
			else
				levelRange["start"..s_] = _G["MPB_CONFIG_TEAMSETUP_PET"..s_.."_LEVEL_ADJUSTMENT"]
				if levelRange["start"..s_] < 0 then
					levelRange["lowest"..s_] = levelRange["start"..s_]
					levelRange["highest"..s_] = 3
					levelRange["step"..s_] = 1
				elseif levelRange["start"..s_] == 0 then
					levelRange["lowest"..s_] = 0
					levelRange["highest"..s_] = 0
					levelRange["step"..s_] = 1
				elseif levelRange["start"..s_] > 0 then
					levelRange["lowest"..s_] = -3
					levelRange["highest"..s_] = levelRange["start"..s_]
					levelRange["step"..s_] = -1
				end
				levelRange["start"..s_] = levelRange["start"..s_] + avgLevel
				levelRange["lowest"..s_] = levelRange["lowest"..s_] + avgLevel
				levelRange["highest"..s_] = levelRange["highest"..s_] + avgLevel
				-- print("level start:", levelRange["start"..s_], "level low:", levelRange["lowest"..s_], "level high:", levelRange["highest"..s_])
			end

			local function selectPetTeamCandidatesHandler(pet)
				local healthPercent = pet.health / pet.maxHealth
				if healthPercent > healthThreshold and pet.level >= levelRange["lowest"..s_] and pet.level <= levelRange["highest"..s_] and (doMatchLevels or mypetbattle_auto_forfeit or MyPetBattleVars.petLevels[pet.level].t > MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL) then
					pet.leveldiff = math.abs(pet.level - levelRange["start"..s_]) -- levels closest to levelRange["start"..s_] take priority
					pet.rarityGroup = (pet.rarity == 4) and 4 or doMatchLevels and 1 or pet.rarity -- group rarity by rare and non-rare.
					pet.random = math.random()
					table.insert(MyPetBattleVars.petList[s_], pet)
				end
			end

			MyPetBattle.loopPets(selectPetTeamCandidatesHandler)

			if #MyPetBattleVars.petList[s_] > 0 then
				-- print("starting sorting slot " .. s_)
				local sortFunction
				if prioritize.level then
					sortFunction = MyPetBattle.composeSortFunction(nil, "leveldiff",ASCENDING,"rarityGroup",DESCENDING,"level",levelRange["step"..s_] > 0 and ASCENDING or DESCENDING,"rarity",DESCENDING,MPB.RANDOMIZE and "random" or "speciesName",ASCENDING,"petID",ASCENDING)
				else
					sortFunction = MyPetBattle.composeSortFunction(nil, "rarityGroup",DESCENDING,"leveldiff",ASCENDING,"level",levelRange["step"..s_] > 0 and ASCENDING or DESCENDING,"rarity",DESCENDING,MPB.RANDOMIZE and "random" or "speciesName",ASCENDING,"petID",ASCENDING)
				end

				table.sort(MyPetBattleVars.petList[s_], sortFunction)
				-- Set found pet to pet slot	
				local petGUID = C_PetJournal.GetPetLoadOutInfo(s_)
				local pet = MyPetBattleVars.petList[s_][1]
				if pet.petID ~= petGUID then
					C_PetJournal.SetPetLoadOutInfo(s_, pet.petID)
				end
				-- Save pet guid
				MyPetBattleVars.used_petguids[pet.petID] = s_
				
				if not doMatchLevels then
					-- we already did this above for doMatchLevels
					MyPetBattleVars.petLevels[pet.level].t = MyPetBattleVars.petLevels[pet.level].t - 1
				end
				-- Update UI elements for pet slot
				_G["Pet"..s_.."_texture"]:SetTexture(pet.icon)
				_G["Pet"..s_.."_level_string"]:SetText(pet.level)
				-- Print to chat
				print("|cffff8000MPB|r: Pet "..s_..": Name: " .. pet.speciesName .. " Level: " .. pet.level .. (pet.petID ~= petGUID and "" or " (unchanged)"))
				pet_set[s_] = true
			end

		end -- if not locked
	end -- for

	-- Print to chat
	if (pet_set[1] or MPB_LOCK_PET1) and (pet_set[2] or MPB_LOCK_PET2) and (pet_set[3] or MPB_LOCK_PET3) then
		print("|cffff8000MPB|r: |cFFADFF2FDone setting team!")
	else
		print("|cffff8000MPB|r: |cFFFF0033Could not set a team. Please check health, levels or set the team manually!")
		if not pet_set[1] and not MPB_LOCK_PET1 then print("- Failed to set pet 1") end
		if not pet_set[2] and not MPB_LOCK_PET2 then print("- Failed to set pet 2") end
		if not pet_set[3] and not MPB_LOCK_PET3 then print("- Failed to set pet 3") end
	end

	-- Update the WoW pet journal UI with our new pets
	PetJournal_UpdatePetLoadOut() 
end

function MyPetBattle.revive_and_heal_Pets()

	-- Do any of the useable pets require healing?
	local numPetsThatNeedHealing = 0
	local function healPetsHandler(pet)
		if pet.health < pet.maxHealth then
			numPetsThatNeedHealing = numPetsThatNeedHealing + 1
		end
	end
	MyPetBattle.loopPets(healPetsHandler)
	print("|cffff8000MPB|r: There " .. (numPetsThatNeedHealing == 1 and "is " or "are ") .. numPetsThatNeedHealing .. " pet".. (numPetsThatNeedHealing == 1 and "" or "s") .. " that need" .. (numPetsThatNeedHealing == 1 and "s" or "") .. " healing.")

	if numPetsThatNeedHealing > 0 then
		-- Check cooldowns and availability of revive spell and bandages
		local Revive_start, Revive_duration, Revive_enabled = GetSpellCooldown("Revive Battle Pets") -- Cooldown: 8 min. = 480 sec
		local Revive_spell_link, _ = GetSpellLink("Revive Battle Pets")
		local ReviveCooldown_Remaining = Revive_start+Revive_duration-GetTime()

		local Bandage_count = GetItemCount("Battle Pet Bandage", nil, nil)
		local _, Bandage_itemLink, _, _, _, _, _, _, _, Bandage_itemTexture, _ = GetItemInfo("Battle Pet Bandage")

		if MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT and Revive_start == 0 then
			-- Cast "Revive Battle Pets"
			CastSpellByName("Revive Battle Pets")
			print("|cffff8000MPB|r: Casting ".. Revive_spell_link)
		elseif MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT and Bandage_count > 0 and ReviveCooldown_Remaining > 210 and ReviveCooldown_Remaining < 270 then	-- Of revive cooldown is between 3.5 and 4.5 min
			-- Use "Battle Pet Bandage"
			UseItemByName("Battle Pet Bandage")
			print("|cffff8000MPB|r: Using \124T"..Bandage_itemTexture..":0\124t "..Bandage_itemLink )
		elseif MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT or MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT then
			print("|cffff8000MPB|r: Cannnot heal pets at this time.")
		end
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

function MyPetBattle.sendPetList()
	MyPetBattle.countPets()

	-- output the message string; see "MATCH_POS_ constants" above for the message layout
	
	MyPetBattleVars.petListPlayer = (
		"m"
		..((MyPetBattleVars.state == MyPetBattleState.RECIEVED_PET_LIST or
		    MyPetBattleVars.state == MyPetBattleState.RECIEVED_PET_LIST_AGAIN or
		    MyPetBattleVars.state == MyPetBattleState.RECIEVED_PET_LIST_ACK) and "a" or ".")
		..(mypetbattle_auto_forfeit and "f" or ".")
		..(UnitIsGroupLeader("player") and "L" or ".")
		..(MPB.PRIORITIZE_LEVEL and "1" or "0")
		..(MPB.USE_NON_RARE and "1" or "0")
		.." "
		..(string.sub(tostring(MyPetBattleVars.lockedpetlevels[1] + 100),2,3))
		..(string.sub(tostring(MyPetBattleVars.lockedpetlevels[2] + 100),2,3))
		..(string.sub(tostring(MyPetBattleVars.lockedpetlevels[3] + 100),2,3))
		.." "
		..(string.sub(tostring(MPB.MATCH_PET_LEVELS_START_LEVEL + 100),2,3))
		..((MPB.MATCH_PET_LEVELS_LEVEL_STEP < 0) and "-" or "+")
		..MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL
		.." "
	)

	for n_ = 1, 25 do
		MyPetBattleVars.petListPlayer = (
			MyPetBattleVars.petListPlayer
			..((MyPetBattleVars.petLevels[n_].t > 9) and 9 or MyPetBattleVars.petLevels[n_].t)
			..((MyPetBattleVars.petLevels[n_].un > 9) and 9 or MyPetBattleVars.petLevels[n_].un)
			..((MyPetBattleVars.petLevels[n_].ur > 9) and 9 or MyPetBattleVars.petLevels[n_].ur)
		)
	end

	SendAddonMessage("MPB", MyPetBattleVars.petListPlayer, "PARTY")
end

-----------------------------------------------------------------
-- CHECK IF WE HAVE ALL PETS IN THE GAME IN THE ROTATION FILES --
-----------------------------------------------------------------
function MyPetBattle.checkMissingPets()
	-- Sort the pet journal so we see all pets; collected and not collected
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_COLLECTED, true) -- Pets you have collected
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_FAVORITES, false) -- Pets you have set as favorites
	C_PetJournal.SetFlagFilter(LE_PET_JOURNAL_FLAG_NOT_COLLECTED, true) -- Pets you have not collected

	-- Get total number of pets in the game (regardless of owned/not owned)
	local numPets, numOwned = C_PetJournal.GetNumPets()
	print("Total number of pets: "..numPets)

	-- Loop through all available pets in the game
	for k_ = 1, numPets do
--		print("Iteration #"..k_)
		-- Get pet info
		local petID, speciesID, owned, _, level, _, isRevoked, speciesName, icon, petType, _, _, _, _, canBattle = C_PetJournal.GetPetInfoByIndex(k_)
		level = MyPetBattle.getPetLevel("checkMissingPets", petID, level)

		-- Check if it is a battle pet
		if canBattle then
			local spell = nil
			if petType == 1 then 		-- HUMANOID
				spell = humanoid(speciesName)		
			elseif petType == 2 then 	-- DRAGONKIN
				spell = dragonkin(speciesName)
			elseif petType == 3 then 	-- FLYING
				spell = flying(speciesName)
			elseif petType == 4 then 	-- UNDEAD
				spell = undead(speciesName)
			elseif petType == 5 then 	-- CRITTER
				spell = critter(speciesName)
			elseif petType == 6 then 	-- MAGIC
				spell = magic(speciesName)
			elseif petType == 7 then 	-- ELEMENTAL
				spell = elemental(speciesName)
			elseif petType == 8 then 	-- BEAST
				spell = beast(speciesName)
			elseif petType == 9 then 	-- WATER / AQUATIC
				spell = aquatic(speciesName)
			elseif petType == 10 then 	-- MECHANICAL
				spell = mechanical(speciesName)
			end
			
			-- Print the pets we are missing rotations for
			if spell == "UNKNOWN" then
				print("Missing rotation for: \124T"..icon..":0\124t "..speciesName)
			end
		end	
	end

end
