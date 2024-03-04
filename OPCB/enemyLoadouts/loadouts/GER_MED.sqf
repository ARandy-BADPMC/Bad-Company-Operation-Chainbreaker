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
_this addWeapon "hlc_rifle_G36A1";
_this addPrimaryWeaponItem "hlc_30rnd_556x45_EPR_G36";
_this addWeapon "hgun_P07_F";
_this addHandgunItem "16Rnd_9x21_Mag";

// "Add containers";
_this forceAddUniform "PBW_Uniform1_fleck";
_this addVest "pbw_koppel_sani";
_this addBackpack "B_AssaultPack_khk";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToVest "16Rnd_9x21_Mag";};
_this addItemToVest "SmokeShell";
_this addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_this addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {_this addItemToVest "HandGrenade";};
for "_i" from 1 to 8 do {_this addItemToVest "hlc_30rnd_556x45_EPR_G36";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_fieldDressing";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_elasticBandage";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_packingBandage";};
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_bloodIV";};
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_bloodIV_250";};
for "_i" from 1 to 2 do {_this addItemToBackpack "ACE_bloodIV_500";};
for "_i" from 1 to 5 do {_this addItemToBackpack "ACE_splint";};
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_tourniquet";};
for "_i" from 1 to 15 do {_this addItemToBackpack "ACE_suture";};
_this addItemToBackpack "ACE_surgicalKit";
for "_i" from 1 to 10 do {_this addItemToBackpack "ACE_morphine";};
_this addHeadgear "PBW_Helm1_fleck";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"WhiteHead_12","male02eng"] call BIS_fnc_setIdentity;
