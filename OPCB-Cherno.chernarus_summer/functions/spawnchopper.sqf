if(isServer) then
{
//private ["_chopper","_taskmarker"];

_chopper = _this select 0;
_taskmarker = _this select 1;

_choppergroup = createGroup east;

_spawnedch = [(getMarkerPos _taskmarker),140,_chopper,_choppergroup] call BIS_fnc_spawnVehicle;
//_spawnedch setPos [(_taskmarker select 0),(_taskmarker select 1),(_taskmarker select 1) + 200];

_choppers = ["rhs_mi28n_s13_vvs","RHS_Mi8MTV3_UPK23_vvs","RHS_Ka52_UPK23_vvs"];
if((_spawnedch select 0) in _choppers) then
	{
		_spawnedch select 0 flyInHeight 150;
	} 
else 
	{
		_spawnedch select 0 flyInHeight 200;
	};



_wayp1m = [_spawnedch select 0, 2000, 359] call BIS_fnc_relPos;
_wayp2m = [_spawnedch select 0, 2000, 90] call BIS_fnc_relPos;
_wayp3m = [_spawnedch select 0, 2000, 180] call BIS_fnc_relPos;
_wayp4m = [_spawnedch select 0, 2000, 270] call BIS_fnc_relPos;




_wayp1 = _choppergroup addWaypoint [_wayp1m, 100]; //_spawnedch select 0
//_wayp1 setWaypointCombatMode "RED";
_wayp1 setWaypointType "SAD";

_wayp2 = _choppergroup addWaypoint [_wayp2m, 100];
//_wayp2 setWaypointCombatMode "RED";
_wayp2 setWaypointType "SAD";

_wayp3 = _choppergroup addWaypoint [_wayp3m, 100];
//_wayp3 setWaypointCombatMode "RED";
_wayp3 setWaypointType "SAD";

_wayp4 = _choppergroup addWaypoint [_wayp4m, 100];
//_wayp4 setWaypointCombatMode "RED";
_wayp4 setWaypointType "CYCLE";

};