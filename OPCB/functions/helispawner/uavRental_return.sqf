private _uid    = getPlayerUID player;
private _padPos = getMarkerPos "aircraft_spawner";
if (_padPos isEqualTo [0,0,0]) exitWith { hint "Marker 'aircraft_spawner' missing"; };

private _near = nearestObjects [_padPos, ["Air"], 40];
private _mine = _near findIf {
    private _v = _x;
    (_v getVariable ["OPCB_isRental", false]) &&
    ((_v getVariable ["OPCB_rentalOwner",""]) isEqualTo _uid)
};

if (_mine < 0) exitWith { hint "Bring your rented UAV to the pad to return it."; };

private _uav = _near select _mine;
[getPlayerUID player, netId _uav] remoteExecCall ["CHAB_fnc_uavRental_return_server", 2];
