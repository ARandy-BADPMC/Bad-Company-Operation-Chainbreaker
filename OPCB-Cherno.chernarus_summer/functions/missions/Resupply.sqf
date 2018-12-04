params ["_base","_current_tasknumber"];
_taskcomp = selectRandom ["fob1","fob2","fob3","fob4","fob5"];
_officergroup = createGroup [west,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,["Nearby friendly forces have requested our help. You have to bring supplies to them. You have abou 15 minutes left before the attack begins.","Resupply"], _current_task,"ASSIGNED",10,true,true,"rearm",true] call BIS_fnc_setTask;
_officer = _officergroup createUnit ["rhsusf_usmc_marpat_d_officer", _base, [], 2, "NONE"];
_officer disableAI "MOVE";

_container = "C_IDAP_supplyCrate_F" createVehicle (getMarkerPos "object_dropoff");
[_container, 5] call ace_cargo_fnc_setSize;
clearItemCargoGlobal _container;
_guardpos = getPos _officer;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_markpos1 = _guardpos getPos[50,random 360];
_markpos2 = _guardpos getPos[50,random 360];
_defender1 = [_markpos1, west,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;
_defender2 = [_markpos2, west,["rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_1stcav","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_m16"]] call BIS_fnc_spawnGroup;

[_defender1, _guardpos, 100] call bis_fnc_taskPatrol;
[_defender2, _guardpos, 100] call bis_fnc_taskPatrol;

[[_defender2,_defender1]] call CHAB_fnc_serverGroups;

waitUntil {
  sleep 5;
  _crate = nearestObjects [ _guardpos, ["C_IDAP_supplyCrate_F"], 100];

  count _crate > 0
};
"You have delivered the supplies. Maybe you should stick around in case the enemies got news about our envoy" remoteExec ["hint"];

_groups = [
	configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad",
	configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_2mg",
	configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_infantry_flora" >> "rhs_group_rus_vdv_infantry_flora_squad_mg_sniper"
];
_nearestplayer = [_officer] call CHAB_fnc_nearest;
if(isnull _nearestplayer) then{ _nearestplayer == officer_jeff};

_dir = [ _officer, _nearestplayer ] call BIS_fnc_dirTo;
_opposite = _dir + 140;

for "_i" from 0 to 5 do {
	_opposite = _opposite +20;
	_attackpos = [0,0,0];
	_tries = 5;

	while {surfaceIsWater _attackpos && _tries >0 } do {
			_attackpos = _guardpos getPos[random [500,700,1000],_opposite];
			_suitable = [_attackpos, 0, 300, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (count _suitable == 3) then {
			  _suitable = [_suitable select 0,_suitable select 1];
			};
			
			_attackpos = _suitable;
			_tries = _tries -1;
		};
if (_tries > 0) then {
	_attacker= [_attackpos, east, selectRandom _groups] call BIS_fnc_spawnGroup;
	_wayp = _attacker addWaypoint [_guardpos, 100];
	_wayp setWaypointType "SAD";

	[_attacker] call CHAB_fnc_serverGroups;
};
	
};
_vehicles = [
configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_gaz66" >> "rhs_group_rus_vdv_gaz66_squad_2mg",
configfile >> "CfgGroups" >> "East" >> "rhs_faction_vdv" >> "rhs_group_rus_vdv_BTR80a" >> "rhs_group_rus_msv_BTR80a_squad_mg_sniper"
];

_opposite = _dir +160;
for "_i" from 0 to 1 do {
	_opposite = _opposite +20;
	_attackpos = [0,0,0];
	_tries = 10;
		
	while {surfaceIsWater _attackpos && _tries >0 } do {
		_attackpos = _guardpos getPos[random [500,700,1000],_opposite];
		_suitable = [_attackpos, 0, 300, 10, 0, 0.7, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
		  _suitable = [_suitable select 0,_suitable select 1];
		};
		
		_attackpos = _suitable;
		_tries = _tries -1;
	};
	if (_tries > 0) then {
		_attacker= [_attackpos, east, selectRandom _vehicles] call BIS_fnc_spawnGroup;
		_wayp = _attacker addWaypoint [_guardpos, 100];
		_wayp setWaypointType "SAD";

		[_attacker] call CHAB_fnc_serverGroups;

	};


};

_trg = createTrigger ["EmptyDetector", _guardpos,true];
_trg setTriggerArea [1200, 1200, 0, false];
_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "", ""];

[_current_tasknumber,_base] call BIS_fnc_taskSetDestination;
waitUntil 
{
	sleep 10;
	 !(alive _officer) || triggerActivated _trg
};

if(!(alive _officer)) then 
{
	"The commander of the FOB is dead and now the supplies are worthless." remoteExec ["hint"];
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
}else
{
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
};

[ _comp ] call LARs_fnc_deleteComp;
deleteVehicle _officer; 
deleteVehicle _container;