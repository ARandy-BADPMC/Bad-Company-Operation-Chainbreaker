params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["destroy_chopper","destroy_radar","destroy_tower","destroy_tower2","weap_factory"];
_guardgroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["Insurgents set up a base and will hold it under any circumstances. Clear out the area and destroy any important equipment.","Annihilate and Destroy"], _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;
_guard = _guardgroup createUnit ["rhsgref_nat_commander", _base, [], 2, "NONE"];
_guardpos = getPos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_guard,10,1,2] call CHAB_fnc_spawn_nat;

_destroytargets = nearestObjects [ _guardpos, ["Land_Device_assembled_F","RHS_Mi24Vt_vvs","rhs_mi28n_vvs","Land_TTowerBig_1_F","Land_TTowerBig_2_F","rhs_p37","Land_i_Shed_Ind_F"], 30];
_thetarget =selectRandom _destroytargets ;
_trg = createTrigger ["EmptyDetector", _guardpos,true];
_trg setTriggerArea [600, 600, 0, false];
_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "", ""];
[] call CHAB_fnc_enemycount;
waitUntil { 
	sleep 10; 
	(!(alive _thetarget) || (damage _thetarget > 0.8)) && (triggerActivated _trg)
};
[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;

[_base] call CHAB_fnc_endmission;
[ _comp ] call LARs_fnc_deleteComp;
deleteVehicle _trg;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;