params ["_vehicle"];

if(isNull _vehicle) exitWith{};

_vehicle addEventHandler ["GetIn",{
	params ["_vehicle","_seat", "_player" ];
	#include "..\..\data\vehicleDriverUnitTypes.sqf";
	if(_seat == "driver" ) then {
		if !(typeOf _player in _tankDriverTypes) then {
			moveOut _player;
		};
	};
}];

_vehicle addEventHandler ["SeatSwitched", {
	params ["_vehicle", "_unit1", "_unit2"];

	private _localSwitched = {
		params ["_unit", "_vehicle"];
		[_unit1, _vehicle] spawn {
			params ["_unit", "_vehicle"];

			#include "..\..\data\vehicleDriverUnitTypes.sqf";
			uiSleep 0.1;
			private _role = (assignedVehicleRole _unit) select 0;
				
			if (_role == "driver" && !((typeOf _unit) in _tankDriverTypes)) then {
				moveOut _unit; 
			};

		};
	}

	[_unit1, _vehicle] call _localSwitched;
	[_unit2, _vehicle] call _localSwitched;
}];

_vehicle addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];

	#include "..\..\data\vehicleDriverUnitTypes.sqf";
	
	if(_role != "driver" ) exitWith {};

	if !((typeOf _unit) in _tankDriverTypes) then {
		moveOut _unit; 
	};
}];
