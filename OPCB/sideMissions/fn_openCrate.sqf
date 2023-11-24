
params ["_crate"];
private _chosen = selectRandom SM_Rewards;

private _cratePos = getPos _crate;
deleteVehicle _crate;

private _tank = createVehicle [_chosen, _cratePos, [], 0 , "CAN_COLLIDE"];

_tank call Hz_pers_API_addVehicle;

[_tank] call BADCO_fnc_skinApplier;
	