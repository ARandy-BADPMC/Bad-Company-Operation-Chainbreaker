private _reward = 60;
params ["_base","_current_tasknumber"];
_taskcomp = "peacekeeper";
_resgroup = createGroup [resistance,true];
_guardgroup = createGroup [civilian,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["IDAP Units have reported indirect and small arms fire on one of their locations, wounding several peacekeepers and civilians. You are tasked, to investigate, interrogate survivors, locate the enemy firing-positions and take them, including all the equipment, out. Be aware of counterattacks!","Locate Mortars"],
 _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;
 
_guard = _guardgroup createUnit ["B_GEN_Commander_F", _base, [], 2, "NONE"];
_guardpos = getPos _guard;
_comp = [_taskcomp,_guardpos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_reference = [ _comp ] call LARs_fnc_getCompObjects;

_markpos1 = _guardpos getPos[100,random 360];
_defender1 = [_markpos1, civilian,["B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Commander_F"]] call BIS_fnc_spawnGroup;
[_defender1,150] call CHAB_fnc_shk_patrol;

[[_resgroup,_guardgroup,_defender1]] call CHAB_fnc_serverGroups;
_defender1 deleteGroupWhenEmpty true;
_nearestCity = nearestLocation [ _guardpos, "NameVillage"]; //village only? What if it's a city?
_village = locationPosition _nearestCity;

[_current_tasknumber,_guardpos] call BIS_fnc_taskSetDestination;

_stations = [_village,_guard] call CHAB_fnc_artillery;

[_village,(_stations select 1)] call CHAB_fnc_idap_fn;
[_guard,["<t color='#FF0000'>Tell me which town is under attack.</t>",
{
	_village = _this select 3 select 0;
	_townName = text _village;
	hint format ["%1 is currently under heavy artillery fire. Please save the Village.",_townName];
}, [_nearestCity], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteExecCall ["addaction",0,true];

ArtilleryRemaining = 4;

waitUntil {
	sleep 1;
	ArtilleryRemaining <= 0 || {!alive _guard}
};

if(!alive _guard) exitWith {
	ArtilleryRemaining = 0;
	"Mission failed. The IDAP officer is dead. " remoteExec ["hint"];
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
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

[_reference] spawn {
	params ["_reference"];
	sleep 60;
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
};