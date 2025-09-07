params ["_vehicle"];
_boatpos = getPos boat_spawner;

_boat = createVehicle [_vehicle, _boatpos, [], 0 , "CAN_COLLIDE"];
_boat setdir (direction boat_spawner);

OPCB_Boats pushBackUnique _boat;
publicVariable "OPCB_Boats";

private _target = remoteExecutedOwner;
private _aliveBoats = { alive _x } count OPCB_Boats;
[format ["Boat delivered Slots left: %1", (12 - _aliveBoats) max 0]] remoteExec ["hint", _target];

// Flipflops - mark destruction + array cleanup
_boat addEventHandler ["Killed", { (_this select 0) setVariable ["OPCB_destroyed", true, true]; }];
_boat addEventHandler ["Deleted", {
    params ["_b"];
    OPCB_Boats = OPCB_Boats - [_b];
    publicVariable "OPCB_Boats";
}];

_boat call Hz_pers_API_addVehicle;

_boat addMPEventHandler ["MPKilled", {
    params ["_veh"];
    if (isServer && !(_veh getVariable ["OPCB_countedDown", false])) then {
        _veh setVariable ["OPCB_countedDown", true, true];
        MaxBoats = (MaxBoats - 1) max 0;
        publicVariable "MaxBoats";
    };
}];

[_boat] call BADCO_fnc_skinApplier;
