params [['_vehicle', '', ['']], ['_spawnMarker', '', ['']]];
if (!isServer || {!isRemoteExecuted}) exitWith {};

private _caller = remoteExecutedOwner;
private _callerIndex = allPlayers findIf {owner _x == _caller};
if (_callerIndex < 0) exitWith {};
if !(missionNamespace getVariable ["Hz_pers_serverInitialised", false]) exitWith {
	"The server is still loading saved vehicles. Please try again shortly." remoteExecCall ["hint", _caller];
};
private _buyer = allPlayers select _callerIndex;
private _vehicleType = toUpper _vehicle;
private _inInfantryShop = _vehicleType in OPCB_econ_vehicleTypes_INF;
private _inEngineerShop = _vehicleType in OPCB_econ_vehicleTypes_ENG;
#include "..\..\data\vehicleDriverUnitTypes.sqf"
if (!_inInfantryShop && {!(_inEngineerShop && {(typeOf _buyer) in _tankDriverTypes})}) exitWith {};
if !(_spawnMarker in allMapMarkers && {_spawnMarker == "tank_spawner" || {(_spawnMarker find "Fob_spawner") == 0}}) exitWith {};

private _groundSlot = if (_vehicleType in OPCB_econ_vehicleGroundAttackTypes) then {"Tank"} else {
	if (_vehicleType in OPCB_econ_vehicleGroundApcTypes) then {"APC"} else {"Vehicle"}
};
private _tierType = if (_groundSlot == "Vehicle") then {"INF"} else {"ENG"};
private _tier = [_tierType, _vehicle] call OPCB_econ_fnc_getVehicleTier;
if (_tier == -1) then {
	_tierType = if (_tierType == "INF") then {"ENG"} else {"INF"};
	_tier = [_tierType, _vehicle] call OPCB_econ_fnc_getVehicleTier;
};
if (_tier < OPCB_econ_currentTier) exitWith {"This vehicle is not available at the current tier." remoteExecCall ["hint", _caller];};

call CHAB_fnc_shopGroundReconcile;
if (_groundSlot == "Tank" && {MaxTanks >= 1}) exitWith {"There is already a tank/SPG in game" remoteExecCall ["hint", _caller];};
if (_groundSlot == "APC" && {MaxAPC >= 3}) exitWith {"3 APCs are already in game. Recover or destroy an existing APC." remoteExecCall ["hint", _caller];};
if (_groundSlot == "Vehicle" && {ShopVehicleCount >= 8}) exitWith {"8 vehicles are already in game. Recover or destroy an existing vehicle." remoteExecCall ["hint", _caller];};

private _cost = [_tierType, _tier] call OPCB_econ_fnc_getTierCost;
if (OPCB_econ_credits < _cost) exitWith {"You don't have enough credits to buy this vehicle!" remoteExecCall ["hint", _caller];};

private _tankPos = markerPos _spawnMarker;
if ((nearestObjects [_tankPos, ["LandVehicle", "Air", "Ship", "Man"], 7]) isNotEqualTo []) exitWith {
	"Spawn position is not empty. Clear the area and try again." remoteExecCall ["hint", _caller];
};

private _tank = createVehicle [_vehicle, _tankPos, [], 0, "CAN_COLLIDE"];
if (isNull _tank) exitWith {"Vehicle could not be created." remoteExecCall ["hint", _caller];};
_tank setDir (markerDir _spawnMarker);
[_tank, _groundSlot] call CHAB_fnc_shopSlotTrack;
_tank call Hz_pers_API_addVehicle;
call CHAB_fnc_shopGroundReconcile;

OPCB_econ_credits = OPCB_econ_credits - _cost;
publicVariable "OPCB_econ_credits";
VehicleSpawnerHistory pushBack [name _buyer, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName"), _cost];
publicVariable "VehicleSpawnerHistory";
"Vehicle delivered" remoteExecCall ["hint", _caller];

private _cargoIndex = OPCB_econ_vehicleCargoSpaces findIf {(_x select 0) == _vehicleType};
if (_cargoIndex != -1) then {
	[_tank, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
};
[_tank] call BADCO_fnc_skinApplier;
if (_tank isKindOf "Tank") then {
	[_tank, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
} else {
	if (_tank isKindOf "Car") then {[_tank, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;};
};
if (_groundSlot == "Tank") then {[_tank] remoteExec ["CHAB_fnc_tank_restriction", 0, true];};
