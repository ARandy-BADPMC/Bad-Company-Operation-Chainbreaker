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
_this addWeapon "rhs_weap_ak74n";
_this addPrimaryWeaponItem "rhs_acc_dtk1983";
_this addPrimaryWeaponItem "rhs_acc_1p78";
_this addPrimaryWeaponItem "rhs_30Rnd_545x39_7N6M_AK";

// "Add containers";
_this forceAddUniform "LOP_U_SLA_Fatigue_01";
_this addVest "LOP_V_6Sh92_OLV";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_mag_rgd5";
_this addItemToVest "rhs_mag_rdg2_white";
for "_i" from 1 to 7 do {_this addItemToVest "rhs_30Rnd_545x39_7N6M_AK";};
_this addHeadgear "PO_H_SSh68Helmet_wz93";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";

// "Set identity";
[_this,"WhiteHead_18","male04gre"] call BIS_fnc_setIdentity;
