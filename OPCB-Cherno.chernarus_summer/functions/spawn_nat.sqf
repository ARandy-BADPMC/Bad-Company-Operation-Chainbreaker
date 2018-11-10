params ["_centerobj", "_groupsToSpawn", "_tanksToSpawn","_mechToSpawn"];

_tanks = ["rhs_zsu234_chdkz","rhsgref_nat_ural_Zu23"];

_cfgGroups =  configFile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhsgref_group_national_infantry";
_groupArray = [];

_mechanized = selectRandom ["rhs_group_nat_btr70_squad_2mg","rhs_group_nat_btr70_squad","rhs_group_nat_btr70_squad_mg_sniper"];
_cfgMechanized =  configFile >> "CfgGroups" >> "Indep" >> "rhs_faction_nationalist" >> _mechanized;
_MechArray = [];

for "_j" from 0 to (count _cfgMechanized)-1 do {
	_currentGroup = _cfgMechanized select _j;
	_MechArray pushback _currentGroup;
};
_MechArray deleteat 0;
if (_mechToSpawn != 0) then {
	for "_i" from 1 to _mechToSpawn do { 
		_randomDistance = 0;

		waitUntil {
		  _randomDistance = random 700;
		  _randomDistance >200
		}; 

		_spawnPos = "pos" + str _i;

		_spawnPos = [getpos _centerobj, _randomDistance, random 360] call BIS_fnc_relPos; 
		
		_groupNumber = "group" + str _i;

		_groupNumber = [_spawnPos, resistance,selectrandom _MechArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, _randomDistance] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		sleep 2;
	};
};

for "_j" from 0 to (count _cfgGroups)-1 do {
	_currentGroup = _cfgGroups select _j;
	_groupArray pushback _currentGroup;
};

_groupArray deleteat 0;
if (_groupsToSpawn != 0) then {
	for "_i" from 1 to _groupsToSpawn do {
		_randomDistance = 0;

		waitUntil {
		  _randomDistance = random 700;
		  _randomDistance > 200
		}; 

		_spawnPos = "pos" + str _i;

		_spawnPos = [getpos _centerobj, _randomDistance, random 360] call BIS_fnc_relPos; 
		
		_groupNumber = "group" + str _i;

		_groupNumber = [_spawnPos, resistance,selectrandom _groupArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, _randomDistance] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		sleep 2;
	};
};
if (_tanksToSpawn != 0) then {
	for "_i" from 1 to _tanksToSpawn do {
		_randomDistance = 0;

		waitUntil {
		  _randomDistance = random 700;
		  _randomDistance > 200
		}; 

		_spawnPos = "pos" + str _i;

		_spawnPos = [getpos _centerobj, _randomDistance, random 360] call BIS_fnc_relPos; 
		
		_groupNumber = "group" + str _i;

		_groupNumber = [_spawnPos,random 360,selectrandom _tanks,resistance] call BIS_fnc_spawnVehicle;

		_roadPos = [_spawnPos, 3000] call BIS_fnc_nearestRoad;
		(_groupNumber select 0) setPos (getPos _roadPos);

		[_groupNumber select 2, getPos _centerobj, _randomDistance] call bis_fnc_taskPatrol;

		_groupNumber select 2 deleteGroupWhenEmpty true;
		sleep 2;
	};
};

