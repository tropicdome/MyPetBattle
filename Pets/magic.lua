-----------
-- MAGIC --
-----------
function magic()

local magic_abilities = nil

-- Get pet name
petName = MyPetBattle.petName()

------------
-- DEMONS --
------------
if petName == "Minfernal" then
	magic_abilities = 
		{
			{"Immolation", 		not MyPetBattle.buff("Immolation") },	-- Slot 2
			{"Crush", 			},	-- Slot 1
			{"Immolate", 		},	-- Slot 1
			{"Extra Plating", 	},	-- Slot 2
			{"Meteor Strike", 	},	-- Slot 3
			{"Explode", 		},	-- Slot 3
		}
elseif petName == "Mini Diablo" then
	magic_abilities = 
		{
			{"Burn", 			},	-- Slot 1
			{"Blast of Hatred", },	-- Slot 1
			{"Call of Darkness",},	-- Slot 2
			{"Agony", 			},	-- Slot 2
			{"Weakness", 		},	-- Slot 3
			{"Bone Prison", 	},	-- Slot 3
		}
elseif petName == "Twilight Fiendling" then
	magic_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Creepy Chomp", 	},	-- Slot 1
			{"Rake", 			},	-- Slot 1
			{"Creeping Ooze", 	},	-- Slot 2
			{"Andrenal Glands", },	-- Slot 3
			{"Siphone Life", 	},	-- Slot 3
		}
------------------------
-- JEWELED COMPANIONS --
------------------------
elseif petName == "Jade Owl" then
	magic_abilities = 
		{
			{"Slicing Wind", 	},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Adrenaline Rush", },	-- Slot 2
			{"Hawk Eye", 		},	-- Slot 2
			{"Lift-Off", 		},	-- Slot 3
			{"Cyclone", 		},	-- Slot 3
		}
elseif petName == "Jade Tiger" then
	magic_abilities = 
		{
			{"Jade Claw", 		},	-- Slot 1
			{"Pounce", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 2
			{"Jadeskin", 		},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"Prowl", 			},	-- Slot 3
		}
elseif petName == "Onyx Panther" then
	magic_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 3
			{"Claw", 			},	-- Slot 1
			{"Onyx Bite", 		},	-- Slot 1
			{"Stoneskin", 		},	-- Slot 2
			{"Roar", 			},	-- Slot 2
			{"Stone Rush", 		},	-- Slot 3
		}
elseif petName == "Zipao Tiger" then
	magic_abilities = 
		{
			{"Onyx Bite", 		},	-- Slot 1
			{"Pounce", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 2
			{"Stoneskin", 		},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"Prowl", 			},	-- Slot 3
		}
------------------------
-- LANTERNS AND LAMPS --
------------------------
elseif petName == "Enchanted Lantern" or petName == "Festival Lantern" or petName == "Lunar Lantern" then
	magic_abilities = 
		{
			{"Beam", 			},	-- Slot 1
			{"Burn", 			},	-- Slot 1
			{"Illuminate", 		},	-- Slot 2
			{"Flash", 			},	-- Slot 2
			{"Soul Ward", 		},	-- Slot 3
			{"Light", 			},	-- Slot 3
		}
elseif petName == "Magic Lamp" then
	magic_abilities = 
		{
			{"Beam", 			},	-- Slot 1
			{"Arcane Blast", 	},	-- Slot 1
			{"Sear Magic", 		},	-- Slot 2
			{"Gravity", 		},	-- Slot 2
			{"Soul Ward", 		},	-- Slot 3
			{"Wish", 			},	-- Slot 3
		}
----------------------
-- OOZES AND SLIMES --
----------------------
elseif petName == "Jade Oozeling" or petName == "Oily Slimeling" or petName == "Toxic Wasteling" then
	magic_abilities = 
		{
			{"Ooze Touch", 		},	-- Slot 1
			{"Absorb", 			},	-- Slot 1
			{"Corrosion", 		},	-- Slot 2
			{"Creeping Ooze", 	},	-- Slot 2
			{"Expunge", 		},	-- Slot 3
			{"Acidic Goo", 		},	-- Slot 3
		}
elseif petName == "Viscidus Globule" then
	magic_abilities = 
		{
			{"Ooze Touch", 		},	-- Slot 1
			{"Acid Touch", 		},	-- Slot 1
			{"Weakness", 		},	-- Slot 2
			{"Poison Spit", 	},	-- Slot 2
			{"Expunge", 		},	-- Slot 3
			{"Creeping Ooze", 	},	-- Slot 3
		}
---------------
-- WYRMLINGS --
---------------
elseif petName == "Mana Wyrmling" or petName == "Shimmering Wyrmling" then
	magic_abilities = 
		{
			{"Feedback", 		},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Drain Power", 	},	-- Slot 2
			{"Amplify Magic", 	},	-- Slot 2
			{"Mana Surge", 		},	-- Slot 3
			{"Deflection", 		},	-- Slot 3
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Arcane Eye" then
	magic_abilities = 
		{
			{"Focused Beams", 	},	-- Slot 1
			{"Physic Blast", 	},	-- Slot 1
			{"Eyeblast", 		},	-- Slot 2
			{"Drain Power", 	},	-- Slot 2
			{"Interrupting Gaze",},	-- Slot 3
			{"Mana Surge", 		},	-- Slot 3
		}
elseif petName == "Darkmoon Eye" then
	magic_abilities = 
		{
			{"Laser", 			},	-- Slot 1
			{"Focused Beams", 	},	-- Slot 1
			{"Eyeblast", 		},	-- Slot 2
			{"Inner Vision", 	},	-- Slot 2
			{"Darkmoon Curse", 	},	-- Slot 3
			{"Interrupting Gaze",},	-- Slot 3
		}
elseif petName == "Enchanted Broom" then
	magic_abilities = 
		{
			{"Broom", 			},	-- Slot 1
			{"Batter", 			},	-- Slot 1
			{"Sandstorm", 		},	-- Slot 2
			{"Sweep", 			},	-- Slot 2
			{"Clean-Up", 		},	-- Slot 3
			{"Wind-Up", 		},	-- Slot 3
		}
elseif petName == "Ethereal Soul-Trader" then
	magic_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Beam", 			},	-- Slot 1
			{"Soul Ward", 		},	-- Slot 2
			{"Inner Vision", 	},	-- Slot 2
			{"Soulrush", 		},	-- Slot 3
			{"Life Exchange", 	},	-- Slot 3
		}
elseif petName == "Gusting Grimoire" then
	magic_abilities = 
		{
			{"Fel Immolate", 	},	-- Slot 1
			{"Shadow Shock", 	},	-- Slot 1
			{"Agony", 			},	-- Slot 2
			{"Amplify Magic", 	},	-- Slot 2
			{"Meteor Strike", 	},	-- Slot 3
			{"Curse of Doom", 	},	-- Slot 3
		}
elseif petName == "Legs" then
	magic_abilities = 
		{
			{"Laser", 			},	-- Slot 1
			{"Pump", 			},	-- Slot 1
			{"Surge of Power", 	},	-- Slot 2
			{"Gravity", 		},	-- Slot 2
			{"Focused Beams", 	},	-- Slot 3
			{"Whirlpool", 		},	-- Slot 3
		}
elseif petName == "Lofty Libram" then
	magic_abilities = 
		{
			{"Arcane Blast", 	},	-- Slot 1
			{"Shadow Shock", 	},	-- Slot 1
			{"Arcane Explosion",},	-- Slot 2
			{"Amplify Magic", 	},	-- Slot 2
			{"Inner Vision", 	},	-- Slot 3
			{"Curse of Doom", 	},	-- Slot 3
		}
elseif petName == "Mini Mindslayer" then
	magic_abilities = 
		{
			{"Eyeblast", 		},	-- Slot 1
			{"Mana Surge", 		},	-- Slot 1
			{"Amplify Magic", 	},	-- Slot 2
			{"Inner Vision", 	},	-- Slot 2
			{"Interrupting Gaze",},	-- Slot 3
			{"Life Exchange", 	},	-- Slot 3
		}
elseif petName == "Nordrassil Wisp" then
	magic_abilities = 
		{
			{"Beam", 			},	-- Slot 1
			{"Light", 			},	-- Slot 1
			{"Flash", 			},	-- Slot 2
			{"Arcane Blast", 	},	-- Slot 2
			{"Soul Ward", 		},	-- Slot 3
			{"Arcane Explosion",},	-- Slot 3
		}
elseif petName == "Spectral Cub" or petName == "Spectral Tiger Cub" then
	magic_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 3
			{"Claw", 			},	-- Slot 1
			{"Rend", 			},	-- Slot 1
			{"Evanescence", 	},	-- Slot 2
			{"Spectral Strike", },	-- Slot 2
			{"Prowl", 			},	-- Slot 3
		}
elseif petName == "Spectral Porcupette" then
	magic_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Powerball", 		},	-- Slot 1
			{"Spectral Strike", },	-- Slot 2
			{"Spirit Spikes", 	},	-- Slot 2
			{"Illusionary Barrier", },	-- Slot 3
			{"Spectral Spine", 	},	-- Slot 3
		}
elseif petName == "Willy" then
	magic_abilities = 
		{
			{"Tongue Lash", 	},	-- Slot 1
			{"Focused Beams", 	},	-- Slot 1
			{"Interrupting Gaze",},	-- Slot 2
			{"Eye Blast", 		},	-- Slot 2
			{"Agony", 			},	-- Slot 3
			{"Dark Simulacrum", },	-- Slot 3
		}
---------------------
-- ZERG COMPANIONS --
---------------------
elseif petName == "Baneling" then
	magic_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Centrifugal Hooks",},	-- Slot 2
			{"Adrenal Glands", 	},	-- Slot 2
			{"Burrow", 			},	-- Slot 3
			{"Baneling Burst", 	},	-- Slot 3
		}
elseif petName == "Zergling" then
	magic_abilities = 
		{
			{"Metabolic Boost",	MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Metabolic Boost") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Flank", 			},	-- Slot 1
			{"Adrenal Glands", 	},	-- Slot 2
			{"Consume", 		},	-- Slot 3
			{"Zergling Rush", 	},	-- Slot 3
		}
-------------------
else -- Unknown magic pet
	print("|cFFFF0000 Unknown magic pet")
end

	spell = MyPetBattle.parseSpellTable(magic_abilities)
	return spell
end