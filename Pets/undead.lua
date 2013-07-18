------------
-- UNDEAD --
------------
function undead(petName)

local undead_abilities = nil

-- Get pet name
if petName == nil then
	petName = MyPetBattle.petName()
end

-----------------------
-- DISEASED CRITTERS --
-----------------------
if petName == "Blighted Squirrel" then
	undead_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Woodchipper", 	},	-- Slot 1
			{"Adrenaline Rush", },	-- Slot 2
			{"Crouch", 			},	-- Slot 2
			{"Rabid Strike", 	},	-- Slot 3
			{"Stampede", 		},	-- Slot 3
		}
elseif petName == "Blighthawk" then
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
			{"Claw", 			},	-- Slot 1
			{"Bone Bite", 		},	-- Slot 1
			{"Ancient Blessing",},	-- Slot 2
			{"Death and Decay",	},	-- Slot 2
			{"Bone Prison", 	},	-- Slot 3
			{"BONESTORM", 		},	-- Slot 3
		}
elseif petName == "Frosty" then
	undead_abilities = 
		{
			{"Diseased Bite", 	},	-- Slot 1
			{"Frost Breath", 	},	-- Slot 1
			{"Call Blizzard", 	},	-- Slot 2
			{"Shriek",			},	-- Slot 2
			{"Ice Tomb", 		},	-- Slot 3
			{"Blistering Cold", },	-- Slot 3
		}
elseif petName == "Ghostly Skull" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- Slot 1
			{"Death Coil", 		},	-- Slot 1
			{"Ghostly Bite", 	},	-- Slot 2
			{"Spectral Strike",	},	-- Slot 2
			{"Siphon Life", 	},	-- Slot 3
			{"Unholy Ascension", },	-- Slot 3
		}
elseif petName == "Landro's Lichling" or petName == "Lil' K.T." then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- Slot 1
			{"Howling Blast", 	MyPetBattle.debuff("Frost Nova") },	-- Slot 1
			{"Siphon Life", 	},	-- Slot 2
			{"Death and Decay",	},	-- Slot 2
			{"Frost Nova", 		},	-- Slot 3
			{"Curse of Doom", 	},	-- Slot 3
		}
---------------------
-- SPECTRAL BEINGS --
---------------------
elseif petName == "Lost of Lordaeron" then
	undead_abilities = 
		{
			{"Curse of Doom", 	not MyPetBattle.debuff("Curse of Doom") },	-- Slot 3
			{"Shadow Slash", 	},	-- Slot 1
			{"Absorb", 			},	-- Slot 1
			{"Siphon Life", 	},	-- Slot 2
			{"Arcane Explosion",},	-- Slot 2
			{"Bone Prison", 	},	-- Slot 3
		}
elseif petName == "Restless Shadeling" then
	undead_abilities = 
		{
			{"Shadow Shock", 	},	-- Slot 1
			{"Arcane Blast", 	},	-- Slot 1
			{"Plagued Blood", 	},	-- Slot 2
			{"Death and Decay", },	-- Slot 2
			{"Death Coil", 		},	-- Slot 3
			{"Phase Shift", 	},	-- Slot 3
		}
elseif petName == "Spirit Crab" then
	undead_abilities = 
		{
			{"Snap", 			},	-- Slot 1
			{"Amplify Magic", 	},	-- Slot 1
			{"Surge", 			},	-- Slot 2
			{"Whirlpool", 		},	-- Slot 2
			{"Shell Shield", 	},	-- Slot 3
			{"Dark Simulacrum", },	-- Slot 3
		}
-----------------------
-- VOODOO COMPANIONS --
-----------------------
elseif petName == "Fetish Shaman" or petName == "Sen'jin Fetish" or petName == "Voodoo Figurine" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- Slot 1
			{"Flame Breath", 	},	-- Slot 1
			{"Immolate", 		},	-- Slot 2
			{"Wild Magic", 		},	-- Slot 2
			{"Sear Magic", 		},	-- Slot 3
			{"Dark Simulacrum", },	-- Slot 3
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Crawling Claw" then
	undead_abilities = 
		{
			{"Curse of Doom", 	not MyPetBattle.debuff("Curse of Doom") },	-- Slot 3
			{"Shadow Slash", 	},	-- Slot 1
			{"Agony", 			},	-- Slot 1
			{"Ancient", 		},	-- Slot 2
			{"Death Grip", 		},	-- Slot 2
			{"Dark Simulacrum", },	-- Slot 3
		}
elseif petName == "Creepy Crate" then
	undead_abilities = 
		{
			{"Curse of Doom", 	not MyPetBattle.debuff("Curse of Doom") },	-- Slot 2
			{"Creepy Chomp", 	},	-- Slot 1
			{"Agony", 			},	-- Slot 1
			{"Death Grip", 		},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"BONESTORM", 		},	-- Slot 3
		}
elseif petName == "Eye of the Legion" then
	undead_abilities = 
		{
			{"Shadow Slash", 	},	-- Slot 1
			{"Eyeblast", 		},	-- Slot 1
			{"Agony", 			},	-- Slot 2
			{"Gravity", 		},	-- Slot 2
			{"Soul Ward", 		},	-- Slot 3
			{"Dark Simulacrum", },	-- Slot 3
		}
elseif petName == "Fungal Abomination" then
	undead_abilities = 
		{
			{"Absorb", 			},	-- Slot 1
			{"Consume", 		},	-- Slot 1
			{"Creeping Fungus", },	-- Slot 2
			{"Leech Seed", 		},	-- Slot 2
			{"Spore Shrooms", 	},	-- Slot 3
			{"Stun Seed", 		},	-- Slot 3
		}
elseif petName == "Vampiric Batling" then
	undead_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Screech", 		},	-- Slot 1
			{"Leech Life", 		},	-- Slot 2
			{"Hawk Eye", 		},	-- Slot 2
			{"Reckless Strike", },	-- Slot 3
			{"Nocturnal Strike", },	-- Slot 3
		}
elseif petName == "Unborn Val'kyr" then
	undead_abilities = 
		{
			{"Unholy Ascension", MyPetBattle.hp() < 0.3 },	-- Slot 3
			{"Curse of Doom", 	not MyPetBattle.debuff("Curse of Doom") },	-- Slot 2
			{"Shadow Slash", 	},	-- Slot 1
			{"Shadow Shock", 	},	-- Slot 1
			{"Siphon Life", 	},	-- Slot 2
			{"Haunt",			},	-- Slot 3
		}
-------------------
else -- Unknown undead
	print("|cFFFF0000 Unknown undead: "..petName)
	return "UNKNOWN"
end

	spell = MyPetBattle.parseSpellTable(undead_abilities)
	return spell
end