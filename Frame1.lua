-- Add the custom configuration panel to the Interface Options menu
function Frame1Panel_OnLoad(panel)
	-- Set the name for the Category for the Panel.
	panel.name = "My Pet Battle"

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
	MPB.SORT_METHOD = DropDownSortMethod:GetValue()
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

function DropDownSortMethod_Init (self)
	self.defaultValue = 0;
	self.oldValue = MPB.SORT_METHOD;
	self.value = self.oldValue or self.defaultValue;
	self.tooltip = "Sorting priority for choosing pets";

	UIDropDownMenu_SetWidth(self, 90);
	UIDropDownMenu_Initialize(self, DropDownSortMethod_Initialize);
	UIDropDownMenu_SetSelectedValue(self, self.value);

	self.SetValue =
		function (self, value)
			self.value = value;
			UIDropDownMenu_SetSelectedValue(self, value);
		end;
	self.GetValue =
		function (self)
			return UIDropDownMenu_GetSelectedValue(self);
		end
	self.RefreshValue =
		function (self)
			UIDropDownMenu_Initialize(self, DropDownSortMethod_Initialize);
			UIDropDownMenu_SetSelectedValue(self, self.value);
		end
end


function DropDownSortMethod_OnClick(self)
	DropDownSortMethod:SetValue(self.value);
end

function DropDownSortMethod_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(DropDownSortMethod);
	local info = UIDropDownMenu_CreateInfo();

	info.text = "Rarity";
	info.func = DropDownSortMethod_OnClick;
	info.value = 0;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Rarity";
	info.tooltipText = "Pets are selected by rarity first, then level difference, then level";
	UIDropDownMenu_AddButton(info);

	info.text = "Level Difference";
	info.func = DropDownSortMethod_OnClick;
	info.value = 1;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Level Difference";
	info.tooltipText = "Pets are selected by level difference first, then rarity, then level";
	UIDropDownMenu_AddButton(info);

	info.text = "Level";
	info.func = DropDownSortMethod_OnClick;
	info.value = 2;
	if ( info.value == selectedValue ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	info.tooltipTitle = "Level";
	info.tooltipText = "Pets are selected by level first, then level difference, then rarity";
	UIDropDownMenu_AddButton(info);
end
