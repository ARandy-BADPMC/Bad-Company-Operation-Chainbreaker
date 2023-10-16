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
_this addWeapon "rhs_weap_maaws";
_this addSecondaryWeaponItem "rhs_optic_maaws";
_this addSecondaryWeaponItem "rhs_mag_maaws_HEAT";

// "Add containers";
_this forceAddUniform "LOP_U_RACS_Fatigue_01_slv";
_this addVest "rhsusf_plateframe_light";
_this addBackpack "LOP_B_CA_MAAWS_cbr";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_this addItemToUniform "rhs_mag_30Rnd_556x45_M855_PMAG";};
_this addItemToVest "rhs_mag_30Rnd_556x45_M855_PMAG";
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red";};
_this addItemToVest "rhs_mag_an_m8hc";
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_m67";};
_this addItemToBackpack "rhs_mag_maaws_HEAT";
_this addHeadgear "rhsusf_protech_helmet_rhino";
_this addGoggles "rhsusf_shemagh_white";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "rhsusf_ANPVS_14";

// "Set identity";
[_this,"AsianHead_A3_02","male08eng"] call BIS_fnc_setIdentity;
