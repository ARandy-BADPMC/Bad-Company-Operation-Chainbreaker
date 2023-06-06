private _reward = 80;
params ["_base","_current_tasknumber"];
_taskcomp = [
	[
		"ied_factory", 
		"Insurgents set up an IED Factory. To protect our own and the lifes of the innocent population, we need to take it out. If possible, capture the Leader, that is controlling the manufacturing process",
	 	"Locate and Destroy IED Factory",
		{_this call CHAB_fnc_spawn_ins;}
	],
	[
		"weap_factory",
		"Insurgents have set up a Weaponfactory in an abandoned, unmarked FOB. Locate the factory and destroy important equipment. Also, according to one of our agents, a commander is visiting the factory. Try to capture him.",
		"Locate and Destroy Weapon Factory",
		{_this call CHAB_fnc_spawn_nat;}
	]
];
_actualTask = selectRandom _taskcomp;
_actualTask params ["_comp","_desc","_short","_enemySpawnerFunction"];

_capturegroup = createGroup east;

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,[_desc,_short], _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;

_leader = _capturegroup createUnit [OPCB_unitTypes_inf_ins_TL,  _base, [], 2, "NONE"];
_comp = [_comp,_leader, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_houses = nearestObjects [ _base, ["Land_i_Shed_Ind_F"], 100];
_thehouse = selectrandom _houses ;
_leader setPos (_thehouse buildingPos 0);

removeAllWeapons _leader;
_leader setunitpos "middle";
_leader disableAI "PATH"; 

_spawncomps = [_leader] call CHAB_fnc_roadblock_ins;
[_leader,10,1,2] call _enemySpawnerFunction;

waitUntil {
	sleep 2;
	_houses findIf {alive _x } == -1 && {!alive _leader || {_leader distance (getPos dropoffpoint) < 10} }
};


if(!alive _leader) then {
	"The IED factory is destroyed, but the leader is dead." remoteExec ["hint"];
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;

}
else {
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
	publicVariable "OPCB_econ_credits";
	(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
};


[_base] call CHAB_fnc_endmission;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;

[ _comp ] call LARs_fnc_deleteComp;

[_leader] spawn {
	params ["_leader"];
	sleep 60;
	deleteVehicle _leader;
}