params ["_trigger"];
if (!isServer || {isNull _trigger}) exitWith {};

private _existing = _trigger getVariable ["OPCB_townCivilians", []];
if ((_existing findIf {!isNull _x && {alive _x}}) >= 0) exitWith {};

private _center = getPosATL _trigger;
private _area = triggerArea _trigger;
private _radius = (_area select 0) max (_area select 1);
private _targetCount = (((floor (_radius / 200)) + 2) min 6) max 3;
private _civTypes = [
    "C_Man_1",
    "C_Man_2",
    "C_Man_3",
    "C_man_polo_1_F",
    "C_man_polo_2_F",
    "C_man_polo_3_F",
    "C_man_polo_4_F"
];
_civTypes = _civTypes select {isClass (configFile >> "CfgVehicles" >> _x)};
if (_civTypes isEqualTo []) exitWith {
    diag_log "[Civilians] No civilian classes are available.";
};

private _houses = nearestObjects [_center, ["House"], _radius] select {
    count (_x buildingPos -1) > 0
};
_houses = _houses call BIS_fnc_arrayShuffle;
private _spawnPositions = [];

{
    private _buildingPositions = _x buildingPos -1;
    if !(_buildingPositions isEqualTo []) then {
        _spawnPositions pushBack (selectRandom _buildingPositions);
    } else {
        private _position = [getPosATL _x, 0, 25, 3, 0, 0.3, 0] call BIS_fnc_findSafePos;
        if !(_position isEqualTo [0, 0, 0]) then { _spawnPositions pushBack _position; };
    };
    if (count _spawnPositions >= _targetCount) exitWith {};
} forEach _houses;

if (_spawnPositions isEqualTo []) then {
    for "_index" from 1 to 3 do {
        private _position = [_center, 0, (_radius min 100) max 25, 3, 0, 0.3, 0] call BIS_fnc_findSafePos;
        if !(_position isEqualTo [0, 0, 0]) then { _spawnPositions pushBack _position; };
    };
};

private _group = createGroup [civilian, false];
private _civilians = [];
{
    private _civilian = _group createUnit [selectRandom _civTypes, _x, [], 0, "NONE"];
    if (!isNull _civilian) then {
        _civilian setVariable ["OPCB_civTalkUsed", false, true];
        _civilian addEventHandler ["Killed", {
            params ["_civilian", "_killer", "_instigator"];
            private _source = if (isNull _instigator) then { _killer } else { _instigator };
            if (!isNull _source && {side _source == west}) then {
                OPCB_civLastHarmAt = serverTime;
                [-15] call CHAB_fnc_civRelationChange;
            };
        }];
        private _harm = {
            params ["_civilian", "_source", "_penalty"];
            if (isNull _source || {side group _source != west}) exitWith {};
            if (serverTime - (_civilian getVariable ["OPCB_civHarmAt", -1e6]) < 10) exitWith {};
            _civilian setVariable ["OPCB_civHarmAt", serverTime];
            OPCB_civLastHarmAt = serverTime;
            [_penalty] call CHAB_fnc_civRelationChange;
        };
        _civilian setVariable ["OPCB_civHarmFn", _harm];
        _civilian addEventHandler ["FiredNear", {
            params ["_civilian", "_firer"];
            if (alive _civilian && {(_firer aimedAtTarget [_civilian]) > 0.3}) then {
                [_civilian, _firer, -1] call (_civilian getVariable "OPCB_civHarmFn");
            };
        }];
        _civilian addEventHandler ["Hit", {
            params ["_civilian", "_source", "_damage", "_instigator"];
            [_civilian, if (isNull _instigator) then { _source } else { _instigator }, -3] call (_civilian getVariable "OPCB_civHarmFn");
        }];
        OPCB_townCivs = (missionNamespace getVariable ["OPCB_townCivs", []]) select {!isNull _x};
        OPCB_townCivs pushBack _civilian;
        _civilian setVariable ["OPCB_civHomeGroup", _group];
        private _jipId = format ["OPCB_CivTalk_%1", netId _civilian];
        _civilian setVariable ["OPCB_civActionJipId", _jipId];
        [_civilian] remoteExecCall ["CHAB_fnc_civiliansAddAction", 0, _jipId];
        _civilians pushBack _civilian;
    };
} forEach _spawnPositions;

if (_civilians isEqualTo []) exitWith { deleteGroup _group; };
_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";
[_group, _center, _radius min 250] call BIS_fnc_taskPatrol;
_trigger setVariable ["OPCB_townCivilians", _civilians];
_trigger setVariable ["OPCB_townCivGroup", _group];
{ [_x] call CHAB_fnc_civApplyTrustState; } forEach _civilians;
