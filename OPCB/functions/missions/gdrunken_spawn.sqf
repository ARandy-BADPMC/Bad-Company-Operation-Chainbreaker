params ["_pos"];
_comps = [];
_group = createGroup east;
_tanks = [];

for "_i" from 0 to 3 do {
	_suitable = [0, 0, 0];
	_maxDist = 1500;
	_list = [];

	while {((count _suitable) == 3) || {(count _list) > 0}} do {
	
		_suitable = [_pos, 0, _maxDist, 20, 0, 0.4, 0] call BIS_fnc_findSafePos;
		
		if ((count _suitable) == 3) then {
			_maxDist = worldSize min (_maxDist + 100);
		} else {
			_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], 55,false];
		};
		
	};

	_unit = _group createUnit [OPCB_unitTypes_inf_ins_commander, _suitable, [], 2, "NONE"];
	_comp = ["ammodepot",_unit, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
	_pad = nearestObject [_unit, "Land_HelipadEmpty_F"];
	deleteVehicle _unit;

	_groupNumber = [getPos _pad,random 360,selectrandom OPCB_unitTypes_veh_ins_armor, east] call BIS_fnc_spawnVehicle;
	(_groupNumber select 0) setFuel 0;
	(_groupNumber select 0) setVehicleLock "LOCKED";
	_tanks pushBack (_groupNumber select 0);

	_comps pushBack _comp;
};
deleteGroup _group;

_stations = [_comps,_tanks];
_stations