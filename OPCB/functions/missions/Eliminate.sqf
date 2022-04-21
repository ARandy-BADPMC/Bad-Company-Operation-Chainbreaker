params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["warhead1","warhead2","destroy1","destroy2","destroy_tower","destroy_tower2","destroy_radar"];
_guardgroup = createGroup [east,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["We have intel on an OPFOR base located in the marked area. You need to eliminate them","Eliminate"], _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;
_guard = _guardgroup createUnit ["rhsgref_nat_commander", _base, [], 2, "NONE"];
_guardpos = getPos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_ins;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
[_guard,10,1,2] call CHAB_fnc_spawn_nat;

_trg = createTrigger ["EmptyDetector", _guardpos,true];
_trg setTriggerArea [600, 600, 0, false];
_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "", ""];
[] call CHAB_fnc_enemycount;
waitUntil {sleep 10;triggerActivated _trg};
[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
[_base] call CHAB_fnc_endmission;
[ _comp ] call LARs_fnc_deleteComp;
deleteVehicle _trg;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;