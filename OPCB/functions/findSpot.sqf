params ["_radius", ["_basePos", markerPos "base_marker"], ["_maxRange", 0]];
private _taskSpot = [0,0,0];
private _list = [];
private _suitableSpots = [];
private ["_step","_prevStep","_spot","_heading", "_suitable"];

private _iter = ((ceil (worldSize/500)) - 5) max 10;
private _minDistance = 2000;

if(_maxRange == 0) then {
	_maxRange = worldSize / 2;
	_minDistance = 100;
};

for "_i" from 1 to _iter do {
	
	_suitable = [0,0,0];	
	while {count _suitable == 3 || {surfaceIsWater _suitable}} do {
		
		private _rndPos = _basePos getPos[random [_minDistance,_maxRange/2, _maxRange] ,random 360];
		_suitable = [_rndPos, 0, _maxRange, 1, 0, 0.3, 0, ["base_marker"]] call BIS_fnc_findSafePos;
	};
	
	_suitableSpots pushBack _suitable;

};
_taskSpot = selectRandom _suitableSpots;
	
_list = nearestTerrainObjects [_taskSpot,[], _radius,false];

{
	_x hideObjectGlobal true;
} forEach _list;

[_taskSpot select 0, _taskSpot select 1, 0]