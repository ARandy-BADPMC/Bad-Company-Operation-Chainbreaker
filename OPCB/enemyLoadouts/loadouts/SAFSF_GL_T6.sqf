// "Exported from Arsenal by Alex K.";

// "[!] UNIT MUST BE LOCAL [!]";
if (!local //) exitWith {};

// "Remove existing items";
removeAllWeapons //;
removeAllItems //;
removeAllAssignedItems //;
removeUniform //;
removeVest //;
removeBackpack //;
removeHeadgear //;
removeGoggles //;

// "Add weapons";
// addWeapon "rhs_weap_m4a1_blockII_M203";
// addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
// addPrimaryWeaponItem "rhsusf_acc_su230_mrds_c";
// addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_M855_PMAG";
// addPrimaryWeaponItem "rhs_mag_M441_HE";

// "Add containers";
// forceAddUniform "LOP_U_RACS_Fatigue_01_slv";
// addVest "rhsusf_plateframe_grenadier";

// "Add items to containers";
// addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {// addItemToUniform "rhs_mag_30Rnd_556x45_M855_PMAG";};
// addItemToVest "rhs_mag_30Rnd_556x45_M855_PMAG";
for "_i" from 1 to 2 do {// addItemToVest "rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red";};
// addItemToVest "rhs_mag_an_m8hc";
// addItemToVest "rhs_mag_m67";
for "_i" from 1 to 3 do {// addItemToVest "rhs_mag_M441_HE";};
// addHeadgear "rhsusf_protech_helmet_rhino";

// "Add items";
// linkItem "ItemMap";
// linkItem "ItemCompass";
// linkItem "ItemWatch";
// linkItem "ItemRadio";
// linkItem "rhsusf_ANPVS_15";

// "Set identity";
[//,"PersianHead_A3_03","male06eng"] call BIS_fnc_setIdentity;
