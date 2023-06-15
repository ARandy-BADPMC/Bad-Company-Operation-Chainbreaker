params ["_radius"];
private _taskSpot = [0,0,0];
private _list = [];
if (_radius < 500) then {
	
	private _basePos = markerPos "base_marker";
	private _suitableSpots = [];
	
	private ["_step","_prevStep","_spot","_heading", "_suitable"];
	
	private _startingDist = worldSize min (2000 + random [0, 1000, 2000]);
	
	private _iter = ((ceil (worldSize/500)) - 5) max 10;
	
	for "_i" from 1 to _iter do {
		
		_suitable = [0,0,0,0];	

		while {count _suitable == 4 || {surfaceIsWater _suitable}} do {
			
			_suitable = [_basePos, 2000, _startingDist, 10, 0, 0.3, 0, [], [[0,0,0,0],[0,0,0,0]]] call BIS_fnc_findSafePos;

			_list = nearestTerrainObjects [_suitable,[], _radius,false];
			_startingDist = worldSize min (_startingDist + 800);
		};
		
		_suitableSpots pushBack _suitable;
		
		_startingDist = worldSize min (_startingDist + 800);
	
	};
	_taskSpot = selectRandom _suitableSpots;
	
};

{
	_x hideObjectGlobal true;
} forEach _list;

[_taskSpot select 0, _taskSpot select 1, 0]