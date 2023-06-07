params ["_radius"];
_taskSpot = [0,0,0];
if (_radius < 500) then {
	
	_suitableSpots = [];
	
	private ["_step","_prevStep","_spot","_heading"];
	
	_startingDist = 2500;
	
	_iter = ((ceil (worldSize/500)) - 5) max 10;
	
	for "_i" from 1 to _iter do {
		
		_suitable = [0,0,0];	
		_list = [];

		while {((count _suitable) == 3) || {count _list > 0}} do {
			
			_suitable = [markerpos "base_marker", 2000, _startingDist, 10, 0, 0.7] call BIS_fnc_findSafePos;
			
			if ((count _suitable) == 3) then {
				_startingDist = worldSize min (_startingDist + 500);
			} else {
				_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], _radius,false];
			};		
			
		};
		
		_suitableSpots pushBack _suitable;
		
		_startingDist = worldSize min (_startingDist + 500);
	
	};

	_taskSpot = selectRandom _suitableSpots;
	
};
_taskSpot