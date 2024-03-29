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
_this addWeapon "rhs_weap_m4_carryhandle";
_this addPrimaryWeaponItem "rhsusf_acc_compm4";
_this addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_Mk318_Stanag";

// "Add containers";
_this forceAddUniform "LOP_U_Fatigue_BDU_RACS_01";
_this addVest "V_Chestrig_khk";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_this addItemToUniform "rhs_mag_30Rnd_556x45_Mk318_Stanag";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_30Rnd_556x45_Mk262_Stanag";};
for "_i" from 1 to 2 do {_this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
_this addItemToVest "rhs_mag_rdg2_white";
_this addItemToVest "HandGrenade";
_this addHeadgear "PO_H_PASGT_6CD";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
