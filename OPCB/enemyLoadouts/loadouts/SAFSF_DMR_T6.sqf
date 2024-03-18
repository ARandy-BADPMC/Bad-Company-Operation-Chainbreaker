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
_this addWeapon "rhs_weap_sr25_ec";
_this addPrimaryWeaponItem "rhsusf_acc_aac_762sdn6_silencer";
_this addPrimaryWeaponItem "rhsusf_acc_premier";
_this addPrimaryWeaponItem "rhsusf_20Rnd_762x51_SR25_m118_special_Mag";
_this addPrimaryWeaponItem "rhsusf_acc_harris_bipod";

// "Add containers";
_this forceAddUniform "LOP_U_RACS_Fatigue_01";
_this addVest "rhsusf_plateframe_marksman";

// "Add binoculars";
_this addWeapon "rhsusf_bino_lerca_1200_tan";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhsusf_20Rnd_762x51_SR25_m118_special_Mag";
_this addItemToUniform "rhs_mag_an_m8hc";
for "_i" from 1 to 4 do {_this addItemToVest "rhsusf_20Rnd_762x51_SR25_m118_special_Mag";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_m67";};
_this addHeadgear "LOP_H_Booniehat_RACS";
_this addGoggles "rhsusf_shemagh2_grn";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "ItemGPS";
