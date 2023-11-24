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
_this addWeapon "rhs_weap_mk17_CQC";
_this addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
_this addPrimaryWeaponItem "rhsusf_acc_su230a_c";
_this addPrimaryWeaponItem "rhs_mag_20Rnd_SCAR_762x51_m80_ball";
_this addPrimaryWeaponItem "rhsusf_acc_tdstubby_tan";

// "Add containers";
_this forceAddUniform "LOP_U_RACS_Fatigue_01_slv";
_this addVest "rhsusf_plateframe_rifleman";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_mag_20Rnd_SCAR_762x51_m80_ball";
_this addItemToUniform "rhs_mag_an_m8hc";
for "_i" from 1 to 5 do {_this addItemToVest "rhs_mag_20Rnd_SCAR_762x51_m80_ball";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_m67";};
_this addHeadgear "rhsusf_protech_helmet_rhino";
_this addGoggles "G_Bandanna_tan";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "rhsusf_ANPVS_15";
