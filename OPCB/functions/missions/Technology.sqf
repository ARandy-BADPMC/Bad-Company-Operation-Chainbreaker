private _reward = 60;
params["_base","_current_tasknumber"];

_taskcomp = "generator1";
_guardgroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];

[_current_tasknumber ,west,
["Operation Thunderstrike has been initiated in response to intelligence reports indicating that the Insurgents have successfully infiltrated a local research lab and stolen highly advanced technology. Their nefarious intentions involve auctioning off this technology to the highest bidder, posing a grave threat to global security. The primary objective of Operation Phatom Strike is to neutralize the Insurgents and destroy the stolen device, thus preventing its potential catastrophic consequences.",
"Operation Phantom Strike"], _current_task,"ASSIGNED",10,true,true,"Destroy",true] call BIS_fnc_setTask;

_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_commander, _base, [], 2, "NONE"];
_guardpos = getpos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
[_guard,10,1,2] call CHAB_fnc_spawn_nat;
_destroytargets = nearestObjects [ _guardpos, ["Land_Device_assembled_F"], 30];
_thetarget = selectrandom _destroytargets;

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