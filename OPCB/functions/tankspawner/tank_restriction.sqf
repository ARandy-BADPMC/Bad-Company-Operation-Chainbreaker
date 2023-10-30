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
	params ["_vehicle"];

	#include "..\..\data\vehicleDriverUnitTypes.sqf";

	_driver = driver _vehicle;
	
	if !((typeOf _driver) in _tankDriverTypes) then {
		moveOut _driver; 
	};
}];

_vehicle addEventHandler ["GetIn", {
	params ["_vehicle", "_role", "_unit", "_turret"];

	#include "..\..\data\vehicleDriverUnitTypes.sqf";
	
	if(_role != "driver" ) exitWith {};

	if !((typeOf _unit) in _tankDriverTypes) then {
		moveOut _unit; 
	};
}];
