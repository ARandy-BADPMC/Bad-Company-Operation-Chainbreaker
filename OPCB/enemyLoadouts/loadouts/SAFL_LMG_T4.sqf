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
_this addWeapon "rhs_weap_m249";
_this addPrimaryWeaponItem "rhsusf_100Rnd_556x45_soft_pouch";
_this addPrimaryWeaponItem "rhsusf_acc_saw_bipod";

// "Add containers";
_this forceAddUniform "LOP_U_Fatigue_BDU_RACS_02";
_this addVest "V_Chestrig_khk";
_this addBackpack "LOP_RACS_Fieldpack_PKM";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToVest "rhsusf_100Rnd_556x45_soft_pouch";
_this addItemToVest "rhs_mag_rdg2_white";
_this addItemToVest "HandGrenade";
for "_i" from 1 to 3 do {_this addItemToBackpack "rhsusf_100Rnd_556x45_soft_pouch";};
_this addHeadgear "PO_H_PASGT_6CD";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"AsianHead_A3_01","male06gre"] call BIS_fnc_setIdentity;
