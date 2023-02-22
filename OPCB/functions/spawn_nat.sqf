params ["_centerobj", "_groupsToSpawn", "_tanksToSpawn","_mechToSpawn"];

_suitable = globalWaterPos;
_playerRate = [] call CHAB_fnc_playerScale;

_groupsToSpawn = ceil (_playerRate*_groupsToSpawn);
_tanksToSpawn = ceil (_playerRate*_tanksToSpawn);
_mechToSpawn = ceil (_playerRate*_mechToSpawn);

private ["_suitable"]; 

if (_mechToSpawn != 0) then {
	for "_i" from 1 to _mechToSpawn do { 
		_spawnPos = globalWaterPos;
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 1000,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};
		_groupNumber = [_spawnPos, east,selectrandom OPCB_unitTypes_grp_ins_mech] call BIS_fnc_spawnGroup;
		
		{
			(vehicle _x) setVehicleLock "LOCKED";
		} foreach ((units _groupNumber) select {_x == (effectiveCommander vehicle _x)});
		
		[_groupNumber, getPos _centerobj, random 800] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		
		[_groupNumber] call CHAB_fnc_serverGroups;
	};
};

if (_groupsToSpawn != 0) then {
	for "_i" from 1 to _groupsToSpawn do {
		_spawnPos = globalWaterPos;
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 999,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos, east,selectrandom OPCB_unitTypes_grp_ins_inf] call BIS_fnc_spawnGroup;
		
		{
			(vehicle _x) setVehicleLock "LOCKED";
		} foreach ((units _groupNumber) select {_x == (effectiveCommander vehicle _x)});
		
		[_groupNumber, getPos _centerobj, random 799] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		
		[_groupNumber] call CHAB_fnc_serverGroups;
		sleep 1;
	};
};
if (_tanksToSpawn != 0) then {
	for "_i" from 1 to _tanksToSpawn do {
		_spawnPos = globalWaterPos;
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 1000,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos,random 360,selectrandom OPCB_unitTypes_veh_ins_armor,east] call BIS_fnc_spawnVehicle;
		
		(_groupNumber select 0) setVehicleLock "LOCKED";

		[_groupNumber select 2, getPos _centerobj, random 800] call bis_fnc_taskPatrol;

		(_groupNumber select 2) deleteGroupWhenEmpty true;
		
		[_groupNumber select 2] call CHAB_fnc_serverGroups;
	};
};