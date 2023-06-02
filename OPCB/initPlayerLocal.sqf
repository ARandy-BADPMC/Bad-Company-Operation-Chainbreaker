waitUntil {
	sleep 1;
	!isNull player
};

removeAllWeapons player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

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

jeff addAction ["<t color='#FF0000'>Request Mission</t>", "[] remoteExec ['CHAB_fnc_mission_selector',2];", nil, 1, false, true, "", "true", 10, false,""];

heli_jeff addAction ["<t color='#FF0000'>Aircraft Spawner</t>","[] spawn CHAB_fnc_spawn_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
heli_jeff addAction ["<t color='#FF0000'>I want my Aircraft removed!</t>","[] spawn CHAB_fnc_remover_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER

tank_spawner addAction ["<t color='#FFFF00'>Vehicle Spawner</t>","[] spawn CHAB_fnc_spawn_tank;",nil, 1, false, true, "", "true", 10, false,""];
tank_spawner addAction ["<t color='#00FFFF'>Box Spawner</t>","[] spawn OPCB_crateSpawner_openDialog;",nil, 1, false, true, "", "true", 10, false,""];   
tank_spawner addAction ["<t color='#FF0000'>I want my vehicle removed!</t>","[] spawn CHAB_fnc_remover_tank;",nil, 1, false, true, "", "true", 10, false,""];   

_uid = getPlayerUID player;

#include "data\soar.sqf";
if (_uid in _SOAR) then {
	player setVariable ["SOAR",1];
};

player addEventHandler ["GetInMan",{[_this select 0,_this select 1, _this select 2] call BADCO_fnc_classCheck;}];

#include "data\soarUnitTypes.sqf";

if (typeof player in _soarUnitTypes) then {
	if (_uid in _soar) then {
		hint "Welcome whitelisted player";
	} else {
		hint "You must be whitelisted to use this slot.";
		[] spawn {
			sleep 10;
			endMission "not_Whitelisted";				
		};
	};
}; 

#include "data\developers.sqf";

if(_uid in _developers) then {
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

{
	_x addaction ["Arsenal", {[_this select 0, _this select 1] call ace_arsenal_fnc_openBox;},nil,0,true,false,"","",10];
} forEach [box1,box2,box3,box4];

// disable the long-term effect of stamina...
[] spawn {
	scriptName "ACE_advanced_fatigue_rebalance";		
	while {true} do {
			sleep 5;
			ace_advanced_fatigue_anfatigue = 1;
	};
};

Hz_pers_clientReadyForLoad = true;