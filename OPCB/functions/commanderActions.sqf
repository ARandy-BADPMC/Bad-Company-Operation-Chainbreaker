if(CommanderActionUnderway) exitWith {
	//hint "already requested";
};

params ["_unitOrPosition"];
if!(_unitOrPosition isEqualTo []) then {
	_unitOrPosition = getPos _unitOrPosition;
};

CommanderActionUnderway = true;

(selectRandom (CommanderSupportActions select { ((_x select 1) select 0) >= 1 })) params ["_action", "_actionDescriptor"];

private ["_transportGroups", "_transportHelicopterGroups", "_attackHelicopterGroups", "_infGroups"];

_actionDescriptor params ["_actionCount", "_side"];

switch (_side) do {
	case east: { 
		_infGroups = OPCB_InfantryGroups_OPFOR;
		_transportGroups = OPCB_TransportVehicles_OPFOR;
		_transportHelicopterGroups = OPCB_TransportHelicopters_OPFOR;
		_attackHelicopterGroups = OPCB_AttackHelicopters_OPFOR;
	};
	case resistance: {
		_infGroups = OPCB_InfantryGroups_Insurgents;
		_transportHelicopterGroups = OPCB_TransportHelicopters_Insurgents;
		_transportGroups = OPCB_TransportVehicles_Insurgents;
		_attackHelicopterGroups = OPCB_AttackHelicopters_Insurgents;
	};
	case west: {

	};
	default {

	};
};

switch (_action) do {
	case "attackHelis": {
		private _rate = 500;
		private _pos = _unitOrPosition getPos[random 4500 + _rate, random 4500 + _rate];
		private _nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;

		while {_nearestPlayerDistance < 2000} do {
			_rate = _rate + 500;
			_pos = _unitOrPosition getPos[random 5000 + _rate, random 5000 + _rate];
			_nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;
		};
		
		([_pos, random 180, selectRandom _attackHelicopterGroups, _side] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];
		[_spawnedGroup, _unitOrPosition] call BIS_fnc_taskAttack;
		[_spawnedGroup] call CHAB_fnc_setVehicleLock;

		_spawnedGroup deleteGroupWhenEmpty true;
		[_spawnedGroup] call CHAB_fnc_serverGroups;

		CommanderSupportActions = CommanderSupportActions apply {
			private _var = _x;
			if( (_var select 0) == "attackHelis" ) then {
				_points = (_var select 1) params ["_point", "_side2"];

				_var  = [_var select 0, [_point - 1, _side2]];
			};
			_var
		};
	};
	case "groundTransport": { 
		private _rate = 500;
		private _pos = _unitOrPosition getPos[random 4500 + _rate, random 4500 + _rate];
		private _nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;

		while {_nearestPlayerDistance < 2000} do {
			_rate = _rate + 500;
			_pos = _unitOrPosition getPos[random 5000 + _rate, random 5000 + _rate];
			_nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;
		};

		_rate = 100;
		private _roads = _pos nearRoads _rate;
		while {count _roads == 0} do {
			_rate = _rate + 100;
			_roads = _pos nearRoads _rate;
		};
		private _selectedRoadPos = getPos (selectRandom _roads);

		private _transportGroup = [_selectedRoadPos, _side, selectrandom _infGroups] call BIS_fnc_spawnGroup;

		_transportGroup deleteGroupWhenEmpty true;
		
		([_selectedRoadPos, random 180, selectRandom _transportGroups, _transportGroup] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];

		private _cargoSeats = _createdVehicle emptyPositions "Cargo";

		for "_i" from 1 to _cargoSeats do {
			private _ai = selectRandom ( (units _transportGroup) select {vehicle _x == _x});
			_ai moveInCargo _createdVehicle;
		};

		{
			deleteVehicle _x;
		} forEach ((units _transportGroup) select {vehicle _x == _x});
		

		private _wp = _spawnedGroup addWaypoint [_unitOrPosition, 200];
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointType "UNLOAD";

		[_spawnedGroup, _unitOrPosition] call BIS_fnc_taskAttack;
		[_spawnedGroup] call CHAB_fnc_setVehicleLock;

		_spawnedGroup deleteGroupWhenEmpty true;
		[_spawnedGroup] call CHAB_fnc_serverGroups;

		CommanderSupportActions = CommanderSupportActions apply {
			private _var = _x;
			if( (_var select 0) == "groundTransport" ) then {
				_points = (_var select 1) params ["_point", "_side2"];

				_var  = [_var select 0, [_point - 1, _side2]];
			};
			_var
		};
	};
	case "airTransport": {
		private _rate = 500;
		private _pos = _unitOrPosition getPos[random 4500 + _rate, random 4500 + _rate];
		private _nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;

		while {_nearestPlayerDistance < 2000} do {
			_rate = _rate + 500;
			_pos = _unitOrPosition getPos[random 5000 + _rate, random 5000 + _rate];
			_nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;
		};
		
		private _transportGroup = [_pos, _side, selectrandom _infGroups] call BIS_fnc_spawnGroup;

		_transportGroup deleteGroupWhenEmpty true;

		([_pos, random 180, selectRandom _transportHelicopterGroups, _transportGroup] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];

		private _cargoSeats = _createdVehicle emptyPositions "Cargo";

		for "_i" from 1 to _cargoSeats do {
			private _ai = selectRandom ( (units _transportGroup) select {vehicle _x == _x});
			_ai moveInCargo _createdVehicle;
		};

		{
			deleteVehicle _x;
		} forEach ((units _transportGroup) select {vehicle _x == _x});

		private _wp = _spawnedGroup addWaypoint [_unitOrPosition, 200];
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointBehaviour "AWARE";
		_wp setWaypointType "UNLOAD";

		[_spawnedGroup, _unitOrPosition] call BIS_fnc_taskAttack;
		[_spawnedGroup] call CHAB_fnc_setVehicleLock;

		_spawnedGroup deleteGroupWhenEmpty true;
		[_spawnedGroup] call CHAB_fnc_serverGroups;

		CommanderSupportActions = CommanderSupportActions apply {
			private _var = _x;
			if( (_var select 0) == "airTransport" ) then {
				_points = (_var select 1) params ["_point", "_side2"];

				_var  = [_var select 0, [_point - 1, _side2]];
			};
			_var
		};
	};
	default { 

	};
};

[] spawn {
	sleep random [600, 900, 1200];
	CommanderActionUnderway = false;
};