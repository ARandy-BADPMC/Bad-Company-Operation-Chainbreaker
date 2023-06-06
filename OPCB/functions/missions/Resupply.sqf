private _reward = 100;
params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["fob1","fob2","fob3","fob4","fob5"];
_officergroup = createGroup [west,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["Nearby friendly forces have requested our help. You have to bring supplies to them. You have abou 15 minutes left before the attack begins.",
"Resupply"], _current_task,"ASSIGNED",10,true,true,"rearm",true] call BIS_fnc_setTask;

_officer = _officergroup createUnit ["rhsusf_usmc_marpat_d_officer", _base, [], 2, "NONE"];
_officer disableAI "PATH";

_container = "C_IDAP_supplyCrate_F" createVehicle (getPos dropoffpoint);
[_container, 5] call ace_cargo_fnc_setSize;
clearItemCargoGlobal _container;
_guardpos = getPos _officer;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_defenders = [];

#include "..\..\data\friendlyClasses.sqf";

for "_i" from 0 to 2 do { 
	_markpos = _guardpos getPos[50,random 360];
 	_defender = [_markpos, west,
	_rhsUSF
	] call BIS_fnc_spawnGroup;
	[_defender, _guardpos, 100] call bis_fnc_taskPatrol;
	_defenders pushBack _defender;
};

waitUntil {
  sleep 5;
  !alive _container || {_container distance _guardpos < 100} 
};

if(!alive _container) exitWith {
	"The container is destroyed. There aer no more supplies. You have failed this one. " remoteExec ["hint"];
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
};

"You have delivered the supplies. Maybe you should stick around in case the enemies got news about our envoy!" remoteExec ["hint"];

_nearestplayer = [_officer] call CHAB_fnc_nearest;

_dir = [ _officer, _nearestplayer ] call BIS_fnc_dirTo;
_opposite = _dir + 140;

for "_i" from 0 to 5 do {
	_opposite = _opposite +20;
	_attackpos = globalWaterPos;
	_tries = 5;

	while {
		surfaceIsWater _attackpos && {_tries > 0} 
		} do {
		
		sleep 1;
		_attackpos = _guardpos getPos[random [500,700,1000],_opposite];
		_suitable = [_attackpos, 0, 300, 10, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
			_suitable = [_suitable select 0,_suitable select 1];
		};
		
		_attackpos = _suitable;
		_tries = _tries -1;
	};
	if (_tries > 0) then {
		_attacker= [_attackpos, east, selectRandom OPCB_unitTypes_grp_inf] call BIS_fnc_spawnGroup;
		_wayp = _attacker addWaypoint [_guardpos, 100];
		_wayp setWaypointType "SAD";

		[_attacker] call CHAB_fnc_serverGroups;
	};
	
};

_opposite = _dir +160;
for "_i" from 0 to 1 do {
	_opposite = _opposite +20;
	_attackpos = globalWaterPos;
	_tries = 10;
		
	while {surfaceIsWater _attackpos && _tries >0 } do {
		_attackpos = _guardpos getPos[random [500,700,1000],_opposite];
		_suitable = [_attackpos, 0, 300, 10, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
		  _suitable = [_suitable select 0,_suitable select 1];
		};
		
		_attackpos = _suitable;
		_tries = _tries -1;
	};
	if (_tries > 0) then {
		_attacker= [_attackpos, east, selectRandom OPCB_unitTypes_grp_mech] call BIS_fnc_spawnGroup;
		{
			(vehicle _x) setVehicleLock "LOCKED";
		} foreach ((units _attacker) select {_x == (effectiveCommander vehicle _x)});
		_wayp = _attacker addWaypoint [_guardpos, 100];
		_wayp setWaypointType "SAD";

		[_attacker] call CHAB_fnc_serverGroups;

	};


};

_handle = [] spawn CHAB_fnc_enemycount;


[_current_tasknumber,_base] call BIS_fnc_taskSetDestination;

waitUntil {
	sleep 2;
	!alive _officer || {scriptDone _handle}
};

if(!alive _officer) then {
	"The commander of the FOB is dead and now the supplies are worthless." remoteExec ["hint"];
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
}else {
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
	publicVariable "OPCB_econ_credits";
		
	(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
};

[_base] call CHAB_fnc_endmission;

[ _comp ] call LARs_fnc_deleteComp;

[_officer,_container, _defenders] spawn {
	params ["_officer", "_container", "_defenders"];
	sleep 60;
	deleteVehicle _officer; 
	deleteVehicle _container;

	{
		{
			_vehicle = vehicle _x;
			if (_vehicle != _x) then {
				deleteVehicleCrew _vehicle;
				deleteVehicle _vehicle;
			};
			deletevehicle _x;
		} forEach units _x;
		deleteGroup _x;
	} forEach _defenders;

}