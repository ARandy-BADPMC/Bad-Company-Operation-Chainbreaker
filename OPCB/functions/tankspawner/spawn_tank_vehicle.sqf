params [["_vehicle", ""], ["_spawnMarker", ""]];
disableSerialization;

if (_vehicle == "") then {
	private _list = (findDisplay 9901) displayCtrl 1500;
	private _selection = lbCurSel _list;
	if (_selection >= 0) then { _vehicle = _list lbData _selection; };
};
if (_vehicle == "") exitWith { hint "Select a vehicle first"; };
if (_spawnMarker == "") exitWith {
	["ground", [_vehicle], "tank_spawner"] call CHAB_fnc_shopSpawnLocationOpen;
};

private _isTank = (toUpper _vehicle) in OPCB_econ_vehicleGroundAttackTypes;
if (_isTank && {MaxTanks != 0}) exitWith { hint "There is already a tank/SPG in game"; };
if (!_isTank && {MaxAPC >= 12}) exitWith { hint "12 vehicles are already in game. Recover or destroy existing ones."; };

private _tierType = if (_isTank) then { "ENG" } else { "INF" };
private _tier = [_tierType, _vehicle] call OPCB_econ_fnc_getVehicleTier;
if (_tier == -1) then {
	_tierType = if (_isTank) then { "INF" } else { "ENG" };
	_tier = [_tierType, _vehicle] call OPCB_econ_fnc_getVehicleTier;
};
private _cost = [_tierType, _tier] call OPCB_econ_fnc_getTierCost;
if (OPCB_econ_credits < _cost) exitWith { hint "You don't have enough credits to buy this vehicle!"; };

OPCB_econ_credits = OPCB_econ_credits - _cost;
publicVariable "OPCB_econ_credits";
hint "Vehicle delivered";

if (_isTank) then {
	MaxTanks = MaxTanks + 1;
	publicVariable "MaxTanks";
} else {
	MaxAPC = MaxAPC + 1;
	publicVariable "MaxAPC";
};

VehicleSpawnerHistory pushBack [name player, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName"), _cost];
publicVariable "VehicleSpawnerHistory";
[_vehicle, _isTank, _spawnMarker] remoteExec ["CHAB_fnc_spawn_tank_server", 2];
