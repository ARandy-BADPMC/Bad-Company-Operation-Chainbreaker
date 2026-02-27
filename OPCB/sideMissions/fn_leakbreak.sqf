if (isNil "CHAB_fnc_playerScale") then {
    CHAB_fnc_playerScale = { 1 };
};

private _taskID = format ["SM_TaskNumber_%1", SM_TaskNumber];

private _axis = worldSize / 2;
private _center = [_axis, _axis, 0];
private _locations = nearestLocations [_center, ["BorderCrossing", "NameLocal"], _axis];
private _missionPos = [0, 0, 0];

{
    private _loc = locationPosition _x;
    private _barns = nearestObjects [_loc, ["Land_Barn_01_brown_F","Land_Barn_02_F"], 200];
    if (count _barns > 0) then {
        private _barnPos = getPosATL (selectRandom _barns);
        private _roads = _barnPos nearRoads 100;
        if (count _roads > 0) exitWith {
            _missionPos = _barnPos;
        };
    };
} forEach (_locations apply { selectRandom _locations });

if (_missionPos isEqualTo [0,0,0]) then {
    {
        private _loc = locationPosition _x;
        private _houses = nearestObjects [_loc, ["House","House_Small"], 200];
        private _enterable = _houses select {
            count ([_x] call BIS_fnc_buildingPositions) > 0
        };
        if (count _enterable > 0) then {
            private _housePos = getPosATL (selectRandom _enterable);
            private _roads = _housePos nearRoads 100;
            if (count _roads > 0) exitWith {
                _missionPos = _housePos;
            };
        };
    } forEach (_locations apply { selectRandom _locations });
};

if (_missionPos isEqualTo [0,0,0]) exitWith {
    diag_log "Leak Break: No suitable barn or house location found.";
};

[
    _taskID,
    west,
    [
        "A spy has infiltrated our base and gathered critical intelligence. Intel reveals a meeting point in Mehland where the spy is about to report to the enemy high command. Eliminate the spy before the information is passed on. Expect bodyguards.",
        "Operation Leak Break"
    ],
    _missionPos,
    "AUTOASSIGNED",
    10,
    true,
    true,
    "kill",
    true
] call BIS_fnc_setTask;

[_taskID, _missionPos] call {
    params ["_taskID", "_missionPos"];

    private _flowerPot = createVehicle ["Land_FlowerPot_01_F", _missionPos, [], 0, "NONE"];
    _flowerPot hideObjectGlobal true;

    private _spyGroup = createGroup east;
    private _spy = _spyGroup createUnit ["UK3CB_TKA_O_OFF", getPos _flowerPot, [], 0, "NONE"];
    _spy setSkill 0.55;
    _spy setSkill ["spotDistance", 0.4];
    _spy setSkill ["spotTime", 0.5];
    _spy setSkill ["aimingAccuracy", 0.3];
    _spy setUnitPos "UP";

    private _guardGroup = createGroup east;
    private _livoniaUnits = [
        "UK3CB_LDF_I_RIF_1",
        "UK3CB_LDF_I_GL",
        "UK3CB_LDF_I_MG",
        "UK3CB_LDF_I_MK",
        "UK3CB_LDF_I_MED"
    ];

    for "_i" from 1 to 8 do {
        private _u = _guardGroup createUnit [selectRandom _livoniaUnits, _missionPos getPos [random 8, random 360], [], 0, "NONE"];
        _u setSkill 0.45;
        _u setSkill ["spotDistance", 0.6];
        _u setSkill ["spotTime", 0.5];
        _u setSkill ["aimingAccuracy", 0.35];
        _u setUnitPos "MIDDLE";
        _u setBehaviour "AWARE";
        _u setCombatMode "YELLOW";
    };

    private _patrolGroup = createGroup east;
    for "_i" from 1 to 6 do {
        private _p = _patrolGroup createUnit [selectRandom _livoniaUnits, _missionPos getPos [random [20,30,40], random 360], [], 0, "NONE"];
        _p setSkill 0.40;
        _p setSkill ["spotDistance", 0.5];
        _p setSkill ["spotTime", 0.45];
        _p setSkill ["aimingAccuracy", 0.3];
        _p setBehaviour "SAFE";
        _p setCombatMode "YELLOW";
    };
    [_patrolGroup, _missionPos, 50] call BIS_fnc_taskPatrol;

    waitUntil {
        sleep 3;
        !isNull _spy && {!alive _spy}
    };

    [_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;
    sleep 120;

    { deleteVehicle _x } forEach (units _guardGroup) + (units _patrolGroup) + [_spy, _flowerPot];
    deleteGroup _guardGroup;
    deleteGroup _patrolGroup;
    deleteGroup _spyGroup;
};
