------------
-- UNDEAD --
------------
function undead()

local undead_abilities = nil

-- Get pet name
petName = MyPetBattle.petName()

-----------------------
-- DISEASED CRITTERS --
-----------------------
if petName == "Blighthawk" then
	undead_abilities = 
		{
			{"Infected Claw", 	},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 1
			{"Consume Corpse", 	},	-- Slot 2
			{"Ghostly Bite", 	},	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Cyclone", 		},	-- Slot 3
		}
elseif petName == "Giant Bone Spider" then
	undead_abilities = 
		{
			{"Bone Bite", 		},	-- Slot 1
			{"Poison Spit", 	},	-- Slot 1
			{"Sticky Web", 		},	-- Slot 2
			{"Siphon Life", 	},	-- Slot 2
			{"Leech Life", 		},	-- Slot 3
			{"Death Grip", 		},	-- Slot 3
		}
elseif petName == "Infected Fawn" then
	undead_abilities = 
		{
			{"Diseased Bite", 	},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Adrenaline Rush", },	-- Slot 2
			{"Consume Corpse", 	},	-- Slot 2
			{"Siphon Life", 	},	-- Slot 3
			{"Death and Decay", },	-- Slot 3
		}
elseif petName == "Infected Squirrel" then
	undead_abilities = 
		{
			{"Diseased Bite", 	},	-- Slot 1
			{"Creeping Fungus", },	-- Slot 1
			{"Rabid Strike", 	},	-- Slot 2
			{"Stampede", 		},	-- Slot 2
			{"Consume", 		},	-- Slot 3
			{"Corpse Explosion", },	-- Slot 3
		}
elseif petName == "Infested Bear Cub" then
	undead_abilities = 
		{
			{"Diseased Bite", 	},	-- Slot 1
			{"Roar", 			},	-- Slot 1
			{"Bash", 			},	-- Slot 2
			{"Hibernate", 		},	-- Slot 2
			{"Maul", 			},	-- Slot 3
			{"Corpse Explosion", },	-- Slot 3
		}
elseif petName == "Mr. Bigglesworth" then
	undead_abilities = 
		{
			{"Claw", 			},	-- Slot 1
			{"Pounce", 			},	-- Slot 1
			{"Ice Barrier", 	},	-- Slot 2
			{"Frost Nova", 		},	-- Slot 2
			{"Ice Tomb", 		},	-- Slot 3
			{"Howling Blast", 	},	-- Slot 3
		}
elseif petName == "Scourged Whelpling" then
	undead_abilities = 
		{
			{"Shadowflame", 	},	-- Slot 1
			{"Tail Sweep", 		},	-- Slot 1
			{"Call Darkness", 	},	-- Slot 2
			{"Death and Decay", },	-- Slot 2
			{"Plagued Blood", 	},	-- Slot 3
			{"Dreadful Breath", },	-- Slot 3
		}
elseif petName == "Stitched Pup" then
	undead_abilities = 
		{
			{"Diseased Bite", 	},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Rabid Strike", 	},	-- Slot 2
			{"Howl", 			},	-- Slot 2
			{"Consume Corpse", 	},	-- Slot 3
			{"Plagued Blood", 	},	-- Slot 3
		}
-------------------------
-- SKELETAL COMPANIONS --
-------------------------
elseif petName == "Fossilized Hatchling" then
	undead_abilities = 
		{
			{"Claw", 			},	-- 
			{"Bone Bite", 		},	-- 
			{"Ancient Blessing",},	-- 
			{"Death and Decay",	},	-- 
			{"Bone Prison", 	},	-- 
			{"BONESTORM", 		},	-- 
		}
elseif petName == "Frosty" then
	undead_abilities = 
		{
			{"Diseased Bite", 	},	-- 
			{"Frost Breath", 	},	-- 
			{"Call Blizzard", 	},	-- 
			{"Shriek",			},	-- 
			{"Ice Tomb", 		},	-- 
			{"Blistering Cold", },	-- 
		}
elseif petName == "Ghostly Skull" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- 
			{"Death Coil", 		},	-- 
			{"Ghostly Bite", 	},	-- 
			{"Spectral Strike",	},	-- 
			{"Siphon Life", 	},	-- 
			{"Unholy Ascension", },	-- 
		}
elseif petName == "Landro's Lichling" or petName == "Lil' K.T." then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- 
			{"Howling Blast", 	},	-- 
			{"Siphon Life", 	},	-- 
			{"Death and Decay",	},	-- 
			{"Frost Nova", 		},	-- 
			{"Curse of Doom", 	},	-- 
		}
---------------------
-- SPECTRAL BEINGS --
---------------------
elseif petName == "Lost of Lordaeron" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- 
			{"Absorb", 			},	-- 
			{"Siphon Life", 	},	-- 
			{"Arcane Explosion",},	-- 
			{"Bone Prison", 	},	-- 
			{"Curse of Doom", 	},	-- 
		}
elseif petName == "Restless Shadeling" then
	undead_abilities = 
		{
			{"Shadow Shock", 	},	-- 
			{"Arcane Blast", 	},	-- 
			{"Plagued Blood", 	},	-- 
			{"Death and Decay", },	-- 
			{"Death Coil", 		},	-- 
			{"Phase Shift", 	},	-- 
		}
elseif petName == "Spirit Crab" then
	undead_abilities = 
		{
			{"Snap", 			},	-- 
			{"Amplify Magic", 	},	-- 
			{"Surge", 			},	-- 
			{"Whirlpool", 		},	-- 
			{"Shell Shield", 	},	-- 
			{"Dark Simulacrum", },	-- 
		}
-----------------------
-- VOODOO COMPANIONS --
-----------------------
elseif petName == "Fetish Shaman" or petName == "Sen'jin Fetish" or petName == "Voodoo Figurine" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- 
			{"Flame Breath", 	},	-- 
			{"Immolate", 		},	-- 
			{"Wild Magic", 		},	-- 
			{"Sear Magic", 		},	-- 
			{"Dark Simulacrum", },	-- 
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Crawling Claw" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- 
			{"Agony", 			},	-- 
			{"Ancient", 		},	-- 
			{"Death Grip", 		},	-- 
			{"Curse of Doom", 	},	-- 
			{"Dark Simulacrum", },	-- 
		}
elseif petName == "Creepy Crate" then
	undead_abilities = 
		{
			{"Creepy Chomp", 	},	-- 
			{"Agony", 			},	-- 
			{"Death Grip", 		},	-- 
			{"Curse of Doom", 	},	-- 
			{"Devour", 			},	-- 
			{"BONESTORM", 		},	-- 
		}
elseif petName == "Eye of the Legion" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- 
			{"Eyeblast", 		},	-- 
			{"Agony", 			},	-- 
			{"Gravity", 		},	-- 
			{"Soul Ward", 		},	-- 
			{"Dark Simulacrum", },	-- 
		}
elseif petName == "Fungal Abomination" then
	undead_abilities = 
		{
			{"Absorb", 			},	-- 
			{"Consume", 		},	--
			{"Creeping Fungus", },	-- 
			{"Leech Seed", 		},	-- 
			{"Spore Shrooms", 	},	-- 
			{"Stun Seed", 		},	-- 
		}
elseif petName == "Vampiric Batling" then
	undead_abilities = 
		{
			{"Bite", 			},	-- 
			{"Screech", 		},	-- 
			{"Leech Life", 		},	-- 
			{"Hawk Eye", 		},	-- 
			{"Reckless Strike", },	-- 
			{"Nocturnal Strike", },	-- 
		}
elseif petName == "Unborn Val'kyr" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- Slot 1
			{"Shadow Shock", 	},	-- Slot 1
			{"Siphon Life", 	},	-- Slot 2
			{"Curse of Doom", 	},	-- Slot 2
			{"Haunt",			},	-- Slot 3
			{"Unholy Ascension", },	-- Slot 3
		}
-------------------
else -- Unknown undead
	print("|cFFFF0000 Unknown undead")
end

	spell = MyPetBattle.parseSpellTable(undead_abilities)
	return spell
end