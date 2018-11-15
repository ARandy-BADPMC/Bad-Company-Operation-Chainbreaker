["Initialize"] call BIS_fnc_dynamicGroups;
call compileFinal preprocessfilelinenumbers "functions\heliskinapply.sqf";
call compileFinal preprocessFileLineNumbers "functions\retrieve.sqf";
missionNamespace setVariable ["running_task",0];
missionNamespace setVariable ["zeus_enabled",0];
missionNamespace setVariable ["current_task","asd"];
missionNamespace setVariable ["TaskObjective","none"];

{
 	_x allowDamage false;
	[_x, "LISTEN_BRIEFING", "Light"] call BIS_fnc_ambientAnim;
} forEach [officer_jeff,tank_spawner,heli_jeff]; 

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
_citymarker = createMarker ["citymarker",  getpos officer_jeff];
missionNamespace setVariable ["citymarker",_citymarker];