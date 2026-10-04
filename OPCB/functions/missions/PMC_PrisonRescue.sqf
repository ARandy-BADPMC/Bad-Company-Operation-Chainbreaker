params ["_base","_current_tasknumber", ["_reward", 0]];

if (!isServer) exitWith { _this remoteExec ["CHAB_fnc_PMC_PrisonRescue", 2]; };

private _taskId = format ["PMC_PrisonRescue_%1", _currentTasknumber];
private _taskTitle = "PMC: Prison Rescue";
private _taskDesc = "Hostages are being held in a prison camp. Use the PC to unlock the prison doors, then extract as many civilians as you can to the delivery point. Losses are acceptable, but every rescued hostage increases the payout.";

private _deliveryPos = markerPos "Delivery Point";

private _compName = "prison";
private _comp = [_compName, _base, [0,0,0], random 360, true, true] call LARs_fnc_spawnComp;
private _compObjs = [_comp] call LARs_fnc_getCompObjects;

private _prisonBld = objNull;
{
    if (typeOf _x == "Land_i_Barracks_V1_F") exitWith { _prisonBld = _x; };
} forEach _compObjs;

if (isNull _prisonBld) exitWith {
    diag_log "[PMC_PrisonRescue] ABORT: Prison building not found.";
    [ _comp ] call LARs_fnc_deleteComp;
};

private _doorIdxs = [];
for "_i" from 1 to 22 do { _doorIdxs pushBack _i; };

private _pc = objNull;
{
    if ((vehicleVarName _x) isEqualTo "Prison_unlockdoors") exitWith { _pc = _x; };
} forEach _compObjs;

if (isNull _pc) exitWith {
    diag_log "[PMC_PrisonRescue] ABORT: Could not find Prison_unlockdoors object in composition.";
    [ _comp ] call LARs_fnc_deleteComp;
};

{ _prisonBld setVariable [format ["bis_disabled_Door_%1", _x], 1, true]; } forEach _doorIdxs;
_prisonBld setVariable ["bis_disabled_Door_1", 0, true];
_prisonBld setVariable ["bis_disabled_Door_9", 0, true];

missionNamespace setVariable ["OPCB_prison_unlocked", false, true];
missionNamespace setVariable ["OPCB_prison_reinfStarted", false, true];
missionNamespace setVariable ["OPCB_prison_enemyUnits", [], true];

_pc setVariable ["OPCB_prison_building", _prisonBld, true];
_pc setVariable ["OPCB_prison_taskId", _taskId, true];
_pc setVariable ["OPCB_prison_deliveryPos", _deliveryPos, true];
_pc setVariable ["OPCB_prison_doorIdxs", _doorIdxs, true];
_pc setVariable ["OPCB_prison_doorCount", 22, true];

[_pc] remoteExecCall ["CHAB_fnc_prisonAddUnlockAction", 0, true];

private _pots = _compObjs select { typeOf _x == "Land_FlowerPot_01_F" };

private _pcPos = getPosATL _pc;
private _usablePots = _pots select { ((getPosATL _x) distance2D _pcPos) > 4 };

private _hostageCount = 10 + floor (random 6);
private _spawnAnchors = [];

if ((count _usablePots) > 0) then {
    _spawnAnchors = _usablePots call BIS_fnc_arrayShuffle;
    if (_hostageCount > (count _spawnAnchors)) then { _hostageCount = count _spawnAnchors; };
    _spawnAnchors = _spawnAnchors select [0, _hostageCount];
} else {
    private _bpos = [];
    for "_i" from 0 to 80 do {
        private _p = _prisonBld buildingPos _i;
        if !(_p isEqualTo [0,0,0]) then {
            if ((_p distance2D _pcPos) > 4) then { _bpos pushBack _p; };
        };
    };
    _bpos = _bpos call BIS_fnc_arrayShuffle;
    if (_hostageCount > (count _bpos)) then { _hostageCount = (count _bpos) max 5; };
    _spawnAnchors = _bpos select [0, _hostageCount];
};

private _civTypes = ["C_Man_1","C_Man_2","C_Man_3","C_Man_polo_1_F","C_Man_polo_2_F","C_Man_polo_3_F"];
private _validCivs = _civTypes select { isClass (configFile >> "CfgVehicles" >> _x) };
if ((count _validCivs) == 0) then { _validCivs = ["C_Man_1"]; };

private _civGrp = createGroup [civilian, true];
private _hostages = [];

{
    private _pos = if (_x isEqualType objNull) then { getPosATL _x } else { _x };
    private _u = _civGrp createUnit [selectRandom _validCivs, _pos, [], 0, "CAN_COLLIDE"];
    _u setDir (random 360);

    _u disableAI "MOVE";
    _u disableAI "PATH";
    _u setCaptive true;
    _u allowDamage true;
    _u setVariable ["OPCB_isHostage", true, true];
    _u setVariable ["OPCB_rescued", false, true];
    _u setVariable ["OPCB_processed", false, true];

    if (!isNil "ace_captives_fnc_setHandcuffed") then {
        [_u, true] call ace_captives_fnc_setHandcuffed;
    };

    _hostages pushBack _u;
} forEach _spawnAnchors;

private _guardTypes = [
    "UK3CB_LDF_I_TL",
    "UK3CB_LDF_I_SL",
    "UK3CB_LDF_I_RIF_1",
    "UK3CB_LDF_I_RIF_2",
    "UK3CB_LDF_I_GL",
    "UK3CB_LDF_I_AR",
    "UK3CB_LDF_I_MG",
    "UK3CB_LDF_I_LAT",
    "UK3CB_LDF_I_MD",
    "UK3CB_LDF_I_MK"
];
private _validGuards = _guardTypes select { isClass (configFile >> "CfgVehicles" >> _x) };
if ((count _validGuards) == 0) then { _validGuards = ["O_Soldier_F"]; };

private _guardCount = 10 + floor (random 5);
private _guardGrp = createGroup [resistance, true];
for "_i" from 1 to _guardCount do {
    private _spawnPos = [_base, 15, 90, 5, 0, 0.4, 0] call BIS_fnc_findSafePos;
    private _g = _guardGrp createUnit [selectRandom _validGuards, _spawnPos, [], 0, "NONE"];
    _g setSkill (0.5 + random 0.3);
    _g allowFleeing 0;
};
[_guardGrp, _base, 80] call BIS_fnc_taskPatrol;

missionNamespace setVariable ["OPCB_prison_enemyUnits", (units _guardGrp), true];

[_taskId, west, [_taskDesc, _taskTitle], _base, "ASSIGNED", 10, true, true, "run", true] call BIS_fnc_setTask;

private _total = (count _hostages) max 1;
private _maxPayout = 200;
private _baseValue = floor (_maxPayout / _total);
private _remainder = _maxPayout - (_baseValue * _total);
private _rescued = 0;
private _dead = 0;
private _creditsEarned = 0;

while {true} do {
    sleep 2;

    private _unlocked = missionNamespace getVariable ["OPCB_prison_unlocked", false];

    private _processed = 0;

    {
        private _h = _x;
        if (isNull _h) then { _processed = _processed + 1; } else {
            if (_h getVariable ["OPCB_processed", false]) then {
                _processed = _processed + 1;
            } else {
                if (!alive _h) then {
                    _h setVariable ["OPCB_processed", true, true];
                    _dead = _dead + 1;
                    _processed = _processed + 1;
                } else {
                    if (_unlocked) then {
                        private _p = if (vehicle _h != _h) then { getPosATL (vehicle _h) } else { getPosATL _h };
                        if ((_p distance2D _deliveryPos) <= 15) then {
                            private _value = _baseValue;
                            if (_remainder > 0) then { _value = _value + 1; _remainder = _remainder - 1; };

                            if (isNil "OPCB_econ_credits") then { OPCB_econ_credits = 0; };
                            OPCB_econ_credits = OPCB_econ_credits + _value;
                            publicVariable "OPCB_econ_credits";

                            _rescued = _rescued + 1;
                            _creditsEarned = _creditsEarned + _value;

                            (format ["Hostage rescued! +%1 credits (%2/%3)", _value, _rescued, _total]) remoteExec ["hint", 0];

                            _h setVariable ["OPCB_processed", true, true];
                            deleteVehicle _h;
                            _processed = _processed + 1;
                        };
                    };
                };
            };
        };
    } forEach _hostages;

    if (_processed >= _total) exitWith {};
};

if (_rescued > 0) then {
    [_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
    (format ["Prison Rescue complete. Rescued %1/%2 hostages (%3 KIA). Earned %4 credits.", _rescued, _total, _dead, _creditsEarned]) remoteExec ["hint", 0];
} else {
    [_taskId, "FAILED", true] call BIS_fnc_taskSetState;
    (format ["Prison Rescue failed. Rescued 0/%1 hostages and earned %2 credits.", _total, _creditsEarned]) remoteExec ["hint", 0];
};

[_comp] spawn {
    params ["_c"];
    sleep 90;

    private _en = missionNamespace getVariable ["OPCB_prison_enemyUnits", []];
    { if (!isNull _x) then { deleteVehicle _x; }; } forEach _en;
    missionNamespace setVariable ["OPCB_prison_enemyUnits", [], true];

    [ _c ] call LARs_fnc_deleteComp;
};
