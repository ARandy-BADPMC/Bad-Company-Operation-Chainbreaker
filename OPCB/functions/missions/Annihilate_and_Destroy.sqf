private _reward = 80;
params ["_base","_current_tasknumber"];

_taskcomp = selectRandom ["destroy_chopper","destroy_radar","destroy_tower","destroy_tower2","weap_factory"];
_guardgroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["Insurgents set up a base and will hold it under any circumstances. Clear out the area and destroy any important equipment.","Annihilate and Destroy"],
 _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_commander, _base, [], 2, "NONE"];
_guardpos = getPos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_guard,10,1,2] call CHAB_fnc_spawn_nat;

_destroytargets = nearestObjects [ _guardpos, ["Land_Device_assembled_F","RHS_Mi24Vt_vvs","rhs_mi28n_vvs","Land_TTowerBig_1_F","Land_TTowerBig_2_F","rhs_p37","Land_i_Shed_Ind_F"], 30];

[] call CHAB_fnc_enemycount;

waitUntil { 
	sleep 2; 
	_destroytargets findIf {alive _x } == -1 
};

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];

[_base] call CHAB_fnc_endmission;

[ _comp ] call LARs_fnc_deleteComp;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;

[_destroytargets] spawn {
	params ["_destroytargets"];
	sleep 60;
	{
		deleteVehicle _x;
	} forEach _destroytargets;
}