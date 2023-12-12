params ["_vehicle", "_isAttack"];
if(isNull _vehicle) exitWith{};

if(_isAttack ) exitWith {
	_vehicle addEventHandler ["GetIn",{
		params ["_vehicle","_seat","_player"];

		#include "..\..\data\vehicleDriverUnitTypes.sqf";
		private _playerType = typeof _player;

		_whiteListed = _player getVariable ["WhiteListed", false];
		if (_vehicle isKindOf "Plane" && {_seat == "driver"} && { !(_playerType in _jetPilotTypes)}) exitWith {
			moveOut _player;
			_vehicle engineOn false;
		};
	}];

	_vehicle addEventHandler ["SeatSwitched", {
		params ["_vehicle", "_unit1", "_unit2"];

		private _localSwitched = {
			params ["_unit", "_vehicle"];
			[_unit, _vehicle] spawn {
				params ["_unit", "_vehicle"];

				#include "..\..\data\vehicleDriverUnitTypes.sqf";
				uiSleep 0.1;
				private _role = (assignedVehicleRole _unit) select 0;
				private _playerType = typeof _unit;
					
				if (_role == "driver" && {!(_playerType in _jetPilotTypes)}) then {
					moveOut _unit; 
				};

			};
		};

		[_unit1, _vehicle] call _localSwitched;
		[_unit2, _vehicle] call _localSwitched;
	}];
};
if (typeof _vehicle != "B_UAV_02_dynamicLoadout_f") exitWith {
	_vehicle addEventHandler ["GetIn",{
		#include "..\..\data\vehicleDriverUnitTypes.sqf";
		params ["_vehicle", "_seat", "_player"];
		private _playerType = typeof _player;

		if(_seat == "driver" && { !(_playerType in _helicopterPilotTypes)}) exitWith {
			moveOut _player;
		};
	}];

	_vehicle addEventHandler ["SeatSwitched", {
		params ["_vehicle", "_unit1", "_unit2"];

		private _localSwitched = {
			params ["_unit", "_vehicle"];
			[_unit, _vehicle] spawn {
				params ["_unit", "_vehicle"];

				#include "..\..\data\vehicleDriverUnitTypes.sqf";
				uiSleep 0.1;
				private _role = (assignedVehicleRole _unit) select 0;
				private _playerType = typeof _unit;
					
				if (_role == "driver" && {!(_playerType in _helicopterPilotTypes)}) then {
					moveOut _unit; 
				};

			};
		};

		[_unit1, _vehicle] call _localSwitched;
		[_unit2, _vehicle] call _localSwitched;
	}];
};

