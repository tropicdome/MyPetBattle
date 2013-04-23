function zone_and_pet_level(CurrentPlayerZone)
--------------------------
-- ZONES AND PET LEVELS --
--------------------------
zones_and_pet_levelsTable =
	{
	-- {"ZONE", MIN, MAX },
		-- KALIMDOR
		{"Orgrimmar",			1, 1 },
		{"Azuremyst Isle",		1, 2 },
		{"Durotar",				1, 2 },
		{"Mulgore",				1, 2 },
		{"Teldrassil",			1, 2 },
		{"Darnassus",			1, 3 },
		{"Exodar",				1, 3 },
		{"Thunder Bluff",		1, 3 },
		{"Northern Barrens",	3, 4 },
		{"Azshara",				3, 6 },
		{"Bloodmyst Isle",		3, 6 },
		{"Darkshore",			3, 6 },
		{"Ashenvale",			4, 6 },
		{"Stonetalon Mountains",5, 7 },
		{"Desolace",			7, 9 },
		{"Southern Barrens",	9, 10 },
		{"Feralas",				11, 12 },
		{"Dustwallow Marsh",	12, 13 },
		{"Tanaris",				13, 14 },
		{"Thousand Needles",	13, 14 },
		{"Felwood",				14, 15 },
		{"Moonglade",			15, 16 },
		{"Un'Goro Crater",		15, 16 },
		{"Ahn'Qiraj: The Fallen Kingdom",	16, 17 },
		{"Silithus",			16, 17 },
		{"Winterspring",		17, 18 },

		-- EASTERN KINGDOMS
		{"Stormwind",			1, 1 },
		{"Dun Morogh",			1, 2 },
		{"Elwynn Forest",		1, 2 },
		{"Eversong Woods",		1, 2 },
		{"Tirisfal Glade",		1, 2 },
		{"Undercity",			1, 2 },
		{"Ironforge",			1, 3 },
		{"Silvermoon City",		1, 3 },
		{"Westfall",			3, 4 },
		{"Ghostlands",			3, 6 },
		{"Loch Modan",			3, 6 },
		{"Silverpine Forest",	3, 6 },
		{"Redridge Mountains",	4, 6 },
		{"Duskwood",			5, 7 },
		{"Hillsbrad Foothills",	6, 7 },
		{"Wetlands",			6, 7 },
		{"Arathi Highlands",	7, 8 },
		{"Northern Stranglethorn Vale",	7, 9 },
		{"The Cape of Stranglethorn",	9, 10 },
		{"Western Plaguelands",	10, 11 },
		{"The Hinterlands",		11, 12 },
		{"Eastern Plaguelands",	12, 13 },
		{"Badlands",			13, 14 },
		{"Searing Gorge",		13, 14 },
		{"Swamp of Sorrows",	14, 15 },
		{"Burning Steppes",		15, 16 },
		{"Blasted Lands",		16, 17 },
		{"Deadwind Pass",		17, 18 },

		-- OUTLAND
		{"Hellfire",			17, 18 },
		{"Nagrand",				18, 19 },
		{"Terrokar",			18, 19 },
		{"Zangarmarsh",			18, 19 },
		{"Blade's edge",		18, 20 },
		{"Netherstorm",			20, 21 },
		{"Shadowmoon",			20, 21 },

		-- NORTHREND
		{"Borean tundra",		20, 22 },
		{"Howling Fjord",		20, 22 },
		{"Grizzly Hills",		21, 22 },
		{"Scholazar Basin",		21, 22 },
		{"Crystalsong forest",	22, 23 },
		{"Dragonblight",		22, 23 },
		{"Icecrown",			22, 23 },
		{"Storm Peaks",			22, 23 },

		-- CATACLYSM Zones
		{"Deepholm",			22, 23 },
		{"Mount Hyjal",			22, 24 },
		{"Uldum",				23, 24 },
		{"Twilight Highlands",	23, 24 },

		-- PANDARIA
		{"Krasarang Wilds",		23, 25 },
		{"Kun-Lai Summit",		23, 25 },
		{"The Jade Forest",		23, 25 },
		{"Valley of the Four Winds", 23, 25 },
		{"Dread Wastes",		24, 25 },
		{"Townlong Steppes",	24, 25 },
	}
	
	local zone = nil
	local zonePetMinLevel = nil
	local zonePetMaxLevel = nil
	
	for _, zoneTable in pairs(zones_and_pet_levelsTable) do
		zone = zoneTable[1] 
		zonePetMinLevel = zoneTable[2]
		zonePetMaxLevel = zoneTable[3]
		-- Return pet level if conditions are true.
		if string.lower(CurrentPlayerZone) == string.lower(zone) then
			return zonePetMinLevel, zonePetMaxLevel
		end
	end

	return nil
end
	