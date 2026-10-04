params ["_laptop"];
if (isNull _laptop) exitWith {};
if (!hasInterface) exitWith {};

if (!isNil { _laptop getVariable "OPCB_prison_unlockActionId" }) exitWith {};

private _aid = _laptop addAction [
    "<t color='#ffd000'>Unlock prison doors</t>",
    {
        params ["_target", "_caller", "_actionId", "_args"];
        [_target] remoteExecCall ["CHAB_fnc_prisonUnlockDoors", 2];
    },
    nil,
    2,
    true,
    true,
    "",
    "(_this distance _target) < 3 && !(_target getVariable ['OPCB_prison_unlocked',false])"
];

_laptop setVariable ["OPCB_prison_unlockActionId", _aid, false];
