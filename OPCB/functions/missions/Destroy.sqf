private _reward = 100;
params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["warhead1","warhead2","destroy2"];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["During the previous night, an American tank was illicitly taken by hostile forces. The unauthorized possession of this tank poses a significant threat as the adversaries may attempt to extract valuable technology for their own gain. Our mission is to swiftly locate and neutralize the stolen tank, denying the enemy any opportunity to exploit its advanced capabilities. The primary objective of this operation is to swiftly destroy the stolen American tank to prevent the hostile forces from extracting valuable technology. By executing the mission with speed and precision, we will neutralize their capability to utilize the tank against us or gain valuable insights into American military technology.","Operation Steel Reaper"],
 _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

_spawncomps = [_base] call CHAB_fnc_roadblock_rus;

_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_base,resistance] call CHAB_fnc_enemySpawner;

_thetarget = createVehicle ["rhsusf_m1a1aimd_usarmy", _base, [], 1, "NONE"];
_thetarget lock true;

waitUntil {
  sleep 10;
  !canMove _thetarget || {damage _thetarget > 0.8}
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

[_thetarget] spawn {
  params ["_thetarget"];
  sleep 60;
  deleteVehicle _thetarget;
};