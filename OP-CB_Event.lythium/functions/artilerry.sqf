jey_artilerry = {

_village = _this select 0;
_guard = _this select 1;
_stations = [];
_group = createGroup resistance;
_comps = ["mortar1","mortar2","mortar3"];

	
	for "_i" from 0 to 3 do {

		_markpos = [_village, 1000, random 359] call BIS_fnc_relPos;
		while { (_markpos distance _guard) < 500 || surfaceIsWater _markpos} do {
		  _markpos = [_village, 1000, random 359] call BIS_fnc_relPos;
		};
		//hint "mark done";


		_base = [_markpos,50,800,20,0,0.4,0,["base_marker"],[_markpos,_markpos]] call BIS_fnc_findSafePos;
		while { (_base distance _guard) < 500 || (_base distance _village) <800 } do {
		  _base = [_markpos,50,800,20,0,0.4,0,["base_marker"],[_markpos,_markpos]] call BIS_fnc_findSafePos;
		};
		//hint "base done";

		_civilian = _group createUnit ["C_IDAP_Man_AidWorker_01_F", _base, [], 2, "NONE"];
		_dir = [ _civilian, _village ] call BIS_fnc_dirTo;
		//copyToClipboard str _civilian;

		_arti = selectRandom _comps;
		_pos = getPos _civilian;
		_comp = [_arti,_pos, [0,0,0], _dir, true, true ] call LARs_fnc_spawnComp;
		
		_artilerryunit = (allUnits select {_x distance _pos < 10 && _x != _civilian});
		[_artilerryunit,_village] spawn jey_fire_artilerry;
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

			/*{
			   deleteVehicle _x;
			} forEach nearestObjects [getpos _this select 0 select 0, ["all"], 20];*/
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

};

jey_fire_artilerry = 
{
	_unitar = _this select 0;	
	_village = _this select 1;
	//_can = canSuspend;

	//copyToClipboard str _can; 
	private "_close";

	_unit = _unitar select 0;
	_gep = vehicle _unit;

	while {alive _unit} do {
		_players = allUnits select {isPlayer _x};
	  	{
		  	_playerInRange = (getPosATL _x) inRangeOfArtillery [[_gep], (getArtilleryAmmo [_gep] select 0)];
		  	//_player = [_unit] call jey_fnc_nearest;
			_daytime = daytime;
			//copyToClipboard str _daytime;
			if (_daytime >= 20 || _daytime <= 5) then 
			{
				if ( _playerInRange )// && _player distance _unit <2000
		       	exitWith{
			       	_markpos = [getPos _x, random 500, random 359] call BIS_fnc_relPos;
			       	_gep commandArtilleryFire [_markpos,getArtilleryAmmo [_gep] select 1,1];
		       	};  
			}
			else
			{
				if ( _playerInRange )// && _player distance _unit <2000
		       	exitWith{
			       	_markpos = [getPos _x, random 500, random 359] call BIS_fnc_relPos;
			       	_gep commandArtilleryFire [_markpos,getArtilleryAmmo [_gep] select 0,2];
		       	};
			}
			   
	  	} forEach _players;

	  	sleep random 350;
	};


};

