private _reward = 60;
params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["insurgent1","insurgent2","insurgent3","insurgent4","insurgent_big","insurgent_hostage"];
_capturegroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["A high ranking officer has arrived at an Insurgent camp near the marked area. You have to Capture him","Capture the HRO"], _current_task,"ASSIGNED",10,true,true,"search",true] call BIS_fnc_setTask;
_target1 = _capturegroup createUnit ["rhs_g_Soldier_TL_F", _base, [], 2, "NONE"];
_guardpos = getPos _target1;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
[_target1,10,1,2] call CHAB_fnc_spawn_ins;
removeAllWeapons _target1;
_target1 disableAI "AUTOCOMBAT";
_target1 setunitpos "middle";
_spawncomps = [_target1] call CHAB_fnc_roadblock_ins;
waitUntil 
{
	sleep 10;
	_target1 distance (getPos dropoffpoint) < 10 || !alive _target1
};
if(alive _target1) then 
{
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
}

else
{
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
};
[_base] call CHAB_fnc_endmission;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;
[ _comp ] call LARs_fnc_deleteComp;