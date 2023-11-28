params ["_base","_current_tasknumber", "_reward"];
_taskcomp = selectRandom ["warhead1","warhead2","destroy1","destroy2","destroy_tower","destroy_tower2","destroy_radar"];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["Intelligence reports indicate the presence of an OPFOR FOB in close proximity to the marked area. The FOB serves as a stronghold for enemy forces, enabling them to launch attacks and maintain control over strategic assets. Our mission is to neutralize the OPFOR presence and eliminate any valuable resources that can be used against friendly forces. The primary objective of this operation is to eliminate the OPFOR presence within the FOB and dismantle their operational capabilities. By neutralizing the enemy and destroying valuable assets, we aim to significantly degrade their ability to pose a threat to friendly forces and restore dominance in the area.","Operation Fortress Strike"],
_current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_comp = [_taskcomp, _base, [0,0,0], random 360, true, true] call LARs_fnc_spawnComp;

[_comp] call CHAB_fnc_findFlowerPots;

_spawncomps = [_base] call CHAB_fnc_roadblock_ins;

[_base,east] call CHAB_fnc_enemySpawner;

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