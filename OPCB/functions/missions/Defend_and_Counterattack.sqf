if ((_this select 0) isEqualType objNull) exitWith {
	params ["_commander", ["_mode", "addAction"]];
	if (_mode == "capture") exitWith {
		if (!isServer || {isNull _commander} || {!alive _commander}) exitWith {};
		_commander setVariable ["OPCB_captured", true, true];
		_commander setCaptive true;
		_commander disableAI "ALL";
		["Great work soldiers, bring him back to base."] remoteExec ["hint", 0];
	};
	if (!hasInterface || {isNull _commander} || {!alive _commander}) exitWith {};
	if (!isNil {_commander getVariable "OPCB_captureAction"}) exitWith {};
	private _action = _commander addAction [
		"Capture enemy commander",
		{ params ["_target"]; [_target, "capture"] remoteExec ["CHAB_fnc_Defend_and_Counterattack", 2]; },
		nil,
		1.5,
		true,
		true,
		"",
		"alive _target && {!(_target getVariable ['OPCB_captured', false])} && {_this distance _target < 4}",
		4,
		false,
		""
	];
	_commander setVariable ["OPCB_captureAction", _action];
};

params ["_base", "_currentTasknumber", ["_reward", 600]];
if (!isServer) exitWith { _this remoteExec ["CHAB_fnc_Defend_and_Counterattack", 2]; };

private _taskId = format ["PMC_Defend_%1", _currentTasknumber];
private _taskDesc = "Protect the allied officer and HQ while the outpost comes under attack. After the assault is repelled, capture the enemy commander and return him alive to the delivery point at base.";
if (count _base == 2) then { _base pushBack 0; };
private _hqBase = _base;
private _enemyHiddenTerrain = [];
for "_i" from 1 to 30 do {
	private _candidate = [_base, 0, 250, 5, 0, 0.08, 0, [], [globalWaterPos, globalWaterPos]] call BIS_fnc_findSafePos;
	if !(_candidate isEqualTo [0,0,0]) then {
		if (count _candidate == 2) then { _candidate pushBack 0; };
		if (!surfaceIsWater _candidate && {(surfaceNormal _candidate) select 2 > 0.995}) exitWith { _hqBase = _candidate; };
	};
};
if (count _hqBase == 2) then { _hqBase pushBack 0; };

private _findNamedObject = {
	params ["_objects", "_name"];
	private _found = objNull;
	{
		if (_x isEqualType objNull && {(vehicleVarName _x) isEqualTo _name}) exitWith { _found = _x; };
	} forEach _objects;
	_found
};

private _hiddenTerrain = nearestTerrainObjects [_hqBase, ["TREE", "SMALL TREE", "BUSH"], 70, false];
{ _x hideObjectGlobal true; } forEach _hiddenTerrain;

private _alliedComp = ["HQ_allied", _hqBase, [0,0,0], random 360, true, true] call LARs_fnc_spawnComp;
private _alliedObjects = [_alliedComp] call LARs_fnc_getCompObjects;
private _officer = [_alliedObjects, "Defence_officer"] call _findNamedObject;
if (isNull _officer) exitWith {
	diag_log "[Defend_and_Counterattack] Defence_officer was not found in HQ_allied composition.";
	[_alliedComp] call LARs_fnc_deleteComp;
};
doStop _officer;
{ _officer disableAI _x; } forEach ["MOVE", "PATH", "AUTOCOMBAT", "TARGET", "AUTOTARGET"];
removeAllWeapons _officer;
private _friendlyTypes = [
	"rhsusf_army_ocp_rifleman",
	"rhsusf_army_ocp_rifleman_m4",
	"rhsusf_army_ocp_grenadier",
	"rhsusf_army_ocp_autorifleman"
];
_friendlyTypes = _friendlyTypes select {isClass (configFile >> "CfgVehicles" >> _x)};
if (_friendlyTypes isEqualTo []) then { _friendlyTypes = ["B_Soldier_F"]; };
private _friendlyGroup = createGroup west;
for "_i" from 1 to 20 do {
	private _friendly = _friendlyGroup createUnit [selectRandom _friendlyTypes, _hqBase getPos [random 80, random 360], [], 0, "NONE"];
	_friendly setBehaviour "AWARE";
	_friendly setCombatMode "YELLOW";
};
[_friendlyGroup, _hqBase, 100] call BIS_fnc_taskDefend;

private _cleanup = {
	params ["_enemyComp", "_enemyUnits", "_enemyGroups", "_enemyVehicles", "_commander", "_commanderGuards"];
	{ deleteVehicle _x; } forEach (_enemyUnits + _enemyVehicles + [_commander]);
	{ deleteGroup _x; } forEach (_enemyGroups + [_commanderGuards, _friendlyGroup]);
	[_alliedComp] call LARs_fnc_deleteComp;
	if (_enemyComp isEqualType "" && {_enemyComp != ""}) then { [_enemyComp] call LARs_fnc_deleteComp; };
	{ _x hideObjectGlobal false; } forEach _hiddenTerrain;
	{ _x hideObjectGlobal false; } forEach _enemyHiddenTerrain;
};

[_taskId, west, [_taskDesc, "Operation Iron Shield", "Iron Shield"], _hqBase, "ASSIGNED", 10, true, true, "defend", true] call BIS_fnc_setTask;
["Enemy assault begins in 10 minutes. Prepare the allied HQ."] remoteExec ["hint", 0];
sleep 300;
["Enemy assault begins in 5 minutes. Finish preparing the HQ defenses."] remoteExec ["hint", 0];
sleep 180;
["Enemy assault begins in 2 minutes. Get ready for contact."] remoteExec ["hint", 0];
sleep 120;

private _enemyComp = "";
private _enemyUnits = [];
private _enemyGroups = [];
private _enemyVehicles = [];
private _commander = objNull;
private _commanderGuards = grpNull;
private _repelEndsAt = time + 300;

if (!alive _officer) exitWith {
	[_taskId, "FAILED", true] call BIS_fnc_taskSetState;
	[_enemyComp, _enemyUnits, _enemyGroups, _enemyVehicles, _commander, _commanderGuards] call _cleanup;
};

private _spawnGroup = {
	params ["_angle"];
	private _pos = _hqBase getPos [200, _angle];
	private _group = [_pos, resistance, selectRandom OPCB_InfantryGroups_Insurgents] call BIS_fnc_spawnGroup;
	_group setBehaviour "COMBAT";
	_group setCombatMode "RED";
	_group deleteGroupWhenEmpty true;
	private _waypoint = _group addWaypoint [_hqBase, 0];
	_waypoint setWaypointType "SAD";
	_enemyGroups pushBack _group;
	_enemyUnits append units _group;
};

[0] call _spawnGroup;
sleep 15;
[180] call _spawnGroup;

private _spawnVehicles = {
	params ["_class", "_amount", "_angle"];
	if !(isClass (configFile >> "CfgVehicles" >> _class)) exitWith {};
	for "_i" from 1 to _amount do {
		private _pos = _hqBase getPos [200 + random 50, _angle + random [-20, 0, 20]];
		private _data = [_pos, _pos getDir _hqBase, _class, resistance] call BIS_fnc_spawnVehicle;
		_data params ["_vehicle", "_crew", "_group"];
		_group setBehaviour "COMBAT";
		_group setCombatMode "RED";
		private _waypoint = _group addWaypoint [_hqBase, 0];
		_waypoint setWaypointType "SAD";
		_enemyUnits append units _group;
		_enemyGroups pushBack _group;
		_enemyVehicles pushBack _vehicle;
		sleep 5;
	};
};

["UK3CB_LDF_I_Tigr_FFV", 2 + floor random 3, 0] call _spawnVehicles;
sleep 15;
["UK3CB_LDF_I_BMP1", 1 + floor random 2, 180] call _spawnVehicles;

sleep 120;
[90] call _spawnGroup;

sleep 60;

private _heliClass = "UK3CB_LDF_I_Mi8AMTSh";
if (isClass (configFile >> "CfgVehicles" >> _heliClass)) then {
	private _heliPos = _hqBase getPos [1000, random 360];
	private _heliData = [_heliPos, _heliPos getDir _hqBase, _heliClass, resistance] call BIS_fnc_spawnVehicle;
	_heliData params ["_heli", "_heliCrew", "_heliGroup"];
	_enemyUnits append units _heliGroup;
	_enemyVehicles pushBack _heli;
	_enemyGroups pushBack _heliGroup;
	private _paraGroup = createGroup resistance;
	for "_i" from 1 to 8 do {
		private _unit = _paraGroup createUnit [selectRandom ["UK3CB_LDF_I_RIF_1", "UK3CB_LDF_I_GL", "UK3CB_LDF_I_AR", "UK3CB_LDF_I_MG"], _heliPos, [], 0, "NONE"];
		_unit moveInCargo _heli;
		_enemyUnits pushBack _unit;
	};
	[_heli, _paraGroup, _hqBase] spawn {
		params ["_heli", "_paraGroup", "_hqBase"];
		waitUntil { sleep 2; isNull _heli || {_heli distance2D _hqBase < 250} };
		if (!isNull _heli) then {
			{ moveOut _x; } forEach units _paraGroup;
			[_paraGroup] call CHAB_fnc_serverGroups;
			_enemyGroups pushBack _paraGroup;
			[_paraGroup, getPosATL _heli, 100] call BIS_fnc_taskAttack;
		};
	};
};

waitUntil {
	sleep 5;
	!alive _officer || {time >= _repelEndsAt}
};

if (!alive _officer) exitWith {
	[_taskId, "FAILED", true] call BIS_fnc_taskSetState;
	[_enemyComp, _enemyUnits, _enemyGroups, _enemyVehicles, _commander, _commanderGuards] call _cleanup;
};

["The allied HQ held for five minutes. Enemy forces are retreating to regroup. Prepare for the counterattack."] remoteExec ["hint", 0];
{
	if (!isNull _x) then { deleteVehicle _x; };
} forEach (_enemyUnits + _enemyVehicles);
{ if (!isNull _x) then { deleteGroup _x; }; } forEach _enemyGroups;
_enemyUnits = [];
_enemyVehicles = [];
_enemyGroups = [];

sleep 90;
["Enemy forces have regrouped. Locate their HQ, capture the commander, and bring him back alive."] remoteExec ["hint", 0];

private _enemyHQPos = [0,0,0];
for "_i" from 1 to 30 do {
	private _searchCenter = _hqBase getPos [random [2500, 3500, 4500], random 360];
	private _candidate = [_searchCenter, 0, 300, 5, 0, 0.08, 0, [], [globalWaterPos, globalWaterPos]] call BIS_fnc_findSafePos;
	if !(_candidate isEqualTo [0,0,0]) then {
		if (count _candidate == 2) then { _candidate pushBack 0; };
		if (!surfaceIsWater _candidate && {(surfaceNormal _candidate) select 2 > 0.995}) exitWith { _enemyHQPos = _candidate; };
	};
};
if (_enemyHQPos isEqualTo [0,0,0]) then {
	_enemyHQPos = [_hqBase getPos [2500, random 360], 0, 500, 5, 0, 0.08, 0, [], [globalWaterPos, globalWaterPos]] call BIS_fnc_findSafePos;
};
if (count _enemyHQPos == 2) then { _enemyHQPos pushBack 0; };
if (surfaceIsWater _enemyHQPos) then {
	_enemyHQPos = [_hqBase, 0, 500, 5, 0, 0.08, 0, [], [globalWaterPos, globalWaterPos]] call BIS_fnc_findSafePos;
	if (count _enemyHQPos == 2) then { _enemyHQPos pushBack 0; };
};
_enemyHiddenTerrain = nearestTerrainObjects [_enemyHQPos, ["TREE", "SMALL TREE", "BUSH"], 70, false];
{ _x hideObjectGlobal true; } forEach _enemyHiddenTerrain;
_enemyComp = ["HQ_enemy", _enemyHQPos, [0,0,0], random 360, true, true] call LARs_fnc_spawnComp;
private _enemyObjects = [_enemyComp] call LARs_fnc_getCompObjects;
_commander = [_enemyObjects, "Defence_enemy_officer"] call _findNamedObject;
if (isNull _commander) exitWith {
	diag_log "[Defend_and_Counterattack] Defence_enemy_officer was not found in HQ_enemy composition.";
	[_taskId, "FAILED", true] call BIS_fnc_taskSetState;
	[_enemyComp, _enemyUnits, _enemyGroups, _enemyVehicles, _commander, _commanderGuards] call _cleanup;
};
doStop _commander;
{ _commander disableAI _x; } forEach ["MOVE", "PATH", "AUTOCOMBAT", "TARGET", "AUTOTARGET"];
removeAllWeapons _commander;
_commander setVariable ["OPCB_captured", false, true];
_commanderGuards = [_enemyHQPos, resistance, selectRandom OPCB_InfantryGroups_Insurgents] call BIS_fnc_spawnGroup;
[_commanderGuards, _enemyHQPos] call BIS_fnc_taskDefend;
for "_i" from 1 to 3 do {
	private _guardGroup = [_enemyHQPos getPos [60 + random 60, _i * 120], resistance, selectRandom OPCB_InfantryGroups_Insurgents] call BIS_fnc_spawnGroup;
	_guardGroup setBehaviour "AWARE";
	_guardGroup setCombatMode "RED";
	_guardGroup deleteGroupWhenEmpty true;
	[_guardGroup, _enemyHQPos, 150] call BIS_fnc_taskDefend;
	_enemyGroups pushBack _guardGroup;
	_enemyUnits append units _guardGroup;
};
	[_commander, "addAction"] remoteExec ["CHAB_fnc_Defend_and_Counterattack", 0, true];
[_taskId, west, ["Capture the enemy commander and return him alive to the delivery point at base.", "Capture Enemy Commander", "Capture Commander"], _enemyHQPos, "ASSIGNED", 10, true, true, "kill", true] call BIS_fnc_setTask;

waitUntil { sleep 5; !alive _commander || {_commander getVariable ["OPCB_captured", false]} };
if (!alive _commander) exitWith {
	[_taskId, "FAILED", true] call BIS_fnc_taskSetState;
	[_enemyComp, _enemyUnits, _enemyGroups, _enemyVehicles, _commander, _commanderGuards] call _cleanup;
};

[_taskId, getMarkerPos "Delivery Point"] call BIS_fnc_taskSetDestination;
waitUntil { sleep 5; !alive _commander || {_commander distance2D (getMarkerPos "Delivery Point") < 15} };
if (!alive _commander) exitWith {
	[_taskId, "FAILED", true] call BIS_fnc_taskSetState;
	[_enemyComp, _enemyUnits, _enemyGroups, _enemyVehicles, _commander, _commanderGuards] call _cleanup;
};

[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
[format ["Operation Iron Shield complete. You earned %1 C.", _reward]] remoteExec ["hint", 0];

[_enemyComp, _enemyUnits, _enemyGroups, _enemyVehicles, _commander, _commanderGuards] call _cleanup;
