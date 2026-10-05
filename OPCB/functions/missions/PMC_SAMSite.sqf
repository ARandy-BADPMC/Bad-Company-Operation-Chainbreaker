params ["_base", "_current_tasknumber", ["_reward", 250]];

private _comp = ["PMC_samsite", _base, [0, 0, 0], random 360, true, true] call LARs_fnc_spawnComp;
private _compObjects = [_comp] call LARs_fnc_getCompObjects;
private _samSystems = _compObjects select {_x isEqualType objNull && {typeOf _x == "DRA_I_SAM_System_03_F"}};
private _radarSystems = _compObjects select {_x isEqualType objNull && {typeOf _x == "DRA_I_Radar_System_01_F"}};

if (count _samSystems != 2 || {count _radarSystems != 1}) exitWith {
	diag_log format ["[PMC_SAMSite] Expected 2 SAM systems and 1 radar in PMC_samsite composition; found %1 SAM systems and %2 radars.", count _samSystems, count _radarSystems];
	[_comp] call LARs_fnc_deleteComp;
};
private _targets = _samSystems + _radarSystems;

[_current_tasknumber, west, [
	"Destroy both SAM launchers and the radar to remove the enemy air-defense threat.",
	"Destroy SAM Site",
	"PMC SAM Site"
], _base, "ASSIGNED", 10, true, true, "Destroy", true] call BIS_fnc_setTask;

private _targetGuardCount = 15 + floor random 6;
private _guardGroups = [];

private _guardUnits = [];
private _spawnAttempts = 0;
while {count _guardUnits < _targetGuardCount && {_spawnAttempts < 10}} do {
	_spawnAttempts = _spawnAttempts + 1;
	private _guardPos = [_base, 60, 140, 5, 0, 0.3, 0] call BIS_fnc_findSafePos;
	if (_guardPos isEqualTo [0, 0, 0] || {surfaceIsWater _guardPos}) then { continue; };

	private _guardGroup = [_guardPos, resistance, selectRandom OPCB_InfantryGroups_Insurgents] call BIS_fnc_spawnGroup;
	[_guardGroup, _base] call BIS_fnc_taskDefend;
	_guardGroups pushBack _guardGroup;
	_guardUnits append units _guardGroup;
};

while {count _guardUnits > _targetGuardCount} do {
	deleteVehicle (_guardUnits deleteAt ((count _guardUnits) - 1));
};

[_guardGroups] call CHAB_fnc_serverGroups;

waitUntil {
	sleep 10;
	(_targets findIf {alive _x}) == -1
};

[_current_tasknumber, "SUCCEEDED", true] call BIS_fnc_taskSetState;

OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
(format ["You earned %1 C for destroying both SAM launchers and the radar!", _reward]) remoteExec ["hint", 0];

[_base] call CHAB_fnc_endmission;
[_comp] call LARs_fnc_deleteComp;