// "Exported from Arsenal by Alex K.";

// "[!] UNIT MUST BE LOCAL [!]";
if (!local _this) exitWith {};

// "Remove existing items";
removeAllWeapons _this;
removeAllItems _this;
removeAllAssignedItems _this;
removeUniform _this;
removeVest _this;
removeBackpack _this;
removeHeadgear _this;
removeGoggles _this;

// "Add weapons";
_this addWeapon "arifle_SPAR_03_blk_F";
_this addPrimaryWeaponItem "rhsusf_acc_premier";
_this addPrimaryWeaponItem "20Rnd_762x51_Mag";
_this addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
_this addWeapon "hgun_P07_F";
_this addHandgunItem "16Rnd_9x21_Mag";

// "Add containers";
_this forceAddUniform "U_DMan_SFC_GhillieSuit_Wdl";
_this addVest "V_DMan_CA_PlateCarrier1_Wdl";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "20Rnd_762x51_Mag";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_this addItemToVest "20Rnd_762x51_Mag";};
_this addHeadgear "H_DMan_CA_Helmet_camo_Wdl";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"WhiteHead_15","male05eng"] call BIS_fnc_setIdentity;
