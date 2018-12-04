params ["_centerobj", "_groupsToSpawn", "_tanksToSpawn","_mechToSpawn"];

_tanks = ["rhs_zsu234_aa","rhs_bmp1_vmf","rhs_bmp1d_vmf","rhs_bmp1k_vmf","rhs_bmp1p_vmf","rhs_bmp2e_vmf","rhs_bmp2_vmf","rhs_bmp2d_vmf","rhs_bmp2k_vmf","rhs_brm1k_vmf","rhs_prp3_vmf","rhs_btr60_vmf","rhs_btr70_vmf","rhs_btr80_vmf","rhs_btr80a_vmf","rhs_bmp3_msv","rhs_bmp3_late_msv","rhs_bmp3m_msv","rhs_bmp3mera_msv","rhs_Ob_681_2","rhs_t72ba_tv","rhs_t72bb_tv","rhs_t72bc_tv","rhs_t72bd_tv","rhs_t80","rhs_t80a","rhs_t80b","rhs_t80bk","rhs_t80bv","rhs_t80bvk","rhs_t80u","rhs_t80u45m","rhs_t80ue1","rhs_t80uk","rhs_t80um","rhs_t90_tv","rhs_t90a_tv","rhs_bmd1","rhs_bmd1k","rhs_bmd1p","rhs_bmd1pk","rhs_bmd1r","rhs_bmd2","rhs_bmd2k","rhs_bmd2m","rhs_bmd4_vdv","rhs_bmd4m_vdv","rhs_bmd4ma_vdv"];

_mechanized = selectRandom ["rhs_group_rus_msv_bmp1","rhs_group_rus_msv_bmp2","rhs_group_rus_MSV_BMP3","rhs_group_rus_MSV_bmp3m","rhs_group_rus_msv_btr70","rhs_group_rus_msv_BTR80","rhs_group_rus_msv_BTR80a"];

_cfgMechanized =  configFile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> _mechanized;
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

		_groupNumber = [_spawnPos, east,selectrandom _MechArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, random 800] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		
		[_groupNumber] call CHAB_fnc_serverGroups;
	};
};

_cfgGroups =  configFile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry";
_groupArray = [];

for "_j" from 0 to (count _cfgGroups)-1 do {
	_currentGroup = _cfgGroups select _j;
	_groupArray pushback _currentGroup;
};

_groupArray deleteat 0;

if (_groupsToSpawn != 0) then {
	for "_i" from 1 to _groupsToSpawn do {
		_spawnPos = [0,0,0];
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 1000,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos, east,selectrandom _groupArray] call BIS_fnc_spawnGroup;
		[_groupNumber, getPos _centerobj, random 800] call bis_fnc_taskPatrol;
		_groupNumber deleteGroupWhenEmpty true;
		
		[_groupNumber] call CHAB_fnc_serverGroups;
		sleep 2;
	};
};
if (_tanksToSpawn != 0) then {
	for "_i" from 1 to _tanksToSpawn do {
		_spawnPos = [0,0,0];
		while {surfaceIsWater _spawnPos || (_suitable select 0)<=100 || (_suitable select 1) >= 13000 } do {
			_spawnPos = (getpos _centerobj) getPos[random 1000,random 360];
			_suitable = [_spawnPos, 0, 300, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			_spawnPos = _suitable;
		};

		_groupNumber = [_spawnPos,random 360,selectrandom _tanks,east] call BIS_fnc_spawnVehicle;

		[_groupNumber select 2, getPos _centerobj, random 800] call bis_fnc_taskPatrol;

		(_groupNumber select 2) deleteGroupWhenEmpty true;
		
		[_groupNumber select 2] call CHAB_fnc_serverGroups;
	};
};

