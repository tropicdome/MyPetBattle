-- Enable / disable combat
function CheckButton1_OnClick()
	SlashCmdList.MYPETBATTLE('')
end

-- Automatic queue and join pet battle PvP
function CheckButtonJoinPvP_OnClick()
	SlashCmdList.MYPETBATTLE('join_pvp')
end

-- Enable automatic capture rares if you have room for more of that specie
function CheckButton3_OnClick()
	SlashCmdList.MYPETBATTLE('capture_rares')
end

-- Enable automatic capture common/uncommon if you have room for more of that specie
function CheckButton4_OnClick()
	SlashCmdList.MYPETBATTLE('capture_common_uncommon')
end

-- Make random team based on desired pet level
function Button_MakeRandomTeam_OnClick()
	MyPetBattle.setState(MyPetBattleState.SET_TEAM_START, true)
end

-- Print summary of your per journal rares
function Button_PetJournalSummary_OnClick()
	print("|cFF4169E1 :: Pet Journal summary report ::")
	
	local numPets, numOwned = C_PetJournal.GetNumPets()
--	print("Total owned pets: " .. numOwned)

	local petLevel = nil
	local rareCount = 0
	local n_ = nil
	for petLevel = 1, 25 do
		local petCount = 0
		for n_=1, numOwned do
			local petID, _, owned, _, level, _, isRevoked, speciesName, icon, petType, _, _, _, _, canBattle, _, _, obtainable = C_PetJournal.GetPetInfoByIndex(n_)
			level = MyPetBattle.getPetLevel("Button_PetJournalSummary_OnClick", petID, level)
			local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)
			local petIsSummonable = C_PetJournal.PetIsSummonable(petID)

			if petLevel == level and owned and canBattle and not isRevoked and rarity == 4 and petIsSummonable then
				petCount = petCount + 1
				rareCount = rareCount + 1
			end
		end
		print("Level: " .. petLevel .. ", Count: #"  .. petCount)
	end
	print("Total |cFF0066FFrares|r owned: " .. rareCount)
end

function MyPetBattleForm_OnLoad()

	-- Load version from TOC and set label
	GUI_FontString_version:SetText("v"..GetAddOnMetadata("MyPetBattle", "Version"))
end

-- Open configuration panel
function Button_open_config_panel_OnClick()
	InterfaceOptionsFrame_OpenToCategory("My Pet Battle")
end

-- Show the text for checkbuttons
function Frame_Checkbutton_OnLoad(checkButton)
	getglobal(checkButton:GetName().."Text"):SetText(checkButton:GetText())
end

-- Set variable for checkbuttons to lock pets for random team generation
function Check_lock_pet_1_OnClick()
	MPB_LOCK_PET1 = Check_lock_pet_1:GetChecked()
end
function Check_lock_pet_2_OnClick()
	MPB_LOCK_PET2 = Check_lock_pet_2:GetChecked()
end
function Check_lock_pet_3_OnClick()
	MPB_LOCK_PET3 = Check_lock_pet_3:GetChecked()
end

function CheckButton_auto_forfeit_OnClick()
	SlashCmdList.MYPETBATTLE('auto_forfeit')
end

function CheckButton_wintrade_enable_OnClick()
	SlashCmdList.MYPETBATTLE('wintrade_enable')
end

function CheckButton_wt_match_levels_OnClick()
	SlashCmdList.MYPETBATTLE('wintrade_match_levels')
end

------------------------------
-- Minimap button functions --
------------------------------
-- Update the position of the minimap button
function MPB_MMButton_UpdatePosition()
	-- Initialize minimap button the first time
	if MPB_MMBUTTONPOSITION == nil or MPB_MMBUTTONPOSITION[1] == nil or MPB_MMBUTTONPOSITION[2] == nil then 
		MPB_MMBUTTONPOSITION = {50, 50} 
	end

	-- Set new position of the minimap button
    MPB_MMButton:SetPoint(
        "TOPLEFT",
        "Minimap",
        "TOPLEFT",
        54 - MPB_MMBUTTONPOSITION[1],
        MPB_MMBUTTONPOSITION[2] - 55
    )
end

-- Show tooltip on mouseover
function MPB_MMButton_OnEnter(self)
	MPB_BUTTON_TOOLTIP = "Click to hide/show |cffff8000MPB|r window\n\nClick and hold to move this icon" 
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    GameTooltip:SetText(MPB_BUTTON_TOOLTIP)
    GameTooltipTextLeft1:SetTextColor(1, 1, 1)
    GameTooltip:Show()
end

-- Show/hide ui
function MPB_MMButton_OnClick(self,button)
    SlashCmdList.MYPETBATTLE('ui')
end

-- Calculate position when button is dragged
function MPB_MMButton_BeingDragged()
    local w,x = GetCursorPosition() 
    local y,z = Minimap:GetLeft(), Minimap:GetBottom() 
    w = y-w/UIParent:GetScale()+70 
    x = x/UIParent:GetScale()-z-100
	-- Update position
    MPB_MMBUTTONPOSITION = {w,x}
    MPB_MMButton_UpdatePosition()
end

