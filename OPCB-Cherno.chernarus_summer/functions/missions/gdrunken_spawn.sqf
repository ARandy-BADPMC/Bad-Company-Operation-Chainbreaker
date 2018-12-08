_pos = _this select 0;
_suitable = [0,0,0];
_list = [];
_comps = [];
_group = createGroup resistance;
_tanks = ["rhsgref_ins_g_t72bc","rhsgref_ins_g_t72bb","rhsgref_ins_g_t72ba"];
_tankss = [];

for "_i" from 0 to 3 do {
	while {surfaceIsWater _suitable || (_suitable select 0)<=100 || count _list > 0 || (_suitable select 1) >= 13000} do {
		_spot = _pos getPos [random [500,1000,1500], random 360];
		_suitable = [_spot, 0, 500, 20, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
			_suitable = [_suitable select 0,_suitable select 1];
		};
		_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], 55,false];
	};
	_unit = _group createUnit ["B_GEN_Commander_F", _suitable, [], 2, "NONE"];
	_comp = ["ammodepot",_unit, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
	_pad = nearestObject [_unit, "Land_HelipadEmpty_F"];
	deleteVehicle _unit;

	//_truckpos = _suitable findEmptyPosition [1, 50, "RHS_T72BB_chdkz"];
	//_truckpos = [_suitable, 0, 50, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;

	_groupNumber = [getPos _pad,random 360,selectrandom _tanks,resistance] call BIS_fnc_spawnVehicle;
	(_groupNumber select 0) setFuel 0; 
	_tankss pushBack (_groupNumber select 0);

	_comps pushBack _comp;
};
deleteGroup _group;

_stations = [_comps,_tankss];
_stations