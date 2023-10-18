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
_this addWeapon "rhs_weap_m24sws";
_this addPrimaryWeaponItem "rhsusf_acc_LEUPOLDMK4";
_this addPrimaryWeaponItem "rhsusf_5Rnd_762x51_m993_Mag";
_this addPrimaryWeaponItem "rhsusf_acc_harris_swivel";

// "Add containers";
_this forceAddUniform "LOP_U_Fatigue_BDU_RACS_02";
_this addVest "LOP_V_CarrierRig_TAN";
_this addBackpack "LOP_RACS_FalconII_SVD";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 4 do {_this addItemToUniform "rhsusf_5Rnd_762x51_m993_Mag";};
for "_i" from 1 to 2 do {_this addItemToUniform "rhsusf_5Rnd_762x51_m62_Mag";};
_this addItemToUniform "rhs_mag_rdg2_white";
_this addItemToVest "HandGrenade";
for "_i" from 1 to 5 do {_this addItemToBackpack "rhs_10Rnd_762x54mmR_7N1";};
for "_i" from 1 to 2 do {_this addItemToBackpack "HandGrenade";};
_this addItemToBackpack "rhs_mag_rdg2_white";
_this addHeadgear "LOP_H_Booniehat_RACS";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"WhiteHead_04","male03gre"] call BIS_fnc_setIdentity;
