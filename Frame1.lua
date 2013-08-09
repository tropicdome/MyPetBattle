-- Add the custom configuration panel to the Interface Options menu
function Frame1Panel_OnLoad(panel)
	-- Set the name for the Category for the Panel.
	panel.name = "MPB Options Panel"

	-- Set FontString "Version" to the TOC version number
	FontString_version:SetText("Version: "..GetAddOnMetadata("MyPetBattle", "Version"))

	-- When the player clicks okay, run this function.
	panel.okay = function (self) Frame1Panel_Close(); end;

	-- When the player clicks cancel, run this function.
--	panel.cancel = function (self)  Frame1Panel_CancelOrLoad();  end;

	-- Add the panel to the Interface Options
	InterfaceOptions_AddCategory(panel);
	
end

-- Show the text for checkbuttons
function Frame1_Checkbutton_OnLoad(checkButton)
	getglobal(checkButton:GetName().."Text"):SetText(checkButton:GetText())
end

-- When the player clicks okay, run this function to save the settings.
function Frame1Panel_Close()
	-- Set SavedVariables to user preferences
	print("Saving configuration...")

	-- TEAM SETUP
	MPB_CONFIG_TEAMSETUP_RANDOM_TEAM_PET_HEALTH_THRESHOLD = tonumber(EditBox_min_team_pet_health:GetText()) / 100
	MPB_CONFIG_TEAMSETUP_PET1_LEVEL_ADJUSTMENT = Slider_pet1_level:GetValue()
	MPB_CONFIG_TEAMSETUP_PET2_LEVEL_ADJUSTMENT = Slider_pet2_level:GetValue()
	MPB_CONFIG_TEAMSETUP_PET3_LEVEL_ADJUSTMENT = Slider_pet3_level:GetValue()

	MPB.USE_NON_RARE = not CheckButtonIncludeOnlyRare:GetChecked() and true or false
	MPB.PRIORITIZE_LEVEL = CheckButtonPrioritizeLevel:GetChecked() and true or false
	MPB.RANDOMIZE = CheckButtonRandomize:GetChecked() and true or false
	MPB.KEEP_MINIMUM_NUM_OF_A_LEVEL = tonumber(EditBoxLevelKeepMinimum:GetText()) or 0
		
	-- PRE-COMBAT
	MPB_CONFIG_PRE_COMBAT_ATTEMPT_STRONGEST_RANDOM_TEAM = CheckButton15:GetChecked() and true or false
	MPB.EQUIP_SAFARI_HAT = CheckButtonEquipSafariHat:GetChecked() and true or false
		
	-- COMBAT
	MPB_CONFIG_COMBAT_SWAP_PET_HEALTH_THRESHOLD = tonumber(EditBox_swap_pet_health_threshold:GetText()) / 100

	-- POST-COMBAT
	MPB_CONFIG_POST_COMBAT_USE_REVIVE_BATTLE_PETS_AFTER_COMBAT = CheckButton12:GetChecked() and true or false
	MPB_CONFIG_POST_COMBAT_USE_BATTLE_PET_BANDAGE_AFTER_COMBAT = CheckButton14:GetChecked() and true or false
	MPB_CONFIG_POST_COMBAT_AUTOMATIC_NEW_RANDOM_TEAM_AFTER_COMBAT = CheckButton11:GetChecked() and true or false

	-- MISC	
	MPB_CONFIG_MISC_AUTOMATIC_RELEASE_NON_RARES = CheckButton13:GetChecked() and true or false
end

-- When the player clicks cancel, run this function to cancel the changes made.
function Frame1Panel_CancelOrLoad()

end

