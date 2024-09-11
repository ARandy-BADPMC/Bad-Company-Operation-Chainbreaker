params ["_base","_current_tasknumber", "_reward"];
_taskcomp = "narco";
_officergroup = createGroup [west,true];
_narcogroup = createGroup [west,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["After lengthy interrogations by the CIA, a drug lord was brought to this region for negotiations with locals and a U.S. officer. We don't know anything specific, but whoever is paying the bills does not want us to know much more anyway. Bring him to the mansion, where the meeting is being held, and make sure he survives it. He is waiting at the delivery point for pickup.",
"Operation Bloody Bag"], _current_task,"ASSIGNED",10,true,true,"talk",true] call BIS_fnc_setTask;

#include "..\..\data\friendlyClasses.sqf";

_officer = _officergroup createUnit [selectRandom _rhsOfficers, _base, [], 2, "NONE"];
_officer disableAI "PATH";

_narco = _narcogroup createUnit [selectRandom _narcolord, getPos dropoffpoint, [], 5, "NONE"];
_narco disableAI "PATH";

_officerPos = getPos _officer;
_comp = [_taskcomp,_base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_defenders = [];


for "_i" from 0 to 2 do { 
	_markpos = _officerPos getPos[50,random 360];
 	_defender = [_markpos, west,
	_rhsUSF
	] call BIS_fnc_spawnGroup;
	[_defender, _officerPos, 100] call bis_fnc_taskPatrol;
	_defenders pushBack _defender;
};

waitUntil {
  sleep 5;
  !alive _narco || {_narco distance _officerPos < 50} 
};

if(!alive _narco) exitWith {
	"The client was killed. Return to base." remoteExec ["hint"];
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
};

"Ey gringo! My old friends could be unhappy about my return. Be a good soldier and protect us!" remoteExec ["hint"];

_nearestplayer = ([_officer] call CHAB_fnc_nearest) select 0;

_dir = [ _officer, _nearestplayer ] call BIS_fnc_dirTo;
_opposite = _dir + 140;

for "_i" from 0 to 7 do {
	_opposite = _opposite + 50;
	_attackpos = _officerPos getPos[random [700, 900, 1200],_opposite];
	_tries = 5;

	while {
		surfaceIsWater _attackpos && {_tries > 0} 
		} do {
		
		sleep 1;
		_attackpos = _officerPos getPos[random [700, 900, 1200],_opposite];
		_suitable = [_attackpos, 0, 300, 10, 0, 0.5, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
			_suitable = [_suitable select 0,_suitable select 1];
		};
		
		_attackpos = _suitable;
		_tries = _tries -1;
	};
	if (_tries > 0) then {
		_attacker= [_attackpos, east, selectRandom OPCB_InfantryGroups_Insurgents] call BIS_fnc_spawnGroup;
		_wayp = _attacker addWaypoint [_officerPos, 100];
		_wayp setWaypointType "SAD";

		[_attacker] call CHAB_fnc_serverGroups;
	};
	
};

_opposite = _dir + 160;
for "_i" from 0 to 2 do {
	_opposite = _opposite + 50;
	_attackpos = _officerPos getPos[random  [700, 900, 1200],_opposite];
	_tries = 10;
		
	while {surfaceIsWater _attackpos && _tries >0 } do {
		_attackpos = _officerPos getPos[random  [700, 900, 1200],_opposite];
		_suitable = [_attackpos, 0, 300, 10, 0, 0.5, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
		  _suitable = [_suitable select 0,_suitable select 1];
		};
		
		_attackpos = _suitable;
		_tries = _tries -1;
	};
	if (_tries > 0) then {
		_attacker= [_attackpos, east, selectRandom OPCB_MechanizedGroups_Insurgents] call BIS_fnc_spawnGroup;
		{
			(vehicle _x) setVehicleLock "LOCKEDPLAYER";
		} foreach ((units _attacker) select {_x == (effectiveCommander vehicle _x)});
		_wayp = _attacker addWaypoint [_officerPos, 100];
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

[_officer,_narco, _defenders] spawn {
	params ["_officer", "_narco", "_defenders"];
	sleep 60;
	deleteVehicle _officer; 
	deleteVehicle _narco;

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