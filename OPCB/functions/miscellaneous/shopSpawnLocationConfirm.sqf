private _request = uiNamespace getVariable ["OPCB_pendingShopSpawn", []];
if (_request isEqualTo []) exitWith {};

private _display = findDisplay 74820;
if (isNull _display) exitWith {};
private _list = _display displayCtrl 74821;
private _selection = lbCurSel _list;
if (_selection < 0) exitWith { hint "Select a spawn location first."; };

private _spawnMarker = _list lbData _selection;
_request params ["_shopType", "_payload"];
uiNamespace setVariable ["OPCB_shopSpawnConfirmed", true];
closeDialog 0;

switch (_shopType) do {
    case "ground": { [_payload select 0, _spawnMarker] call CHAB_fnc_spawn_tank_vehicle; };
    case "static": { [_payload select 0, _spawnMarker] call CHAB_fnc_spawn_static_vehicle; };
    case "crate": { [_payload select 0, _spawnMarker] call OPCB_crateSpawner_fnc_spawnCrate; };
    case "drone": { [_payload select 0, _spawnMarker] call CHAB_fnc_spawn_drone_vehicle; };
    default { hint "Unknown shop type."; };
};

uiNamespace setVariable ["OPCB_pendingShopSpawn", nil];
