params ["_centerobj", "_groupsToSpawn", "_tanksToSpawn","_mechToSpawn"];

_tanks = ["rhs_zsu234_chdkz"];
_suitable = globalWaterPos;
_cfgGroups =  configFile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhsgref_group_national_infantry";
_groupArray = [];
private ["_suitable"]; 
_MechArray = [
	configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhs_group_indp_nat_btr70" >> "rhs_group_nat_btr70_chq",
	configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhs_group_indp_nat_btr70" >> "rhs_group_nat_btr70_squad",
	configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhs_group_indp_nat_btr70" >> "rhs_group_nat_btr70_squad_2mg",
	configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhs_group_indp_nat_btr70" >> "rhs_group_nat_btr70_squad_aa",
	configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhs_group_indp_nat_btr70" >> "rhs_group_nat_btr70_squad_mg_sniper",
	configfile >> "CfgGroups" >> "Indep" >> "rhsgref_faction_nationalist" >> "rhs_group_indp_nat_btr70" >> "rhs_group_nat_btr70_squad_sniper"
];
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
		_spawnPos = globalWaterPos;
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 999,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos, resistance,selectrandom _groupArray] call BIS_fnc_spawnGroup;
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

		_groupNumber = [_spawnPos,random 360,selectrandom _tanks,resistance] call BIS_fnc_spawnVehicle;

		[_groupNumber select 2, getPos _centerobj, random 800] call bis_fnc_taskPatrol;

		(_groupNumber select 2) deleteGroupWhenEmpty true;
		
		[_groupNumber select 2] call CHAB_fnc_serverGroups;
	};
};