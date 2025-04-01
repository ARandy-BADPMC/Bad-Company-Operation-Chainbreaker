waitUntil {
	sleep 1;
	!isNull player
};
#include "economy\vehicleCargoSpaces.sqf";
#include "economy\vehicleAttackTypes.sqf";
#include "economy\crateCargoSizes.sqf";
#include "data\helicopterLoadouts.sqf"

removeAllWeapons player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

enableSentences false;
enableRadio false;

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;


// init fob store vars
fobPrice = 1350;

//ACRE check & kick
if (!isServer && {isMultiplayer}) then {
	[] spawn {
		sleep 10;	
		if ((isnil "acre_sys_io_serverStarted") || {!acre_sys_io_serverStarted}) then {
			endMission "ACRE_disabled";
		};
	};
};

["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
call compileFinal preprocessFileLineNumbers "economy\init.sqf";

jeff addAction ["<t color='#FF0000'>Request Mission</t>", "[] remoteExec ['CHAB_fnc_mission_selector',2];", nil, 1, false, true, "", "true", 10, false,""];
jeff addAction ["<t color='#FF0000'>Buy FOB</t>", "[] spawn CHAB_fnc_fobStore;", nil, 1, false, true, "", "true", 10, false,""];

pmc addAction ["<t color='#0db804'>Request Mission</t>", "[] remoteExec ['CHAB_fnc_mission_selector',2];", nil, 1, false, true, "", "true", 10, false,""];

heli_jeff addAction ["<t color='#FF0000'>Aircraft Spawner</t>","[] spawn CHAB_fnc_spawn_heli;",nil, 1, false, true, "", "true", 10, false,""];  
heli_jeff addAction ["<t color='#FF0000'>I want my Aircraft removed!</t>","[] spawn CHAB_fnc_remover_heli;",nil, 1, false, true, "", "true", 10, false,""];  
heli_jeff addAction ["<t color='#01FF24'>Shop history</t>","[] spawn CHAB_fnc_vehicleSpawnerHistory;",nil, 1, false, true, "", "true", 10, false,""]; 

tank_spawner addAction ["<t color='#FFFF00'>Vehicle Spawner</t>","[] spawn CHAB_fnc_spawn_tank;",nil, 1, false, true, "", "true", 10, false,""];
tank_spawner addAction ["<t color='#FFFF00'>Static Spawner</t>","[] spawn CHAB_fnc_spawn_static;",nil, 1, false, true, "", "true", 10, false,""];
tank_spawner addAction ["<t color='#00FFFF'>Utility Spawner</t>","[] spawn OPCB_crateSpawner_openDialog;",nil, 1, false, true, "", "true", 10, false,""];   
tank_spawner addAction ["<t color='#01FF24'>Drone Spawner</t>","[] spawn CHAB_fnc_spawn_drone;",nil, 1, false, true, "", "true", 10, false,""];  

tank_spawner addAction ["<t color='#FF0000'>I want my vehicle removed!</t>","[] spawn CHAB_fnc_remover_tank;",nil, 1, false, true, "", "true", 10, false,""]; 
tank_spawner addAction ["<t color='#01FF24'>Shop history</t>","[] spawn CHAB_fnc_vehicleSpawnerHistory;",nil, 1, false, true, "", "true", 10, false,""]; 

boat_jeff_1 addAction ["<t color='#FFFF00'>Boat Spawner</t>","[] spawn CHAB_fnc_spawn_boat;",nil, 1, false, true, "", "true", 10, false,""];
boat_jeff_1 addAction ["<t color='#01FF24'>Shop history</t>","[] spawn CHAB_fnc_vehicleSpawnerHistory;",nil, 1, false, true, "", "true", 10, false,""]; 

player addEventHandler ["GetInMan",{
	params ["_unit", "_role", "_vehicle"];

	[_role, _vehicle, _unit] call BADCO_fnc_classCheck;
}];

jeff addaction ["Lights on", {
	_lamp = [11753.754,25.629173,2334.1289] nearestObject "Land_LampAirport_F";
	_lamp sethit ["light_1_hitpoint",0];
	_lamp sethit ["light_2_hitpoint",0];
}];

jeff addaction ["Lights off", {
	_lamp = [11753.754,25.629173,2334.1289] nearestObject "Land_LampAirport_F";
	_lamp sethit ["light_1_hitpoint",1];
	_lamp sethit ["light_2_hitpoint",1];	
}];

{
	_x addaction ["Arsenal", {[_this select 0, _this select 1] call ace_arsenal_fnc_openBox;},nil,0,true,false,"","",10];
} forEach [box1,box2,box3,box4,box5];

// disable the long-term effect of stamina...
[] spawn {
	scriptName "ACE_advanced_fatigue_rebalance";		
	while {true} do {
		sleep 5;
		ace_advanced_fatigue_anfatigue = 1;
	};
};

player addEventHandler ["Killed", {
	params ["_unit"];

	[_unit] remoteExec ['CHAB_fnc_deathPenalty',2];
}];

Hz_pers_clientReadyForLoad = true;

[] spawn {
	waitUntil{
		sleep 1;
		_initDone = player getVariable ["InitDone", false];
		_initDone
	};

	#include "data\whitelistedUnitTypes.sqf";

	if (typeof player in _whitelistedUnitTypes) then {
		_whiteListed = player getVariable ["WhiteListed", false];
		if (_whiteListed) then {
			hint "Welcome whitelisted player";
		} else {
			hint "You must be whitelisted to use this slot." ;
			sleep 10;
			endMission "not_Whitelisted";	
		};
	}; 

	_developer = player getVariable ["Developer", false];
	if(_developer) then {
		player addAction ["<t color='#00AAFF'>Developer Console</t>","[] spawn CHAB_fnc_adminconsole;",nil, -99, false, true, "", "true", 10, false,""];
	};	

	_spectator = player getVariable ["AdminSpectator", false];
	if(_spectator) then {
		player addAction ["<t color='#00AAFF'>Start/Stop Admin Spectate</t>","[] spawn CHAB_fnc_adminSpectate;",nil, -99, false, true, "", "true", 10, false,""];
	};

	// spectate is a monitor defined in the missionFile wher users could spectate.
	spectate addAction ["<t color='#00AAFF'>Start/Stop Admin Spectate</t>","[] spawn CHAB_fnc_adminSpectate;",nil, -99, false, true, "", "true", 10, false,""]

};

fnc_teleport_to_spawn = {
	params ["_player"];
	_clanStatus = (squadparams player select 0) select 0;
	_badco_respawn_pos = markerPos "badco_spawn";
	if (((getPos _player) distance _badco_respawn_pos) < 1000) then {
		switch (_clanStatus) do {
			case "B.A.D. PMC": {_player setPos _badco_respawn_pos;};
			case "Bad Co": {hint str _player; _player setPos _badco_respawn_pos;};
			default {};
		};
	};
};

player addMPEventHandler ["MPRespawn", {
	params ["_unit", "_corpse"];
	[_unit] spawn fnc_teleport_to_spawn;
}];

_null = [] execVM "Briefing.sqf";  // Briefing tabs
