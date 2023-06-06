params ["_vehicle"];

_vehicle addEventHandler ["GetIn",{
	params ["_vehicle","_seat", "_player" ]
	#include "..\..\data\vehicleDriverUnitTypes.sqf";
	if(_seat == "driver" ) then {
		if !(typeOf _player in _tankDriverTypes) then {
			moveOut _player;
		};
	};
}];
_vehicle addEventHandler ["Engine",{
	params ["_vehicle"];
	_pilot = driver _vehicle;

	#include "..\..\data\vehicleDriverUnitTypes.sqf";

	if (!(typeOf _player in _tankDriverTypes) || {isNull _pilot}) then {
		_vehicle engineOn false; 
	};
	
}];
