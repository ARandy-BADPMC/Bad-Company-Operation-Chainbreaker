if (isNil "CHAB_fnc_playerScale") then {
    CHAB_fnc_playerScale = { 1 };
};

private _missionPos = if (!isNil "CHAB_fnc_findSpot") then {
    [150] call CHAB_fnc_findSpot;
} else {
    [[worldSize / 2, worldSize / 2, 0], 0, worldSize / 2, 15, 0, 0.2, 0] call BIS_fnc_findSafePos
};

private _taskId = format ["SM_TaskNumber_%1", SM_TaskNumber];
private _taskDesc = "A frontline medical station has come under attack. Several wounded soldiers are trapped inside and require immediate evacuation. Secure the area, treat them, and transport them to the Delivery Point.";
[_taskId, west, [_taskDesc, "Medical Emergency"], _missionPos, "AUTOASSIGNED", 10, true, true, "medevac", true] call BIS_fnc_setTask;


private _flowerPot = createVehicle ["Land_FlowerPot_01_F", _missionPos, [], 0, "NONE"];
_flowerPot hideObjectGlobal true;


private _compObjects = ["peacekeeper", _missionPos, [0,0,0], random 360, true, true] call LARs_fnc_spawnComp;
if (isNil "_compObjects" || {count _compObjects == 0}) then {
    diag_log "WARNING: Peacekeeper composition failed to spawn!";
};


private _crewGroup = createGroup west;
{
    private _pos = _flowerPot getPos [5 + random 10, random 360];
    _pos set [2, 0];
    private _dead = _crewGroup createUnit [_x, _pos, [], 0, "NONE"];
    _dead setDamage 1; 
} forEach [
    "rhsusf_usmc_marpat_wd_rifleman",
    "rhsusf_usmc_marpat_wd_grenadier",
    "rhsusf_usmc_marpat_wd_autorifleman",
    "rhsusf_usmc_marpat_wd_teamleader"
];


private _woundedGroup = createGroup civilian;
private _woundedUnits = [];
for "_i" from 1 to 4 do {
    private _pos = _flowerPot getPos [3 + random 5, random 360];
    _pos set [2, 0];

    private _unit = _woundedGroup createUnit ["C_man_polo_1_F", _pos, [], 0, "NONE"];
    removeAllWeapons _unit; removeAllItems _unit; removeAllAssignedItems _unit;
    _unit forceAddUniform selectRandom [
        "U_B_CombatUniform_mcam",
        "U_B_CombatUniform_mcam_worn",
        "U_B_CombatUniform_mcam_tshirt",
        "U_B_CombatUniform_mcam_vest"
    ];
    _unit setCaptive true;
    _unit disableAI "MOVE";
    _unit disableAI "PATH";
    _unit disableAI "AUTOCOMBAT";
    _unit disableAI "TARGET";

    [_unit, 0.35, "leg_r", "bullet"] call ace_medical_fnc_addDamageToUnit;
    [_unit, 0.35, "leg_l", "bullet"] call ace_medical_fnc_addDamageToUnit;
    [_unit, 0.35, "body", "bullet"] call ace_medical_fnc_addDamageToUnit;
    [_unit, 0.15, "head", "bullet"] call ace_medical_fnc_addDamageToUnit;
    [_unit, true] call ace_medical_fnc_setUnconscious;
    _unit setVariable ["ace_medical_statemachine_permanentUnconscious", true, true];
    _unit setVariable ["medevac_safe", false];

   
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

    _woundedUnits pushBack _unit;
};


private _enemyGroup = createGroup east;
private _enemySpawnPos = _missionPos getPos [300, random 360];
for "_i" from 1 to 8 do {
    private _unit = _enemyGroup createUnit [
        selectRandom [
            "UK3CB_LDF_I_RIF_1",
            "UK3CB_LDF_I_GL",
            "UK3CB_LDF_I_MG",
            "UK3CB_LDF_I_MK",
            "UK3CB_LDF_I_MED"
        ],
        _enemySpawnPos getPos [random 10, random 360], [], 0, "NONE"
    ];
    _unit setSkill 0.55;
};
_enemyGroup setBehaviour "AWARE";
_enemyGroup setCombatMode "YELLOW";
_enemyGroup move _missionPos;


private _deliveryPoint = getMarkerPos "Delivery Point";
private _complete = false;
private _failed = false;

while {!_complete && !_failed} do {
    sleep 5;
    if ({ (!alive _x && !(_x getVariable ["medevac_safe", false])) } count _woundedUnits > 0) then {
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


sleep 120;
{ deleteVehicle _x } forEach _woundedUnits + (units _enemyGroup) + [_flowerPot];
deleteGroup _crewGroup;
deleteGroup _enemyGroup;
if (!isNil "_compObjects" && {count _compObjects > 0}) then {
    [_compObjects] call LARs_fnc_deleteComp;
};
