params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["warhead1","warhead2","destroy2"];
_guardgroup = createGroup [east,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["Last night an american Tank was stolen. You are tasked with destroying it as quickly as possible, before media notice","Destroy"], _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;
_guard = _guardgroup createUnit ["rhsgref_nat_commander", _base, [], 2, "NONE"];
_guardpos = getpos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
[_guard,10,2,1] call CHAB_fnc_spawn_nat;
_thetarget = createVehicle ["rhsusf_m1a1aimd_usarmy", _guardpos, [], 1, "NONE"];
_thetarget lock true;
waitUntil { sleep 10; !(alive _thetarget) || (damage _thetarget > 0.8)};
[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
[_base] call CHAB_fnc_endmission;
[ _comp ] call LARs_fnc_deleteComp;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;