if (isNil "CHAB_fnc_playerScale") then {
    CHAB_fnc_playerScale = { 1 };
};

private _taskID = format ["task_pitfall_%1", round random 9999];

private _axis = worldSize / 2;
private _center = [_axis, _axis, 0];
private _locations = nearestLocations [_center, ["Hill", "ViewPoint", "NameVillage", "NameLocal"], _axis];

private _missionPos = [0, 0, 0];

{
    private _loc = locationPosition _x;
    private _roads = _loc nearRoads 500;
    if (count _roads > 0) exitWith {
        _missionPos = getPos (selectRandom _roads);
    };
} forEach (_locations apply { selectRandom _locations });

if (_missionPos isEqualTo [0,0,0]) exitWith {
    diag_log "Pitfall: No suitable road-adjacent location found.";
};

[
    _taskID,
    west,
    [
        "Intel suggests an enemy BMP-2 was damaged nearby. Retrieve it. Enemy patrols may still be close.",
        "Operation Pitfall"
    ],
    _missionPos,
    "AUTOASSIGNED",
    10,
    true,
    true,
    "repair",
    true
] call BIS_fnc_setTask;


private _flowerPot = createVehicle ["Land_FlowerPot_01_F", _missionPos, [], 0, "NONE"];
_flowerPot hideObjectGlobal true;


private _vehicle = createVehicle ["UK3CB_LSM_O_BMP2", _missionPos, [], 0, "NONE"];
_vehicle setFuel 1;
_vehicle setVariable ["BIS_enableRandomization", false, true];
_vehicle setHitPointDamage ["HitEngine", 0.85]; // Disable engine

private _enemyGroup = createGroup resistance;

for "_i" from 1 to 6 do {
    private _unit = _enemyGroup createUnit ["UK3CB_LDF_I_RIF_1", getPos _flowerPot, [], 0, "FORM"];
    _unit setUnitPos "MIDDLE";
    _unit setBehaviour "AWARE";
    _unit setCombatMode "YELLOW";
    _unit doMove (_missionPos getPos [random 10, random 360]); // move around BMP
};

_enemyGroup setBehaviour "AWARE";
_enemyGroup setCombatMode "YELLOW";
_enemyGroup setSpeedMode "LIMITED";
_enemyGroup setFormation "STAG COLUMN";


private _failThread = [_taskID, _vehicle, _enemyGroup, _flowerPot] spawn {
    params ["_taskID", "_vehicle", "_enemyGroup", "_flowerPot"];
    while { true } do {
        sleep 5;
        if (isNull _vehicle || !alive _vehicle) exitWith {
            [_taskID, "FAILED", true] call BIS_fnc_taskSetState;
            { deleteVehicle _x } forEach (units _enemyGroup) + [_flowerPot];
            deleteGroup _enemyGroup;
        };
    };
};


[_taskID, _vehicle, _enemyGroup, _flowerPot, _failThread] call {
    params ["_taskID", "_vehicle", "_enemyGroup", "_flowerPot", "_failThread"];

    waitUntil {
        sleep 5;
        !isNull _vehicle && {alive _vehicle} &&
        canMove _vehicle &&
        damage _vehicle < 0.2 &&
        (_vehicle getHitPointDamage "HitEngine") < 0.2
    };

    hint "The BMP-2 is fully operational — bring it back!";

    private _basePos = getMarkerPos "Delivery Point";

    waitUntil {
        sleep 5;
        (!isNull _vehicle && alive _vehicle) &&
        (_vehicle distance2D _basePos) < 30 &&
        canMove _vehicle &&
        damage _vehicle < 0.2 &&
        (_vehicle getHitPointDamage "HitEngine") < 0.2
    };

    terminate _failThread;
    [_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;


    sleep 4;
    { deleteVehicle _x } forEach (units _enemyGroup) + [_vehicle, _flowerPot];
    deleteGroup _enemyGroup;
};
