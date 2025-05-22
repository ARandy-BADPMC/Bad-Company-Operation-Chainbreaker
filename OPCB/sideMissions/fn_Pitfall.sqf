if (isNil "CHAB_fnc_playerScale") then {
    CHAB_fnc_playerScale = { 1 };
};

private _taskID = format ["SM_TaskNumber_%1", SM_TaskNumber];

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
        "Intel suggests an enemy BRDM-2 was damaged and abandoned nearby. Retrieve the vehicle before opposing forces can reclaim or destroy it. Enemy patrols may still be active in the area. Make sure to repair it before returning — we want it ready to rejoin the fight for our cause!",
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

[_taskID, _missionPos] call {
    params ["_taskID", "_missionPos"];

    private _flowerPot = createVehicle ["Land_FlowerPot_01_F", _missionPos, [], 0, "NONE"];
    _flowerPot hideObjectGlobal true;

    private _vehicle = createVehicle ["UK3CB_LDF_B_BRDM2", _missionPos, [], 0, "NONE"];
    _vehicle setFuel 1;
    _vehicle setVariable ["BIS_enableRandomization", false, true];
    _vehicle setHitPointDamage ["HitEngine", 0.85];

    private _enemyGroup = createGroup resistance;

    for "_i" from 1 to 6 do {
        private _unit = _enemyGroup createUnit ["UK3CB_LDF_I_RIF_1", getPos _flowerPot, [], 0, "FORM"];
        _unit setUnitPos "MIDDLE";
        _unit setBehaviour "AWARE";
        _unit setCombatMode "YELLOW";
        _unit doMove (_missionPos getPos [random 10, random 360]);
    };

    _enemyGroup setBehaviour "AWARE";
    _enemyGroup setCombatMode "YELLOW";
    _enemyGroup setSpeedMode "LIMITED";
    _enemyGroup setFormation "STAG COLUMN";

    private _basePos = getMarkerPos "Delivery Point";

    private _done = false;
    private _failed = false;

    while {!_done && !_failed} do {
        sleep 5;

        if (isNull _vehicle || {!alive _vehicle}) then {
            _failed = true;
        };

        if (!_failed &&
            !isNull _vehicle &&
            alive _vehicle &&
            canMove _vehicle &&
            damage _vehicle < 0.2 &&
            (_vehicle getHitPointDamage "HitEngine") < 0.2 &&
            (_vehicle distance2D _basePos) < 30
        ) then {
            _done = true;
        };
    };

    if (_failed) then {
        [_taskID, "FAILED", true] call BIS_fnc_taskSetState;
    };

    if (_done) then {
        [_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;
    };
	    
sleep 4;
    { deleteVehicle _x } forEach (units _enemyGroup) + [_vehicle, _flowerPot];
    deleteGroup _enemyGroup;
};
