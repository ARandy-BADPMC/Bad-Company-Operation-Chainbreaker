params ["_vehicle", "_isAttack"];
if(isNull _vehicle) exitWith{};

if(_isAttack ) exitWith {
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

