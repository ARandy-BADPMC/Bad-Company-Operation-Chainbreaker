params ["_vehicle", ["_spawnMarker", "tank_spawner"]];
private _tankpos = markerPos _spawnMarker;

{
	if (!alive _x) then { deleteVehicle _x; };
} forEach (nearestObjects [_tankpos, ["StaticWeapon"], 7]);

_tank = createVehicle [_vehicle, _tankpos, [], 0 , "CAN_COLLIDE"];
_tank setDir (markerDir _spawnMarker);

_tank call Hz_pers_API_addVehicle;