private _reward = 100;
params ["_base","_current_tasknumber"];
_taskcomp = "druglord";
_officergroup = createGroup [east,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,east,["We have located a local drug-lord, who is one of the main financers of the Insurgents. Take him out, but be careful; if enemy forces notice it, they might send reinforcements, to revenge his death.","El Chapo"], _current_task,"ASSIGNED",10,true,true,"rearm",true] call BIS_fnc_setTask;
_officer = _officergroup createUnit ["rhsusf_usmc_marpat_d_officer", _base, [], 2, "NONE"];
_officer disableAI "MOVE";

_guardpos = getPos _officer;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_markpos1 = _guardpos getPos[50,random 360];
_markpos2 = _guardpos getPos[50,random 360];
_defender1 = [_markpos1, east,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;
_defender2 = [_markpos2, east,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;

[_defender1, _guardpos, 100] call bis_fnc_taskPatrol;
[_defender2, _guardpos, 100] call bis_fnc_taskPatrol;

[[_defender2,_defender1]] call CHAB_fnc_serverGroups;

waitUntil {
  sleep 5;
  (!(alive _officer)) then
};
"The Leader is dead. Prepare for an attack!" remoteExec ["hint"];

_nearestplayer = [_officer] call CHAB_fnc_nearest;
if(isnull _nearestplayer) then{ _nearestplayer == officer_jeff};

_dir = [ _officer, _nearestplayer ] call BIS_fnc_dirTo;
_opposite = _dir + 140;

for "_i" from 0 to 5 do {
	_opposite = _opposite +20;
	_attackpos = globalWaterPos;
	_tries = 5;

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

_handle = [33] spawn CHAB_fnc_enemycount;

[_current_tasknumber,_base] call BIS_fnc_taskSetDestination;
waitUntil 
{
	sleep 10;
	!alive _officer || {scriptDone _handle }
};

{
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
};
[_base] call CHAB_fnc_endmission;
[ _comp ] call LARs_fnc_deleteComp;