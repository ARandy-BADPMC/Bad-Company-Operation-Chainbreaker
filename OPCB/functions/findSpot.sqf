params ["_radius"];
private _taskSpot = [0,0,0];
private _list = [];
if (_radius < 500) then {
	
	private _basePos = markerPos "base_marker";
	private _suitableSpots = [];
	
	private ["_step","_prevStep","_spot","_heading", "_suitable"];
	
	private _iter = ((ceil (worldSize/500)) - 5) max 10;

	private _worldHalf = worldSize /2;
	
	for "_i" from 1 to _iter do {
		
		_suitable = [0,0,0];	

		while {count _suitable == 3 || {surfaceIsWater _suitable}} do {
			_rndPos = _basePos getPos[random [2000,_worldHalf/2, _worldHalf] ,random 360];
			_suitable = [_rndPos, 0, _worldHalf, 1, 0, 0.3, 0, ["base_marker"], [[0,0,0,0],[0,0,0,0]]] call BIS_fnc_findSafePos;
		};
		
		_suitableSpots pushBack _suitable;
	
	};
	_taskSpot = selectRandom _suitableSpots;
	
};
_list = nearestTerrainObjects [_taskSpot,[], _radius,false];

{
	_x hideObjectGlobal true;
} forEach _list;

[_taskSpot select 0, _taskSpot select 1, 0]