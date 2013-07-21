----------------
-- CRITTER --
----------------
function critter(petName)

local critter_abilities = nil

-- Get pet name
if petName == nil then
	petName = MyPetBattle.petName()
end

----------------
-- ARMADILLOS --
----------------
if petName == "Armadillo Pup" or petName == "Stone Armadillo" then
	critter_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Thrash", 			},	-- Slot 1
			{"Shell Shield", 	},	-- Slot 2
			{"Roar", 			},	-- Slot 2
			{"Infected Claw", 	},	-- Slot 3
			{"Powerball", 		},	-- Slot 3
		}
-----------
-- BIRDS --
-----------
elseif petName == "Darkmoon Hatchling" then
	critter_abilities = 
		{
			{"Peck", 			},	-- Slot 1
			{"Trample", 		},	-- Slot 1
			{"Screech", 		},	-- Slot 2
			{"Hawk Eye", 		},	-- Slot 2
			{"Flock", 			},	-- Slot 3
			{"Predatory Strike",},	-- Slot 3
		}
elseif petName == "Egbert" or petName == "Mulgore Hatchling" then
	critter_abilities = 
		{
			{"Adrenaline Rush", MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Adrenaline") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Peck", 			},	-- Slot 1
			{"Shell Shield", 	},	-- Slot 2
			{"Trample", 		},	-- Slot 3
			{"Feign Death", 	},	-- Slot 3
		}
----------
-- DEER --
----------
elseif petName == "Fawn" or petName == "Gazelle Fawn" or petName == "Little Fawn" or petName == "Winter Reindeer" then
	critter_abilities = 
		{
			{"Tranquility", 	MyPetBattle.hp() < 0.7 and not MyPetBattle.buff("Tranquility") },	-- Slot 2
			{"Bleat", 			MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Hoof", 			},	-- Slot 1
			{"Stampede", 		},	-- Slot 1
			{"Nature's Ward", 	},	-- Slot 2
			{"Headbutt", 		},	-- Slot 3
		}
------------
-- ELEKKS --
------------
elseif petName == "Peanut" or petName == "Pint-Sized Pink Pachyderm" then
	critter_abilities = 
		{
			{"Smash", 			},	-- Slot 1
			{"Trample", 		},	-- Slot 1
			{"Trumpet Strike", 	},	-- Slot 2
			{"Survival", 		},	-- Slot 2
			{"Headbutt", 		},	-- Slot 3
			{"Stampede", 		},	-- Slot 3
		}
-------------
-- INSECTS --
-------------
elseif petName == "Beetle" or petName == "Cockroach" or petName == "Creepy Crawly" or petName == "Crystal Beetle" or petName == "Death's Head Cockroach" or petName == "Deepholm Cockroach" or petName == "Dung Beetle" or petName == "Fire-Proof Roach" or petName == "Gold Beetle" or petName == "Irradiated Roach" or petName == "Locust" or petName == "Resilient Roach" or petName == "Roach" or petName == "Sand Scarab" or petName == "Savory Beetle" or petName == "Scarab Hatchling" or petName == "Stinkbug" or petName == "Tainted Cockroach" or petName == "Tol'vir Scarab" or petName == "Twilight Beetle" or petName == "Undercity Cockroach" then
	critter_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Flank", 			},	-- Slot 1
			{"Hiss", 			},	-- Slot 2
			{"Survival", 		},	-- Slot 2
			{"Swarm", 			},	-- Slot 3
			{"Apocalypse", 		},	-- Slot 3
		}
elseif petName == "Fire Beetle" or petName == "Lava Beetle" then
	critter_abilities = 
		{
			{"Apocalypse", 		},	-- Slot 3
			{"Cauterize", MyPetBattle.hp() < 0.7		},	-- Slot 2
			{"Burn", 			},	-- Slot 1
			{"Flank", 			},	-- Slot 1
			{"Hiss", 			},	-- Slot 2
			{"Scorched Earth", 	},	-- Slot 3
		}
elseif petName == "Grassland Hopper" or petName == "Marsh Fiddler" or petName == "Red Cricket" or petName == "Singing Cricket" then
	critter_abilities = 
		{
			{"Nature's Touch", 	MyPetBattle.hp() < 0.7 },	-- Slot 3
			{"Skitter", 		},	-- Slot 1
			{"Screech", 		},	-- Slot 1
			{"Swarm", 			},	-- Slot 2
			{"Cocoon Strike", 	},	-- Slot 2
			{"Inspiring Song", 	},	-- Slot 3
		}
elseif petName == "Imperial Silkworm" then
	critter_abilities = 
		{
			{"Burrow", 			},	-- Slot 3
			{"Chomp", 			},	-- Slot 1
			{"Consume", 		},	-- Slot 1
			{"Sticky Goo", 		},	-- Slot 2
			{"Moth Balls", 		},	-- Slot 2
			{"Moth Dust", 		},	-- Slot 3
		}
elseif petName == "Nether Roach" then
	critter_abilities = 
		{
			{"Flank", 			},	-- Slot 3
			{"Nether Blast", 	},	-- Slot 1
			{"Hiss", 			},	-- Slot 1
			{"Survival", 		},	-- Slot 2
			{"Swarm", 			},	-- Slot 2
			{"Apocalypse", 		},	-- Slot 3
		}
-------------
-- MARMOTS --
-------------
elseif petName == "Borean Marmot" or petName == "Brown Marmot" or petName == "Brown Prairie Dog" or petName == "Prairie Dog" or petName == "Yellow-Bellied Marmot" then 
	critter_abilities = 
		{
			{"Burrow", 			},	-- Slot 3
			{"Adrenaline Rush", MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Adrenaline") },	-- Slot 2
			{"Leap", 			MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Speed Boost") },	-- Slot 3
			{"Chomp", 			},	-- Slot 1
			{"Comeback", 		},	-- Slot 1
			{"Crouch", 			},	-- Slot 2
		}
----------
-- PIGS --
----------
elseif petName == "Golden Pig" or petName == "Lucky" or petName == "Mr. Wiggles" or petName == "Silver Pig" then 
	critter_abilities = 
		{
			{"Hoof", 			},	-- Slot 1
			{"Diseased Bite", 	},	-- Slot 1
			{"Crouch", 			},	-- Slot 2
			{"Buried Treasure", },	-- Slot 2
			{"Uncanny Luck", 	},	-- Slot 3
			{"Headbutt", 		},	-- Slot 3
		}
-------------
-- RABBITS --
-------------
elseif petName == "Alpine Hare" or petName == "Arctic Hare" or petName == "Brown Rabbit" or petName == "Elfin Rabbit" or petName == "Grasslands Cottontail" or petName == "Hare" or petName == "Mountain Cottontail" or petName == "Rabbit" or petName == "Snowshoe Hare" or petName == "Snowshoe Rabbit" or petName == "Spring Rabbit" or petName == "Tolai Hare" or petName == "Tolai Hare Pup" then
	critter_abilities = 
		{
			{"Burrow", 			},	-- Slot 3
			{"Dodge", 			},	-- Slot 2
			{"Adrenaline Rush", MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Adrenaline") },	-- Slot 2
			{"Scratch", 		},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Stampede",		},	-- Slot 3
		}
elseif petName == "Darkmoon Rabbit" then
	critter_abilities = 
		{
			{"Burrow", 			},	-- Slot 3
			{"Dodge", 			},	-- Slot 2
			{"Vicious Streak", 	MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Vicious Streak") },	-- Slot 2
			{"Scratch", 		},	-- Slot 1
			{"Huge, Sharp Teeth!",},	-- Slot 1
			{"Stampede",		},	-- Slot 3
		}
elseif petName == "Wolpertinger" then
	critter_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Horn Attack", 	},	-- Slot 1
			{"Flyby", 			},	-- Slot 2
			{"Sleeping Gas", 	},	-- Slot 2
			{"Headbutt", 		},	-- Slot 3
			{"Rampage",			},	-- Slot 3
		}
-------------------
-- RATS AND MICE --
-------------------
elseif petName == "Black Rat" or petName == "Carrion Rat" or petName == "Fjord Rat" or petName == "Giant Sewer Rat" or petName == "Highlands Mouse" or petName == "Long-tailed Mole" or petName == "Mouse" or petName == "Rat" or petName == "Redridge Rat" or petName == "Stormwind Rat" or petName == "Stowaway Rat" or petName == "Tainted Rat" or petName == "Undercity Rat" or petName == "Wharf Rat" or petName == "Yakrat"  or petName == "Prairie Mouse" then
	critter_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Comeback", 		},	-- Slot 1
			{"Flurry", 			},	-- Slot 2
			{"Poison Fang", 	},	-- Slot 2
			{"Stampede", 		},	-- Slot 3
			{"Survival",		},	-- Slot 3
		}
elseif petName == "Grotto Vole" or petName == "Whiskers the Rat" then
	critter_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Sting", 			},	-- Slot 2
			{"Survival", 		},	-- Slot 2
			{"Stampede", 		},	-- Slot 3
			{"Comeback",		},	-- Slot 3
		}
elseif petName == "Malayan Quillrat" or petName == "Malayan Quillrat Pup" or petName == "Porcupette" or petName == "Silent Hedgehog" then
	critter_abilities = 
		{
			{"Spiked Skin", 	not MyPetBattle.buff("Spiked Skin") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Poison Fang", 	},	-- Slot 1
			{"Counterstrike", 	},	-- Slot 2
			{"Survival", 		},	-- Slot 3
			{"Powerball",		},	-- Slot 3
		}
-----------
-- SHEEP --
-----------
elseif petName == "Black Lamb" or petName == "Elwynn Lamb" then
	critter_abilities = 
		{
			{"Hoof", 			},	-- Slot 1
			{"Chew", 			},	-- Slot 1
			{"Comeback", 		},	-- Slot 2
			{"Sooth", 			},	-- Slot 2
			{"Headbutt", 		},	-- Slot 3
			{"Rampage",			},	-- Slot 3
		}
----------------------
-- SKUNKS AND COONS --
----------------------
elseif petName == "Bandicoon" or petName == "Bandicoon Kit" or petName == "Masked Tanuki" or petName == "Masked Tanuki Pup" or petName == "Shy Bandicoon" then
	critter_abilities = 
		{
			{"Survival", 		MyPetBattle.hp() < 0.3 },	-- Slot 2
			{"Poison Fang", 	not MyPetBattle.debuff("Poisoned") },	-- Slot 3
			{"Bite", 			},	-- Slot 1
			{"Tongue Lash", 	},	-- Slot 1
			{"Counterstrike", 	},	-- Slot 2
			{"Powerball",		},	-- Slot 3
		}
elseif petName == "Highlands Skunk" or petName == "Mountain Skunk" or petName == "Skunk" or petName == "Stinker" then
	critter_abilities = 
		{
			{"Scratch", 		},	-- Slot 1
			{"Flurry", 			},	-- Slot 1
			{"Rake", 			},	-- Slot 2
			{"Perk Up", 		},	-- Slot 2
			{"Stench", 			},	-- Slot 3
			{"Bleat",			},	-- Slot 3
		}
------------
-- SNAILS --
------------
elseif petName == "Rapana Whelk" or petName == "Rusty Snail" or petName == "Scooter the Snail" or petName == "Shimmershell Snail" or petName == "Silkbead Snail" then
	critter_abilities = 
		{
			{"Ooze Touch", 		},	-- Slot 1
			{"Absorb", 			},	-- Slot 1
			{"Acidic Goo", 		},	-- Slot 2
			{"Shell Shield", 	},	-- Slot 2
			{"Dive", 			},	-- Slot 3
			{"Headbutt",		},	-- Slot 3
		}
---------------
-- SQUIRRELS --
---------------
elseif petName == "Alpine Chipmunk" or petName == "Grizzly Squirrel" or petName == "Nuts" or petName == "Red-Tailed Chipmunk" or petName == "Squirrel" then
	critter_abilities = 
		{
			{"Adrenaline Rush", MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Adrenaline") },	-- Slot 2
			{"Scratch", 		},	-- Slot 1
			{"Woodchipper", 	},	-- Slot 1
			{"Crouch", 			},	-- Slot 2
			{"Nut Barrage", 	},	-- Slot 3
			{"Stampede", 		},	-- Slot 3
		}
elseif petName == "Blighted Squirrel" then
	critter_abilities = 
		{
			{"Adrenaline Rush", MyPetBattle.currentPetSpeed(1) < MyPetBattle.currentPetSpeed(2) and not MyPetBattle.buff("Adrenaline") },	-- Slot 2
			{"Scratch", 		},	-- Slot 1
			{"Woodchipper", 	},	-- Slot 1
			{"Crouch", 			},	-- Slot 2
			{"Rabid Strike", 	},	-- Slot 3
			{"Stampede", 		},	-- Slot 3
		}
-------------------
-- MISCELLANEOUS --
-------------------
elseif petName == "Lucky Quilen Cub" or petName == "Perky Pug" then
	critter_abilities = 
		{
			{"Burrow", 			},	-- Slot 3
			{"Bite", 			},	-- Slot 1
			{"Comeback", 		},	-- Slot 1
			{"Perk Up", 		},	-- Slot 2
			{"Buried Treasure", },	-- Slot 2
			{"Trample", 		},	-- Slot 3
		}
elseif petName == "Porcupette" then
	critter_abilities = 
		{
			{"Spiked Skin", 	not MyPetBattle.buff("Spiked Skin") },	-- Slot 2
			{"Bite", 			},	-- Slot 1
			{"Poison Fang", 	},	-- Slot 1
			{"Counterstrike", 	},	-- Slot 2
			{"Survival", 		},	-- Slot 3
			{"Powerball", 		},	-- Slot 3
		}
-------------------
else -- Unknown critter pet
	print("|cFFFF0000 Unknown critter pet: "..petName)
	return "UNKNOWN"
end

	spell = MyPetBattle.parseSpellTable(critter_abilities)
	return spell
end
