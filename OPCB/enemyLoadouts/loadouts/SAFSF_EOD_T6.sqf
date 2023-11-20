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
_this addWeapon "rhs_weap_mk18_KAC";
_this addPrimaryWeaponItem "rhsusf_acc_anpeq15";
_this addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
_this addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_M855_PMAG";

// "Add containers";
_this forceAddUniform "LOP_U_RACS_Fatigue_01_slv";
_this addVest "rhsusf_mbav_mg";
_this addBackpack "LOP_B_KB_EOD";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "rhs_mag_30Rnd_556x45_M855_PMAG";};
_this addItemToVest "rhs_mag_30Rnd_556x45_M855_PMAG";
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red";};
_this addItemToVest "rhs_mag_an_m8hc";
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_m67";};
_this addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_this addItemToBackpack "rhsusf_m112_mag";};
_this addItemToBackpack "rhsusf_m112x4_mag";
_this addItemToBackpack "ClaymoreDirectionalMine_Remote_Mag";
_this addHeadgear "rhsusf_protech_helmet_rhino";
_this addGoggles "rhs_googles_black";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "rhsusf_ANPVS_14";
