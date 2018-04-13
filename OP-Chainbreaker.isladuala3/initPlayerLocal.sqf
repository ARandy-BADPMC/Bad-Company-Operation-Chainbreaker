waitUntil {!isNull player && player == player};
["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; // Initializes the player/client side Dynamic Groups framework
	
player setVariable ["cams",[]];
player setVariable ["allscreens",0];

{
	[_x,(getPlayerUID _x),player] call CHAB_fnc_newcam;
} forEach allPlayers; 

call compile preprocessfilelinenumbers "Scripts\ArsenalWhitelist.sqf";
call compile preprocessfilelinenumbers "functions\heliskinapply.sqf"; 

if (didJIP) then {
	[player,getPlayerUID player,clientOwner] remoteExecCall ["CHAB_fnc_jipcam",0,false];
};

player addMPEventHandler ["MPRespawn", 
{
	_this execVM "scripts\spawnProtection.sqf";

	[(getPlayerUID player),player] remoteExecCall ["CHAB_fnc_reassign_cam",-2,false];
}];

jeff addAction ["<t color='#FF0000'>Request a Task</t>", "remoteExec ['CHAB_fnc_mission_selector',2]", nil, 1, false, true, "", "true", 10, false,""];
if (typeOf player == "B_RangeMaster_F") then {
	pc5 addAction ["<t color='#FF0000'>Use Overwatch consol</t>", "[_this select 1] call CHAB_fnc_random_screen;", nil, 1, false, true, "", "true", 5, false,""];
};

if(typeOf player == "rhsusf_airforce_jetpilot")
	then
	{
	 [player] call CHAB_fnc_whitelist;
	};	
if(typeOf player != "rhsusf_army_ocp_helipilot" && typeOf player != "rhsusf_airforce_jetpilot")
	then
	{
	 	tank_spawner addAction ["<t color='#FF0000'>Armor Spawner</t>","[] spawn CHAB_fnc_spawn_tank;",nil, 1, false, true, "", "true", 10, false,""];   
		tank_spawner addAction ["<t color='#FF0000'>I want my vehicle removed!</t>","[] spawn CHAB_fnc_remover_tank;",nil, 1, false, true, "", "true", 10, false,""];   
	};	

if(typeOf player == "rhsusf_army_ocp_helipilot")
	then
	{
		heli_jeff addAction ["<t color='#FF0000'>Aircraft Spawner</t>","[] spawn CHAB_fnc_spawn_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
		heli_jeff addAction ["<t color='#FF0000'>I want my Aircraft removed!</t>","[] spawn CHAB_fnc_remover_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
	};	

//[] call CHAB_fnc_uavControls;

_admins = ["76561198048254349","76561198142692277","76561198017258138","76561198002110130","76561197998271838","76561197992821044"]; //76561197998271838-GOMEZ 76561197992821044-GRAND
_adminid = getPlayerUID player;
if(_adminid in _admins) 
	then 
	{
		player addAction ["<t color='#FF0000'>Admin Console</t>","[] spawn CHAB_fnc_adminconsole;",nil, 1, false, true, "", "true", 10, false,""];
		player addMPEventHandler ["MPRespawn", {_this call CHAB_fnc_adminrespawn}];
	};

campfire addAction ["<t color='#FF0000'>Rest</t>", {
	_playerke =  _this select 1;
    _playerke playAction "SitDown";
	{
		_playerke setVariable [_x, nil];
	} forEach ["ace_advanced_fatigue_ae1reserve", "ace_advanced_fatigue_ae2reserve", "ace_advanced_fatigue_anreserve", "ace_advanced_fatigue_anfatigue", "ace_advanced_fatigue_muscledamage"];

}, nil, 1, false, true, "", "true", 10, false,""];

Helicopter_loadouts = 
[
 	"RHS_A10",["Anti-Tank",["rhs_mag_ANALQ131","rhs_mag_FFAR_7_USAF","rhs_mag_agm65d_3","rhs_mag_gbu12","rhs_mag_gbu12","","rhs_mag_gbu12","rhs_mag_gbu12","rhs_mag_agm65d_3","rhs_mag_FFAR_7_USAF","rhs_mag_Sidewinder_2"],"CAS",["rhs_mag_ANALQ131","rhs_mag_FFAR_7_USAF","rhs_mag_agm65d","rhs_mag_gbu12","rhs_mag_gbu12","","rhs_mag_gbu12","rhs_mag_gbu12","rhs_mag_agm65d","rhs_mag_FFAR_7_USAF","rhs_mag_Sidewinder_2"]],
	"B_Plane_CAS_01_dynamicLoadout_F",["Normal",["PylonRack_1Rnd_Missile_AA_04_F","PylonRack_7Rnd_Rocket_04_HE_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonMissile_1Rnd_Bomb_04_F","PylonRack_3Rnd_Missile_AGM_02_F","PylonRack_7Rnd_Rocket_04_AP_F","PylonRack_1Rnd_Missile_AA_04_F"]],
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
	"O_Heli_Transport_04_F", ["Unarmed",[]],
	"RHS_MELB_H6M",["Unarmed",[]],
	"B_Heli_Attack_01_dynamicLoadout_F",["Simple",["PylonMissile_1Rnd_ACE_Hellfire_AGM114K","PylonMissile_1Rnd_ACE_Hellfire_AGM114K","PylonRack_12Rnd_PG_missiles","PylonRack_12Rnd_PG_missiles","PylonMissile_1Rnd_ACE_Hellfire_AGM114K","PylonMissile_1Rnd_ACE_Hellfire_AGM114K"]],
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

//[player,"myArtillery_jey"] call BIS_fnc_addCommMenuItem; 
/*
jey_call_flares =
{
	_targetinrange = getPos _this inRangeOfArtillery [[artilerry1], (getArtilleryAmmo [artilerry1] select 1)];
	if (_targetinrange) then {
	  hint "Shells are on the way!";
	  [_this] remoteExec ["flares_server",2];
	  
	} else { hint "Out of artilerry range!";};
};

  MENU_COMMS_1 =
	[
		// First array: "User menu" This will be displayed under the menu, bool value: has Input Focus or not.
		// Note that as to version Arma2 1.05, if the bool value set to false, Custom Icons will not be displayed.
		["Support Menu",false],
		// Syntax and semantics for following array elements:

		// ["Title_in_menu", [assigned_key], "Submenu_name", CMD, [["expression",script-string]], "isVisible", "isActive" <, optional icon path> ]
		// Title_in_menu: string that will be displayed for the player
		// Assigned_key: 0 - no key, 1 - escape key, 2 - key-1, 3 - key-2, ... , 10 - key-9, 11 - key-0, 12 and up... the whole keyboard
		// Submenu_name: User menu name string (eg "#USER:MY_SUBMENU_NAME" ), "" for script to execute.
		// CMD: (for main menu:) CMD_SEPARATOR -1; CMD_NOTHING -2; CMD_HIDE_MENU -3; CMD_BACK -4; (for custom menu:) CMD_EXECUTE -5
		// script-string: command to be executed on activation.  (_target=CursorTarget,_pos=CursorPos) 
		// isVisible - Boolean 1 or 0 for yes or no, - or optional argument string, eg: "CursorOnGround"
		// isActive - Boolean 1 or 0 for yes or no - if item is not active, it appears gray.
		// optional icon path: The path to the texture of the cursor, that should be used on this menuitem.
		

		["Call Flares", [2], "", -5, [["expression", "player spawn jey_call_flares;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"]
		//["Kill Target", [3], "", -5, [["expression", "_target SetDamage 1;"]], "1", "1", "\A3\ui_f\data\IGUI\Cfg\Cursors\iconcursorsupport_ca.paa"],
		//["Disabled", [4], "", -5, [["expression", ""]], "1", "0"],
		//["Submenu", [5], "#USER:MENU_COMMS_2", -5, [], "1", "1"]
	];*/
	
[] execVM "EPD\Ied_Init.sqf";

