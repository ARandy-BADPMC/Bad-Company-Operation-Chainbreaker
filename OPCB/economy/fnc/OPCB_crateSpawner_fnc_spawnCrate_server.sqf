params ["_crateType"];
_callerRE = remoteExecutedOwner;

if (CrateCount > 19) exitWith {
    "You have reached the utility limit!" remoteExec ["hint", _callerRE];
};

_tankpos = markerPos "tank_spawner";

_nObjects = nearestObjects [_tankpos, [], 7];
if (count _nObjects <= 1) then {

    
    private _limit = 20;
    [format ["Utility delivered Slots left: %1", (_limit - (CrateCount + 1)) max 0]] remoteExec ["hint", _callerRE];
        
    CrateCount = CrateCount + 1;
    
    _crate = _crateType createVehicle (_tankpos);

    
    if (_crateType == "ACE_MEDICALSUPPLYCRATE") then {
        OPCB_CratesMed pushBackUnique _crate;
        publicVariable "OPCB_CratesMed";
    } else {
        OPCB_CratesAmmo pushBackUnique _crate;
        publicVariable "OPCB_CratesAmmo";
    };

    // flipflop - mark destruction + array cleanup 
    _crate addEventHandler ["HandleDamage", {
        params ["_o","","_dmg"];
        if (_dmg >= 1 && !(_o getVariable ["OPCB_destroyed", false])) then {
            _o setVariable ["OPCB_destroyed", true, true];
        };
        _dmg
    }];
    _crate addEventHandler ["Deleted", {
        params ["_c"];
        OPCB_CratesAmmo = OPCB_CratesAmmo - [_c];
        OPCB_CratesMed  = OPCB_CratesMed  - [_c];
        publicVariable "OPCB_CratesAmmo";
        publicVariable "OPCB_CratesMed";
    }];

    
    _cargoRequirement = 0;
    {
        if ((_x select 0) == _crateType) exitWith {
            _cargoRequirement = _x select 1;
        };
    } foreach OPCB_econ_vehicleCargoSizes;
    [_crate, _cargoRequirement] call ace_cargo_fnc_setSize;

    _crate addEventHandler ["Killed",
    {
        if(isServer) then {
            CrateCount = CrateCount - 1;
            publicVariable "CrateCount";
        };
    }];
    
    if (_crateType != "ACE_MEDICALSUPPLYCRATE") then {
        clearBackpackCargoGlobal _crate;
        clearWeaponCargoGlobal _crate;
        clearMagazineCargoGlobal _crate;
        clearItemCargoGlobal _crate;
    };
    
} else {
    "Spawn position is not empty" remoteExec ["hint", _callerRE];
};
