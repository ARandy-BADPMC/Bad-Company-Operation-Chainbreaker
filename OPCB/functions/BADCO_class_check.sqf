params ["_unit", "_role", "_vehicle"];
private ["_jetPilotTypes", "_helicopterPilotTypes", "_tankDriverTypes"];

#include "..\data\vehicleDriverUnitTypes.sqf";

_unitType = typeOf _unit;
_attack = _unit getVariable ["SOAR",0];
_attackVehicle = count getPylonMagazines _vehicle;

if ((typeof _vehicle ==  "NonSteerable_Parachute_F") || {(typeof _vehicle == "Steerable_Parachute_F")}) exitWith {}; 

if (_role == "Driver") then 
{
	if (_vehicle isKindOf "Plane") exitWith {
		if !(_unitType in _jetPilotTypes) exitWith {
			_vehicle engineOn false;
			moveOut _unit;
			hint "You must be a jet pilot to fly this"
							
		};
	};
	if (_vehicle isKindOf "Helicopter") exitWith {		
		if !(_unitType in _helicopterPilotTypes) exitWith {
			_vehicle engineOn false;
			moveOut _unit;			
			hint "You must be a helicopter pilot to fly this";
		};
		if (_attackVehicle != 0 && {_attack == 0}) exitWith {
			_vehicle engineOn false;
			moveOut _unit;
			hint "You must be whitelisted to fly this";				
		};
	};
	if (_vehicle isKindOf "Tank") exitWith {
		if !(_unitType in _tankDriverTypes) exitWith {
			_vehicle engineOn false;
			moveOut _unit;
			hint "You must be an engineer to drive this";
		};			
	};
};
