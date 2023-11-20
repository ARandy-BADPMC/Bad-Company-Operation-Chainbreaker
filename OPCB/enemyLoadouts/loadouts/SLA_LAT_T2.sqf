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
_this addWeapon "rhs_weap_akm";
_this addPrimaryWeaponItem "rhs_acc_dtkakm";
_this addPrimaryWeaponItem "rhs_30Rnd_762x39mm";
_this addWeapon "rhs_weap_rpg18";
_this addSecondaryWeaponItem "rhs_rpg18_mag";

// "Add containers";
_this forceAddUniform "LOP_U_SLA_Fatigue_01";
_this addVest "LOP_V_6Sh92_OLV";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_30Rnd_762x39mm";
_this addItemToUniform "rhs_mag_rgd5";
for "_i" from 1 to 3 do {_this addItemToVest "rhs_30Rnd_762x39mm";};
_this addItemToVest "rhs_mag_rdg2_white";
_this addHeadgear "LOP_H_SSh68Helmet_OLV";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
