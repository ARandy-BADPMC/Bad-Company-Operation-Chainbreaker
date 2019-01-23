waitUntil {!isNull player && player == player};
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;

call compileFinal preprocessfilelinenumbers "scripts\ArsenalWhitelist.sqf"; //more secure

jeff addAction ["<t color='#FF0000'>Request a Task</t>", "[0] remoteExec ['CHAB_fnc_mission_selector',2]", nil, 1, false, true, "", "true", 10, false,""];

switch (typeOf player) do { 
	case "rhsusf_airforce_jetpilot" : {  player call CHAB_fnc_whitelist; }; 
	case "rhsusf_army_ocp_helipilot" : {  
		heli_jeff addAction ["<t color='#FF0000'>Aircraft Spawner</t>","[] spawn CHAB_fnc_spawn_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
		heli_jeff addAction ["<t color='#FF0000'>I want my Aircraft removed!</t>","[] spawn CHAB_fnc_remover_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
	}; 
	default {
	 	tank_spawner addAction ["<t color='#FF0000'>Armor Spawner</t>","[] spawn CHAB_fnc_spawn_tank;",nil, 1, false, true, "", "true", 10, false,""];   
		tank_spawner addAction ["<t color='#FF0000'>I want my vehicle removed!</t>","[] spawn CHAB_fnc_remover_tank;",nil, 1, false, true, "", "true", 10, false,""];   
	}; 
};
_admins = ["76561198117073327","76561198142692277","76561198017258138","76561198002110130","76561197998271838","76561197992821044","76561197988793826","76561198048254349","76561198088658039"]; //76561197998271838-GOMEZ 76561197992821044-GRAND 76561197988793826-WEEDO  76561198117073327-Randy  76561198142692277-Alex.K   76561198017258138 - A.Mitchell 76561198002110130 K.Hunter 76561198088658039 Ayoub
if(getPlayerUID player in _admins) 
	then 
	{
		player addAction ["<t color='#FF0000'>Admin Console</t>","[] spawn CHAB_fnc_adminconsole;",nil, 1, false, true, "", "true", 10, false,""];
	
	};

jeff addaction ["Lights on", {
	_lamp = [12068,12595.7,0] nearestObject "Land_LampAirport_F";
	_lamp sethit ["light_1_hitpoint",0];
	_lamp sethit ["light_2_hitpoint",0];
}];
jeff addaction ["Lights off", {
	_lamp = [12068,12595.7,0] nearestObject "Land_LampAirport_F";
	_lamp sethit ["light_1_hitpoint",1];
	_lamp sethit ["light_2_hitpoint",1];	
}];

base_flag addAction ["Teleport to Shootingrange", {
	[player,[12028,12608.6,0]] remoteExec ["setPos",2];
}];
base_flag addAction ["Teleport to Heli-Spawner", {
	[player,[12204.2,12621,0]] remoteExec ["setPos",2];
}];
ShootingRange_flag addAction ["Teleport to Base", {
	[player,[12129.8,18100.4,0]] remoteExec ["setPos",2];
}];

Helicopter_loadouts = 
[
 	"RHS_A10",["Anti-Tank",["rhs_mag_ANALQ131","rhs_mag_FFAR_7_USAF","rhs_mag_agm65d_3","rhs_mag_gbu12","rhs_mag_gbu12","","rhs_mag_gbu12","rhs_mag_gbu12","rhs_mag_agm65d_3","rhs_mag_FFAR_7_USAF","rhs_mag_Sidewinder_2"],"CAS",["rhs_mag_ANALQ131","rhs_mag_FFAR_7_USAF","rhs_mag_agm65d","rhs_mag_gbu12","rhs_mag_gbu12","","rhs_mag_gbu12","rhs_mag_gbu12","rhs_mag_agm65d","rhs_mag_FFAR_7_USAF","rhs_mag_Sidewinder_2"]],
	"B_Plane_CAS_01_dynamicLoadout_F",["Normal",["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_7Rnd_Rocket_04_AP_F","PylonRack_1Rnd_Missile_AA_04_F"]],
	"RHS_AN2_B",["Unarmed",[]],
	"RHS_AH1Z",["ACE",["rhs_mag_Sidewinder_heli_2","PylonRack_4Rnd_ACE_Hellfire_AGM114K","rhs_mag_M151_19_green","rhs_mag_M151_19_green","PylonRack_4Rnd_ACE_Hellfire_AGM114K","rhs_mag_Sidewinder_heli_2"]],
	"RHS_AH64D",["CAS",["rhs_mag_Sidewinder_heli","rhs_mag_M151_19","rhs_mag_AGM114L_4","rhs_mag_AGM114N_4","rhs_mag_M151_19","rhs_mag_Sidewinder_heli"]],
	"RHS_MELB_AH6M",["Light",["rhs_mag_M151_7","rhs_mag_m134_pylon_3000","rhs_mag_m134_pylon_3000","rhs_mag_M151_7"],"Medium",["rhsusf_mag_gau19_melb_left","","","rhs_mag_DAGR_8"],"Heavy",["rhsusf_mag_gau19_melb_left","","","rhs_mag_AGM114K_2"]],
	"I_Heli_Transport_02_F",["Unarmed",[]],
	"I_Heli_light_03_dynamicLoadout_F",["Anti Tank",["PylonWeapon_300Rnd_20mm_shells","PylonRack_4Rnd_ACE_Hellfire_AGM114K"],"Anti Infantry",["PylonWeapon_300Rnd_20mm_shells","PylonRack_12Rnd_missiles"]],
	"I_Heli_light_03_unarmed_F",["Unarmed",[]],
	"RHS_C130J",["Unarmed",[]],
	"C_Plane_Civil_01_F",["Unarmed",[]],
	"C_Plane_Civil_01_racing_F",["Unarmed",[]],
 	"RHS_CH_47F_10",["Unarmed",[]],
	"B_Heli_Transport_03_F",["Unarmed",[]],
	"B_Heli_Transport_03_unarmed_F",["Unarmed",[]],
	"rhsusf_CH53E_USMC_D",["Unarmed",[]],
 	"B_Plane_Fighter_01_F",["Normal",["PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AMRAAM_D_x1","PylonRack_Missile_AGM_02_x2","PylonRack_Missile_AGM_02_x2","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_BIM9X_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Missile_AMRAAM_D_INT_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"]],
	"I_Plane_Fighter_04_F",["Anti Ground",["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1","ace_maverick_L_PylonRack_x1","ace_maverick_L_PylonRack_x1","PylonMissile_Bomb_GBU12_x1","PylonMissile_Bomb_GBU12_x1"], "Anti Air", ["PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1","PylonRack_Missile_AMRAAM_C_x1","PylonMissile_Bomb_GBU12_x1","PylonRack_Missile_BIM9X_x2"]],
	"O_Heli_Light_02_dynamicLoadout_F",["Light",["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_missiles"],"Medium",["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"],"Heavy",["PylonRack_1Rnd_ACE_Hellfire_AGM114N","PylonRack_1Rnd_ACE_Hellfire_AGM114N"]],
	"O_Heli_Light_02_unarmed_F",["Unarmed",[]],
	"C_Heli_Light_01_civil_F",["Unarmed",[]],
	"B_Heli_Light_01_F",["Unarmed",[]],
	"RHS_MELB_MH6M",["Unarmed",[]],
	"RHS_Mi8AMTSh_vvs", ["Unarmed",[]],
	"RHS_Mi24P_vdv", ["Standard",["rhs_mag_fab250","rhs_mag_fab250","rhs_mag_b8v20a_s8kom","rhs_mag_b8v20a_s8kom","rhs_mag_9M120M_Mi24_2x","rhs_mag_9M120M_Mi24_2x"],"Rockets", ["rhs_mag_ub32_s5m1","rhs_mag_ub32_s5m1","rhs_mag_ub32_s5m1","rhs_mag_ub16_s5m1","rhs_mag_9M120M_Mi24_2x","rhs_mag_9M120M_Mi24_2x"]],
	"O_Heli_Transport_04_F", ["Unarmed",[]],
	"RHS_MELB_H6M",["Unarmed",[]],
	"B_Heli_Attack_01_dynamicLoadout_F",["Simple",["PylonMissile_1Rnd_ACE_Hellfire_AGM114K","PylonMissile_1Rnd_ACE_Hellfire_AGM114K","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_PG_missiles","PylonMissile_1Rnd_ACE_Hellfire_AGM114K","PylonMissile_1Rnd_ACE_Hellfire_AGM114K"]],
	"rhssaf_airforce_l_18", ["CAS", ["rhs_mag_b8m1_bd3_umk2a_s8kom","rhs_mag_b8m1_bd3_umk2a_s8kom","rhs_mag_b8m1_bd3_umk2a_s8df","rhs_mag_b8m1_bd3_umk2a_s8df","rhs_mag_R60M_APU60","rhs_mag_R60M_APU60",""]],
	"RHS_L39_cdf_b_cdf", ["CAP",["rhs_mag_R73M","rhs_mag_R73M"], "Rockets",["rhs_mag_ub16_s5ko","rhs_mag_ub16_s5ko"]],
	"RHS_l159_cdf_b_CDF", ["CAS",["rhs_mag_Sidewinder","rhs_mag_FFAR_7_USAF","rhs_mag_gbu12","rhs_mag_zpl20_mixed","rhs_mag_gbu12","rhs_mag_FFAR_7_USAF","rhs_mag_Sidewinder"],"AP",["rhs_mag_Sidewinder","rhs_mag_FFAR_7_USAF","rhs_mag_cbu100_3","rhs_mag_zpl20_mixed","rhs_mag_cbu100_3","rhs_mag_FFAR_7_USAF","rhs_mag_Sidewinder"],"CAP",["rhs_mag_Sidewinder","rhs_mag_aim120d","rhs_mag_aim120d","rhs_mag_l159_fuelpod_grey","rhs_mag_aim120","rhs_mag_aim120","rhs_mag_Sidewinder"]],
	"RHSGREF_cdf_b_su25",["Normal",["rhs_mag_kh29D","rhs_mag_kh29D","rhs_mag_kh25MP","rhs_mag_kh25MP","rhs_mag_b8m1_s8kom","rhs_mag_b8m1_s8kom","rhs_mag_ub32_s5m1","rhs_mag_ub32_s5m1","rhs_mag_R60M","rhs_mag_R60M"]],
	"RHS_UH1Y_d",["Normal",["rhs_mag_M151_7_green","rhs_mag_M151_7_green"]],
	"RHS_UH1Y_UNARMED_d",["Unarmed",[]],
	"RHS_UH60M_d",["Unarmed",[]],
	"RHS_UH60M_ESSS_d",["Light",["rhs_mag_M229_19","rhs_mag_M229_19","rhs_mag_M229_19","rhs_mag_M229_19"], "Medium", ["rhs_mag_AGM114N_4","rhs_mag_M229_19","rhs_mag_M229_19","rhs_mag_AGM114N_4"], "Heavy",["rhs_mag_AGM114N_4","rhs_mag_AGM114N_4","rhs_mag_AGM114N_4","rhs_mag_AGM114N_4"]],
	"RHS_UH60M2_d",["Unarmed",[]],
	"RHS_UH60M_MEV_d",["Unarmed",[]],
	"B_Heli_Transport_01_F",["Unarmed",[]],
	"B_T_VTOL_01_armed_F",["Unarmed",[]],
	"B_T_VTOL_01_vehicle_F",["Unarmed",[]],
	"B_T_VTOL_01_infantry_F",["Unarmed",[]],
	"B_UAV_02_dynamicLoadout_f", ["Vhikr",["PylonRack_3Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel"],"Hellfire",["PylonRack_3Rnd_ACE_Hellfire_AGM114N","PylonRack_3Rnd_ACE_Hellfire_AGM114K"], "GBU-12", ["PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F"]]
]; 


/*addMissionEventHandler ["Draw3D",{

	_pos = getposATL player;
	_buildings = nearestObjects [_pos,["house"],15];
	_windowPositions = [];
	{

		_building = _x;
		_it = 0;

		_selectionNames = selectionNames _building;
		_selectionPositions = [];
		_windows = _selectionNames select {toUpper _x find "GLASS" >= 0};
		{
			_selectionPositions pushBack (_building modelToWorldVisual (_building selectionPosition [_x,"GEOMETRY"]));
		} forEach _windows;

		_windowPositions append _selectionPositions;

	} forEach _buildings;

	_text = "Window";

	{
	drawIcon3D ["",[1,1,1,1],_x,1,1,0,_text,2];

	} forEach _windowPositions;
}];*/