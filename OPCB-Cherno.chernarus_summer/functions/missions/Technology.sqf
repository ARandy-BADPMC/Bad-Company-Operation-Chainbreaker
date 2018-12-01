params["_base","_current_tasknumber"];
_taskcomp = "generator1";
_guardgroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["We have reports, that the Insurgents stole new technology from a local research lab. They are planning to sell it to the highest bidder, which could have horrible consequences. Don`t let this happen!","Destroy Technology"], _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;
_guard = _guardgroup createUnit ["rhsgref_nat_commander", _base, [], 2, "NONE"];
_guardpos = getpos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
[_guard,10,1,2] call CHAB_fnc_spawn_nat;
_destroytargets = nearestObjects [ _guardpos, ["Land_Device_assembled_F"], 30];
_thetarget = selectrandom _destroytargets;
waitUntil { 
	sleep 10; 
	!(alive _thetarget) || (damage _thetarget > 0.8)
};
[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
[ _comp ] call LARs_fnc_deleteComp;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;