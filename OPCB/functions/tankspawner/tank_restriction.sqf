params ["_vehicle"];

if(isNull _vehicle) exitWith{};

_vehicle addEventHandler ["SeatSwitched", {
	params ["_vehicle", "_unit1", "_unit2"];

	private _localSwitched = {
		params ["_unit", "_vehicle"];
		[_unit, _vehicle] spawn {
			params ["_unit", "_vehicle"];

			#include "..\..\data\vehicleDriverUnitTypes.sqf";
			uiSleep 0.1;
			private _role = (assignedVehicleRole _unit) select 0;
				
			if (_role == "driver" && !((typeOf _unit) in _tankDriverTypes)) then {
				moveOut _unit; 
			};

		};
	};

	[_unit1, _vehicle] call _localSwitched;
	[_unit2, _vehicle] call _localSwitched;
}];
