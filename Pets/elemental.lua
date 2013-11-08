---------------
-- ELEMENTAL --
---------------
function elemental(petName)

local elemental_abilities = nil

-- Get pet name
if petName == nil then
	petName = MyPetBattle.petName()
end

----------------
-- ELEMENTALS --
----------------
if petName == "Fel Flame" or petName == "Searing Scorchling" then
	elemental_abilities = 
		{
			{"Scorched Earth", 	not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Conflagrate", 	MyPetBattle.debuff("Immolate") or MyPetBattle.debuff("Flamethrower") or MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 3
			{"Immolation", 		not MyPetBattle.buff("Immolation") },	-- Slot 3
			{"Immolate", 		not MyPetBattle.debuff("Immolate") and not MyPetBattle.debuff("Flamethrower") and not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Burn", 			},	-- Slot 1
			{"Flame Breath", 	},	-- Slot 1
		}
elseif petName == "Frigid Frostling" then
	elemental_abilities = 
		{
			{"Frost Shock", 	},	-- Slot 1
			{"Surge", 			},	-- Slot 1
			{"Frost Nova", 		},	-- Slot 2
			{"Slippery Ice", 	},	-- Slot 2
			{"Ice Tomb", 		},	-- Slot 3
			{"Howling Blast", 	},	-- Slot 3
		}
elseif petName == "Grinder" or petName == "Lumpy" or petName == "Pebble" then
	elemental_abilities = 
		{
			{"Stone Shot", 		},	-- Slot 1
			{"Stone Rush", 		},	-- Slot 1
			{"Sandstorm", 		},	-- Slot 2
			{"Rupture", 		},	-- Slot 2
			{"Rock Barrage", 	},	-- Slot 3
			{"Quake", 			},	-- Slot 3
		}
elseif petName == "Kirin Tor Familiar" then
	elemental_abilities = 
		{
			{"Beam", 			},	-- Slot 1
			{"Arcane Blast", 	},	-- Slot 1
			{"Gravity", 		},	-- Slot 2
			{"Arcane Storm", 	},	-- Slot 2
			{"Arcane Explosion",},	-- Slot 3
			{"Dark Simulacrum", },	-- Slot 3
		}
elseif petName == "Living Sandling" then
	elemental_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Sand Bolt", 		},	-- Slot 1
			{"Stoneskin", 		},	-- Slot 2
			{"Sandstorm", 		},	-- Slot 2
			{"Stone Rush", 		},	-- Slot 3
			{"Quicksand", 		},	-- Slot 3
		}
elseif petName == "Pandaren Air Spirit" then
	elemental_abilities = 
		{
			{"Cyclone",			not MyPetBattle.debuff("Cyclone") },	-- Slot 3
			{"Slicing Wind", 	},	-- Slot 1
			{"Wild Winds", 		},	-- Slot 1
			{"Whirlwind", 		},	-- Slot 2
			{"Soothing Mists", 	},	-- Slot 2
			{"Arcane Storm", 	},	-- Slot 3
		}
elseif petName == "Pandaren Earth Spirit" then
	elemental_abilities = 
		{
			{"Stone Shot", 		},	-- Slot 1
			{"Stone Rush", 		},	-- Slot 1
			{"Rupture", 		},	-- Slot 2
			{"Rock Barrage", 	},	-- Slot 2
			{"Crystal Prison", 	},	-- Slot 3
			{"Mudslide",	 	},	-- Slot 3
		}
elseif petName == "Pandaren Fire Spirit" then
	elemental_abilities = 
		{
			{"Cauterize", 		MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Immolate", 		not MyPetBattle.debuff("Immolate") and not MyPetBattle.debuff("Flamethrower") and not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Burn", 			},	-- Slot 1
			{"Magma Wave", 		},	-- Slot 1
			{"Flamethrower", 	},	-- Slot 2
			{"Conflagrate",	 	},	-- Slot 3
		}
elseif petName == "Pandaren Water Spirit" then
	elemental_abilities = 
		{
			{"Dive", 			},	-- Slot 3
			{"Water Jet", 		},	-- Slot 1
			{"Tidal Wave", 		},	-- Slot 1
			{"Healing Wave", 	},	-- Slot 2
			{"Whirlpool", 		},	-- Slot 2
			{"Geyser",	 		},	-- Slot 3
		}
elseif petName == "Thundertail Flapper" then
	elemental_abilities = 
		{
			{"Tail Slap", 		},	-- Slot 1
			{"Jolt", 			},	-- Slot 1
			{"Buried Treasure", },	-- Slot 2
			{"Lightning Shield",},	-- Slot 2
			{"Thunderbolt", 	},	-- Slot 3
			{"Beaver Dam",		},	-- Slot 3
		}
elseif petName == "Tiny Twister" then
	elemental_abilities = 
		{
			{"Cyclone",			not MyPetBattle.debuff("Cyclone") },	-- Slot 3
			{"Slicing Wind", 	},	-- Slot 1
			{"Wild Winds", 		},	-- Slot 1
			{"Flyby", 			},	-- Slot 2
			{"Bash", 			},	-- Slot 2
			{"Sandstorm",		},	-- Slot 3
		}
elseif petName == "Water Waveling" then
	elemental_abilities = 
		{
			{"Water Jet", 		},	-- Slot 1
			{"Ice Lance", 		},	-- Slot 1
			{"Frost Nova", 		},	-- Slot 2
			{"Frost Shock", 	},	-- Slot 2
			{"Geyser", 			},	-- Slot 3
			{"Tidal Wave",		},	-- Slot 3
		}
elseif petName == "Tainted Waveling" then
	elemental_abilities = 
		{
			{"Acidic Goo", 		not MyPetBattle.debuff("Acidic Goo") },	-- Slot 2
			{"Ooze Touch", 		},	-- Slot 1
			{"Poison Spit", 	},	-- Slot 1
			{"Corrosion",		},	-- Slot 2
			{"Healing Wave", 	},	-- Slot 3
			{"Creeping Ooze",	},	-- Slot 3
		}
------------
-- GEODES --
------------
elseif petName == "Ashstone Core" then
	elemental_abilities = 
		{
			{"Crystal Overload", not MyPetBattle.buff("Crystal Overload") and MyPetBattle.hp() > 0.50 },	-- Slot 2
			{"Feedback", 		},	-- Slot 1
			{"Burn", 			},	-- Slot 1
			{"Stoneskin", 		},	-- Slot 2
			{"Crystal Prison", 	},	-- Slot 3
			{"Instability", 	},	-- Slot 3
		}
elseif petName == "Crimson Geode" or petName == "Elementium Geode" then
	elemental_abilities = 
		{
			{"Crystal Overload", not MyPetBattle.buff("Crystal Overload") and MyPetBattle.hp() > 0.50 },	-- Slot 2
			{"Feedback", 		},	-- Slot 1
			{"Spark", 			},	-- Slot 1
			{"Amplify Magic", 	},	-- Slot 2
			{"Stone Rush", 		},	-- Slot 3
			{"Elementium Bolt", },	-- Slot 3
		}
--------------
-- MYTHICAL --
--------------
elseif petName == "Core Hound Pup" then
	elemental_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Howl", 			},	-- Slot 2
			{"Dodge", 			},	-- Slot 2
			{"Burn", 			},	-- Slot 3
			{"Burrow", 			},	-- Slot 3
		}
elseif petName == "Dark Phoenix Hatchling" then
	elemental_abilities = 
		{
			{"Conflagrate", 	MyPetBattle.debuff("Immolate") or MyPetBattle.debuff("Flamethrower") or MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 3
			{"Immolate", 		not MyPetBattle.debuff("Immolate") and not MyPetBattle.debuff("Flamethrower") and not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Darkflame", 		},	-- Slot 2
			{"Burn", 			},	-- Slot 1
			{"Laser", 			},	-- Slot 1
			{"Dark Rebirth", 	},	-- Slot 3
		}
elseif petName == "Lil' Ragnaros" then
	elemental_abilities = 
		{
			{"Conflagrate", 	MyPetBattle.debuff("Immolate") or MyPetBattle.debuff("Flamethrower") or MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Flamethrower", 	not MyPetBattle.debuff("Immolate") and not MyPetBattle.debuff("Flamethrower") and not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 3
			{"Sons of the Flame",},	-- Slot 3
			{"Magma Trap", 		},	-- Slot 2
			{"Sulfuras Smash", 	},	-- Slot 1
			{"Magma Wave", 		},	-- Slot 1
		}
elseif petName == "Phoenix Hatchling" then
	elemental_abilities = 
		{
			{"Cauterize", 		MyPetBattle.hp() < 0.7 },	-- Slot 2
			{"Immolation", 		not MyPetBattle.buff("Immolation") },	-- Slot 3
			{"Immolate", 		not MyPetBattle.debuff("Immolate") and not MyPetBattle.debuff("Flamethrower") and not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Conflagrate", 	MyPetBattle.debuff("Immolate") or MyPetBattle.debuff("Flamethrower") or MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 3
			{"Burn", 			},	-- Slot 1
			{"Peck", 			},	-- Slot 1
		}
----------------
-- PLANT LIFE --
----------------
elseif petName == "Ammen Vale Lashling" or petName == "Crimson Lasher" then
	elemental_abilities = 
		{
			{"Lash", 			},	-- Slot 1
			{"Poison Lash", 	},	-- Slot 1
			{"Soothing Mists", 	},	-- Slot 2
			{"Plant", 			},	-- Slot 2
			{"Stun Seed", 		},	-- Slot 3
			{"Entangling Roots",},	-- Slot 3
		}
elseif petName == "Ruby Sapling" then
	elemental_abilities = 
		{
			{"Photosynthesis", 	not MyPetBattle.buff("Photosynthesis") and MyPetBattle.hp() < 0.8 },	-- Slot 3
			{"Shell Shield", 	not MyPetBattle.buff("Shell Shield") },	-- Slot 2
			{"Scratch", 		},	-- Slot 1
			{"Poisoned Branch", },	-- Slot 1
			{"Thorns", 			},	-- Slot 2
			{"Entangling Roots",},	-- Slot 3
		}
elseif petName == "Singing Sunflower" then
	elemental_abilities = 
		{
			{"Photosynthesis", 	not MyPetBattle.buff("Photosynthesis") and MyPetBattle.hp() < 0.8 },	-- Slot 2
			{"Early Advantage", MyPetBattle.hp("active", 1) < MyPetBattle.hp("active", 2) },	-- Slot 3
			{"Lash", 			},	-- Slot 1
			{"Solar Beam", 		},	-- Slot 1
			{"Inspiring Song", 	},	-- Slot 2
			{"Sunlight", 		},	-- Slot 3
		}
elseif petName == "Sinister Squashling" then
	elemental_abilities = 
		{
			{"Burn", 			},	-- Slot 1
			{"Poison Lash", 	},	-- Slot 1
			{"Thorns", 			},	-- Slot 2
			{"Stun Seed", 		},	-- Slot 2
			{"Plant", 			},	-- Slot 3
			{"Leech Seed", 		},	-- Slot 3
		}
elseif petName == "Teldrassil Sproutling" then
	elemental_abilities = 
		{
			{"Photosynthesis", 	not MyPetBattle.buff("Photosynthesis") and MyPetBattle.hp() < 0.8 },	-- Slot 2
			{"Shell Shield", 	not MyPetBattle.buff("Shell Shield") },	-- Slot 1
			{"Scratch", 		},	-- Slot 1
			{"Poisoned Branch", },	-- Slot 2
			{"Thorns", 			},	-- Slot 3
			{"Entangling Roots",},	-- Slot 3
		}
elseif petName == "Terrible Turnip" then
	elemental_abilities = 
		{
			{"Weakening Blow", 	MyPetBattle.hp("active", 2) > 0.05 },	-- Slot 1 -- Cannot reduce enemy below 1 hp
			{"Tidal Wave", 		},	-- Slot 1
			{"Leech Seed", 		},	-- Slot 2
			{"Inspiring Song", 	},	-- Slot 2
			{"Sunlight", 		},	-- Slot 3
			{"Sons of the Root",},	-- Slot 3
		}
elseif petName == "Tiny Bog Beast" then
	elemental_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Crush", 			},	-- Slot 1
			{"Clobber", 		},	-- Slot 1
			{"Lash", 			},	-- Slot 2
			{"Poison Lash", 	},	-- Slot 3
			{"Rampage", 		},	-- Slot 3
		}
elseif petName == "Venus" then
	elemental_abilities = 
		{
			{"Lash", 			},	-- Slot 1
			{"Poison Lash", 	},	-- Slot 1
			{"Sunlight", 		},	-- Slot 2
			{"Plant", 			},	-- Slot 2
			{"Stun Seed", 		},	-- Slot 3
			{"Leech Seed", 		},	-- Slot 3
		}
elseif petName == "Withers" then
	elemental_abilities = 
		{
			{"Photosynthesis", 	not MyPetBattle.buff("Photosynthesis") and MyPetBattle.hp() < 0.8 },	-- Slot 2
			{"Shell Shield", 	not MyPetBattle.buff("Shell Shield") },	-- Slot 1
			{"Scratch", 		},	-- Slot 1
			{"Poisoned Branch", },	-- Slot 2
			{"Thorns", 			},	-- Slot 3
			{"Entangling Roots",},	-- Slot 3
		}
elseif petName == "Blossoming Ancient" then
	elemental_abilities = 
		{
			{"Photosynthesis",	not MyPetBattle.buff("Photosynthesis") and MyPetBattle.hp() < 0.8 },	-- Slot 2
			{"Poisoned Branch",	},	-- Slot 1
			{"Ironbark", 		},	-- Slot 1
			{"Autumn Breeze", 	},	-- Slot 2
			{"Stun Seed", 		},	-- Slot 3
			{"Sunlight",		},	-- Slot 3
		}
-------------------
-- SHALE SPIDERS --
-------------------
elseif petName == "Amethyst Shale Hatchling" or petName == "Crimson Shale Hatchling" or petName == "Emerald Shale Hatchling" or petName == "Tiny Shale Spider" or petName == "Topaz Shale Hatchling" then
	elemental_abilities = 
		{
			{"Burn", 			},	-- Slot 1
			{"Leech Life", 		},	-- Slot 1
			{"Sticky Web", 		},	-- Slot 2
			{"Poison Spit", 	},	-- Slot 2
			{"Stone Rush", 		},	-- Slot 3
			{"Stoneskin", 		},	-- Slot 3
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Cinder Kitten" then
	elemental_abilities = 
		{
			{"Scorched Earth", 	not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 3
			{"Immolate", 		not MyPetBattle.debuff("Immolate") and not MyPetBattle.debuff("Flamethrower") and not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2 -- If your (1) speed is slower than you enemy (2) and not boosted
			{"Claw", 			},	-- Slot 1
			{"Rend", 			},	-- Slot 1
			{"Prowl", 			},	-- Slot 3
		}
elseif petName == "Electrified Razortooth" then
	elemental_abilities = 
		{
			{"Devour", 			MyPetBattle.hp("active",2) < 0.20 },	-- Slot 3,  if we kill the enemy with Devour, we restore health
			{"Rip", 			},	-- Slot 1
			{"Jolt", 			},	-- Slot 1
			{"Paralyzing Shock",},	-- Slot 2
			{"Lightning Shield",},	-- Slot 2
			{"Blood in the Water",},	-- Slot 3
		}
elseif petName == "Jade Tentacle" then
	elemental_abilities = 
		{
			{"Photosynthesis", 	not MyPetBattle.buff("Photosynthesis") and MyPetBattle.hp() < 0.8 },	-- Slot 2
			{"Shell Shield", 	not MyPetBattle.buff("Shell Shield") },	-- Slot 2
			{"Scratch", 		},	-- Slot 1
			{"Poisoned Branch", },	-- Slot 1
			{"Entangling Roots",},	-- Slot 3
			{"Thorns", 			},	-- Slot 3
		}
elseif petName == "Lava Crab" then
	elemental_abilities = 
		{
			{"Survival", 		MyPetBattle.hp() < 0.3 },	-- Slot 1
			{"Cauterize", 		MyPetBattle.hp() < 0.7 },	-- Slot 2
			{"Shell Shield", 	not MyPetBattle.buff("Shell Shield") },	-- Slot 2
			{"Conflagrate", 	},	-- Slot 3
			{"Burn", 			},	-- Slot 1
			{"Magma Wave", 		},	-- Slot 3
		}
elseif petName == "Sapphire Cub" then
	elemental_abilities = 
		{
			{"Lash", 			},	-- Slot 1
			{"Pounch", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 2
			{"Screech", 		},	-- Slot 2
			{"Stone Rush", 		},	-- Slot 3
			{"Prowl", 			},	-- Slot 3
		}
elseif petName == "Spirit of Summer" then
	elemental_abilities = 
		{
			{"Scorched Earth", 	not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Immolation", 		not MyPetBattle.buff("Immolation") },	-- Slot 3
			{"Immolate", 		not MyPetBattle.debuff("Immolate") and not MyPetBattle.debuff("Flamethrower") and not MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 2
			{"Conflagrate", 	MyPetBattle.debuff("Immolate") or MyPetBattle.debuff("Flamethrower") or MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 3
			{"Burn", 			},	-- Slot 1
			{"Flame Breath", 	},	-- Slot 1
		}
elseif petName == "Tiny Snowman" then
	elemental_abilities = 
		{
			{"Snowball", 		},	-- Slot 1
			{"Magic Hat", 		},	-- Slot 1
			{"Call Blizzard", 	},	-- Slot 2
			{"Frost Nova", 		},	-- Slot 2
			{"Howling Blast", 	},	-- Slot 3
			{"Deep Freeze", 	},	-- Slot 3
		}
-------------------
else -- Unknown elemental pet
	print("|cFFFF0000 Unknown elemental pet: "..petName)
	return "UNKNOWN"
end

	spell = MyPetBattle.parseSpellTable(elemental_abilities)
	return spell
end
