
_howBig = _this select 0;

if (_howBig < 500) then {

	missionNamespace setVariable["task_underway",true];
	
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
				_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], _howBig,false];
			};		
			
		};
		
		_suitableSpots pushBack _suitable;
		
		_startingDist = worldSize min (_startingDist + 500);
	
	};

	missionNamespace setVariable ["task_spot", selectRandom _suitableSpots];
	
	/*
	// test code
	_marker = createMarker [str random 1000, task_spot];
	_marker setMarkerType "hd_destroy";
	_marker setMarkerColor "ColorRed";
	player setpos task_spot;
	*/
	
}
else
{
	missionNamespace setVariable ["task_spot",[0,0,0]];
};
