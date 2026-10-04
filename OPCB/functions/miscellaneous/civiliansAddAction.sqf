params ["_civilian"];
if (!hasInterface || {isNull _civilian} || {!alive _civilian}) exitWith {};
if (!isNil {_civilian getVariable "OPCB_civActionId"}) exitWith {};

private _actionId = _civilian addAction [
    "Ask about local threats",
    {
        params ["_target", "_caller"];
        [_target, _caller] remoteExecCall ["CHAB_fnc_civiliansTalk", 2];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "alive _target && {alive _this} && {_this distance _target < 3} && {!(_target getVariable ['OPCB_civTalkUsed', false])}",
    3,
    false,
    ""
];

_civilian setVariable ["OPCB_civActionId", _actionId];
