
params ["_taskobjective"];
private ["_radius","_currentTasknumber","_base","_selected"];

scopeName "OPCB_PMC_REQ";
_callerRE = remoteExecutedOwner;

_baseMarker = markerPos "base_marker";
_closeFriendlies = {(_baseMarker distance2d _x) < 1000 } count playableUnits;

private _minPlayersAtBase = missionNamespace getVariable ["OPCB_pmc_minPlayersAtBase", 2];

if (_closeFriendlies < _minPlayersAtBase && {isNil "_taskobjective"}) exitWith {
    (format ["At least %1 people are required to be at base to request a PMC mission!", _minPlayersAtBase]) remoteExec ["hint", _callerRE];
};

if (isNil "OPCB_pmc_nextMissionTime") then { OPCB_pmc_nextMissionTime = 0; publicVariable "OPCB_pmc_nextMissionTime"; };
if (isNil "_taskobjective") then {
    private _now = serverTime;
    if (_now < OPCB_pmc_nextMissionTime) then {
        "Sorry, I have no PMC task for you at the moment. Come back later" remoteExec ["hint", _callerRE];
        breakOut "OPCB_PMC_REQ";
    };
};

if (isNil "_taskobjective") then {
    _selected = "";
} else {
    _selected = _taskobjective;
};

if (!isNil "IsAPMCTaskRunning" && {IsAPMCTaskRunning}) exitWith {
    "This option is unavailable at the moment" remoteExec ["hint", _callerRE];
};

if (isNil "PMCTaskNumber") then { PMCTaskNumber = 0; publicVariable "PMCTaskNumber"; };

#include "..\data\pmc_tasks.sqf";

if (count _selected == 0) then {
    _selected = selectRandom (keys _pmcTasks);
};


PMCTaskNumber = PMCTaskNumber + 1;
_currentTasknumber = format ["PMC_Task_%1", PMCTaskNumber];

_radius = (_pmcTasks get _selected) select 0;
private _credits = (_pmcTasks get _selected) select 1;


if (_selected == "Convoy Intercept") then {
    _base = [0, 0, 0];
} else {
    _base = [_radius] call CHAB_fnc_findSpot;
};

IsAPMCTaskRunning = true;

private _nowCooldown = serverTime;
private _cooldownSeconds = 1800 + (random 900); 
OPCB_pmc_nextMissionTime = _nowCooldown + _cooldownSeconds;
publicVariable "OPCB_pmc_nextMissionTime";

switch (_selected) do {
    case "Prison Rescue" : {
        [_base, _currentTasknumber, _credits] call CHAB_fnc_PMC_PrisonRescue;
    };
    case "Grid Sweep" : {
        // Grid Sweep does not require a base position (it uses insurgency grid logic)
        [_currentTasknumber, _credits] call CHAB_fnc_GridSweep;
    };
    case "SAM Site" : {
        if (isNil "CHAB_fnc_PMC_SAMSite") exitWith {
            "SAM Site mission function is missing on this build." remoteExec ["hint", _callerRE];
        };
        [_base, _currentTasknumber, _credits] call CHAB_fnc_PMC_SAMSite;
    };
    case "Convoy Intercept" : {
        [_currentTasknumber, _credits] call CHAB_fnc_PMC_ConvoyIntercept;
    };
    default {
        "Failed to spawn a PMC task, try again" remoteExec ["hint", _callerRE];
    };
};

IsAPMCTaskRunning = false;
