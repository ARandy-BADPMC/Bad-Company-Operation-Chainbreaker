["Initialize"] call BIS_fnc_dynamicGroups; // Initializes the Dynamic Groups framework	
call compile preprocessfilelinenumbers "comp\select.sqf";
call compile preprocessfilelinenumbers "functions\endmission.sqf";
call compileFinal preprocessfilelinenumbers "functions\roadblock.sqf";
call compileFinal preprocessfilelinenumbers "functions\roadblock_ins.sqf";
call compile preprocessfilelinenumbers "functions\injured.sqf";
call compile preprocessfilelinenumbers "functions\adminconsole.sqf";
call compileFinal preprocessfilelinenumbers "functions\spawn_city_rus.sqf";
call compileFinal preprocessfilelinenumbers "functions\spawn_city_ins.sqf";
call compileFinal preprocessfilelinenumbers "functions\enemycount.sqf";
call compile preprocessfilelinenumbers "functions\helispawner.sqf";
call compile preprocessfilelinenumbers "functions\tankspawner.sqf";
call compileFinal preprocessfilelinenumbers "functions\minefield.sqf";
call compile preprocessfilelinenumbers "choppers.sqf";
call compile preprocessfilelinenumbers "functions\idap.sqf";
call compile preprocessfilelinenumbers "functions\artilerry.sqf";
call compile preprocessfilelinenumbers "functions\heliskinapply.sqf";

missionNamespace setVariable ["running_task",0];
missionNamespace setVariable ["zeus_enabled",0];

missionNamespace setVariable ["current_task",10];

officer_jeff allowDamage false;
[officer_jeff, "LISTEN_BRIEFING", "NONE"] call BIS_fnc_ambientAnim;

[tank_spawner, "LISTEN_BRIEFING", "NONE"] call BIS_fnc_ambientAnim;
tank_spawner allowDamage false;

heli_jeff allowDamage false;
[heli_jeff, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim; 

_citymarker = createMarker ["citymarker",  getpos officer_jeff];
missionNamespace setVariable ["citymarker",_citymarker];

fnc_cleanup = compileFinal preprocessFileLineNumbers "cleanup.sqf";

//"Sign_Arrow_F" createVehicle [15104.8,17256.7,0.0808277]; //tank spawner

[] spawn {

	while {true} do {        

		[] call fnc_cleanup;

	sleep 1200;
	};
};
flares_server =
{
	_markpos = [getPos (_this select 0), random 150, random 359] call BIS_fnc_relPos;
	artilerry1 commandArtilleryFire [_markpos,getArtilleryAmmo [artilerry1] select 1,1];
	artilerry2 commandArtilleryFire [_markpos,getArtilleryAmmo [artilerry2] select 1,1];
};

_terrainobjects = nearestTerrainObjects [[3996.09,2200.36],[],5];
{hideObjectGlobal _x} foreach _terrainobjects;
