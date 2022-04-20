params ["_base","_current_tasknumber"];
_taskcomp = "gdrunken";
_guardgroup = createGroup [resistance,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["The insurgents have received a fraction of a large shipment of vehicles, mostly focused on reinforcing their poorly organised mechanized groups. These groups mostly consists of IFVs/AFVs/APCs and MBTs. The task is all but simple. Our scouts report that the Insurgents have already mobilized some of their groups and are about to move out. Your job is to enter the AO and destroy the Insurgent vehicles that are located within the AO itself and clear out established FOBs or repair depots if there are any.","Tracked Nightmare"], _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;
_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", _base, [], 2, "NONE"];
_guardpos = getPos _guard;

_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
_reference = [ _comp ] call LARs_fnc_getCompObjects;

_trucks = [];
for "_i" from 0 to 3 do {
	_truckpos = _guardpos findEmptyPosition [1, 20, "RHS_T72BB_chdkz"];
	_thetarget = createVehicle ["RHS_T72BB_chdkz", _truckpos, [], 1, "NONE"];
	_thetarget setFuel 0; 
	_thetarget setDamage 0;
	_trucks pushBack _thetarget;
};

_stations = [_guardpos] call CHAB_fnc_gdrunken_spawn;

{
	_trucks pushBack _x;
} forEach (_stations select 1);

[_guard,3,0,6] call CHAB_fnc_spawn_ins;

waitUntil {
sleep 10;
	_done = true;
	{
		if (alive _x) exitWith {
		  _done = false;
		};
	} forEach _trucks;
	_done
};

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;

[_base] call CHAB_fnc_endmission;
[ _comp ] call LARs_fnc_deleteComp;
{
  [ _x ] call LARs_fnc_deleteComp;
} forEach (_stations select 0);

{
	if(typeName _x == "GROUP") then
	{
		{
		  deleteVehicle _x;
		} forEach (units _x);
		deleteGroup _x;
	}
	else{
		deleteVehicle _x;
	};
} forEach _reference;

