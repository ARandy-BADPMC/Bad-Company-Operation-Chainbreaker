
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
_this addPrimaryWeaponItem "rhsusf_acc_su230_mrds_c";
_this addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_M855_PMAG";
_this addWeapon "rhs_weap_fim92";

// "Add containers";
_this forceAddUniform "LOP_U_RACS_Fatigue_01_slv";
_this addVest "rhsusf_mbav_light";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "rhs_mag_30Rnd_556x45_M855_PMAG";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855_PMAG";};
_this addItemToVest "rhs_mag_an_m8hc";
_this addItemToVest "rhs_mag_m67";
_this addHeadgear "rhsusf_protech_helmet_rhino_ess";
_this addGoggles "rhsusf_shemagh_grn";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "rhsusf_ANPVS_14";

// "Set identity";
[_this,"WhiteHead_08","male08eng"] call BIS_fnc_setIdentity;
