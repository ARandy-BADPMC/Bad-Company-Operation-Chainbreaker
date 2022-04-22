waitUntil {!isNull player && player == player};

//ACRE check & kick
if (isMultiplayer) then {
	[] spawn {
		sleep 10;	
		if ((isnil "acre_sys_io_serverStarted") || {!acre_sys_io_serverStarted}) then {
			endMission "ACRE_disabled";
		};
	};
};

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
call compile preprocessFileLineNumbers "functions\BADCO_class_check.sqf"; 


jeff addAction ["<t color='#FF0000'>Request a Task</t>", "[0] remoteExec ['CHAB_fnc_mission_selector',2]", nil, 1, false, true, "", "true", 10, false,""];


heli_jeff addAction ["<t color='#FF0000'>Aircraft Spawner</t>","[] spawn CHAB_fnc_spawn_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
heli_jeff addAction ["<t color='#FF0000'>I want my Aircraft removed!</t>","[] spawn CHAB_fnc_remover_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER

tank_spawner addAction ["<t color='#FFFF00'>Vehicle Spawner</t>","[] spawn CHAB_fnc_spawn_tank;",nil, 1, false, true, "", "true", 10, false,""];   
tank_spawner addAction ["<t color='#FF0000'>I want my vehicle removed!</t>","[] spawn CHAB_fnc_remover_tank;",nil, 1, false, true, "", "true", 10, false,""];   


_uid = getPlayerUID player;
_SOAR = ["76561198117073327","76561198142692277","76561198059583284","76561198067590754","76561198067590754"];//76561198142692277 -Alex. K., 76561198117073327 - A.Randy,   76561198059583284 - Vittex?, 76561198067590754 - Mas Pater, "76561198129876850" - Dehumanized
if (_uid in _soar) then {player setVariable ["SOAR",1]};
player addEventHandler ["GetInMan",{[_this select 0,_this select 1, _this select 2] call BADCO_role_check;}];
if (typeof player == "rhsusf_usmc_marpat_d_uav" || typeOf player == "rhsusf_airforce_jetpilot") then 
{
	if (_uid in _soar) then 
	{
		hint "Welcome whitelisted player"
	} else 
	{
		["epicFail",false,2] call BIS_fnc_endMission;				
	};
};

_devs = ["76561198117073327","76561198142692277","76561198002110130","76561198048254349"];
if(getPlayerUID player in _devs) 
	then 
	{
		player addAction ["<t color='#00AAFF'>Developer Console</t>","[] spawn CHAB_fnc_adminconsole;",nil, -99, false, true, "", "true", 10, false,""];
	
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

/*
base_flag addAction ["Teleport to Shootingrange", {
	[player,[9882.12,9979.88,0]] remoteExec ["setPos",2];
}];
base_flag addAction ["Teleport to Heli-Spawner", {
	[player,[9927.14,10071.4,0]] remoteExec ["setPos",2];
}];
ShootingRange_flag addAction ["Teleport to Base", {
	[player,[9838.25,9949.16,0.0807343]] remoteExec ["setPos",2];
}];
*/

Helicopter_loadouts = 
[
	"RHS_AN2_B",["Default",[]],
	"RHS_MELB_AH6M",["Light",["rhs_mag_M151_7","rhs_mag_m134_pylon_3000","rhs_mag_m134_pylon_3000","rhs_mag_M151_7"],"Medium",["rhsusf_mag_gau19_melb_left","","","rhs_mag_DAGR_8"],"Heavy",["rhsusf_mag_gau19_melb_left","","","rhs_mag_AGM114K_2"]],
	"I_Heli_Transport_02_F",["Default",[]],
	"I_Heli_light_03_dynamicLoadout_F",["Anti Tank",["PylonWeapon_300Rnd_20mm_shells","PylonRack_4Rnd_ACE_Hellfire_AGM114K"],"Anti Infantry",["PylonWeapon_300Rnd_20mm_shells","PylonRack_12Rnd_missiles"]],
	"I_Heli_light_03_unarmed_F",["Default",[]],
	//"C_Plane_Civil_01_F",["Default",[]],
	//"C_Plane_Civil_01_racing_F",["Default",[]],
 	"RHS_CH_47F_10",["Default",[]],
	"rhsusf_CH53E_USMC_D",["Default",[]],
	"O_Heli_Light_02_dynamicLoadout_F",["Light",["PylonWeapon_2000Rnd_65x39_belt","PylonRack_12Rnd_missiles"],"Medium",["PylonRack_12Rnd_missiles","PylonRack_12Rnd_missiles"],"Heavy",["PylonRack_1Rnd_ACE_Hellfire_AGM114N","PylonRack_1Rnd_ACE_Hellfire_AGM114N"]],
	"O_Heli_Light_02_unarmed_F",["Default",[]],
	//"C_Heli_Light_01_civil_F",["Default",[]],
	"B_Heli_Light_01_F",["Default",[]],
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

_boxes = [box1,box2,box3];
{_x addaction ["Arsenal", 
	{[_this select 0, _this select 1] call ace_arsenal_fnc_openBox;},nil,0,true,false,"","",10];
} forEach _boxes;

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