private _reward = 140;
params ["_base","_current_tasknumber"];
_taskcomp = "gdrunken";

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["The insurgents have gained possession of a fraction of a significant vehicle shipment, primarily aimed at reinforcing their disorganized mechanized troops. These forces are expected to consist mainly of IFVs/AFVs/APCs and MBTs. Our intelligence reveals that the insurgents have mobilized certain groups and are preparing to initiate movement. The primary objective of this operation is to swiftly eliminate the insurgent's vehicle threat within the AO while disrupting their logistical support by neutralizing any FOBs or repair depots encountered. By executing this mission with precision and speed, we will significantly degrade the insurgent's mechanized capabilities and restore peace and security to the region.","Operation Battlefield Purge"],
 _current_task,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
_reference = [ _comp ] call LARs_fnc_getCompObjects;

_trucks = [];
private _tanktype = "";
for "_i" from 0 to 3 do {
	_tanktype = selectRandom OPCB_ArmoredVehicles_OPFOR;
	_truckpos = _base findEmptyPosition [1, 20, _tanktype];
	_thetarget = createVehicle [_tanktype, _truckpos, [], 1, "NONE"];
	_thetarget setVehicleLock "LOCKEDPLAYER";
	_thetarget setFuel 0; 
	_thetarget setDamage 0;
	_trucks pushBack _thetarget;
};

_stations = [_base] call CHAB_fnc_gdrunken_spawn;

_trucks append (_stations select 1);

[_base,resistance] call CHAB_fnc_enemySpawner;

waitUntil {
	sleep 5;
	_trucks findIf {alive _x } == -1
};

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];

[_base] call CHAB_fnc_endmission;
[ _comp ] call LARs_fnc_deleteComp;

{
  [ _x ] call LARs_fnc_deleteComp;
} forEach (_stations select 0);
_reference append _trucks;

[_reference] spawn {
	params ["_reference"];
	{
		if(typeName _x == "GROUP") then {
			{
				deleteVehicle _x;
			} forEach (units _x);
			deleteGroup _x;
		}
		else{
			deleteVehicle _x;
		};
	} forEach _reference;
}