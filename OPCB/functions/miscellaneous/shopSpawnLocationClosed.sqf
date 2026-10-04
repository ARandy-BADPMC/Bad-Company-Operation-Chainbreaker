if (uiNamespace getVariable ["OPCB_shopSpawnConfirmed", false]) exitWith {
    uiNamespace setVariable ["OPCB_shopSpawnConfirmed", false];
};

private _request = uiNamespace getVariable ["OPCB_pendingShopSpawn", []];
uiNamespace setVariable ["OPCB_pendingShopSpawn", nil];
if (_request isEqualTo []) exitWith {};

private _shopType = _request select 0;
[_shopType] spawn {
    params ["_shopType"];
    uiSleep 0.1;
    switch (_shopType) do {
        case "ground": { [] spawn CHAB_fnc_spawn_tank; };
        case "static": { [] spawn CHAB_fnc_spawn_static; };
        case "crate": { [] spawn OPCB_crateSpawner_openDialog; };
        case "drone": { [] spawn CHAB_fnc_spawn_drone; };
    };
};
