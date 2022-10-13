private _reward = 60;
params ["_base","_current_tasknumber"];
_taskcomp = "ied_factory";
_capturegroup = createGroup resistance;

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["Insurgents set up an IED Factory. To protect our own and the lifes of the innocent population, we need to take it out. If possible, capture the Leader, that is controlling the manufacturing process","Locate and Destroy IED Factory"], _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;
_leader = _capturegroup createUnit ["rhs_g_Soldier_TL_F",  _base, [], 2, "NONE"];
_comp = [_taskcomp,_leader, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_house = nearestObjects [ _base, ["Land_i_Shed_Ind_F"], 100];
_thehouse = selectrandom _house ;
_leader setPos (_thehouse buildingPos 0);
removeAllWeapons _leader;
_leader setunitpos "middle";
_spawncomps = [_leader] call CHAB_fnc_roadblock_ins;
[_leader,10,1,2] call CHAB_fnc_spawn_ins;
waitUntil 
{
	sleep 10;
	!alive _thehouse
};
waitUntil {
  sleep 10;			
  (_leader distance (getPos dropoffpoint) < 10) || !alive _leader
};
[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
if(!(alive _leader)) then 
{
	"The IED factory is destroyed, but the leader is dead." remoteExec ["hint"];
};
[_base] call CHAB_fnc_endmission;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;
[ _comp ] call LARs_fnc_deleteComp;