params ["_civilian", "_caller"];
if (!isServer || {isNull _civilian} || {isNull _caller}) exitWith {};
if (!alive _civilian || {!alive _caller} || {_caller distance _civilian > 4}) exitWith {};
if (_civilian getVariable ["OPCB_civTalkUsed", false]) exitWith {};

_civilian setVariable ["OPCB_civTalkUsed", true, true];
private _relation = missionNamespace getVariable ["OPCB_civRelation", 50];
if (_relation < 60) exitWith {
    [format ["The local refuses to help. Civilian trust: %1/100.", _relation]] remoteExec ["hint", owner _caller];
};

private _iedTypes = [
    "IEDLandBig_F",
    "IEDLandSmall_F",
    "IEDUrbanBig_F",
    "IEDUrbanSmall_F",
    "ACE_IEDUrbanSmall_Range",
    "ACE_IEDLandSmall_Range",
    "ACE_IEDUrbanBig_Range",
    "ACE_IEDLandBig_Range"
];
private _iedCandidates = allMines + (missionNamespace getVariable ["OPCB_scriptedIEDs", []]);
private _nearestIed = objNull;
private _iedDistance = 900;
{
    if (!isNull _x && {mineActive _x} && {((typeOf _x) in _iedTypes) || {_x getVariable ["OPCB_scriptedIED", false]}}) then {
        private _distance = _caller distance2D _x;
        if (_distance < _iedDistance) then {
            _nearestIed = _x;
            _iedDistance = _distance;
        };
    };
} forEach _iedCandidates;

private _nearestEnemy = objNull;
private _enemyDistance = 1200;
{
    if (alive _x && {side _x in [east, resistance]}) then {
        private _distance = _caller distance2D _x;
        if (_distance < _enemyDistance) then {
            _nearestEnemy = _x;
            _enemyDistance = _distance;
        };
    };
} forEach allUnits;

if (!isNull _nearestIed && {isNull _nearestEnemy || {_iedDistance <= _enemyDistance}}) then {
    private _position = getPosATL _nearestIed;
    private _marker = format ["OPCB_CivIEDIntel_%1_%2", floor serverTime, floor random 100000];
    createMarker [_marker, _position];
    _marker setMarkerType "mil_dot";
    _marker setMarkerColor "ColorYellow";
    _marker setMarkerText "Civilian IED tip";
    [format ["A local reports a possible IED at grid %1.", mapGridPosition _position]] remoteExec ["hint", owner _caller];
    [_marker] spawn {
        params ["_marker"];
        sleep 180;
        deleteMarker _marker;
    };
} else {
    if (!isNull _nearestEnemy) then {
        private _compassPoints = ["North", "North-East", "East", "South-East", "South", "South-West", "West", "North-West"];
        private _bearing = _caller getDir _nearestEnemy;
        private _direction = _compassPoints select (round (_bearing / 45) mod 8);
        [format ["A local reports hostile activity to the %1.", _direction]] remoteExec ["hint", owner _caller];
    } else {
        ["The local has no useful information right now."] remoteExec ["hint", owner _caller];
    };
};
