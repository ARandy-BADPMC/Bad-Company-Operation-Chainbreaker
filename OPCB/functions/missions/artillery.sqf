params ["_village", "_centerUnit"];
private _artgroups = [];
private _base = [0,0,0];
private _comps = ["mortar1","mortar2","mortar3"];
private _mortars = ["rhs_2b14_82mm_vdv"];
private _stations = [];
	
for "_i" from 0 to 3 do {
	_base = [20, getpos _centerUnit, 2000] call CHAB_fnc_findSpot;
	private _dir = [ _base, _village ] call BIS_fnc_dirTo;

	private _comp = [selectRandom _comps, _base, [0,0,0], _dir, true, true ] call LARs_fnc_spawnComp;

	private _artiPos = [_comp] call CHAB_fnc_findFlowerPots;

	private _spawnedGroup = createGroup [resistance, true];

	[_spawnedGroup] call CHAB_fnc_serverGroups;
	([_artiPos, random 360, selectRandom _mortars, _spawnedGroup] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew"]; 
	
	_createdVehicle setVariable ["disableInsurgencyCleanup", true];
	_artgroups pushBack (_spawnedGroup);

	private _unit = _crew select 0;

	[_createdVehicle, _unit] spawn CHAB_fnc_fire_artillery;

	_unit addEventHandler ["Killed", {
		ArtilleryRemaining = ArtilleryRemaining - 1;
	}];

	[_base, resistance, random [1,3,7], selectRandom [0,1], selectRandom [2,3], 0, false ] call CHAB_fnc_enemySpawner;
	_stations pushBack _comp;
};

[_stations, _artgroups]