private _reward = 40;
params ["_base","_current_tasknumber"];

_taskcomp = selectRandom ["insurgent1","insurgent2","insurgent3","insurgent4","insurgent_big","insurgent_hostage"];
_guardgroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];

[_current_tasknumber ,west,
["Insurgents terrorising the total population. We can not tolerate this.","Defend the defensless"],
 _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_TL, _base, [], 2, "NONE"];
_guardpos = getPos _guard;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_guard,10,2,2] call CHAB_fnc_spawn_ins;

_spawncomps = [_guard] call CHAB_fnc_roadblock_ins;

[] call CHAB_fnc_enemycount;

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;

OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
[_base] call CHAB_fnc_endmission;

[ _comp ] call LARs_fnc_deleteComp;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;