------------
-- FLYING --
------------
function flying(petName)

local flying_abilities = nil

-- Get pet name
if petName == nil then
	petName = MyPetBattle.petName()
end

------------------------
-- BALLOONS AND KITES --
------------------------
if petName == "Dragon Kite" then
	flying_abilities = 
		{
			{"Lift-Off", 		},	-- Slot 3
			{"Breath", 			},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Call Lightning", 	},	-- Slot 2
			{"Roar", 			},	-- Slot 2
			{"Volcano", 		},	-- Slot 3
		}
elseif petName == "Tuskarr Kite" then
	flying_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Frost Shock", 	},	-- Slot 1
			{"Wild Winds", 		},	-- Slot 2
			{"Cyclone", 		},	-- Slot 2
			{"Flyby", 			},	-- Slot 3
			{"Reckless Strike", },	-- Slot 3
		}
----------
-- BATS --
----------
elseif petName == "Bat" or petName == "Tirisfal Batling" then
	flying_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Leech Life", 		},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Hawk Eye", 		},	-- Slot 2
			{"Reckless Strike", },	-- Slot 3
			{"Nocturnal Strike",},	-- Slot 3
		}
-------------------
-- BIRDS OF PREY --
-------------------
elseif petName == "Blue Mini Jouster" or petName == "Dragonbone Hatchling" or petName == "Fledgling Buzzard" or petName == "Gold Mini Jouster" or petName == "Imperial Eagle Chick" or petName == "Tickbird Hatchling" or petName == "White Tickbird Hatchling" then
	flying_abilities = 
		{
			{"Lift-Off", 		},	-- Slot 3
			{"Slicing Wind", 	},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Hawk Eye", 		},	-- Slot 2
			{"Adrenaline Rush", },	-- Slot 2
			{"Cyclone", 		},	-- Slot 3
		}
elseif petName == "Brilliant Kaliri" then
	flying_abilities = 
		{
			{"Predatory Strike", MyPetBattle.hp("active", LE_BATTLE_PET_ENEMY) < 0.25 },	-- Slot 3
			{"Shriek", 			not MyPetBattle.debuff("Attack Reduction") },	-- Slot 2
			{"Cyclone", 		},	-- Slot 2
			{"Nocturnal Strike",},	-- Slot 3
			{"Peck", 			},	-- Slot 1
			{"Quills", 			},	-- Slot 1
		}
elseif petName == "Ji-Kun Hatchling" then
	flying_abilities = 
		{
			{"Slicing Wind", 	not MyPetBattle.debuff("Wild Winds") },	-- Slot 1
			{"Peck", 			},	-- Slot 1
			{"Wild Winds", 		},	-- Slot 2
			{"Acidic Goo", 		},	-- Slot 2
			{"Flock", 			},	-- Slot 3
			{"Caw", 			},	-- Slot 3
		}
---------------
-- FIREFLIES --
---------------
elseif petName == "Darkmoon Glowfly" then
	flying_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 1
			{"Glowing Toxin", 	},	-- Slot 2
			{"Sting", 			},	-- Slot 2
			{"Confusing Sting", },	-- Slot 3
			{"Dazzling Dance", 	MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Dazzling Dance") },	-- Slot 3
		}
elseif petName == "Effervescent Glowfly" or petName == "Firefly" or petName == "Mei Li Sparkler" or petName == "Shrine Fly" then
	flying_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 1
			{"Confusing Sting", not MyPetBattle.debuff("Confusing Sting") },  -- Slot 2
			{"Cocoon Strike", 	},	-- Slot 2
			{"Swarm",			not MyPetBattle.debuff("Shattered Defenses")},  -- Slot 3
			{"Glowing Toxin",	not MyPetBattle.debuff("Glowing Toxin")},  -- Slot 3
		}
elseif petName == "Tiny Flamefly" then
	flying_abilities = 
		{
			{"Burn", 			},	-- Slot 1
			{"Alpha Strike", 	},	-- Slot 1
			{"Immolate", 		},	-- Slot 2
			{"Hiss", 			},	-- Slot 2
			{"Swarm", 			},	-- Slot 3
			{"Adrenaline Rush", },	-- Slot 3
		}
----------
-- FOWL --
----------
elseif petName == "Ancona Chicken" or petName == "Chicken" or petName == "Szechuan Chicken" or petName == "Westfall Chicken" then
	flying_abilities = 
		{
			{"Peck", 			},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 1
			{"Squawk", 			},	-- Slot 2
			{"Adrenaline Rush", },	-- Slot 2
			{"Egg Barrage", 	},	-- Slot 3
			{"Flock", 			},	-- Slot 3
		}
elseif petName == "Highlands Turkey" or petName == "Plump Turkey" or petName == "Turkey" then
	flying_abilities = 
		{
			{"Peck", 			},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 1
			{"Squawk", 			},	-- Slot 2
			{"Gobble Strike", 	MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Food Coma", 		},	-- Slot 3
			{"Flock", 			},	-- Slot 3
		}
----------------------
-- GULLS AND RAVENS --
----------------------
elseif petName == "Crow" then
	flying_abilities = 
		{
			{"Peck", 			},	-- Slot 1
			{"Alpha Strike", 	},	-- Slot 1
			{"Squawk", 			},	-- Slot 2
			{"Call Darkness", 	},	-- Slot 2
			{"Murder", 			},	-- Slot 3
			{"Nocturnal Strike",},	-- Slot 3
		}
elseif petName == "Gilnean Raven" then
	flying_abilities = 
		{
			{"Peck", 			},	-- Slot 1
			{"Alpha Strike", 	},	-- Slot 1
			{"Drakflame", 		},	-- Slot 2
			{"Call Darkness", 	},	-- Slot 2
			{"Nocturnal Strike",},	-- Slot 3
			{"Nevermore", 		},	-- Slot 3
		}
elseif petName == "Rustberg Gull" or petName == "Sandy Petrel" or petName == "Sea Gull" then
	flying_abilities = 
		{
			{"Lift-Off", 		},	-- Slot 3
			{"Slicing Wind", 	},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Hawk Eye",		not MyPetBattle.buff("Hawk Eye") },  -- Slot 2
			{"Adrenaline Rush",	not MyPetBattle.buff("Adrenaline") },  -- Slot 2
			{"Cyclone",			not MyPetBattle.debuff("Cyclone") },  -- Slot 3
		}
-----------
-- MOTHS --
-----------
elseif petName == "Amber Moth" or petName == "Blue Moth" or petName == "Crimson Moth" or petName == "Forest Moth" or petName == "Fungal Moth" or petName == "Garden Moth" or petName == "Gilded Moth" or petName == "Grey Moth" or petName == "Luyu Moth" or petName == "Oasis Moth" or petName == "Red Moth" or petName == "Silky Moth" or petName == "Swamp Moth" or petName == "Tainted Moth" or petName == "White Moth" or petName == "Yellow Moth" then
	flying_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Alpha Strike", 	},	-- Slot 1
			{"Cocoon Strike", 	},	-- Slot 2
			{"Adrenaline Rush", },	-- Slot 2
			{"Moth Balls", 		},	-- Slot 3
			{"Moth Dust", 		},	-- Slot 3
		}
elseif petName == "Imperial Moth" then
	flying_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Wild Winds", 		},	-- Slot 1
			{"Cocoon Strike", 	},	-- Slot 2
			{"Moth Balls", 		},	-- Slot 2
			{"Moth Dust", 		},	-- Slot 3
			{"Cyclone", 		},	-- Slot 3
		}

--------------
-- MYTHICAL --
--------------
elseif petName == "Cenarion Hatchling" or petName == "Hippogryph Hatchling" then
	flying_abilities = 
		{
			{"Rush", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Peck", 			},	-- Slot 1
			{"Quills", 			},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Reckless Strike", },	-- Slot 3
		}
elseif petName == "Gryphon Hatchling" or petName == "Wildhammer Gryphon Hatchling" then
	flying_abilities = 
		{
			{"Lift-Off", 		},	-- Slot 3
			{"Peck", 			},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 1
			{"Squawk", 			},	-- Slot 2
			{"Adrenaline Rush", },	-- Slot 2
			{"Flock", 			},	-- Slot 3
		}
elseif petName == "Guardian Cub" then
	flying_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Onyx Bite",		},	-- Slot 1
			{"Roar", 			},	-- Slot 2
			{"Wild Winds", 		},	-- Slot 2
			{"Reckless Strike", },	-- Slot 3
			{"Cyclone", 		},	-- Slot 3
		}
-----------------
-- NETHER RAYS --
-----------------
elseif petName == "Fledgling Nether Ray" or petName == "Nether Ray Fry" then
	flying_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Arcane Blast", 	},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 2
			{"Slicing Wind", 	},	-- Slot 2
			{"Shadow Shock", 	},	-- Slot 3
			{"Lash", 			},	-- Slot 3
		}
----------
-- OWLS --
----------
elseif petName == "Crested Owl" or petName == "Great Horned Owl" or petName == "Hawk Owl" or petName == "Snowy Owl" then
	flying_abilities = 
		{
			{"Peck", 			},	-- Slot 1
			{"Quills", 			},	-- Slot 1
			{"Shriek", 			},	-- Slot 2
			{"Cyclone", 		},	-- Slot 2
			{"Nocturnal Strike",},	-- Slot 3
			{"Predatory Strike",},	-- Slot 3
		}
-------------
-- PARROTS --
-------------
elseif petName == "Cockatiel" or petName == "Green Wing Macaw" or petName == "Hyacinth Macaw" or petName == "Parrot" or petName == "Polly" or petName == "Senegal" then
	flying_abilities = 
		{
			{"Lift-Off", 		},	-- Slot 3
			{"Slicing Wind", 	},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Hawk Eye", 		},	-- Slot 2
			{"Adrenaline Rush", },	-- Slot 2
			{"Cyclone", 		},	-- Slot 3
		}
elseif petName == "Miniwing" then
	flying_abilities = 
		{
			{"Peck", 			},	-- Slot 1
			{"Quills", 			},	-- Slot 1
			{"Shriek", 			},	-- Slot 2
			{"Cyclone", 		},	-- Slot 2
			{"Nocturnal Strike",},	-- Slot 3
			{"Predatory Strike",},	-- Slot 3
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Jade Crane Chick" then
	flying_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Hawk Eye",		},	-- Slot 2
			{"Jadeskin", 		},	-- Slot 2
			{"Cyclone",			},	-- Slot 3
			{"Cyclone",			},	-- Slot 3
		}
elseif petName == "Pterrordax Hatchling" then
	flying_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Flyby", 			},	-- Slot 1
			{"Ancient Blessing", },	-- Slot 2
			{"Apocalypse", 		},	-- Slot 2
			{"Lift-Off",		},	-- Slot 3
			{"Feign Death",		},	-- Slot 3
		}
elseif petName == "Tiny Sporebat" then
	flying_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Shadow Slash", 	},	-- Slot 1
			{"Creeping Fungus", },	-- Slot 2
			{"Leech Seed", 		},	-- Slot 2
			{"Spore Shrooms", 	},	-- Slot 3
			{"Confusing Sting", },	-- Slot 3
		}
-------------------
else -- Unknown flying pet
	print("|cFFFF0000 Unknown flying pet: "..petName)
	return "UNKNOWN"
end

	spell = MyPetBattle.parseSpellTable(flying_abilities)
	return spell
end