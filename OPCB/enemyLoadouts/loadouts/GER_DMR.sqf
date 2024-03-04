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
_this addWeapon "hlc_rifle_g3sg1";
_this addPrimaryWeaponItem "hlc_optic_ZF95_g3";
_this addPrimaryWeaponItem "hlc_20rnd_762x51_Mk316_G3";
_this addWeapon "hgun_P07_F";
_this addHandgunItem "16Rnd_9x21_Mag";

// "Add containers";
_this forceAddUniform "PBW_Uniform1_fleck";
_this addVest "pbw_koppel_schtz";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_this addItemToVest "hlc_20rnd_762x51_Mk316_G3";};
_this addHeadgear "PBW_Helm1_fleck";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"WhiteHead_10","male03eng"] call BIS_fnc_setIdentity;
