if (isNil "CHAB_fnc_playerScale") then {
    CHAB_fnc_playerScale = { 1 };
};

private _missionPos = if (!isNil "CHAB_fnc_findSpot") then {
    [150] call CHAB_fnc_findSpot;
} else {
    [
        [worldSize / 2, worldSize / 2, 0],
        0,
        worldSize / 2,
        15,
        0,
        0.2,
        0
    ] call BIS_fnc_findSafePos
};

private _taskId = format ["SM_TaskNumber_%1", SM_TaskNumber];
private _taskDesc = "A frontline medical station has come under attack. Several wounded soldiers are trapped inside and require immediate evacuation. Secure the area, treat them, and transport them to the Delivery Point.";
[_taskId, west, [_taskDesc, "Medical Emergency"], _missionPos, "AUTOASSIGNED", 10, true, true, "", true] call BIS_fnc_setTask;
[_taskId] spawn {
    params ["_tid"];
    sleep 1;
    [_tid, "medevac"] call BIS_fnc_taskSetType;
};

[_taskId, _missionPos] call {
    params ["_taskId", "_missionPos"];

    private _comp = objNull;
    if (!isNil "LARs_fnc_spawnComp") then {
        _comp = ["peacekeeper", _missionPos, [0,0,0], random 360, true, true] call LARs_fnc_spawnComp;
    };
    if (isNil "_comp" || {isNull _comp}) then {
        _comp = createVehicle ["Land_Cargo_HQ_V1_F", _missionPos, [], 0, "NONE"];
    };

    private _woundedGroup = createGroup civilian;
    private _woundedUnits = [];
    private _uniforms = [
        "U_B_CombatUniform_mcam",
        "U_B_CombatUniform_mcam_worn",
        "U_B_CombatUniform_mcam_tshirt",
        "U_B_CombatUniform_mcam_vest"
    ];

    for "_i" from 1 to 4 do {
        private _pos = _missionPos getPos [random [5, 8, 12], random 360];
        _pos set [2, 0];

        private _unit = _woundedGroup createUnit ["C_man_polo_1_F", _pos, [], 0, "NONE"];
        removeAllWeapons _unit;
        removeAllItems _unit;
        removeAllAssignedItems _unit;
        removeVest _unit;
        removeHeadgear _unit;
        _unit forceAddUniform (selectRandom _uniforms);
        _unit setCaptive true;

        _unit disableAI "MOVE";
        _unit disableAI "PATH";
        _unit disableAI "AUTOCOMBAT";
        _unit disableAI "TARGET";

        [_unit, 0.35, "leg_r", "bullet"] call ace_medical_fnc_addDamageToUnit;
        [_unit, 0.35, "leg_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
        [_unit, 0.35, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
        [_unit, 0.15, "head", "bullet"] call ace_medical_fnc_addDamageToUnit;
        [_unit, 0.35, "hand_r", "bullet"] call ace_medical_fnc_addDamageToUnit;
        [_unit, 0.35, "hand_l", "bullet"] call ace_medical_fnc_addDamageToUnit;

        [_unit, true] call ace_medical_fnc_setUnconscious;
        _unit setVariable ["ace_medical_statemachine_permanentUnconscious", true, true];
        [_unit] spawn {
            params ["_cas"];
            while {alive _cas && !(_cas getVariable ["medevac_safe", false])} do {
                if !(lifeState _cas isEqualTo "INCAPACITATED") then {
                    [_cas, true] call ace_medical_fnc_setUnconscious;
                };
                _cas setVariable ["ace_medical_statemachine_permanentUnconscious", true, true];
                sleep 5;
            };
        };

        private _blood = createVehicle ["BloodPool_01_Large_New_F", getPosATL _unit, [], 0, "CAN_COLLIDE"];
        _blood setVectorUp [0,0,1];

        _unit setVariable ["medevac_safe", false];
        _woundedUnits pushBack _unit;
    };

    for "_i" from 1 to 2 do {
        private _pos = _missionPos getPos [random [6, 12, 16], random 360];
        _pos set [2, 0];
        private _deadMedic = createVehicle ["B_medic_F", _pos, [], 0, "NONE"];
        _deadMedic setDamage 1;
        private _blood = createVehicle ["BloodPool_01_Large_New_F", getPosATL _deadMedic, [], 0, "CAN_COLLIDE"];
        _blood setVectorUp [0,0,1];
    };

    private _enemyGroup = createGroup east;
    private _enemyTypes = [
        "UK3CB_LDF_I_RIF_1",
        "UK3CB_LDF_I_GL",
        "UK3CB_LDF_I_MG",
        "UK3CB_LDF_I_MK",
        "UK3CB_LDF_I_MED"
    ];
    private _spawnDist = 180;
    private _enemySpawnPos = _missionPos getPos [_spawnDist, random 360];

    for "_i" from 1 to 10 do {
        private _type = selectRandom _enemyTypes;
        private _posE = _enemySpawnPos getPos [random 10, random 360];
        private _unit = _enemyGroup createUnit [_type, _posE, [], 0, "NONE"];

        _unit setSkill 0.55;
        _unit setSkill ["aimingAccuracy", 0.20];
        _unit setSkill ["aimingSpeed", 0.20];
        _unit setSkill ["aimingShake", 0.15];
        _unit setSkill ["commanding", 1.00];
        _unit setSkill ["courage", 0.65];
        _unit setSkill ["spotDistance", 0.20];
        _unit setSkill ["spotTime", 0.20];
        _unit setSkill ["reloadSpeed", 1.00];
    };
    _enemyGroup setBehaviour "AWARE";
    _enemyGroup setCombatMode "YELLOW";
    _enemyGroup move _missionPos;

    private _deliveryPoint = getMarkerPos "Delivery Point";
    private _complete = false;
    private _failed = false;

    while {!_complete && !_failed} do {
        sleep 5;
        if ({(!alive _x && !(_x getVariable ["medevac_safe", false]))} count _woundedUnits > 0) then {
            _failed = true;
        };
        if (!_failed && { alive _x && (_x distance2D _deliveryPoint) < 10 } count _woundedUnits == count _woundedUnits) then {
            _complete = true;
        };
    };

    if (_failed) then {
        [_taskId, "FAILED", true] call BIS_fnc_taskSetState;
    };
    if (_complete) then {
        { _x setVariable ["medevac_safe", true]; } forEach _woundedUnits;
        [_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
    };

    { deleteVehicle _x } forEach _woundedUnits;

    sleep 120;
    { deleteVehicle _x } forEach (units _enemyGroup);
    deleteGroup _enemyGroup;

    if (!isNull _comp) then {
        if (_comp isEqualType objNull) then {
            deleteVehicle _comp;
        } else {
            [_comp] spawn {
                params ["_comp"];
                sleep 120;
                [_comp] call LARs_fnc_deleteComp;
            };
        }
    };
};
