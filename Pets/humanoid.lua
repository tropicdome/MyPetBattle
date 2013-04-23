--------------
-- HUMANOID --
--------------
function humanoid()

local humanoid_abilities = nil

-- Get pet name
petName = MyPetBattle.petName()

------------
-- GNOMES --
------------
if petName == "Father Winter's Helper" or petName == "Winter's Little Helper" then
	humanoid_abilities = 
		{
			{"Snowball", 		},	-- Slot 1
			{"Ice Lance", 		},	-- Slot 1
			{"Call Blizzard", 	},	-- Slot 2
			{"Eggnog", 			},	-- Slot 2
			{"Ice Tomb", 		},	-- Slot 3
			{"Gift of Winter's Veil",},	-- Slot 3
		}
--------------
-- HOPLINGS --
--------------
elseif petName == "Feral Vermling" or petName == "Hopling" then
	humanoid_abilities = 
		{
			{"Crush", 			},	-- Slot 1
			{"Tongue Lash", 	},	-- Slot 1
			{"Sticky Goo", 		},	-- Slot 2
			{"Poison Lash", 	},	-- Slot 2
			{"Backflip", 		},	-- Slot 3
			{"Dreadful Breath", },	-- Slot 3
		}
------------
-- HUMANS --
------------
-- None able to battle

-------------
-- MOONKIN --
-------------
elseif petName == "Moonkin Hatchling" then
	humanoid_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Solar Beam", 		},	-- Slot 1
			{"Entangling Roots",},	-- Slot 2
			{"Clobber", 		},	-- Slot 2
			{"Cyclone", 		},	-- Slot 3
			{"Moonfire", 		},	-- Slot 3
		}
-------------
-- MURLOCS --
-------------
elseif petName == "Deathy" then
	humanoid_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Deep Breath", 	},	-- Slot 1
			{"Scorched Earth", 	},	-- Slot 2
			{"Call Darkness", 	},	-- Slot 2
			{"Clobber", 		},	-- Slot 3
			{"Roar", 			},	-- Slot 3
		}
elseif petName == "Grunty" then
	humanoid_abilities = 
		{
			{"Gauss Rifle", 	},	-- Slot 1
			{"U-238 Rounds", 	},	-- Slot 1
			{"Stimpack", 		},	-- Slot 2
			{"Shield Block", 	},	-- Slot 2
			{"Launch", 			},	-- Slot 3
			{"Lock-On", 		},	-- Slot 3
		}
elseif petName == "Gurky" or petName == "Lurky" or petName == "Murki" or petName == "Murky" or petName == "Terky" then
	humanoid_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Flank", 			},	-- Slot 1
			{"Acid Touch", 		},	-- Slot 2
			{"Lucky Dance", 	},	-- Slot 2
			{"Clobber", 		},	-- Slot 3
			{"Stampede", 		},	-- Slot 3
		}
elseif petName == "Murkablo" then
	humanoid_abilities = 
		{
			{"Burn", 			},	-- Slot 1
			{"Bone Prison", 	},	-- Slot 1
			{"Agony", 			},	-- Slot 2
			{"Drain Power", 	},	-- Slot 2
			{"Blast of Hatred", },	-- Slot 3
			{"Scorched Earth", 	},	-- Slot 3
		}
elseif petName == "Murkimus the Gladiator" then
	humanoid_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Shield Block", 	},	-- Slot 2
			{"Counterstrike", 	},	-- Slot 2
			{"Heroic Leap", 	},	-- Slot 3
			{"Haymaker", 		},	-- Slot 3
		}
----------
-- ORCS --
----------
-- None able to battle

-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Anubisath Idol" then
	humanoid_abilities = 
		{
			{"Crush", 			},	-- Slot 1
			{"Demolish", 		},	-- Slot 1
			{"Sandstorm", 		},	-- Slot 2
			{"Stoneskin", 		},	-- Slot 2
			{"Deflection", 		},	-- Slot 3
			{"Rupture", 		},	-- Slot 3
		}
elseif petName == "Corefire Imp" then
	humanoid_abilities = 
		{
			{"Rush", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 1
			{"Immolation", 		not MyPetBattle.buff("Immolation") },	-- Slot 2
			{"Burn", 			},	-- Slot 1
			{"Flamethrower", 	},	-- Slot 2
			{"Cauterize", 		},	-- Slot 3
			{"Wild Magic", 		},	-- Slot 3
		}
elseif petName == "Curious Oracle Hatchling" then
	humanoid_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Water Jet", 		},	-- Slot 1
			{"Super Sticky Goo",},	-- Slot 2
			{"Aged Yolk", 		},	-- Slot 2
			{"Backflip", 		},	-- Slot 3
			{"Dreadful Breath", },	-- Slot 3
		}
elseif petName == "Curious Wolvar Pup" then
	humanoid_abilities = 
		{
			{"Punch", 			},	-- Slot 1
			{"Bite", 			},	-- Slot 1
			{"Snap Trap", 		},	-- Slot 2
			{"Frenzyheart Brew",},	-- Slot 2
			{"Whirlwind", 		},	-- Slot 3
			{"Maul", 			},	-- Slot 3
		}
elseif petName == "Flayer Youngling" then
	humanoid_abilities = 
		{
			{"Blitz", 			},	-- Slot 1
			{"Triple Snap", 	},	-- Slot 1
			{"Focus", 			},	-- Slot 2
			{"Deflection", 		},	-- Slot 2
			{"Kick", 			},	-- Slot 3
			{"Rampage", 		},	-- Slot 3
		}
elseif petName == "Gregarious Grell" then
	humanoid_abilities = 
		{
			{"Immolate", 		not MyPetBattle.debuff("Immolate") },	-- Slot 2
			{"Punch", 			},	-- Slot 1
			{"Burn", 			},	-- Slot 1
			{"Phase Shift", 	},	-- Slot 2
			{"Cauterize", 		},	-- Slot 3
			{"Sear Magic", 		},	-- Slot 3
		}
elseif petName == "Harbinger of Flame" then
	humanoid_abilities = 
		{
			{"Impale", 			MyPetBattle.hp("active", LE_BATTLE_PET_ENEMY) < 0.25 },	-- Slot 3 You can also use "2" instead of "LE_BATTLE_PET_ENEMY"
			{"Immolate", 		not MyPetBattle.debuff("Immolate") },	-- Slot 2
			{"Conflagrate", 	MyPetBattle.debuff("Immolate") or MyPetBattle.currentWeather("Scorched Earth") },	-- Slot 3
			{"Jab", 			},	-- Slot 1
			{"Burn", 			},	-- Slot 1
			{"Magma Wave", 		},	-- Slot 2
		}
elseif petName == "Harpy Youngling" then
	humanoid_abilities = 
		{
			{"Quills", 			},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 1
			{"Flyby", 			},	-- Slot 2
			{"Counterstrike", 	},	-- Slot 2
			{"Squawk", 			},	-- Slot 3
			{"Lift-Off", 		},	-- Slot 3
		}
elseif petName == "Kun-Lai Runt" then
	humanoid_abilities = 
		{
			{"Thrash", 			},	-- Slot 1
			{"Takedown", 		},	-- Slot 1
			{"Mangle", 			},	-- Slot 2
			{"Frost Shock", 	},	-- Slot 2
			{"Rampage", 		},	-- Slot 3
			{"Deep Freeze", 	},	-- Slot 3
		}
elseif petName == "Mini Tyrael" then
	humanoid_abilities = 
		{
			{"Holy Sword", 		},	-- Slot 1
			{"Omnislash", 		},	-- Slot 1
			{"Holy Justice", 	},	-- Slot 2
			{"Surge of Light", 	},	-- Slot 2
			{"Holy Charge", 	},	-- Slot 3
			{"Restoration", 	},	-- Slot 3
		}
elseif petName == "Pandaren Monk" then
	humanoid_abilities = 
		{
			{"Jab", 			},	-- Slot 1
			{"Takedown", 		},	-- Slot 1
			{"Focus Chi", 		},	-- Slot 2
			{"Staggered Steps", },	-- Slot 2
			{"Fury of 1,000 Fists",},	-- Slot 3
			{"Blackout Kick", 	},	-- Slot 3
		}
elseif petName == "Peddlefeet" then
	humanoid_abilities = 
		{
			{"Bow Shot", 		},	-- Slot 1
			{"Rapid Fire", 		},	-- Slot 1
			{"Lovestruck", 		},	-- Slot 2
			{"Perfumed Arrow", 	},	-- Slot 2
			{"Shot Through The Heart",},	-- Slot 3
			{"Love Potion", 	},	-- Slot 3
		}
elseif petName == "Qiraji Guardling" then
	humanoid_abilities = 
		{
			{"Crush", 			},	-- Slot 1
			{"Whirlwind", 		},	-- Slot 1
			{"Hawk Eye", 		},	-- Slot 2
			{"Sandstorm", 		},	-- Slot 2
			{"Reckless Strike", },	-- Slot 3
			{"Blackout Kick", 	},	-- Slot 3
		}
elseif petName == "Sporeling Sprout" then
	humanoid_abilities = 
		{
			{"Jab", 			},	-- Slot 1
			{"Charge", 			},	-- Slot 1
			{"Creeping Fungus", },	-- Slot 2
			{"Leech Seed", 		},	-- Slot 2
			{"Spore Shrooms", 	},	-- Slot 3
			{"Crouch", 			},	-- Slot 3
		}
elseif petName == "Stunted Yeti" then
	humanoid_abilities = 
		{
			{"Thrash", 			},	-- Slot 1
			{"Punch", 			},	-- Slot 1
			{"Mangle", 			},	-- Slot 2
			{"Haymaker", 		},	-- Slot 2
			{"Rampage", 		},	-- Slot 3
			{"Bash", 			},	-- Slot 3
		}
	
-------------------
else -- Unknown humanoid pet
	print("|cFFFF0000 Unknown humanoid pet")
end

	spell = MyPetBattle.parseSpellTable(humanoid_abilities)
	return spell
end