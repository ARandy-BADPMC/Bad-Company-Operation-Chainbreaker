params ["_ownerUID", "_vehNetId"];
#include "..\..\data\uavRentalClassnames.sqf"

private _veh = objectFromNetId _vehNetId;
if (isNull _veh) exitWith {};

private _okOwner = ((_veh getVariable ["OPCB_rentalOwner",""]) isEqualTo _ownerUID);
private _isRental = _veh getVariable ["OPCB_isRental", false];
if (!(_okOwner && _isRental)) exitWith {};

private _alive = alive _veh && (damage _veh < 1);
private _refund = 0;
if (_alive) then {
    private _idx = OPCB_uavRental_list findIf { toUpper (_x select 1) == toUpper typeOf _veh };
    _refund = if (_idx >= 0) then { (OPCB_uavRental_list select _idx) select 3 } else { 0 };
};

deleteVehicleCrew _veh; deleteVehicle _veh;

private _player = objNull;
{ if (getPlayerUID _x == _ownerUID) exitWith { _player = _x; }; } forEach allPlayers;

if (_alive) then {
    if (!isNull _player) then { [_refund, "UAV returned. Refund paid."] remoteExec ["CHAB_fnc_uavRental_refund_client", _player]; };
} else {
    if (!isNull _player) then { [0, "UAV destroyed. No refund."] remoteExec ["CHAB_fnc_uavRental_refund_client", _player]; };
};
