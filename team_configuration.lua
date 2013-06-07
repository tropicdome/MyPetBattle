------------------------
-- TEAM CONFIGURATION --
------------------------

-- LOTS OF TO DO'S !!!

-- { "Pet Name", approximate level e.g. 20 } -- if level is nil maximum level will be chosen e.g. 25
local team_pet1 = { "Onyxian Whelping" }
local team_pet2 = { "Onyxian Whelping", 20 }
local team_pet3 = { "Onyxian Whelping", 20 }

-- Pet switching
local petOwner = LE_BATTLE_PET_ALLY
local petIndex = C_PetBattles.GetActivePet(petOwner)
local i = nil

if MyPetBattle.hp(petIndex) < 0.4 then
	for i=1,3 do
		if MyPetBattle.hp(i) > 0.5 then
			C_PetBattles.ChangePet(i)
			print("|cFF8B0000.. Changing pet due to low health! ..")
		end
	end
end	

-- PvP - switch between all pets
-- PvE leveling - switch only if pet is about to die
-- Switch to stronger pet based on strengths and weaknesses 


-----------------------------
-- ABILITIES AND MECHANICS --
-----------------------------
-- http://www.wowhead.com/petabilities


-- Offensive spells

-- Defensive spells