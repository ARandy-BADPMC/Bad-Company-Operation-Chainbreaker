params ["_vehicle","_isAttack"];
_tankpos = getMarkerPos "tank_spawner";

_tank = createVehicle [_vehicle, _tankpos, [], 0 , "CAN_COLLIDE"];
_tank setdir (markerDir "tank_spawner");

if (_isAttack) then {
    OPCB_MBTs pushBackUnique _tank; publicVariable "OPCB_MBTs";
    _tank setVariable ["OPCB_counterKey", "MaxTanks", true];
} else {
    OPCB_APCs pushBackUnique _tank; publicVariable "OPCB_APCs";
    _tank setVariable ["OPCB_counterKey", "MaxAPC", true];
};


private _buyerID = remoteExecutedOwner;
if (_isAttack) then {
    [format ["Vehicle delivered - Slots left: %1", (1 - (count OPCB_MBTs)) max 0]] remoteExec ["hint", _buyerID];
};

// Flipflops - mark destruction flag
_tank addEventHandler ["Killed", { (_this select 0) setVariable ["OPCB_destroyed", true, true]; }];

// Flipflops Immediate limit relief on death OR Zeus delete
_tank addMPEventHandler ["MPKilled", {
    params ["_veh"];
    if (isServer) then {
        if !(_veh getVariable ["OPCB_countedDown", false]) then {
            _veh setVariable ["OPCB_countedDown", true, true];
            private _key = _veh getVariable ["OPCB_counterKey",""];
            if (_key != "") then {
                private _val = missionNamespace getVariable [_key, 0];
                _val = (_val - 1) max 0;
                missionNamespace setVariable [_key, _val];
                publicVariable _key;
            };
        };
    };
}];

_tank addEventHandler ["Deleted", {
    params ["_veh"];
    OPCB_MBTs = OPCB_MBTs - [_veh];
    OPCB_APCs = OPCB_APCs - [_veh];
    publicVariable "OPCB_MBTs";
    publicVariable "OPCB_APCs";

    if (isServer) then {
        if !(_veh getVariable ["OPCB_countedDown", false]) then {
            _veh setVariable ["OPCB_countedDown", true, true];
            private _key = _veh getVariable ["OPCB_counterKey",""];
            if (_key != "") then {
                private _val = missionNamespace getVariable [_key, 0];
                _val = (_val - 1) max 0;
                missionNamespace setVariable [_key, _val];
                publicVariable _key;
            };
        };
    };
}];

if (_isAttack ) then {
    private _cargoIndex = -1;
    _vehicle = toUpper _vehicle;
    {
        if ((_x select 0) == _vehicle) exitWith { _cargoIndex = _foreachIndex; };
    } foreach OPCB_econ_vehicleCargoSpaces;

    if (_cargoIndex != -1) then {
        [_tank, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
    };

    _tank call Hz_pers_API_addVehicle;

    [_tank] call BADCO_fnc_skinApplier;

    if (_tank isKindOf "Tank") then {
        [_tank, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
    } else {
        if (_tank isKindOf "Car") then {
            [_tank, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
        };
    };

    [_tank] remoteExec ["CHAB_fnc_tank_restriction",0,true];

} else {
    private _cargoIndex = -1;
    _vehicle = toUpper _vehicle;
    {
        if ((_x select 0) == _vehicle) exitWith { _cargoIndex = _foreachIndex; };
    } foreach OPCB_econ_vehicleCargoSpaces;
    if (_cargoIndex != -1) then {
        [_tank, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
    };

    _tank call Hz_pers_API_addVehicle;
    [_tank] call BADCO_fnc_skinApplier;

    if (_tank isKindOf "Tank") then {
        [_tank, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
    } else {
        if (_tank isKindOf "Car") then {
            [_tank, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
        };
    };
};
