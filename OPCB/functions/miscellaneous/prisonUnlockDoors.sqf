params ["_laptop"];
if (!isServer) exitWith {};
if (isNull _laptop) exitWith {};

private _bld = _laptop getVariable ["OPCB_prison_building", objNull];
if (isNull _bld) exitWith {};

private _doorIdxs = _laptop getVariable ["OPCB_prison_doorIdxs", []];
if ((count _doorIdxs) == 0) then {
    private _doorCount = _laptop getVariable ["OPCB_prison_doorCount", 20];
    if (_doorCount <= 0) then { _doorCount = 20; };
    for "_i" from 1 to _doorCount do { _doorIdxs pushBack _i; };
};

{ _bld setVariable [format ["bis_disabled_Door_%1", _x], 0, true]; } forEach _doorIdxs;

[_bld] remoteExecCall ["CHAB_fnc_prisonPlayAlarm", 0];

_laptop setVariable ["OPCB_prison_unlocked", true, true];
missionNamespace setVariable ["OPCB_prison_unlocked", true, true];

private _taskId = _laptop getVariable ["OPCB_prison_taskId", ""]; 
private _deliveryPos = _laptop getVariable ["OPCB_prison_deliveryPos", [0,0,0]];
if (_taskId != "" && { !(_deliveryPos isEqualTo [0,0,0]) }) then {
    [_taskId, _deliveryPos] call BIS_fnc_taskSetDestination;
};

if (isNil "OPCB_prison_reinfStarted" || {!(missionNamespace getVariable ["OPCB_prison_reinfStarted", false])}) then {
    missionNamespace setVariable ["OPCB_prison_reinfStarted", true, true];

    private _delay = 360 + floor (random 241);
    private _targetPos = getPosATL _bld;

    [_delay, _targetPos] spawn {
        params ["_d", "_tPos"];
        sleep _d;

        private _ion = [
            "UK3CB_ION_I_Woodland_SF_TL",
            "UK3CB_ION_I_Woodland_SF_RIF_1",
            "UK3CB_ION_I_Woodland_SF_RIF_2",
            "UK3CB_ION_I_Woodland_SF_AR",
            "UK3CB_ION_I_Woodland_SF_MG",
            "UK3CB_ION_I_Woodland_SF_GL",
            "UK3CB_ION_I_Woodland_SF_MD",
            "UK3CB_ION_I_Woodland_SF_MK",
            "UK3CB_ION_I_Woodland_SF_LAT"
        ];

        private _valid = _ion select { isClass (configFile >> "CfgVehicles" >> _x) };
        if (count _valid == 0) exitWith {};

        private _grp = createGroup [resistance, true];
        private _count = 8 + floor (random 5);

        private _spawnPos = [_tPos, 450, 650, 10, 0, 0.4, 0] call BIS_fnc_findSafePos;
        if (_spawnPos isEqualTo [0,0,0]) then { _spawnPos = _tPos vectorAdd [600,0,0]; };

        for "_i" from 1 to _count do {
            private _u = _grp createUnit [selectRandom _valid, _spawnPos, [], 0, "NONE"];
            _u setSkill (0.6 + random 0.25);
            _u allowFleeing 0;
        };

        private _en = missionNamespace getVariable ["OPCB_prison_enemyUnits", []];
        _en append (units _grp);
        missionNamespace setVariable ["OPCB_prison_enemyUnits", _en, true];

        _grp setBehaviour "AWARE";
        _grp setSpeedMode "FULL";

        private _wp = _grp addWaypoint [_tPos, 0];
        _wp setWaypointType "SAD";
        _wp setWaypointCompletionRadius 30;
    };
};

"The prison doors have been unlocked grab the hostages and bring them back safely" remoteExec ["hint", 0];
