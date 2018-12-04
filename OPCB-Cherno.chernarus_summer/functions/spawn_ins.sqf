params ["_centerobj", "_groupsToSpawn", "_tanksToSpawn","_mechToSpawn"];
//enhanced version, units won't die on spawn or spawn in water anymore. 
_tanks = ["rhs_zsu234_chdkz","rhs_t72bb_chdkz"];

_cfgGroups =  configFile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "Infantry";
_groupArray = [];

_mechanized = selectRandom ["rhs_group_indp_ins_bmd1","rhs_group_indp_ins_bmd2","rhs_group_indp_ins_bmp1","rhs_group_indp_ins_bmp2","rhs_group_indp_ins_btr60","rhs_group_indp_ins_btr70"];
_cfgMechanized =  configFile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> _mechanized;
_MechArray = [];
private ["_suitable"];
_suitable = [0,0,0];
for "_j" from 0 to (count _cfgMechanized)-1 do {
	_currentGroup = _cfgMechanized select _j;
	_MechArray pushback _currentGroup;
};
_MechArray deleteat 0;
if (_mechToSpawn != 0) then {
	for "_i" from 1 to _mechToSpawn do { 
		_spawnPos = [0,0,0];
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 1000,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos, resistance,selectrandom _MechArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, random 800] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		[_groupNumber] call CHAB_fnc_serverGroups;
	};
};

for "_j" from 0 to (count _cfgGroups)-1 do {
	_currentGroup = _cfgGroups select _j;
	_groupArray pushback _currentGroup;
};

_groupArray deleteat 0;
if (_groupsToSpawn != 0) then {
	for "_i" from 1 to _groupsToSpawn do {
		_spawnPos = [0,0,0];

		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 998,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos, resistance,selectrandom _groupArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, random 799] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		[_groupNumber] call CHAB_fnc_serverGroups;
	};
};
if (_tanksToSpawn != 0) then {

	
	for "_i" from 1 to _tanksToSpawn do {
		_spawnPos = [0,0,0];

		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 999,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos,random 360,selectrandom _tanks,resistance] call BIS_fnc_spawnVehicle;

		[_groupNumber select 2, getPos _centerobj, random 801] call bis_fnc_taskPatrol;

		(_groupNumber select 2) deleteGroupWhenEmpty true;
		
		[_groupNumber select 2] call CHAB_fnc_serverGroups;
	};
};

