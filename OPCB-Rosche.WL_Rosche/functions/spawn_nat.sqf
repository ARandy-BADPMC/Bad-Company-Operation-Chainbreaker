params ["_centerobj", "_groupsToSpawn", "_tanksToSpawn","_mechToSpawn"];

_tanks = ["rhs_zsu234_chdkz","rhsgref_nat_ural_Zu23"];

_cfgGroups =  configFile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhsgref_group_national_infantry";
_groupArray = [];

_mechanized = selectRandom ["rhs_group_nat_btr70_squad_2mg","rhs_group_nat_btr70_squad","rhs_group_nat_btr70_squad_mg_sniper"];
_cfgMechanized =  configFile >> "CfgGroups" >> "Indep" >> "rhs_faction_nationalist" >> _mechanized;
_MechArray = [];
private ["_suitable"];
_suitable = [-2766.16,-7006.65,5.27815];
for "_j" from 0 to (count _cfgMechanized)-1 do {
	_currentGroup = _cfgMechanized select _j;
	_MechArray pushback _currentGroup;
};
_MechArray deleteat 0;
if (_mechToSpawn != 0) then {
	for "_i" from 1 to _mechToSpawn do { 
		_spawnPos = [-2766.16,-7006.65,5.27815];
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 1000,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos, resistance,selectrandom _MechArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, random 800] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
	};
};

for "_j" from 0 to (count _cfgGroups)-1 do {
	_currentGroup = _cfgGroups select _j;
	_groupArray pushback _currentGroup;
};

_groupArray deleteat 0;
if (_groupsToSpawn != 0) then {
	for "_i" from 1 to _groupsToSpawn do {
		_spawnPos = [-2766.16,-7006.65,5.27815];
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 999,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos, resistance,selectrandom _groupArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, random 799] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		sleep 2;
	};
};
if (_tanksToSpawn != 0) then {
	for "_i" from 1 to _tanksToSpawn do {
		_spawnPos = [-2766.16,-7006.65,5.27815];
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 1000,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos,random 360,selectrandom _tanks,resistance] call BIS_fnc_spawnVehicle;

		[_groupNumber select 2, getPos _centerobj, random 800] call bis_fnc_taskPatrol;

		_groupNumber select 2 deleteGroupWhenEmpty true;
	};
};

