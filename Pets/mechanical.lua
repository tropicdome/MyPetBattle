----------------
-- MECHANICAL --
----------------
function mechanical(petName)

local mechanical_abilities = nil

-- Get pet name
if petName == nil then
	petName = MyPetBattle.petName()
end

------------------------
-- LIFELIKE CREATIONS --
------------------------
if petName == "Fluxfire Feline" then
	mechanical_abilities = 
		{
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Claw", 			},	-- Slot 1
			{"Pounce", 			},	-- Slot 1
			{"Flux", 			},	-- Slot 2
			{"Prowl", 			},	-- Slot 3
			{"Supercharge", 	},	-- Slot 3
		}
elseif petName == "Lifelike Toad" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Water Jet", 		},	-- Slot 1
			{"Tongue Lash", 	},	-- Slot 1
			{"Healing Wave", 	},	-- Slot 2
			{"Cleansing Rain", 	},	-- Slot 2
			{"Frog Kiss", 		},	-- Slot 3
		}
elseif petName == "Tranquil Mechanical Yeti" then
	mechanical_abilities = 
		{
			{"Metal Fist", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Call Lightning", 	},	-- Slot 2
			{"Call Blizzard", 	},	-- Slot 2
			{"Supercharge", 	},	-- Slot 3
			{"Ion Cannon", 		},	-- Slot 3
		}
-------------------------
-- MECHANIZED CRITTERS --
-------------------------
elseif petName == "Anodized Robo Cub" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Demolish", 		},	-- Slot 1
			{"Rebuild", 		},	-- Slot 2
			{"Maul", 			},	-- Slot 3
			{"Supercharge", 	},	-- Slot 3
		}
elseif petName == "Cogblade Raptor" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Batter", 			},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Exposed Wounds", 	},	-- Slot 3
		}
elseif petName == "De-Weaponized Mechanical Companion" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Metal Fist", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Extra Plating", 	},	-- Slot 2
			{"Demolish", 		},	-- Slot 3
		}
elseif petName == "Mechanical Chicken" or petName == "Robo-Chick" then
	mechanical_abilities = 
		{
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Peck", 			},	-- Slot 1
			{"Batter", 			},	-- Slot 1
			{"Rebuild", 		},	-- Slot 2
			{"Supercharge", 	},	-- Slot 3
			{"Wind-Up", 		},	-- Slot 3
		}
elseif petName == "Mechanical Pandaren Dragonling" then
	mechanical_abilities = 
		{
			{"Breath", 			},	-- Slot 1
			{"Thunderbolt", 	},	-- Slot 1
			{"Flyby", 			},	-- Slot 2
			{"Decoy", 			},	-- Slot 2
			{"Bombing Run", 	},	-- Slot 3
			{"Explode", 		},	-- Slot 3
		}
elseif petName == "Mechanical Squirrel" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Metal Fist", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Extra Plating", 	},	-- Slot 2
			{"Wind-Up", 		},	-- Slot 3
		}
elseif petName == "Mechanopeep" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Peck", 			},	-- Slot 1
			{"Rebuild", 		},	-- Slot 1
			{"Batter", 			},	-- Slot 2
			{"Wind-Up", 		},	-- Slot 3
		}
elseif petName == "Pet Bombling" then
	mechanical_abilities = 
		{
			{"Zap", 			},	-- Slot 1
			{"Batter", 			},	-- Slot 1
			{"Minefield", 		},	-- Slot 2
			{"Toxic Smoke", 	},	-- Slot 2
			{"Screeching Gears",},	-- Slot 3
			{"Explode", 		},	-- Slot 3
		}
elseif petName == "Rabid Nut Varmint 5000" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Metal Fist", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Extra Plating", 	},	-- Slot 2
			{"Rabid Strike", 	},	-- Slot 3
		}
elseif petName == "Rocket Chicken" then
	mechanical_abilities = 
		{
			{"Missile", 		},	-- Slot 1
			{"Peck", 			},	-- Slot 1
			{"Squawk", 			},	-- Slot 2
			{"Toxic Smoke", 	},	-- Slot 2
			{"Extra Plating", 	},	-- Slot 3
			{"Launch", 			},	-- Slot 3
		}
------------
-- ROBOTS --
------------
elseif petName == "Blue Clockwork Rocket Bot" or petName == "Clockwork Rocket Bot" or petName == "Lil' Smoky" or petName == "Mini Thor" then
	mechanical_abilities = 
		{
			{"Missile", 		},	-- 
			{"Batter", 			},	-- 
			{"Toxic Smoke", 	},	-- 
			{"Minefield", 		},	-- 
			{"Sticky Grenade", 	},	-- 
			{"Launch Rocket", 	},	-- 
		}
elseif petName == "Clock'em" then
	mechanical_abilities = 
		{
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Kick", 			},	-- Slot 3
			{"Jab", 			},	-- Slot 1
			{"Haymaker", 		},	-- 
			{"Counterstrike", 	},	-- 
			{"Dodge", 			},	-- 
		}
elseif petName == "Clockwork Gnome" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 2
			{"Build Turret", 	},	-- Slot 3
			{"Metal Fist", 		},	-- Slot 1
			{"Railgun", 		},	-- Slot 1
			{"Blitz", 			},	-- Slot 2
			{"Launch Rocket", 	},	-- Slot 3
		}
elseif petName == "Landro's Lil' XT" or petName == "Lil' XT" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 2
			{"Zap", 			},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Heartbroken", 	},	-- Slot 2
			{"XE-321 Boombot", 	},	-- Slot 3
			{"Tympanic Tantrum", },	-- Slot 3
		}	
elseif petName == "Personal World Destroyer" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 2
			{"Metal Fist", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Supercharge", 	},	-- Slot 2
			{"Screeching Gears", },	-- Slot 3
			{"Quake", 			},	-- Slot 3
		}
elseif petName == "Son of Animus" then
	mechanical_abilities = 
		{
			{"Metal Fist", 		},	-- 
			{"Batter", 			},	-- 
			{"Siphon Anima", 	},	-- 
			{"Touch of the Animus", },	-- 
			{"Extra Plating", 	},	-- 
			{"Interrupting Jolt", },	-- 
		}
elseif petName == "Sunreaver Micro-Sentry" then
	mechanical_abilities = 
		{
			{"Laser", 			},	-- 
			{"Fel Immolate", 	},	-- 
			{"Extra Plating", 	},	-- 
			{"Haywire", 		},	-- 
			{"Call Lightning", 	},	-- 
			{"Supercharge", 	},	-- 
		}
elseif petName == "Tiny Harvester" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Overtune", 		MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Metal Fist", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Extra Plating", 	},	-- Slot 2
			{"Demolish", 		},	-- Slot 3
		}
elseif petName == "Warbot" then
	mechanical_abilities = 
		{
			{"Missile", 		},	-- Slot 1
			{"Batter", 			},	-- Slot 1
			{"Toxic Smoke", 	},	-- Slot 2
			{"Minefield", 		},	-- Slot 2
			{"Extra Plating", 	},	-- Slot 3
			{"Launch Rocket", 	},	-- Slot 3
		}	
elseif petName == "Menagerie Custodian" then
	mechanical_abilities = 
		{
			{"Ion Cannon",		MyPetBattle.hp() < 0.35 },	-- Slot 3
			{"Shock and Awe", 	},	-- Slot 2
			{"Zap", 			},	-- Slot 1
			{"Overtune", 		},	-- Slot 1
			{"Demolish", 		},	-- Slot 2
			{"Lock-On",			},	-- Slot 3
		}	
elseif petName == "Pocket Reaver" then
	mechanical_abilities = 
		{
			{"Repair", 			MyPetBattle.hp() < 0.7 },	-- Slot 2
			{"Metal Fist", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Fel Immolate", 	},	-- Slot 3
			{"Supercharge",		},	-- Slot 3
			{"Quake", 			},	-- Slot 2
		}

-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Darkmoon Tonk" then
	mechanical_abilities = 
		{
			{"Ion Cannon", 		MyPetBattle.hp() < 0.35 },	-- Slot 3
			{"Shock and Awe", 	},	-- Slot 2
			{"Minefield", 		},	-- Slot 2
			{"Missile", 		},	-- Slot 1
			{"Charge", 			},	-- Slot 1
			{"Lock-On", 		},	-- Slot 3
		}	
elseif petName == "Darkmoon Zeppelin" then
	mechanical_abilities = 
		{
			{"Missile", 		},	-- Slot 1
			{"Thunderbolt", 	},	-- Slot 1
			{"Flyby", 			},	-- Slot 2
			{"Decoy", 			},	-- Slot 2
			{"Bombing Run", 	},	-- Slot 3
			{"Explode", 		},	-- Slot 3
		}	
-------------------
else -- Unknown robot pet
	print("|cFFFF0000 Unknown mechanical pet: "..petName)
	return "UNKNOWN"
end

	spell = MyPetBattle.parseSpellTable(mechanical_abilities)
	return spell
end
