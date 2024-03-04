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
_this addWeapon "rhs_weap_vhsd2_bg_ct15x";
_this addPrimaryWeaponItem "rhsgref_30rnd_556x45_vhs2";
_this addPrimaryWeaponItem "rhs_mag_M441_HE";
_this addWeapon "hgun_P07_F";
_this addHandgunItem "16Rnd_9x21_Mag";

// "Add containers";
_this forceAddUniform "U_DMan_CA_CombatUniform_Wdl_tshirt";
_this addVest "V_DMan_CA_PlateCarrierGL_Wdl";
_this addBackpack "B_AssaultPack_khk";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "rhsgref_30rnd_556x45_vhs2";};
for "_i" from 1 to 2 do {_this addItemToUniform "rhs_mag_M441_HE";};
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
_this addItemToVest "rhs_mag_M441_HE";
_this addHeadgear "H_DMan_CA_Helmet_camo_Wdl";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"AfricanHead_02","male06eng"] call BIS_fnc_setIdentity;
