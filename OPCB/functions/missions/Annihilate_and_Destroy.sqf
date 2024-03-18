params ["_base","_current_tasknumber", "_reward"];

_taskcomp = selectRandom ["destroy_chopper","destroy_radar","destroy_tower","destroy_tower2","weap_factory"];
_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["Insurgents have established a fortified base and are determined to hold it at all costs. Their presence poses a significant threat to security and stability in the region. Our mission is to eliminate the insurgents, clear the area, and neutralize their ability to continue their operations. The primary objective of this operation is to clear out the insurgents' base, neutralize their presence, and destroy vital equipment. By eliminating their stronghold and disrupting their operations, we aim to restore security and stability in the area, creating a safe environment for the local population.","Operation Iron Purge"],
 _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

_spawncomps = [_base] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_base,resistance] call CHAB_fnc_enemySpawner;

_destroytargets = nearestObjects [ _base, ["Land_Device_assembled_F","RHS_Mi24Vt_vvs","rhs_mi28n_vvs","Land_TTowerBig_1_F","Land_TTowerBig_2_F","rhs_p37","Land_i_Shed_Ind_F"], 30];

[] call CHAB_fnc_enemycount;

waitUntil { 
	sleep 10; 
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