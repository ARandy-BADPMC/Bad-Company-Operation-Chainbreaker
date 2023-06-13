private _reward = 60;
params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["warhead1","warhead2"];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["OPFOR is using the old abandoned FOB as a refueling point for transporting new technology through the region. Our mission is to intercept and secure the technology, preventing OPFOR from successfully delivering it and gaining a technological advantage.","Operation Phantom Grab"],
 _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_spawncomps = [_base] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

[_base,east] call CHAB_fnc_enemySpawner;

_truckpos = _base findEmptyPosition [1, 20, "O_Truck_03_device_F"];
_thetarget = createVehicle ["O_Truck_03_device_F", _truckpos, [], 1, "NONE"];
_thetarget setVehicleAmmo 0;
_thetarget setDamage 0;

waitUntil {
 	sleep 2; 
	!alive _thetarget || {_thetarget distance (getPos dropoffpoint) < 15}
};

if(!alive _thetarget) then {
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
}
else {
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
	publicVariable "OPCB_econ_credits";
		
	(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
};

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