// "Exported from Arsenal by D3fiance";

// "[!] UNIT MUST BE LOCAL [!]";
if (!local __this) exitWith {};

// "Remove existing items";
removeAllWeapons __this;
removeAllItems __this;
removeAllAssignedItems __this;
removeUniform __this;
removeVest __this;
removeBackpack __this;
removeHeadgear __this;
removeGoggles __this;

// "Add weapons";
__this addWeapon "rhs_weap_m16a4_carryhandle";
__this addPrimaryWeaponItem "rhs_mag_30Rnd_556x45_Mk318_Stanag";

// "Add containers";
__this forceAddUniform "LOP_U_RACS_Fatigue_01";
__this addVest "V_Chestrig_khk";

// "Add items to containers";
__this addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {__this addItemToUniform "rhs_mag_30Rnd_556x45_Mk318_Stanag";};
for "_i" from 1 to 2 do {__this addItemToVest "rhs_mag_30Rnd_556x45_Mk262_Stanag";};
for "_i" from 1 to 2 do {__this addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green";};
__this addItemToVest "rhs_mag_rdg2_white";
__this addItemToVest "HandGrenade";
__this addHeadgear "PO_H_PASGT_6CD";

// "Add items";
__this linkItem "ItemMap";
__this linkItem "ItemCompass";
__this linkItem "ItemWatch";
__this linkItem "ItemRadio";

// "Set identity";
[__this,"WhiteHead_04","male05gre"] call BIS_fnc_setIdentity;
