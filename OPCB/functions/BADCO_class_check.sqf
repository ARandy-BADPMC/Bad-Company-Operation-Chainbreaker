params ["_role", "_vehicle"];
private ["_jetPilotTypes", "_helicopterPilotTypes", "_tankDriverTypes"];

#include "..\data\vehicleDriverUnitTypes.sqf";

_unitType = typeOf player;
_attackVehicle = count getPylonMagazines _vehicle;

if ((typeof _vehicle ==  "NonSteerable_Parachute_F") || {(typeof _vehicle == "Steerable_Parachute_F")}) exitWith {}; 

if (_role == "Driver") then 
{
	if (_vehicle isKindOf "Plane") exitWith {
		if !(_unitType in _jetPilotTypes) exitWith {
			_vehicle engineOn false;
			moveOut player;
			hint "You must be a jet pilot to fly this"
							
		};
	};
	if (_vehicle isKindOf "Helicopter") exitWith {		
		if !(_unitType in _helicopterPilotTypes) exitWith {
			_vehicle engineOn false;
			moveOut player;			
			hint "You must be a helicopter pilot to fly this";
		};
		_whiteListed = player getVariable ["WhiteListed", false];
		if (_attackVehicle != 0 && {!_whiteListed}) exitWith {
			_vehicle engineOn false;
			moveOut player;
			hint "You must be whitelisted to fly this";				
		};
	};
	if (_vehicle isKindOf "Tank") exitWith {
		if !(_unitType in _tankDriverTypes) exitWith {
			_vehicle engineOn false;
			moveOut player;
			hint "You must be an engineer to drive this";
		};			
	};
};
