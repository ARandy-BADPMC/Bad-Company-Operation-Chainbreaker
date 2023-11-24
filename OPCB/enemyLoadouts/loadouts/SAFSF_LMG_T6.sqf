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
_this addWeapon "rhs_weap_m249_pip_S";
_this addPrimaryWeaponItem "rhsusf_acc_ELCAN_ard";
_this addPrimaryWeaponItem "rhsusf_100Rnd_556x45_soft_pouch";
_this addPrimaryWeaponItem "rhsusf_acc_saw_bipod";

// "Add containers";
_this forceAddUniform "LOP_U_Fatigue_BDU_RACS_01";
_this addVest "rhsusf_plateframe_machinegunner";
_this addBackpack "LOP_B_KB_M249";

// "Add items to containers";
_this addItemToUniform "FirstAidKit";
_this addItemToUniform "rhs_mag_an_m8hc";
_this addItemToUniform "rhs_mag_m67";
_this addItemToVest "rhsusf_100Rnd_556x45_soft_pouch";
_this addItemToVest "rhs_mag_m67";
for "_i" from 1 to 3 do {_this addItemToBackpack "rhsusf_100Rnd_556x45_soft_pouch";};
_this addHeadgear "rhsusf_protech_helmet_rhino_ess";
_this addGoggles "G_Bandanna_tan";

// "Add items";
_this linkItem "ItemMap";
_this linkItem "ItemCompass";
_this linkItem "ItemWatch";
_this linkItem "ItemRadio";
_this linkItem "rhsusf_ANPVS_15";
