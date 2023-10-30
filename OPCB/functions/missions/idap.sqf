private _reward = 60;
params ["_base","_current_tasknumber"];
_taskcomp = "peacekeeper";
_resgroup = createGroup [resistance,true];
_officerGroup = createGroup [civilian,true];

_current_task = _base getPos[random 600,random 360];
[_current_tasknumber ,west,
["IDAP Units have encountered hostile mortar fire at one of their locations, resulting in injuries to both peacekeepers and civilians. The exact origin and motive of the attack are currently unknown. The mission requires immediate investigation and a swift response to ensure the safety of personnel and the local population. The primary objective of this operation is to investigate the hostile attack, identify the responsible individuals or groups, and neutralize their firing positions. By securing the area and gathering actionable intelligence, we will enhance the safety of IDAP personnel and local civilians. Additionally, we aim to prevent future attacks and maintain a secure environment.","Operation Resolute Guard"],
 _current_task,"ASSIGNED",10,true,true,"interact",true] call BIS_fnc_setTask;
 
_officer = _officerGroup createUnit ["B_GEN_Commander_F", _base, [], 2, "NONE"];
_officerPos = getPos _officer;
_comp = [_taskcomp,_officerPos, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;

_reference = [ _comp ] call LARs_fnc_getCompObjects;

_markpos1 = _officerPos getPos[100,random 360];
_defender1 = [_markpos1, civilian,["B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Soldier_F","B_GEN_Commander_F"]] call BIS_fnc_spawnGroup;
[_defender1,150] call CHAB_fnc_shk_patrol;

[[_resgroup,_officerGroup,_defender1]] call CHAB_fnc_serverGroups;
_defender1 deleteGroupWhenEmpty true;
_nearestCity = nearestLocation [ _officerPos, "NameVillage"]; //village only? What if it's a city?
_village = locationPosition _nearestCity;

[_current_tasknumber,_officerPos] call BIS_fnc_taskSetDestination;

([_village, _officer] call CHAB_fnc_artillery) params ["_stations", "_artyGroups"];

[_village, _artyGroups] call CHAB_fnc_idap_fn;

[_officer,["<t color='#FF0000'>Tell me which town is under attack.</t>",
{
	_village = _this select 3 select 0;
	_townName = text _village;
	hint format ["%1 is currently under heavy artillery fire. Please save the Village.",_townName];
}, [_nearestCity], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteExecCall ["addaction",0,true];

ArtilleryRemaining = 4;

waitUntil {
	sleep 1;
	ArtilleryRemaining <= 0 || {!alive _officer}
};

if(!alive _officer) exitWith {
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
} forEach _stations;