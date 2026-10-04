params [["_vehicle", ""], ["_spawnMarker", ""]];
disableSerialization;

if (_vehicle == "") then {
	private _list = (findDisplay 74817) displayCtrl 1500;
	private _selection = lbCurSel _list;
	if (_selection >= 0) then { _vehicle = _list lbData _selection; };
};
if (_vehicle == "") exitWith { hint "Select a static first"; };
if (_spawnMarker == "") exitWith {
	["static", [_vehicle], "tank_spawner"] call CHAB_fnc_shopSpawnLocationOpen;
};

private _tier = ["STAT", _vehicle] call OPCB_econ_fnc_getVehicleTier;
private _cost = ["STAT", _tier] call OPCB_econ_fnc_getTierCost;
if (OPCB_econ_credits < _cost) exitWith { hint "You don't have enough credits to buy this static!"; };

OPCB_econ_credits = OPCB_econ_credits - _cost;
publicVariable "OPCB_econ_credits";
hint "Static delivered";
VehicleSpawnerHistory pushBack [name player, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName"), _cost];
publicVariable "VehicleSpawnerHistory";
[_vehicle, _spawnMarker] remoteExec ["CHAB_fnc_spawn_static_server", 2];
