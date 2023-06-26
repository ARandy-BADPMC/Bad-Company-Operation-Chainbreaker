params ["_village", "_centerPos"];
_stations = [];
_artgroups = [];
_base = [0,0,0];
_group = createGroup [resistance,true];
[_group] call CHAB_fnc_serverGroups;
_comps = ["mortar1","mortar2","mortar3"];
	
for "_i" from 0 to 3 do {

	_markpos = globalWaterPos;
	while { surfaceIsWater _markpos || (_markpos distance officer_jeff <1000) || surfaceIsWater _base || _base distance2D _centerPos < 400} do {
		_markpos = _village getPos[random [500,1000,1500],random 360];
		_base = [_markpos,15,500,10, 0, 0.5, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
	};
	
	_civilian = _group createUnit ["C_IDAP_Man_AidWorker_01_F", _base, [], 2, "NONE"];
	_dir = [ _civilian, _village ] call BIS_fnc_dirTo;

	_pos = getPos _civilian;
	_comp = [selectRandom _comps,_pos, [0,0,0], _dir, true, true ] call LARs_fnc_spawnComp;
	
	_artilleryunit = (allUnits select {_x distance _pos < 10 && _x != _civilian}); 
	_artgroups pushBack (_artilleryunit select 0);
	[_artilleryunit,_village] spawn CHAB_fnc_fire_artillery;
	(_artilleryunit select 0) addEventHandler ["Killed", {
		ArtilleryRemaining = ArtilleryRemaining - 1;
	}];


	[getPos _civilian,resistance, random [1,3,7],selectRandom [0,1], selectRandom [2,3], 0, false ] call CHAB_fnc_enemySpawner;
	deleteVehicle _civilian;
	_stations pushBack _comp;
};
_stations = [_stations,_artgroups];
_stations