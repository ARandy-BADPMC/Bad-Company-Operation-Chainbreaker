private _reward = 60;
params ["_base","_current_tasknumber"];

_taskcomp = selectRandom ["insurgent1","insurgent2","insurgent3","insurgent4","insurgent_big","insurgent_hostage"];
_capturegroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];

[_current_tasknumber ,west,["A high-ranking officer from the insurgent faction has been identified at their camp, posing a valuable opportunity for intelligence gathering. Our mission is to capture this officer alive, enabling us to extract vital information that could aid in dismantling the insurgent network and ensuring regional stability. The primary objective of this operation is to capture the high-ranking officer at the insurgents' camp for subsequent interrogation. By successfully extracting critical intelligence from the officer, we aim to unravel the inner workings of the insurgent faction, disrupt their operations, and enhance regional security.","Operation Silent Intercept"], _current_task,"ASSIGNED",10,true,true,"search",true] call BIS_fnc_setTask;

_target1 = _capturegroup createUnit [selectRandom OPCB_Commanders_Insurgents, _base, [], 2, "NONE"];
_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_base,resistance] call CHAB_fnc_enemySpawner;

removeAllWeapons _target1;
_target1 disableAI "AUTOCOMBAT";
_target1 setunitpos "middle";
_spawncomps = [_base] call CHAB_fnc_roadblock_ins;
waitUntil {
	sleep 2;
	!alive _target1 || {_target1 distance (getPos dropoffpoint) < 10}
};

if(alive _target1) then {
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
	publicVariable "OPCB_econ_credits";
		
	(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
}
else {
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
};

[_base] call CHAB_fnc_endmission;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;

[ _comp ] call LARs_fnc_deleteComp;

[_target1] spawn {
	params ["_target1"];
	sleep 60;
	deleteVehicle _target1;
};