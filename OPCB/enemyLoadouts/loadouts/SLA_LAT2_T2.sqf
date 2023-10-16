// "Exported from Arsenal by Alex K.";

// "[!] UNIT MUST BE LOCAL [!]";
if (!local _this) exitWith {};

// "Remove existing items";
removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;

// "Add weapons";
this addWeapon "rhs_weap_ak74n";
this addPrimaryWeaponItem "rhs_acc_dtk1983";
this addPrimaryWeaponItem "rhs_acc_1p78";
this addPrimaryWeaponItem "rhs_30Rnd_545x39_7N6M_AK";
this addWeapon "rhs_weap_rpg26";
this addSecondaryWeaponItem "rhs_rpg26_mag";

// "Add containers";
this forceAddUniform "LOP_U_SLA_Fatigue_01";
this addVest "LOP_V_6Sh92_OLV";

// "Add items to containers";
this addItemToUniform "FirstAidKit";
this addItemToUniform "rhs_mag_rgd5";
this addItemToVest "rhs_mag_rdg2_white";
for "_i" from 1 to 7 do {this addItemToVest "rhs_30Rnd_545x39_7N6M_AK";};
this addHeadgear "PO_H_SSh68Helmet_wz93";

// "Add items";
this linkItem "ItemMap";
this linkItem "ItemCompass";
this linkItem "ItemWatch";
this linkItem "ItemRadio";

// "Set identity";
[this,"WhiteHead_21","male03gre"] call BIS_fnc_setIdentity;
