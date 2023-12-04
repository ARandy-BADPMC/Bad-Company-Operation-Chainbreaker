params ["_vehicle","_isAttack"];
_tankpos = getMarkerPos "tank_spawner";

_tank = createVehicle [_vehicle, _tankpos, [], 0 , "CAN_COLLIDE"];
_tank setdir (markerDir "tank_spawner");

_tank call Hz_pers_API_addVehicle;