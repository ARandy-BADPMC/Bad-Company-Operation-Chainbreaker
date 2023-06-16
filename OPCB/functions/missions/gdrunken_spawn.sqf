params ["_pos"];
private _comps = [];
private _tanks = [];

for "_i" from 0 to 3 do {
	_suitable = [0, 0, 0, 0];
	_maxDist = 1500;
	_list = [];

	while {count _suitable == 4 || {surfaceIsWater _suitable}} do {
	
		_suitable = [_pos, 0, _maxDist, 20, 0, 0.4, 0] call BIS_fnc_findSafePos;
		
		_maxDist = worldSize min (_maxDist + 100);
		
	};
	_suitable = [_suitable select 0, _suitable select 1, 0];
	_list = nearestTerrainObjects [_suitable,[], 55,false];
	{
		_x hideObjectGlobal true;
	} forEach _list;

	_comp = ["ammodepot",_suitable, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
	_pad = nearestObject [_suitable, "Land_HelipadEmpty_F"];

	_groupNumber = [getPos _pad,random 360,selectrandom OPCB_ArmoredVehicles_OPFOR, east] call BIS_fnc_spawnVehicle;
	(_groupNumber select 0) setFuel 0;
	(_groupNumber select 0) setVehicleLock "LOCKED";
	_tanks pushBack (_groupNumber select 0);

	_comps pushBack _comp;
};

_stations = [_comps,_tanks];
_stations