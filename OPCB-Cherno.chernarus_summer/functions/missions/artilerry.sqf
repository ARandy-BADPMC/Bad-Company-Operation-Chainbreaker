

_village = _this select 0;
_guard = _this select 1;
_stations = [];
_group = createGroup resistance;
_servergroups = missionNamespace getVariable ["enemy_groups",[]];
			_servergroups pushBack _group;
			missionNamespace setVariable ["enemy_groups",_servergroups];
_comps = ["mortar1","mortar2","mortar3"];

	
	for "_i" from 0 to 3 do {

		_markpos = [_village, 1000, random 359] call BIS_fnc_relPos;
		while { (_markpos distance _guard) < 500 || surfaceIsWater _markpos} do {
		  _markpos = [_village, 1000, random 359] call BIS_fnc_relPos;
		};


		_base = [_markpos,50,800,20,0,0.4,0,["base_marker"],[_markpos,_markpos]] call BIS_fnc_findSafePos;
		while { (_base distance _guard) < 500 || (_base distance _village) <800 } do {
		  _base = [_markpos,50,800,20,0,0.4,0,["base_marker"],[_markpos,_markpos]] call BIS_fnc_findSafePos;
		};

		_civilian = _group createUnit ["C_IDAP_Man_AidWorker_01_F", _base, [], 2, "NONE"];
		_dir = [ _civilian, _village ] call BIS_fnc_dirTo;

		_arti = selectRandom _comps;
		_pos = getPos _civilian;
		_comp = [_arti,_pos, [0,0,0], _dir, true, true ] call LARs_fnc_spawnComp;
		
		_artilerryunit = (allUnits select {_x distance _pos < 10 && _x != _civilian});
		[_artilerryunit,_village] spawn CHAB_fnc_fire_artilerry;
		[_artilerryunit] spawn {
			while {alive (_this select 0 select 0)} do {
			  sleep 10;
			};
			_remain = missionNamespace getVariable ["artilerry_rem",4];
			missionNamespace setVariable ["artilerry_rem",(_remain-1)];	
			waitUntil {
			  _taskisrunning = missionNamespace getVariable ["running_task",1];

			  _taskisrunning == 0
			};
		};


		[_civilian,3,0,0] execVM "functions\spawn_ins.sqf";

		sleep 5;
		deleteVehicle _civilian;
		_stations pushBack _comp;
	};
	

	waitUntil {
		sleep 10;
		_taskisrunning = missionNamespace getVariable ["running_task",1];
		_taskisrunning == 0
	};

	{
	  [ _x ] call LARs_fnc_deleteComp;
	} forEach _stations;

	{
	  deleteVehicle _x;
	} forEach (allUnits select { side _x == civilian || side _x == resistance } );



