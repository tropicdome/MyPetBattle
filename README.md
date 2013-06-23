MyPetBattle
===========
Kill those bastards

Version History:

v. 1.0.6
•Lock pet slots. To lock a pet slot, click the checkbutton on the pet portrait
•Checkbutton "Automatic capture rare" will capture rares if checked unless we are capped or fighting legendary. Not checked and we will kill everything
•"/mypetbattle ui" to hide/show the UI

v. 1.0.5
•Updated TOC to version 50300
•Added 20 new pets for WoW 5.3

v. 1.0.4

•Fixed bug in pet health threshold for pet switching in battle. It would sometimes switch back to the pet with low health.

v. 1.0.3

•Added configuration panel ui for additional pre-, in- and post-combat options.
  ◦Min. health threshold for random team generation.
  ◦Sliders to adjust individual pet level threshold for random team generation.
  ◦Health percentage to switch pet in combat.
  ◦Automatic revive/heal after combat with "Revive Battle Pets" or "Battle Pet Bandage".
  ◦Automatic generate new random team after combat.
•Added settings will be saved after each wow session.
•Added rotations for more pets.
•Fixed MyPetBattle.debuff() to also check for team wide buffs.
•Fixed minor potential bugs.

v. 1.0.2

•Added pass turn for more stun and sleep effects.
•Added function MyPetBattle.currentWeather("weatherName") returns true/false if the weather effect is present
•Updated rotations for many more pets.
•Updated MyPetBattle.hp() can also check health of enemy e.g. MyPetBattle.hp("active", 2) or MyPetBattle.hp("active", LE_BATTLE_PET_ENEMY) -- "2" is the same as "LE_BATTLE_PET_ENEMY" (enemy player).
•Fixed MyPetBattle.buff() to also check for team wide buffs.
•Fixed clearfocus from editbox.
•Fixed load pet textures on UI reload.

v. 1.0.1

•Automatic capture rare pets if not capped (3/3). If enabled it will automatically try and capture any rare pets you have room for. If disabled it will stop actions and switch to manual mode when you encounter a rare.
•Better selection of pets for random team setup. Useful for powerleveling.
