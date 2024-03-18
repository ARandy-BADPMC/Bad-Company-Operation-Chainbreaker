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
_this addWeapon "rhs_weap_m249_light_L";
_this addPrimaryWeaponItem "rhsusf_200Rnd_556x45_box";
_this addPrimaryWeaponItem "rhsusf_acc_saw_lw_bipod";
_this addWeapon "hgun_P07_F";
_this addHandgunItem "16Rnd_9x21_Mag";

// "Add containers";
_this forceAddUniform "U_DMan_CA_CombatUniform_Wdl";
_this addVest "V_DMan_CA_TacVest_Wdl";
_this addBackpack "B_Carryall_oli";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_this addItemToVest "rhsusf_100Rnd_556x45_M855_soft_pouch_coyote";};
for "_i" from 1 to 2 do {_this addItemToBackpack "rhsusf_100Rnd_556x45_M855_soft_pouch_coyote";};
_this addHeadgear "H_DMan_CA_Helmet_Wdl";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"WhiteHead_09","male04eng"] call BIS_fnc_setIdentity;
