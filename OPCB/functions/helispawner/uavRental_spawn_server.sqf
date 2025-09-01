params ["_ownerUID", "_classname"];
#include "..\..\data\uavRentalClassnames.sqf"


private _owner = objNull;
{ if (getPlayerUID _x == _ownerUID) exitWith { _owner = _x; }; } forEach allPlayers;


private _padPos = getMarkerPos "aircraft_spawner";
if (_padPos isEqualTo [0,0,0]) exitWith {
 };

// (optional) pad vehicles only
private _near = nearestObjects [_padPos, ["AllVehicles"], 7];
if (count _near > 0) exitWith {
    private _idx  = OPCB_uavRental_list findIf { toUpper (_x select 1) == toUpper _classname };
    private _cost = if (_idx >= 0) then { (OPCB_uavRental_list select _idx) select 2 } else { 0 };
    if (!isNull _owner) then { [_cost, "Pad blocked. Cost refunded."] remoteExec ["CHAB_fnc_uavRental_refund_client", _owner]; };
};


private _uav = createVehicle [_classname, _padPos, [], 0, "NONE"];
if (isNull _uav) exitWith {
    private _idx  = OPCB_uavRental_list findIf { toUpper (_x select 1) == toUpper _classname };
    private _cost = if (_idx >= 0) then { (OPCB_uavRental_list select _idx) select 2 } else { 0 };
    if (!isNull _owner) then { [_cost, "Spawn failed (classname/mod). Cost refunded."] remoteExec ["CHAB_fnc_uavRental_refund_client", _owner]; };
};

_uav setDir (markerDir "aircraft_spawner");
_uav setPosATL [_padPos#0, _padPos#1, 0.1];
createVehicleCrew _uav;

_uav setVariable ["OPCB_isRental", true, true];
_uav setVariable ["OPCB_rentalOwner", _ownerUID, true];
