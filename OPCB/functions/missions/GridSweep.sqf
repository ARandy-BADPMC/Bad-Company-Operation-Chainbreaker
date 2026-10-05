#include "..\..\insurgency\defines.sqf"

params ["_current_tasknumber", "_reward"];

private _parentTaskId = _current_tasknumber;

private _basePos = markerPos "base_marker";

private _houses = [CENTERPOS, AORADIUS, 3, true] call findHouses;
private _baseMarkerSize = (getMarkerSize "base_marker") select 0;

private _allGrids = [];
{
    private _gPos = _x call getGridPos;
    if ((_gPos distance2D _basePos) > _baseMarkerSize) then {
        _allGrids pushBackUnique (str _gPos);
    };
} forEach _houses;

private _candidates = _allGrids select {
    private _mkr = _x;
    private _mkrVar = format ["%1cleared", _mkr];
    private _isCleared = missionNamespace getVariable [_mkrVar, false];
    if (!isNil "Hz_pers_var_insurgencyClearedMarkers") then {
        _isCleared = _isCleared || {(_mkr in Hz_pers_var_insurgencyClearedMarkers)};
    };
    !_isCleared
};

if ((count _candidates) == 0) exitWith {
    [_parentTaskId, west,
        [
            "All grids on the map are currently green. No Grid Sweep objectives available at the moment.",
            "Operation Grid Sweep"
        ],
        _basePos,
        "FAILED",
        10,
        true,
        true,
        "move",
        true
    ] call BIS_fnc_setTask;

    ["No red grids available right now."] remoteExec ["hint"];
};

private _gridSweepRadius = missionNamespace getVariable ["OPCB_gridSweepRadius", 4000];

private _targetCount = 5 + floor (random 6);
_targetCount = _targetCount min (count _candidates);

private _anchorGrid = selectRandom _candidates;
private _anchorPos  = call compile _anchorGrid;

private _localCandidates = (_candidates - [_anchorGrid]) select {
    (call compile _x) distance2D _anchorPos <= _gridSweepRadius
};

private _maxPossible = 1 + (count _localCandidates);
_targetCount = _targetCount min _maxPossible;

private _selectedGrids = [_anchorGrid];
for "_i" from 2 to _targetCount do {
    private _pick = selectRandom _localCandidates;
    _localCandidates = _localCandidates - [_pick];
    _selectedGrids pushBack _pick;
};

private _playersNeeded = missionNamespace getVariable ["playersNeeded", 2];
private _desc = format [
    "Insurgency presence has been confirmed across the region. Your task is to clear %1 designated grids.\n\nReminder: a grid will only turn green when there are NO enemies in the grid and at least %2 players are inside it.",
    _targetCount,
    _playersNeeded
];

private _firstPos = call compile (_selectedGrids select 0);
    [_parentTaskId, west, [_desc, "Operation Grid Sweep"], _firstPos, "ASSIGNED", 10, true, true, "attack", true] call BIS_fnc_setTask;

private _gridTasks = [];
{
    private _idx = _forEachIndex + 1;
    private _gridMkrName = _x;
    private _gridPos = call compile _gridMkrName;

    private _subTaskId = format ["%1_grid_%2", _parentTaskId, _idx];
    _gridTasks pushBack [_subTaskId, _gridMkrName];

    [_subTaskId, west,
        [
            "Clear this grid: eliminate all enemy presence and hold players inside until it turns green.",
            format ["Clear Grid %1/%2", _idx, _targetCount]
        ],
        _gridPos,
        "CREATED",
        9,
        false,
        true,
        "attack",
        true
    ] call BIS_fnc_setTask;

} forEach _selectedGrids;

private _gridDone = createHashMap;
{ _gridDone set [_x, false]; } forEach _selectedGrids;

private _allDone = false;
while {!_allDone} do {
    sleep 5;

    private _doneCount = 0;

    {
        _x params ["_subTaskId", "_gridMkrName"];
        private _mkrVar = format ["%1cleared", _gridMkrName];
        private _isCleared = missionNamespace getVariable [_mkrVar, false];

        if (!isNil "Hz_pers_var_insurgencyClearedMarkers") then {
            _isCleared = _isCleared || {(_gridMkrName in Hz_pers_var_insurgencyClearedMarkers)};
        };

        private _wasDone = _gridDone get _gridMkrName;

        if (_isCleared) then {
            _doneCount = _doneCount + 1;
            if (!_wasDone) then {
                _gridDone set [_gridMkrName, true];
                [_subTaskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
            };
        } else {
            if (_wasDone) then {
                _gridDone set [_gridMkrName, false];
                [_subTaskId, "ASSIGNED", true] call BIS_fnc_taskSetState;
            };
        };

    } forEach _gridTasks;

    _allDone = (_doneCount >= _targetCount);
};

[_parentTaskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;

private _curCredits = missionNamespace getVariable ["OPCB_econ_credits", 0];
missionNamespace setVariable ["OPCB_econ_credits", _curCredits + _reward, true];

(format ["You earned %1 C for successfully completing Operation Grid Sweep!", _reward]) remoteExec ["hint"];

