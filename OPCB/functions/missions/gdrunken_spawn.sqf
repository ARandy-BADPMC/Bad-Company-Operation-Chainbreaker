_pos = _this select 0;
_comps = [];
_group = createGroup east;
_tanks = [];
_list = [];
_suitable = [0, 0, 0];
_offset = 0;

for "_i" from 0 to 3 do {

	while {count _list > 0 || count _suitable == 3} do {
		_suitable = [_pos, 200, 1500 + _offset, 20, 0, 0.4, 0] call BIS_fnc_findSafePos;
		_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], 55,false];
		if (count _suitable == 3) then {
			_offset = _offset + 100;
		}
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