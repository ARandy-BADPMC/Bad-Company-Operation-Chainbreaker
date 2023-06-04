private _reward = 80;
params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["warhead1","warhead2","destroy1","destroy2","destroy_tower","destroy_tower2","destroy_radar"];
_guardgroup = createGroup [east,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["We have intel on an OPFOR base located in the marked area. You need to eliminate them","Eliminate"],
 _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_commander, _base, [], 2, "NONE"];
_guardpos = getPos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_ins;

_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_guard,10,1,2] call CHAB_fnc_spawn_nat;

[25] call CHAB_fnc_enemycount;

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
[_base] call CHAB_fnc_endmission;

[ _comp ] call LARs_fnc_deleteComp;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;