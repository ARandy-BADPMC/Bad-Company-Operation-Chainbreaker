// while {true} do {

// 	sleep random [600, 1200, 1800];
// };

private _vehicles = OPCB_ArmoredVehicles_Insurgents append OPCB_TransportVehicles_Insurgents;

private _redMarkers = ins_gridMarkers select {  (getMarkerColor _x) == "ColorRed" };

private _scrambledPlayers = allPlayers call BIS_fnc_arrayShuffle;

private _getClosestMarker = {
	params ["_player", "_markers"];
	private _closestDistane = 99999;
	private _closestMarker = 0;

	{
		private _distance = (getMarkerPos _x) distance2D _player;
		if(_distance < _closestDistane) then {
			_closestDistane = _distance;
			_closestMarker = _x;
		};
		
	} forEach _markers;

};

private _closestMarker = 0;
{
	if(_x inArea "base_marker") then {
		continue;
	};
	_closestMarker = [_x, _redMarkers] call _getClosestMarker;
	
} forEach _scrambledPlayers;

private _randomCity = Cities select {
	(([locationPosition _x] call CHAB_fnc_nearest) select 1) > 2000
};

private _randomStartingPoint = locationPosition _randomCity;
private _roads = _randomStartingPoint nearRoads 500;

private _randomRoad = selectRandom _roads;

([getPos _randomRoad, random 180, selectRandom _vehicles, resistance] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];
_spawnedGroup deleteGroupWhenEmpty true;
_spawnedGroup setCombatMode "RED";
[_spawnedGroup] call CHAB_fnc_setVehicleLock;

private _waypoint = _spawnedGroup addWaypoint [getMarkerPos _closestMarker, 0];
_waypoint setWaypointType "SAD";

_waypoint setWaypointTimeout [1200, 1800, 2400];

_waypoint = _spawnedGroup addWaypoint [_randomStartingPoint, 0];
_waypoint setWaypointTimeout [1200, 1800, 2400];

_waypoint setWaypointStatements ["true", "
{
	_vehicle = vehicle _x;
	if (_vehicle != _x) then {
		deleteVehicleCrew _vehicle;
		deleteVehicle _vehicle;
	};
	deletevehicle _x;
} forEach units (group this);
"];

