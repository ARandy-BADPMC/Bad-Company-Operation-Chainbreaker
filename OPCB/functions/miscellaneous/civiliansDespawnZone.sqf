params ["_trigger"];
if (!isServer || {isNull _trigger}) exitWith {};

private _civilians = _trigger getVariable ["OPCB_townCivilians", []];
{
    if (!isNull _x) then {
        private _jipId = _x getVariable ["OPCB_civActionJipId", ""];
        if (_jipId != "") then { remoteExecCall ["", 0, _jipId]; };
        deleteVehicle _x;
    };
} forEach _civilians;

private _group = _trigger getVariable ["OPCB_townCivGroup", grpNull];
if (!isNull _group) then { deleteGroup _group; };
_trigger setVariable ["OPCB_townCivilians", []];
_trigger setVariable ["OPCB_townCivGroup", grpNull];
