private _reward = 60;
params ["_base","_current_tasknumber"];

_taskcomp = selectRandom ["insurgent1","insurgent2","insurgent3","insurgent4","insurgent_big","insurgent_hostage"];

_current_task = _base getPos[random 600,random 360];

[_current_tasknumber ,west,
["The region is plagued by the pervasive terror inflicted by insurgents, creating a state of fear and instability among the entire population. Our mission is to eliminate the insurgents and restore a sense of peace, ensuring the safety and well-being of the local community. The primary objective of this operation is to bring an end to the reign of terror imposed by the insurgents. By neutralizing their presence, we aim to restore peace, security, and hope for the entire population. The operation will be conducted with utmost professionalism, adhering to the principles of proportionality and respect for human rights.","Operation Peacekeeper"],
 _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_comp] call CHAB_fnc_findFlowerPots;

[_base,resistance] call CHAB_fnc_enemySpawner;

_spawncomps = [_base] call CHAB_fnc_roadblock_ins;

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