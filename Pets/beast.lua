----------------
-- BEAST --
----------------
function beast(petName)

local beast_abilities = nil

-- Get pet name
if petName == nil then
	petName = MyPetBattle.petName()
end

-----------
-- BEARS --
-----------
if petName == "Baby Blizzard Bear" or petName == "Poley" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Roar", 			},	-- Slot 1
			{"Bash", 			},	-- Slot 2
			{"Hibernate", 		},	-- Slot 2
			{"Maul", 			},	-- Slot 3
			{"Call Blizzard", 	},	-- Slot 3
		}
elseif petName == "Darkshore Cub" or petName == "Dun Morogh Cub" or petName == "Hyjal Bear Cub" or petName == "Panda Cub" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Roar", 			},	-- Slot 1
			{"Hibernate", 		},	-- Slot 2
			{"Bash", 			},	-- Slot 2
			{"Maul", 			},	-- Slot 3
			{"Rampage", 		},	-- Slot 3
		}
------------
-- CANINES --
------------
elseif petName == "Alpine Foxling" or petName == "Alpine Foxling Kit" or petName == "Arctic Fox Kit" or petName == "Fjord Worg Pup" or petName == "Fox Kit" or petName == "Worg Pup" then
	beast_abilities = 
		{
			{"Dazzling Dance", 	MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Dazzling Dance") },	-- Slot 3
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 3
			{"Bite", 			},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Crouch", 			},	-- Slot 2
			{"Howl", 			},	-- Slot 2
		}
elseif petName == "Tito" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Triple Snap", 	},	-- Slot 1
			{"Impale",			},	-- Slot 2
			{"Howl", 			},	-- Slot 2
			{"Cyclone", 		},	-- Slot 3
			{"Buried Treasure", },	-- Slot 3
		}
---------------
-- DIREHORNS --
---------------
elseif petName == "Direhorn Runt" or petName == "Pygmy Direhorn" or petName == "Stunted Direhorn" then
	beast_abilities = 
		{
			{"Trihorn Charge", 	},	-- Slot 1
			{"Trample", 		},	-- Slot 1
			{"Horn Attack", 	},	-- Slot 2
			{"Stampede", 		},	-- Slot 2
			{"Primal Cry", 		},	-- Slot 3
			{"Trihorn Shield", 	},	-- Slot 3
		}
-------------
-- FELINES --
-------------
elseif petName == "Black Tabby Cat" or petName == "Bombay Cat" or petName == "Calico Cat" or petName == "Cat" or petName == "Cheetah Cub" or petName == "Cornish Rex Cat" or petName == "Darkmoon Cub" or petName == "Nightsaber Cub" or petName == "Orange Tabby Cat" or petName == "Panther Cub" or petName == "Sand Kitten" or petName == "Siamese Cat" or petName == "Silver Tabby Cat" or petName == "Snow Cub" or petName == "White Kitten" or petName == "Winterspring Cub" then
	beast_abilities = 
		{
			{"Claw", 			},	-- Slot 1
			{"Pounce", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 2
			{"Screech", 		},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"Prowl", 			},	-- Slot 3
		}
elseif petName == "Feline Familiar" then
	beast_abilities = 
		{
			{"Onyx Bite", 		},	-- Slot 1
			{"Pounce", 			},	-- Slot 1
			{"Stoneskin", 		},	-- Slot 2
			{"Call Darkness", 	},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"Prowl", 			},	-- Slot 3
		}
-------------
-- INSECTS --
-------------
elseif petName == "Devouring Maggot" or petName == "Festering Maggot" or petName == "Jungle Grub" or petName == "Larva" or petName == "Maggot" or petName == "Mr. Grubbs" then
	beast_abilities = 
		{
			{"Leap", 			not MyPetBattle.buff("Speed Boost") and (MyPetBattle.currentPetSpeed(LE_BATTLE_PET_ALLY) < MyPetBattle.currentPetSpeed(LE_BATTLE_PET_ENEMY)) },	-- Slot 3
			{"Chomp", 			},	-- Slot 1
			{"Consume", 		},	-- Slot 1
			{"Acidic Goo", 		},	-- Slot 2
			{"Sticky Goo", 		},	-- Slot 2
			{"Burrow", 			},	-- Slot 3
		}
elseif petName == "Silithid Hatchling" then
	beast_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Devour", 			},	-- Slot 1
			{"Hiss", 			},	-- Slot 2
			{"Survival", 		},	-- Slot 2
			{"Swarm", 			},	-- Slot 3
			{"Sandstorm", 		},	-- Slot 3
		}
-------------
-- LIZARDS --
-------------
elseif petName == "Ash Lizard" or petName == "Diemetradon Hatchling" or petName == "Horned Lizard" or petName == "Lizard Hatchling" or petName == "Plains Monitor" or petName == "Spiky Lizard" or petName == "Spiny Lizard" or petName == "Twilight Iguana" then
	beast_abilities = 
		{
			{"Claw", 			},	-- Slot 1
			{"Quick Attack", 	},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Triple Snap", 	},	-- Slot 2
			{"Comeback", 		},	-- Slot 3
			{"Ravage", 			},	-- Slot 3
		}
elseif petName == "Scalded Basilisk Hatchling" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Crystal Prison", 	},	-- Slot 1
			{"Roar", 			},	-- Slot 2
			{"Feign Death", 	},	-- Slot 2
			{"Thrash", 			},	-- Slot 3
			{"Screech", 		},	-- Slot 3
		}
elseif petName == "Warpstalker Hatchling" then
	beast_abilities = 
		{
			{"Claw", 			},	-- Slot 1
			{"Blinkstrike", 	},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Triple Snap", 	},	-- Slot 2
			{"Ravage", 			},	-- Slot 3
			{"Comeback", 		},	-- Slot 3
		}
--------------
-- PRIMATES --
--------------
elseif petName == "Baby Ape" or petName == "Bananas" or petName == "Darkmoon Monkey" then
	beast_abilities = 
		{
			{"Smash", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 1
			{"Roar", 			},	-- Slot 2
			{"Clobber", 		},	-- Slot 2
			{"Banana Barrage", 	},	-- Slot 3
			{"Barrel Toss", 	},	-- Slot 3
		}
-------------
-- RAPTORS --
-------------
elseif petName == "Darting Hatchling" or petName == "Deviate Hatchling" or petName == "Gundrak Hatchling" or petName == "Lashtail Hatchling" or petName == "Leaping Hatchling" or petName == "Obsidian Hatchling" or petName == "Ravasaur Hatchling" or petName == "Razormaw Hatchling" or petName == "Razzashi Hatchling" then
	beast_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Flank", 			},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"Exposed Wounds", 	},	-- Slot 3
		}
elseif petName == "Zandalari Anklerender" then
	beast_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Hunting Party", 	},	-- Slot 1
			{"Primal Cry", 		},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"Black Claw", 		},	-- Slot 3
		}
elseif petName == "Zandalari Footslasher" then
	beast_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Hunting Party", 	},	-- Slot 1
			{"Primal Cry", 		},	-- Slot 2
			{"Bloodfang", 		},	-- Slot 3
			{"Exposed Wounds", 	},	-- Slot 3
		}
elseif petName == "Zandalari Kneebiter" then
	beast_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 3
			{"Bite", 			},	-- Slot 1
			{"Hunting Party", 	},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Black Claw", 		},	-- Slot 2
			{"Bloodfang", 		},	-- Slot 3
		}
elseif petName == "Zandalari Toenibbler" then
	beast_abilities = 
		{
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Flank", 			},	-- Slot 1
			{"Primal Cry", 		},	-- Slot 2
			{"Bloodfang", 		},	-- Slot 3
			{"Black Claw", 		},	-- Slot 3
		}
-------------
-- RODENTS --
-------------
elseif petName == "Bucktooth Flapper" then
	beast_abilities = 
		{
			{"Tail Slap", 		},	-- Slot 1
			{"Gnaw", 			},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Survival", 		},	-- Slot 2
			{"Woodchipper", 	},	-- Slot 3
			{"Chew", 			},	-- Slot 3
		}
elseif petName == "Clouded Hedgehog" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Poison Fang", 	},	-- Slot 1
			{"Survival", 		},	-- Slot 2
			{"Spiked Skin", 	},	-- Slot 2
			{"Counterstrike", 	},	-- Slot 3
			{"Powerball", 		},	-- Slot 3
		}
elseif petName == "Silent Hedgehog" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Poison Fang", 	},	-- Slot 1
			{"Spiked Skin", 	},	-- Slot 2
			{"Counterstrike", 	},	-- Slot 2
			{"Survival", 		},	-- Slot 3
			{"Powerball", 		},	-- Slot 3
		}
elseif petName == "Sumprush Rodent" then
	beast_abilities = 
		{
			{"Gnaw", 			},	-- Slot 1
			{"Tail Slap", 		},	-- Slot 1
			{"Mudslide", 		},	-- Slot 2
			{"Poison Fang", 	},	-- Slot 2
			{"Survival", 		},	-- Slot 3
			{"Stench", 			},	-- Slot 3
		}
---------------
-- SCORPIONS --
---------------
elseif petName == "Crunchy Scorpion" or petName == "Durotar Scorpion" or petName == "Leopard Scorpid" or petName == "Scorpid" or petName == "Scorpling" or petName == "Stripe-Tailed Scorpid" then
	beast_abilities = 
		{
			{"Crouch", 			},	-- Slot 2
			{"Sting", 			not MyPetBattle.debuff("Sting") },	-- Slot 3
			{"Snap", 			},	-- Slot 1
			{"Triple Snap", 	},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Rampage", 		},	-- Slot 3
		}
------------
-- SNAKES --
------------
elseif petName == "Adder" or petName == "Albino Snake" or petName == "Ash Viper" or petName == "Black Kingsnake" or petName == "Brown Snake" or petName == "Cobra Hatchling" or petName == "Coral Adder" or petName == "Coral Snake" or petName == "Crimson Snake" or petName == "Emerald Boa" or petName == "Grove Viper" or petName == "King Snake" or petName == "Moccasin" or petName == "Rat Snake" or petName == "Rattlesnake" or petName == "Rock Viper" or petName == "Sidewinder" or petName == "Snake" or petName == "Temple Snake" or petName == "Tree Python" or petName == "Water Snake" or petName == "Zooey Snake" then
	beast_abilities = 
		{
			{"Burrow", 			},	-- Slot 3
			{"Bite", 			},	-- Slot 1
			{"Poison Fang", 	},	-- Slot 1
			{"Hiss", 			},	-- Slot 2
			{"Counterstrike", 	},	-- Slot 2
			{"Vicious Fang", 	},	-- Slot 3
		}
elseif petName == "Elder Python" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Poison Fang", 	},	-- Slot 1
			{"Sting", 			},	-- Slot 2
			{"Huge Fang", 		},	-- Slot 2
			{"Burrow", 			},	-- Slot 3
			{"Slither", 		},	-- Slot 3
		}
------------
-- SPIDERS --
------------
elseif petName == "Amethyst Spiderling" or petName == "Ash Spiderling" or petName == "Desert Spider" or petName == "Dusk Spiderling" or petName == "Feverbite Hatchling" or petName == "Forest Spiderling" or petName == "Jumping Spider" or petName == "Skittering Cavern Crawler" or petName == "Smolderweb Hatchling" or petName == "Spider" or petName == "Twilight Spider" or petName == "Venomspitter Hatchling" or petName == "Widow Spiderling" then
	beast_abilities = 
		{
			{"Strike", 			},	-- Slot 1
			{"Poison Spit", 	},	-- Slot 1
			{"Sticky Web",		not MyPetBattle.debuff("Webbed") },  -- Slot 2
			{"Brittle Webbing", not MyPetBattle.debuff("Brittle Webbing") },  -- Slot 2
			{"Leech Life",		MyPetBattle.debuff("Webbed") or MyPetBattle.debuff("Brittle Webbing") },  -- Slot 3
			{"Spiderling Swarm", MyPetBattle.debuff("Webbed") or MyPetBattle.debuff("Brittle Webbing") },  -- Slot 3
		}
elseif petName == "Crystal Spider" then
	beast_abilities = 
		{
			{"Leech Life", 		MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Strike", 			},	-- Slot 1
			{"Crystal Prison", 	},	-- Slot 1
			{"Sticky Web", 		},	-- Slot 2
			{"Brittle Webbing", },	-- Slot 2
			{"Spiderling Swarm",},	-- Slot 3
		}
elseif petName == "Molten Hatchling" then
	beast_abilities = 
		{
			{"Burn", 			},	-- Slot 1
			{"Leech Life", 		},	-- Slot 1
			{"Sticky Web", 		},	-- Slot 2
			{"Cauterize", 		},	-- Slot 2
			{"Magma Wave", 		},	-- Slot 3
			{"Brittle Webbing",},	-- Slot 3
		}
---------------
-- UNGULATES --
---------------
elseif petName == "Clefthoof Runt" then
	beast_abilities = 
		{
			{"Smash", 			},	-- Slot 1
			{"Trample", 		},	-- Slot 1
			{"Survival", 		},	-- Slot 2
			{"Trumpet Strike", 	},	-- Slot 2
			{"Horn Attack", 	},	-- Slot 3
			{"Stampede",		},	-- Slot 3
		}
elseif petName == "Giraffe Calf" then
	beast_abilities = 
		{
			{"Hoof", 			},	-- Slot 1
			{"Stampede", 		},	-- Slot 1
			{"Tranquility", 	},	-- Slot 2
			{"Survival", 		},	-- Slot 2
			{"Headbutt", 		},	-- Slot 3
			{"Bleat",			},	-- Slot 3
		}
elseif petName == "Little Black Ram" or petName == "Summit Kid" then 
	beast_abilities = 
		{
			{"Hoof", 			},	-- Slot 1
			{"Chew", 			},	-- Slot 1
			{"Comeback", 		},	-- Slot 2
			{"Soothe", 			},	-- Slot 2
			{"Headbutt", 		},	-- Slot 3
			{"Stampede",		},	-- Slot 3
		}
elseif petName == "Stunted Shardhorn" then
	beast_abilities = 
		{
			{"Smash", 			},	-- Slot 1
			{"Survival", 		},	-- Slot 1
			{"Trample", 		},	-- Slot 2
			{"Horn Attack", 	},	-- Slot 2
			{"Trumpet Strike", 	},	-- Slot 3
			{"Stampede",		},	-- Slot 3
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Mountain Panda" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Scratch", 		},	-- Slot 1
			{"Cute Face", 		},	-- Slot 2
			{"Rock Barrage", 	},	-- Slot 2
			{"Burrow", 			},	-- Slot 3
			{"Mudslide",		},	-- Slot 3
		}
elseif petName == "Ravager Hatchling" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Rend", 			},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Sting", 			},	-- Slot 2
			{"Devour", 			},	-- Slot 3
			{"Rampage",			},	-- Slot 3
		}
elseif petName == "Red Panda" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Scratch", 		},	-- Slot 1
			{"Crouch", 			},	-- Slot 2
			{"Cute Face", 		},	-- Slot 2
			{"Perk Up", 		},	-- Slot 3
			{"Hibernate",		},	-- Slot 3
		}
elseif petName == "Snowy Panda" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Snowball", 		},	-- Slot 1
			{"Cute Face", 		},	-- Slot 2
			{"Call Blizzard", 	},	-- Slot 2
			{"Crouch", 			},	-- Slot 3
			{"Ice Barrier",		},	-- Slot 3
		}
elseif petName == "Sunfur Panda" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Scratch", 		},	-- Slot 1
			{"Hibernate", 		},	-- Slot 2
			{"Cute Face", 		},	-- Slot 2
			{"Sunlight", 		},	-- Slot 3
			{"Crouch",			},	-- Slot 3
		}
elseif petName == "Wind Rider Cub" then
	beast_abilities = 
		{
			{"Bite", 			},	-- Slot 1
			{"Squawk", 			},	-- Slot 1
			{"Slicing Wind", 	},	-- Slot 2
			{"Adrenaline Rush", },	-- Slot 2
			{"Flock", 			},	-- Slot 3
			{"Lift-Off",		},	-- Slot 3
		}
-------------------
else -- Unknown beast pet
	print("|cFFFF0000 Unknown beast pet: "..petName)
	return "UNKNOWN"
end

	spell = MyPetBattle.parseSpellTable(beast_abilities)
	return spell
end