["Initialize"] call BIS_fnc_dynamicGroups;
call compileFinal preprocessfilelinenumbers "functions\BADCO_skin_applier.sqf";

missionNamespace setVariable ["running_task",0];
missionNamespace setVariable ["task_spot",[5840,5700,0]];

missionNamespace setVariable ["enemy_groups",[]];

missionNamespace setVariable ["Chapo_trigger",false];


missionNamespace setVariable ["MaxTanks",0,true];
missionNamespace setVariable ["MaxAttackHelis",0,true];
missionNamespace setVariable ["MaxTransHelis",0,true];
missionNamespace setVariable ["MaxAPC",0,true];
missionNamespace setVariable ["MaxStatic",0,true];

_zeus_group = createGroup sideLogic;

missionNamespace setVariable ["Zeus_group",_zeus_group];

{
	_x allowDamage false;
	[_x, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim;
} forEach [officer_jeff,tank_spawner,heli_jeff]; 

globalWaterPos = [3067.06,16839.7,10.1122]; //universal for all maps, has to be changed manually 


/*
/\
||

Result:
0.116768 ms

Cycles:
8564/10000

old results:

Result:
0.242012 ms

Cycles:
9651/10000
*/ //if you want to check execution time : BIS_fnc_codePerformance; 


//[7427,7955,0] [7480,13351,0] [1403.27,7529.75,0]
/*

11680
[5840,5700,0];
11400

*/
missionNamespace setVariable ["World_center",[5840,5700,0]];
_citymarker = createMarker ["citymarker",  getpos officer_jeff];
missionNamespace setVariable ["citymarker",_citymarker];

_nearbyLocations = nearestLocations [[5840,5700,0], ["NameCity","NameCityCapital","NameVillage"], 8000];
/*
{
	_marker1 = createMarker ["Marker"+ str _x, getPos _x];
	_marker1 setMarkerType "hd_objective";
} forEach _nearbyLocations;*/

missionNamespace setVariable ["Cities",_nearbyLocations];
