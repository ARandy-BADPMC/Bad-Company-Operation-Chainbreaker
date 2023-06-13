
params ["_group"];
private _vehicles = [];
{
	if(vehicle _x != _x) then {
		_vehicles pushBackUnique (vehicle _x);
	};
	
} forEach units _group;

{
	_x setVehicleLock "LOCKED";
	[_x] call CHAB_fnc_vehicleDeleteCheck;
} foreach _vehicles;
