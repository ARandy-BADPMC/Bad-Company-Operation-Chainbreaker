enableSaving [false, false];
enableSentences true;
enableTeamswitch false;

#include "unitTypes.sqf";

call compileFinal preprocessFileLineNumbers "economy\init.sqf";

[] execVM "Scripts\ied.sqf";
[] execVM "insurgency\init.sqf";
[] execVM "Vcom\VcomInit.sqf";

Resistance setFriend [EAST, 1]; Resistance setFriend [WEST, 0]; Resistance setFriend [Civilian, 1];

EAST setFriend [Resistance, 1]; EAST setFriend [WEST, 0]; EAST setFriend [Civilian, 1];	

WEST setFriend [EAST, 0]; WEST setFriend [Resistance, 0]; WEST setFriend [Civilian, 1]; 	

Civilian setFriend [EAST, 1]; Civilian setFriend [WEST, 1]; Civilian setFriend [Resistance, 1];

Hz_pers_var_insurgencyClearedMarkers = [];
Hz_pers_customLoadFunction = compileFinal preprocessFileLineNumbers "Hz_pers_customLoadFunction.sqf";
Hz_pers_firstTimeLaunchFunction = compileFinal preprocessFileLineNumbers "Hz_pers_firstTimeLaunchFunction.sqf";	

["Initialize"] call BIS_fnc_dynamicGroups;
#include "functions\BADCO_Arsenal.sqf"

IsATaskRunning = false;
TaskSpot = [5840,5700,0];
TaskNumber = 0;
EnemyGroups = [];
ChapoTrigger = false;

CrateCount = 0;
MaxTanks = 0;
MaxAttackHelis = 0;
MaxTransHelis = 0;
MaxAPC = 0;
MaxStatic = 0;

addMissionEventHandler ["OnUserSelectedPlayer", {
		params ["_networkId", "_playerObject"];
		publicVariable "MaxTanks";
		publicVariable "MaxAttackHelis";
		publicVariable "MaxTransHelis";
		publicVariable "MaxAPC";
		publicVariable "OPCB_econ_currentTier";
		publicVariable "MaxStatic";
		publicVariable "CrateCount";
}];

ZeusGroup = createGroup sideLogic;

{
	_x allowDamage false;
	[_x, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim;
} forEach [officer_jeff,tank_spawner,heli_jeff]; 

globalWaterPos = [3067.06,16839.7,10.1122]; //universal for all maps, has to be changed manually 
WorldCenter = [5840,5700,0];

CityMarker = createMarker ["citymarker",  getpos officer_jeff];

Cities = nearestLocations [[5840,5700,0], ["NameCity","NameCityCapital","NameVillage"], 8000];

// for AI -- let's see if this strains the server too much (with more AI)
setViewDistance 3500;
setObjectViewDistance 3500;

Helicopter_loadouts = 
[
	"RHS_AN2_B",["Default",[]],
	"RHS_MELB_AH6M",["Light",["rhs_mag_M151_7","rhs_mag_m134_pylon_3000","rhs_mag_m134_pylon_3000","rhs_mag_M151_7"],"Medium",["rhsusf_mag_gau19_melb_left","","","rhs_mag_DAGR_8"],"Heavy",["rhsusf_mag_gau19_melb_left","","","rhs_mag_AGM114K_2"]],
	//"I_Heli_Transport_02_F",["Default",[]],
	"I_Heli_light_03_dynamicLoadout_F",["Anti Tank",["PylonWeapon_300Rnd_20mm_shells","PylonRack_4Rnd_ACE_Hellfire_AGM114K"],"Anti Infantry",["PylonWeapon_300Rnd_20mm_shells","PylonRack_12Rnd_missiles"]],
	"I_Heli_light_03_unarmed_F",["Default",[]],
	//"C_Plane_Civil_01_F",["Default",[]],
	//"C_Plane_Civil_01_racing_F",["Default",[]],
 	"RHS_CH_47F_10",["Default",[]],
	"rhsusf_CH53E_USMC_D",["Default",[]],
	"O_Heli_Light_02_dynamicLoadout_F",["Light",["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_missiles"],"Medium",["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"],"Heavy",["PylonRack_1Rnd_ACE_Hellfire_AGM114N","PylonRack_1Rnd_ACE_Hellfire_AGM114N"]],
	"O_Heli_Light_02_unarmed_F",["Default",[]],
	//"C_Heli_Light_01_civil_F",["Default",[]],
	//"B_Heli_Light_01_F",["Default",[]],
	"RHS_MELB_MH6M",["Default",[]],
	//"RHS_Mi8AMTSh_vvs", ["Default",[]],
	"O_Heli_Transport_04_F", ["Default",[]],
	"RHS_MELB_H6M",["Default",[]],
	"RHS_UH1Y_d",["Normal",["rhs_mag_M151_7_green","rhs_mag_M151_7_green"]],
	"RHS_UH1Y_unarmed_d",["Default",[]],
	"RHS_UH60M_d",["Default",[]],
	//"RHS_UH60M_ESSS_d",["Light",["rhs_mag_M229_19","rhs_mag_M229_19","rhs_mag_M229_19","rhs_mag_M229_19"], "Medium", ["rhs_mag_AGM114N_4","rhs_mag_M229_19","rhs_mag_M229_19","rhs_mag_AGM114N_4"], "Heavy",["rhs_mag_AGM114N_4","rhs_mag_AGM114N_4","rhs_mag_AGM114N_4","rhs_mag_AGM114N_4"]],
	"RHS_UH60M2_d",["Default",[]],
	"RHS_UH60M_MEV_d",["Default",[]]
]; 


