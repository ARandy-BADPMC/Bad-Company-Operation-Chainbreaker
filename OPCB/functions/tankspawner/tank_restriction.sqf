params ["_vehicle"];

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

	#include "..\..\data\vehicleDriverUnitTypes.sqf";

	{
		_role = assignedVehicleRole _x;
		
		if(_role isEqualTo ["driver"]) then {
			if !(typeOf _x in _tankDriverTypes) then {
				moveOut _x; 
			};
		};
	} forEach [_unit1, _unit2];
}];
