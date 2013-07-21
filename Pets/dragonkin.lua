----------------
-- DRAGONKIN --
----------------
function dragonkin(petName)

local dragonkin_abilities = nil

-- Get pet name
if petName == nil then
	petName = MyPetBattle.petName()
end

-------------------
-- DRAGON WHELPS --
-------------------
if petName == "Azure Whelpling" then
	dragonkin_abilities = 
		{
			{"Surge of Power", 	},	-- Slot 3
			{"Claw", 			},	-- Slot 1
			{"Breath", 			},	-- Slot 1
			{"Arcane Storm", 	},	-- Slot 2
			{"Wild Magic", 		},	-- Slot 2
			{"Ice Tomb", 		},	-- Slot 3
		}
elseif petName == "Crimson Whelpling" or petName == "Onyxian Whelpling" or petName == "Spawn of Onyxia" then
	dragonkin_abilities = 
		{
			{"Healing Flame", 	MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Breath", 			},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Scorched Earth", 	},	-- Slot 2
			{"Deep Breath", 	},	-- Slot 3
		}
elseif petName == "Dark Whelpling" then
	dragonkin_abilities = 
		{
			{"Roar", 			not MyPetBattle.buff("Attack Boost") },	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Shadowflame", 	},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Call Darkness", 	},	-- Slot 2
			{"Deep Breath", 	},	-- Slot 3
		}
elseif petName == "Emerald Proto-Whelp" then
	dragonkin_abilities = 
		{
			{"Ancient Blessing", not MyPetBattle.buff("Ancient Blessing") or MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Breath", 			},	-- Slot 1
			{"Emerald Bite", 	},	-- Slot 1
			{"Emerald Presence",},	-- Slot 2
			{"Proto-Strike", 	},	-- Slot 3
			{"Emerald Dream", 	},	-- Slot 3
		}
elseif petName == "Emerald Whelpling" then
	dragonkin_abilities = 
		{
			{"Moonfire", 		not MyPetBattle.currentWeather("Moonlight") },	-- Slot 2
			{"Breath", 			},	-- Slot 1
			{"Emerald Bite", 	},	-- Slot 1
			{"Emerald Presence",},	-- Slot 2
			{"Tranquility", 	},	-- Slot 3
			{"Emerald Dream", 	},	-- Slot 3
		}
elseif petName == "Infinite Whelpling" then
	dragonkin_abilities = 
		{
			{"Healing Flame", 	MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Tail Sweep", 		},	-- Slot 1
			{"Sleeping Gas", 	},	-- Slot 1
			{"Weakness", 		},	-- Slot 2
			{"Early Advantage", },	-- Slot 3
			{"Darkflame", 		},	-- Slot 3
		}
elseif petName == "Lil' Deathwing" then
	dragonkin_abilities = 
		{
			{"Shadowflame", 	},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Call Darkness", 	},	-- Slot 2
			{"Roll", 			},	-- Slot 2
			{"Elementium Bolt", },	-- Slot 3
			{"Cataclysm", 		},	-- Slot 3
		}
elseif petName == "Lil' Tarecgosa" then
	dragonkin_abilities = 
		{
			{"Breath", 			},	-- Slot 1
			{"Arcane Blast", 	},	-- Slot 1
			{"Surge of Power", 	},	-- Slot 2
			{"Wild Magic", 		},	-- Slot 2
			{"Arcane Storm", 	},	-- Slot 3
			{"Arcane Explosion",},	-- Slot 3
		}
elseif petName == "Nether Faerie Dragon" then
	dragonkin_abilities = 
		{
			{"Moonfire", 		not MyPetBattle.currentWeather("Moonlight") },	-- Slot 3
			{"Slicing Wind", 	},	-- Slot 1
			{"Arcane Blast", 	},	-- Slot 1
			{"Evanescence", 	},	-- Slot 2
			{"Life Exchange", 	},	-- Slot 2
			{"Cyclone", 		},	-- Slot 3
		}
elseif petName == "Netherwhelp" then
	dragonkin_abilities = 
		{
			{"Breath", 			},	-- Slot 1
			{"Nether Blast", 	},	-- Slot 1
			{"Phase Shift", 	},	-- Slot 2
			{"Accuracy", 		},	-- Slot 2
			{"Instability", 	},	-- Slot 3
			{"Soulrush", 		},	-- Slot 3
		}
elseif petName == "Nexus Whelpling" then
	dragonkin_abilities = 
		{
			{"Tail Sweep", 		},	-- Slot 1
			{"Frost Breath", 	},	-- Slot 1
			{"Sear Magic", 		},	-- Slot 2
			{"Mana Surge", 		},	-- Slot 2
			{"Wild Magic", 		},	-- Slot 3
			{"Arcane Storm", 	},	-- Slot 3
		}
elseif petName == "Proto-Drake Whelp" then
	dragonkin_abilities = 
		{
			{"Ancient Blessing", not MyPetBattle.buff("Ancient Blessing") or MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Roar", 			not MyPetBattle.buff("Attack Boost") },	-- Slot 3
			{"Breath", 			},	-- Slot 1
			{"Bite", 			},	-- Slot 1
			{"Flamethrower", 	},	-- Slot 2
			{"Proto-Strike", 	},	-- Slot 3
		}
-----------------
-- DRAGONHAWKS --
-----------------
elseif petName == "Blue Dragonhawk Hatchling" or petName == "Golden Dragonhawk Hatchling" or petName == "Red Dragonhawk Hatchling" or petName == "Silver Dragonhawk Hatchling" then
	dragonkin_abilities = 
		{
			{"Claw", 			},	-- Slot 1
			{"Quills", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 2
			{"Conflagrate", 	},	-- Slot 2
			{"Flame Breath", 	},	-- Slot 3
			{"Flamethrower", 	},	-- Slot 3
		}
elseif petName == "Phoenix Hawk Hatchling" then
	dragonkin_abilities = 
		{
			{"Claw", 			},	-- Slot 1
			{"Quills", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 2
			{"Flyby", 			},	-- Slot 2
			{"Flame Breath", 	},	-- Slot 3
			{"Lift-Off", 		},	-- Slot 3
		}
--------------
-- SERPENTS --
--------------
elseif petName == "Celestial Dragon" then
	dragonkin_abilities = 
		{
			{"Moonfire", 		not MyPetBattle.currentWeather("Moonlight") },	-- Slot 3
			{"Starfall", 		not MyPetBattle.currentWeather("Moonlight") },	-- Slot 3
			{"Ancient Blessing", not MyPetBattle.buff("Ancient Blessing") or MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Roar", 			not MyPetBattle.buff("Attack Boost") },	-- Slot 1
			{"Flamethrower", 	},	-- Slot 1
			{"Arcane Storm", 	},	-- Slot 2 -- Can it remove a root if already rooted or only prevent future roots cast against you?
		}
elseif petName == "Essence of Competition" or petName == "Spirit of Competition" then
	dragonkin_abilities = 
		{
			{"Ancient Blessing", not MyPetBattle.buff("Ancient Blessing") or MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Breath", 			},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Competitive Spirit",},	-- Slot 2
			{"Flamethrower", 	},	-- Slot 3
		}
elseif petName == "Soul of the Aspects" or petName == "Spirit of Competition" then
	dragonkin_abilities = 
		{
			{"Claw", 			},	-- Slot 1
			{"Breath", 			},	-- Slot 1
			{"Sunlight", 		},	-- Slot 2
			{"Deflection", 		},	-- Slot 2
			{"Surge of Light", 	},	-- Slot 3
			{"Solar Beam", 		},	-- Slot 3
		}
elseif petName == "Thundering Serpent Hatchling" or petName == "Tiny Green Dragon" or petName == "Tiny Red Dragon" or petName == "Wild Golden Hatchling" or petName == "Wild Jade Hatchling" then
	dragonkin_abilities = 
		{
			{"Roar", 			not MyPetBattle.buff("Attack Boost") },	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Breath", 			},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Call Lightning", 	},	-- Slot 2
			{"Cyclone", 		},	-- Slot 3
		}
elseif petName == "Wild Crimson Hatchling" then
	dragonkin_abilities = 
		{
			{"Healing Flame", 	MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Breath", 			},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Scorched Earth", 	},	-- Slot 2
			{"Deep Breath", 	},	-- Slot 3
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Chrominius" then
	dragonkin_abilities = 
		{
			{"Ancient Blessing", not MyPetBattle.buff("Ancient Blessing") or MyPetBattle.hp() < 0.75 },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Arcane Explosion",},	-- Slot 1
			{"Howl", 			},	-- Slot 2
			{"Ravage", 			},	-- Slot 3
			{"Surge of Power", 	},	-- Slot 3
		}
elseif petName == "Death Talon Whelpguard" then
	dragonkin_abilities = 
		{
			{"Blitz", 			},	-- Slot 1
			{"Shadowflame", 	},	-- Slot 1
			{"Whirlwind", 		},	-- Slot 2
			{"Spiked Skin", 	},	-- Slot 2
			{"Darkflame", 		},	-- Slot 3
			{"Clobber", 		},	-- Slot 3
		}
elseif petName == "Sprite Darter Hatchling" then
	dragonkin_abilities = 
		{
			{"Moonfire", 		not MyPetBattle.currentWeather("Moonlight") },	-- Slot 3
			{"Slicing Wind", 	},	-- Slot 1
			{"Arcane Blast", 	},	-- Slot 1
			{"Evanescence", 	},	-- Slot 2
			{"Life Exchange", 	},	-- Slot 2
			{"Cyclone", 		},	-- Slot 3
		}
elseif petName == "Untamed Hatchling" then
	dragonkin_abilities = 
		{
			{"Healing Flame", 	MyPetBattle.hp() < 0.75 },	-- Slot 3
			{"Roar", 			not MyPetBattle.buff("Attack Boost") },	-- Slot 2
			{"Claw", 			},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Spiked Skin", 	},	-- Slot 2
			{"Instability", 	},	-- Slot 3
		}
-------------------
else -- Unknown dragonkin pet
	print("|cFFFF0000 Unknown dragonkin pet: "..petName)
	return "UNKNOWN"
end

	spell = MyPetBattle.parseSpellTable(dragonkin_abilities)
	return spell
end
