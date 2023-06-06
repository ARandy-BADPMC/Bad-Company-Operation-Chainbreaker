params ["_marker"];

waitUntil 
{
	sleep 5;
  	playableUnits findIf { _x  distance2D _marker < 1000 } == -1
};

{
	{
		_vehicle = vehicle _x;
		if (_vehicle != _x) then {
			deleteVehicleCrew _vehicle;
			deleteVehicle _vehicle;
		};
		deletevehicle _x;
	} forEach units _x;
	deleteGroup _x;
} forEach EnemyGroups;

EnemyGroups = [];