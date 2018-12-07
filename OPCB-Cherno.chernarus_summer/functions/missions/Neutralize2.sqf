params ["_base","_current_tasknumber"];

_taskcomp = "weap_factory";
_capturegroup = createGroup [resistance,true];
_current_task = _base getPos[random 600,random 360];

[_current_tasknumber ,west,["Insurgents have set up a Weaponfactory in an abandoned, unmarked FOB. Locate the factory and destroy important equipment. Also, according to one of our agents, a commander is visiting the factory. Try to capture him.","Locate and Destroy Weapon Factory"], _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;

_leader = _capturegroup createUnit ["rhsgref_nat_commander",  _base, [], 2, "NONE"];
_comp = [_taskcomp,_leader, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_house = nearestObjects [ _base, ["Land_i_Shed_Ind_F"], 100];
_thehouse = selectRandom _house;
_leader setPos (_thehouse buildingPos 0);
removeAllWeapons _leader;
_leader setunitpos "middle";
[_leader,10,1,2] call CHAB_fnc_spawn_nat;
_spawncomps = [_leader] call CHAB_fnc_roadblock_ins;
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
if(!alive _leader) then 
{
		"The Weapon Factory is destroyed, but the commander is dead." remoteExec ["hint"];				
};
[_base] call CHAB_fnc_endmission;
[ _comp ] call LARs_fnc_deleteComp;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;