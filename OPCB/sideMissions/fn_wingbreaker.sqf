if (!isServer) exitWith {};

private _cleanupDelay = 300;

private _missionPos = [150] call CHAB_fnc_findSpot;
if !(_missionPos isEqualType [] && {count _missionPos >= 2}) exitWith {};

private _taskId    = format ["SM_TaskNumber_%1", SM_TaskNumber];
private _taskTitle = "Wingbreaker";
private _taskDesc  = "A Tunguska has been pushed forward by hostile forces. Its radar and cannons will shred any bird Hunt it, kill it, and free the skies.";

[allPlayers, _taskId, [_taskDesc, _taskTitle, _taskTitle], _missionPos, "ASSIGNED", 1, true, "destroy"] call BIS_fnc_taskCreate;

private _anchor = createVehicle ["Land_FlowerPot_01_F", _missionPos, [], 0, "CAN_COLLIDE"];
_anchor hideObjectGlobal true;
_anchor allowDamage false;
_anchor enableSimulationGlobal false;

private _aaClass = "UK3CB_CW_SOV_O_LATE_2S6_Tunguska";
if !(isClass (configFile >> "CfgVehicles" >> _aaClass)) exitWith {};

private _aaPos = _anchor modelToWorld [0,0,0];
private _aaDir = random 360;

private _aa = createVehicle [_aaClass, _aaPos, [], 0, "NONE"];
_aa setDir _aaDir;
_aa setVectorUp surfaceNormal _aaPos;

createVehicleCrew _aa;
_aa setBehaviour "COMBAT";
{_x setBehaviour "COMBAT"; _x setSkill ["spotDistance", 1]; _x setSkill ["spotTime", 1];} forEach crew _aa;

private _ldfPool_I = [
  "UK3CB_LDF_I_TL","UK3CB_LDF_I_RIF_1","UK3CB_LDF_I_RIF_2","UK3CB_LDF_I_GL",
  "UK3CB_LDF_I_AR","UK3CB_LDF_I_LAT","UK3CB_LDF_I_MD","UK3CB_LDF_I_MK",
  "UK3CB_LDF_I_RIF_1","UK3CB_LDF_I_AR"
];
private _aafPool_I = [
  "I_Soldier_TL_F","I_Soldier_F","I_Soldier_GL_F","I_Soldier_AR_F",
  "I_Soldier_LAT_F","I_medic_F","I_Soldier_M_F","I_Soldier_F",
  "I_Soldier_AR_F","I_Soldier_F"
];
private _useLDF = {isClass (configFile >> "CfgVehicles" >> _x)} count _ldfPool_I == count _ldfPool_I;
private _infPool = if (_useLDF) then {_ldfPool_I} else {_aafPool_I};

private _guardGrp = createGroup resistance;
{
  private _r = 22 + ((_forEachIndex mod 2) * 8);
  private _a = (_forEachIndex * (360 / 10));
  private _p = _aaPos getPos [_r, _a];
  private _u = _guardGrp createUnit [_x, _p, [], 2, "NONE"];
  _u setUnitPos "MIDDLE";
  _u setBehaviour "AWARE";
  _u setCombatMode "YELLOW";
  _u doWatch _aa;
} forEach _infPool;
{if (_forEachIndex < 5) then {_x disableAI "PATH"}} forEach units _guardGrp;

[_anchor, resistance, 1, 0, 0, 0, false] call CHAB_fnc_enemySpawner;

[_aa, _taskId, _guardGrp, _anchor, _cleanupDelay] spawn {
  params ["_aa","_taskId","_guardGrp","_anchor","_cleanupDelay"];
  waitUntil {
    sleep 2;
    (!isNull _aa) && ((!alive _aa) || ({alive _x} count (crew _aa) == 0))
  };
  [_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
  sleep _cleanupDelay;
  if (!isNull _guardGrp) then {{deleteVehicle _x} forEach units _guardGrp; deleteGroup _guardGrp};
  if (!isNull _aa) then {{deleteVehicle _x} forEach crew _aa; deleteVehicle _aa};
  if (!isNull _anchor) then {deleteVehicle _anchor};
};
