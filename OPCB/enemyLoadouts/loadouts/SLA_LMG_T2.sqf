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
_this addWeapon "rhs_weap_pkp";
_this addPrimaryWeaponItem "rhs_100Rnd_762x54mmR";

// "Add containers";
_this forceAddUniform "LOP_U_SLA_Fatigue_01";
_this addVest "LOP_V_6Sh92_OLV";
_this addBackpack "LOP_SLA_Fieldpack_PKM";

// "Add items to containers";
_this addItemToUniform "rhs_mag_rdg2_white";
_this addItemToUniform "rhs_mag_rgd5";
_this addItemToVest "rhs_100Rnd_762x54mmR";
for "_i" from 1 to 3 do {_this addItemToBackpack "rhs_100Rnd_762x54mmR";};
_this addHeadgear "LOP_H_SSh68Helmet_BLK";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
