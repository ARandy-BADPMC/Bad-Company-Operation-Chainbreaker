if (isNil "CHAB_fnc_playerScale") then {
    CHAB_fnc_playerScale = { 1 };
};

private _taskID = format ["task_deadLoad_%1", round random 9999];

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
    diag_log "Dead Load: No suitable road-adjacent location found.";
};

[_taskID, west, [
    "A friendly M1220 has broken down. Repair it and return it to the delivery point.",
    "Operation Dead Load"
], _missionPos, "AUTOASSIGNED", 10, true, true, "repair", true] call BIS_fnc_setTask;

private _flowerPot = createVehicle ["Land_FlowerPot_01_F", _missionPos, [], 0, "NONE"];
_flowerPot hideObjectGlobal true;

private _vehicle = createVehicle ["rhsusf_M1220_M2_usarmy_d", _missionPos, [], 0, "NONE"];
_vehicle setFuel 1;
_vehicle setHitPointDamage ["HitEngine", 0.85];
_vehicle setHitPointDamage ["HitLFWheel", 1];
_vehicle setHitPointDamage ["HitRFWheel", 1];

private _crewGroup = createGroup west;
private _crewUnit1 = _crewGroup createUnit ["rhsusf_army_ocp_rifleman", _missionPos getPos [5, 90], [], 0, "NONE"];
private _crewUnit2 = _crewGroup createUnit ["rhsusf_army_ocp_rifleman", _missionPos getPos [5, 270], [], 0, "NONE"];

{
    _x setUnitPos "MIDDLE";
    _x setBehaviour "COMBAT";
    _x setCombatMode "YELLOW";
    _x doWatch (_missionPos getPos [50, random 360]);
} forEach [_crewUnit1, _crewUnit2];

[_flowerPot, resistance, 1, 0, 0, 0, false] call CHAB_fnc_enemySpawner;

private _failThread = [_taskID, _vehicle, _crewGroup, _flowerPot] spawn {
    params ["_taskID", "_vehicle", "_crewGroup", "_flowerPot"];
    while { true } do {
        sleep 5;
        if (isNull _vehicle || !alive _vehicle) exitWith {
            [_taskID, "FAILED", true] call BIS_fnc_taskSetState;
            { deleteVehicle _x } forEach (units _crewGroup) + [_flowerPot];
            deleteGroup _crewGroup;
        };
    };
};

[_taskID, _vehicle, _crewGroup, _flowerPot, _failThread] call {
    params ["_taskID", "_vehicle", "_crewGroup", "_flowerPot", "_failThread"];

    waitUntil {
        sleep 5;
        !isNull _vehicle && {alive _vehicle} &&
        canMove _vehicle &&
        damage _vehicle < 0.2 &&
        (_vehicle getHitPointDamage "HitEngine") < 0.2 &&
        (_vehicle getHitPointDamage "HitLFWheel") < 0.1 &&
        (_vehicle getHitPointDamage "HitRFWheel") < 0.1
    };

    hint "Vehicle fully operational — return it to the delivery point!";

    private _basePos = getMarkerPos "Delivery Point";

    waitUntil {
        sleep 5;
        (!isNull _vehicle && alive _vehicle) &&
        (_vehicle distance2D _basePos) < 30 &&
        canMove _vehicle &&
        damage _vehicle < 0.2 &&
        (_vehicle getHitPointDamage "HitEngine") < 0.2 &&
        (_vehicle getHitPointDamage "HitLFWheel") < 0.1 &&
        (_vehicle getHitPointDamage "HitRFWheel") < 0.1
    };

    terminate _failThread;
    [_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;

    OPCB_econ_credits = OPCB_econ_credits + 80;
    publicVariable "OPCB_econ_credits";
    format ["You earned %1 C for completing Operation Dead Load!", 80] remoteExec ["hint"];

    sleep 4;
    { deleteVehicle _x } forEach (units _crewGroup) + [_vehicle, _flowerPot];
    deleteGroup _crewGroup;
};
