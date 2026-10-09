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
private _vehicleType = toUpper _vehicle;
private _groundSlot = "Vehicle";
if (_vehicleType in OPCB_econ_vehicleGroundAttackTypes) then {
	_groundSlot = "Tank";
} else {
	if (_vehicleType in OPCB_econ_vehicleGroundApcTypes) then {
		_groundSlot = "APC";
	};
};
if (_groundSlot == "Tank" && {MaxTanks != 0}) exitWith { hint "There is already a tank/SPG in game"; };
if (_groundSlot == "APC" && {MaxAPC >= 3}) exitWith { hint "3 APCs are already in game. Recover or destroy an existing APC."; };
if (_groundSlot == "Vehicle" && {ShopVehicleCount >= 8}) exitWith { hint "8 vehicles are already in game. Recover or destroy an existing vehicle."; };

private _tierType = if (_groundSlot == "Vehicle") then { "INF" } else { "ENG" };
private _tier = [_tierType, _vehicle] call OPCB_econ_fnc_getVehicleTier;
if (_tier == -1) then {
	_tierType = if (_groundSlot == "Vehicle") then { "ENG" } else { "INF" };
	_tier = [_tierType, _vehicle] call OPCB_econ_fnc_getVehicleTier;
};
private _cost = [_tierType, _tier] call OPCB_econ_fnc_getTierCost;
if (OPCB_econ_credits < _cost) exitWith { hint "You don't have enough credits to buy this vehicle!"; };

OPCB_econ_credits = OPCB_econ_credits - _cost;
publicVariable "OPCB_econ_credits";
hint "Vehicle delivered";

if (_groundSlot == "Tank") then {
	MaxTanks = MaxTanks + 1;
	publicVariable "MaxTanks";
} else {
	if (_groundSlot == "Vehicle") then {
		ShopVehicleCount = ShopVehicleCount + 1;
		publicVariable "ShopVehicleCount";
	};
	if (_groundSlot == "APC") then {
		MaxAPC = MaxAPC + 1;
		publicVariable "MaxAPC";
	};
};

VehicleSpawnerHistory pushBack [name player, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName"), _cost];
publicVariable "VehicleSpawnerHistory";
[_vehicle, _groundSlot, _spawnMarker] remoteExec ["CHAB_fnc_spawn_tank_server", 2];
