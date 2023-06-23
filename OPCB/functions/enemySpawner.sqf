params ["_centerPosition","_side"];
private _playerRate = [] call CHAB_fnc_playerScale;

private _infantryGroupsCount = floor random [4 * _playerRate, 8 * _playerRate, 12 * _playerRate];//
private _mechanizedGroupsCount = floor random [0 * _playerRate, 1 * _playerRate, 3 * _playerRate];//
private _staticVehiclesCount = floor random [2 * _playerRate, 4 * _playerRate, 6 * _playerRate];//
private _transportVehiclesCount = floor random [0 * _playerRate, 2 * _playerRate, 4 * _playerRate];

private _transportGroundCount = floor random [0, _transportVehiclesCount/2, _transportVehiclesCount];
private _transportHelicoptersCount = _transportVehiclesCount - _transportGroundCount;

private _attackHelicoptersCount = floor random [0 * _playerRate, 1 * _playerRate, 2 * _playerRate];
private _artilleryCount = floor random [0 * _playerRate, 1 * _playerRate, 2 * _playerRate];

private _armoredVehiclesCount = floor random [0 * _playerRate, 1 * _playerRate, 3 * _playerRate];

private ["_mechGroups","_infGroups", "_staticVehicles", "_commanderUnits", "_armoredVehicles"];

switch (_side) do {
	case east: { 
		_infGroups = OPCB_InfantryGroups_OPFOR;
		_mechGroups = OPCB_MechanizedGroups_OPFOR;
		_staticVehicles = OPCB_StaticVehicles_OPFOR;
		_armoredVehicles = OPCB_ArmoredVehicles_OPFOR;
		_commanderUnits = OPCB_Commanders_OPFOR;
	};
	case resistance: {
		_infGroups = OPCB_InfantryGroups_Insurgents;
		_mechGroups = OPCB_MechanizedGroups_Insurgents;
		_staticVehicles = OPCB_StaticVehicles_Insurgents;
		_armoredVehicles = OPCB_ArmoredVehicles_Insurgents;
		_commanderUnits = OPCB_Commanders_Insurgents;
	};
	case west: {

	};
	default {

	};
};

private ["_spawnPos", "_randomDistancePos", "_group"];

private _findSavePosForGroups = {
	params ["_centerPosition"];
	private _safePos = [0,0,0];
	private _tries = 50;
	while {_tries > 0} do {

		_safePos = [ (_centerPosition getPos[random 1000,random 360]), 0, 300, 4, 0, 0.3, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
		if(!surfaceIsWater _safePos && {count _safePos < 4}) then {
			break;
		};
		_tries = _tries -1;
	};
	_safePos;
};

private _patrolAndFinish = {
	params ["_group","_centerPosition"];
	[_group, _centerPosition, random 1000] call bis_fnc_taskPatrol;
	_group deleteGroupWhenEmpty true;
	[_group] call CHAB_fnc_serverGroups;
};

for "_i" from 1 to _infantryGroupsCount do {
	_spawnPos = [_centerPosition] call _findSavePosForGroups;
	if(surfaceIsWater _spawnPos) then {
		continue;
		//skip spawning the unit, we tried enough times
	};

	_group = [_spawnPos, _side, selectrandom _infGroups] call BIS_fnc_spawnGroup;

	[_group] call CHAB_fnc_setVehicleLock;
	
	[_group, _centerPosition] call _patrolAndFinish;
};

for "_i" from 1 to _mechanizedGroupsCount do {
	_spawnPos = [_centerPosition] call _findSavePosForGroups;
	if(surfaceIsWater _spawnPos) then {
		continue;
		//skip spawning the unit, we tried enough times
	};

	_group = [_spawnPos, _side, selectrandom _mechGroups] call BIS_fnc_spawnGroup;

	[_group] call CHAB_fnc_setVehicleLock;
	
	[_group, _centerPosition] call _patrolAndFinish;
};

for "_i" from 1 to _armoredVehiclesCount do {
	_spawnPos = [_centerPosition] call _findSavePosForGroups;
	if(surfaceIsWater _spawnPos) then {
		continue;
		//skip spawning the unit, we tried enough times
	};

	([_spawnPos, 180, selectRandom _armoredVehicles, _side] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];

	[_spawnedGroup] call CHAB_fnc_setVehicleLock;
	
	[_spawnedGroup, _centerPosition] call _patrolAndFinish;
};

for "_i" from 1 to _staticVehiclesCount do {
	_spawnPos = [_centerPosition] call _findSavePosForGroups;
	if(surfaceIsWater _spawnPos) then {
		continue;
		//skip spawning the unit, we tried enough times
	};

	([_spawnPos, 180, selectRandom _staticVehicles, _side] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];

	[_createdVehicle] call CHAB_fnc_setStaticVehicleLock;

	[_spawnedGroup] call CHAB_fnc_setVehicleLock;

	_group = [_spawnPos, _side, selectrandom _infGroups] call BIS_fnc_spawnGroup;
	
	[_group, _spawnPos] call BIS_fnc_taskDefend;
	
	_spawnedGroup deleteGroupWhenEmpty true;
	_group deleteGroupWhenEmpty true;

	[[_spawnedGroup,_group]] call CHAB_fnc_serverGroups;
};
CommanderSupportActions = [];

{
	if( ((_x select 1) select 0) > 0 ) then {
		CommanderSupportActions pushBack _x;
	};
} forEach 
		[["attackHelis",[_attackHelicoptersCount, _side]],
		["groundTransport",[_transportGroundCount, _side]],
		["airTransport",[_transportHelicoptersCount, _side]],
		["artillery",[_artilleryCount,_side]]];

private _commanderSpawnPos = [_centerPosition] call _findSavePosForGroups;
if!(surfaceIsWater _commanderSpawnPos) then {
	private _commanderGroup = createGroup [_side, true];
	private _commander = _commanderGroup createUnit [selectRandom _commanderUnits, _commanderSpawnPos, [], 1, "NONE"];
	[_commanderGroup, _centerPosition] call BIS_fnc_taskDefend;
	[_commanderGroup] call CHAB_fnc_serverGroups;

	_commanderGroup addEventHandler ["EnemyDetected", {
		params ["_group", "_newTarget"];
		_distance = ((units _group) select 0) distance2D  _newTarget;
		if(_distance < 1500) then {
			[_newTarget] call CHAB_fnc_commanderActions;
		};
	}];
};