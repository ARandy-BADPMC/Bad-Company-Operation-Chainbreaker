params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["warhead1","warhead2"];
_guardgroup = createGroup [east,true];
_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["Russians are transporting new technology through to region and will stop for refueling at an old abandoned FOB. Try to secure the object.","Secure"], _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;
_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 1, "NONE"];
_guardpos = getPos _guard;
_spawncomps = [_guard] call CHAB_fnc_roadblock_rus;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
[_guard,10,1,3] call CHAB_fnc_spawn_rus;
_truckpos = _guardpos findEmptyPosition [1, 20, "O_Truck_03_device_F"];
_thetarget = createVehicle ["O_Truck_03_device_F", _truckpos, [], 1, "NONE"];
_thetarget setVehicleAmmo 0;
_thetarget setDamage 0;
waitUntil {
 sleep 10; 
	!(alive _thetarget) || _thetarget distance (getPos dropoffpoint) < 15
};

if(!alive _thetarget) then 
{
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
}
else 
{
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
};
[ _comp ] call LARs_fnc_deleteComp;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach _spawncomps;