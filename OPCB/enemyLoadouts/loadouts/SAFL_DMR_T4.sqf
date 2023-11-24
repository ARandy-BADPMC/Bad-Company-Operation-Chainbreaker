// "Exported from Arsenal by D3fiance";

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
_this addWeapon "rhs_weap_m14_rail_d";
_this addPrimaryWeaponItem "rhsusf_acc_LEUPOLDMK4";
_this addPrimaryWeaponItem "rhsusf_20Rnd_762x51_m80_Mag";
_this addPrimaryWeaponItem "rhsusf_acc_harris_swivel";

// "Add containers";
_this forceAddUniform "LOP_U_Fatigue_BDU_RACS_02";
_this addVest "V_Chestrig_khk";
_this addBackpack "LOP_RACS_FalconII_SVD";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_mag_rdg2_white";
_this addItemToVest "HandGrenade";
for "_i" from 1 to 5 do {_this addItemToVest "rhsusf_20Rnd_762x51_m118_special_Mag";};
for "_i" from 1 to 5 do {_this addItemToBackpack "rhs_10Rnd_762x54mmR_7N1";};
for "_i" from 1 to 2 do {_this addItemToBackpack "HandGrenade";};
_this addItemToBackpack "rhs_mag_rdg2_white";
for "_i" from 1 to 3 do {_this addItemToBackpack "rhsusf_20Rnd_762x51_m118_special_Mag";};
_this addHeadgear "LOP_H_Booniehat_RACS";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
