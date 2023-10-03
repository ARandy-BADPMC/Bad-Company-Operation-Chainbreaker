if(CommanderActionUnderway) exitWith {
	//hint "already requested";
};

params ["_unitOrPosition"];
if!(_unitOrPosition isEqualTo []) then {
	_unitOrPosition = getPos _unitOrPosition;
};

CommanderActionUnderway = true;

(selectRandom (CommanderSupportActions select { ((_x select 1) select 0) >= 1 })) params ["_action", "_actionDescriptor"];

private ["_transportGroups", "_transportHelicopterGroups", "_attackHelicopterGroups", "_infGroups","_artilleryGroups"];
_actionDescriptor params ["_actionCount", "_side"];
switch (_side) do {
	case east: { 
		_infGroups = OPCB_InfantryGroups_OPFOR;
		_transportGroups = OPCB_TransportVehicles_OPFOR;
		_transportHelicopterGroups = OPCB_TransportHelicopters_OPFOR;
		_attackHelicopterGroups = OPCB_AttackHelicopters_OPFOR;
		_artilleryGroups = OPCB_Artillery_OPFOR;
	};
	case resistance: {
		_infGroups = OPCB_InfantryGroups_Insurgents;
		_transportHelicopterGroups = OPCB_TransportHelicopters_Insurgents;
		_transportGroups = OPCB_TransportVehicles_Insurgents;
		_attackHelicopterGroups = OPCB_AttackHelicopters_Insurgents;
		_artilleryGroups = OPCB_Artillery_Insurgents;
	};
	case west: {

	};
	default {

	};
};

private _subTractPoints = {
	params ["_actionName"];
	CommanderSupportActions = CommanderSupportActions apply {
		private _var = _x;
		if( (_var select 0) == _actionName ) then {
			_points = (_var select 1) params ["_point", "_side2"];

			_var  = [_var select 0, [_point - 1, _side2]];
		};
		_var
	};
};

private _getSafePos = {
	params ["_unitOrPosition",["_minDistance", 2000 , [0]],["_maxDistance", 4500 , [0]]];
	private _rate = 500;
	private _randomDistance = (random 100) random [_minDistance,_maxDistance];
	private _pos = _unitOrPosition getPos[ _randomDistance+ _rate, random 360];
	private _nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;

	while {_nearestPlayerDistance < 2000} do {
		_rate = _rate + 500;
		_pos = _unitOrPosition getPos[_randomDistance + _rate, random 360];
		_nearestPlayerDistance = ([_pos] call CHAB_fnc_nearest) select 1;
	};
	_pos
};

private _getSafeRoads = {
	params ["_pos",["_minDistance", 2000 , [0]]];
	private _rate = 0;
	private _roads = [];
	private _safeRoads =[]; 

	while {count _safeRoads == 0 } do {
		_rate = _rate + 100;
		_roads = _pos nearRoads _rate;
		_safeRoads = _roads select
		{
			private _road = _x;
			private _found = false;
			{
				if( _x distance2D _road> _minDistance) exitWith {
					_found = true;
				};
			} forEach playableUnits;
			_found
		};
	};
	_safeRoads
};

switch (_action) do {
	case "attackHelis": {
		private _pos = [_unitOrPosition] call _getSafePos;
		
		([_pos, random 180, selectRandom _attackHelicopterGroups, _side] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];
		[_spawnedGroup, _unitOrPosition] call BIS_fnc_taskAttack;
		[_spawnedGroup] call CHAB_fnc_setVehicleLock;

		_spawnedGroup deleteGroupWhenEmpty true;
		[_spawnedGroup] call CHAB_fnc_serverGroups;

		["attackHelis"] call _subTractPoints;
	};
	case "artillery": {
		private _pos = [_unitOrPosition] call _getSafePos;

		private _selectedRoadPos = getPos (selectRandom ([_pos,5000] call _getSafeRoads));

		([_selectedRoadPos, random 180, selectRandom _artilleryGroups, _side] call BIS_fnc_spawnVehicle) params ["_createdVehicle", "_crew", "_spawnedGroup"];

		[_createdVehicle] spawn {
			params ["_createdVehicle"];
			while {alive _createdVehicle} do {
				private _ammos = getArtilleryAmmo [_createdVehicle];
				if(count _ammos > 0) then {

					private _selectedPos = [0,0,0,0];
					private _ammo = selectRandom _ammos;
					{
						private _player = _x;
						private _pos = ASLToAGL (getPosASL _player);
						if(_pos inRangeOfArtillery [[_createdVehicle], _ammo]) exitWith {
							_selectedPos = _pos;
						};
					} forEach playableUnits;

					if(count _selectedPos != 4) then {
						_selectedPos = _selectedPos getPos [random 300,random 360];
						_createdVehicle commandArtilleryFire [_selectedPos, _ammo, round random[3,5,7]];
					};

				};
				sleep random [300, 450, 600];
			};
		};
		
		[_spawnedGroup] call CHAB_fnc_setVehicleLock;

		_spawnedGroup deleteGroupWhenEmpty true;
		[_spawnedGroup] call CHAB_fnc_serverGroups;

		["artillery"] call _subTractPoints;
	};
	case "groundTransport": { 
		private _pos = [_unitOrPosition] call _getSafePos;
		private _selectedRoadPos = getPos (selectRandom ([_pos] call _getSafeRoads));

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

		["groundTransport"] call _subTractPoints;
	};
	case "airTransport": {
		private _pos = [_unitOrPosition] call _getSafePos;
		
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

		["airTransport"] call _subTractPoints;
	};
	default { 

	};
};

[] spawn {
	sleep random [600, 900, 1200];
	CommanderActionUnderway = false;
};