_pos = _this select 0;
_suitable = globalWaterPos;
_list = [];
_comps = [];
_group = createGroup east;
_tankss = [];

for "_i" from 0 to 3 do {
	while {surfaceIsWater _suitable || (_suitable select 0)<=100 || count _list > 0 || (_suitable select 1) >= 13000} do {
		_spot = _pos getPos [random [500,1000,1500], random 360];
		_suitable = [_spot, 0, 500, 20, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
			_suitable = [_suitable select 0,_suitable select 1];
		};
		_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], 55,false];
	};
	_unit = _group createUnit [OPCB_unitTypes_inf_ins_commander, _suitable, [], 2, "NONE"];
	_comp = ["ammodepot",_unit, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
	_pad = nearestObject [_unit, "Land_HelipadEmpty_F"];
	deleteVehicle _unit;

	_groupNumber = [getPos _pad,random 360,selectrandom OPCB_unitTypes_veh_ins_armor, east] call BIS_fnc_spawnVehicle;
	(_groupNumber select 0) setFuel 0;
	(_groupNumber select 0) setVehicleLock "LOCKED";
	_tankss pushBack (_groupNumber select 0);

	_comps pushBack _comp;
};
deleteGroup _group;

_stations = [_comps,_tankss];
_stations