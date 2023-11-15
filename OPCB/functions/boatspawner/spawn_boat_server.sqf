params ["_vehicle"];
_boatpos = getPos boat_spawner;

_boat = createVehicle [_vehicle, _boatpos, [], 0 , "CAN_COLLIDE"];
_boat setdir (direction boat_spawner);

_boat call Hz_pers_API_addVehicle;

_boat addMPEventHandler ["MPKilled",
{
	if(isServer) then {
		MaxBoats = MaxBoats - 1;
		publicVariable "MaxAPC";
	};
}];
[_boat] call BADCO_fnc_skinApplier;