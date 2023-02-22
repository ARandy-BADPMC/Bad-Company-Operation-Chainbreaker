private _reward = 40;
params ["_base","_current_tasknumber"];

_cities = missionNamespace getVariable["Cities",0];
_city = selectRandom _cities;
_citypos = locationPosition _city;

_citymarker = missionNamespace getVariable ["citymarker",_citypos];
_citymarker setMarkerPos _citypos;

[_current_tasknumber ,west,["There is a riot going on. Clear out the area and capture the leader. We also have intel of two captured journalists, which need to be rescued.","Clear out and rescue",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;

_guardgroup = createGroup [east,true];
_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_TL, getMarkerPos _citymarker, [], 2, "NONE"];
removeAllWeapons _guard;
_guard disableAI "AUTOCOMBAT";
_guard setunitpos "MIDDLE";
_rescuegroup = createGroup [civilian,true];

_guardpos = getPos _guard;
_houses = nearestObjects [_guardpos, ["house"], 200];
_house1 = selectRandom _houses;
_house2 = selectRandom _houses;

_positions1 = [_house1] call BIS_fnc_buildingPositions;
_positions2 = [_house2] call BIS_fnc_buildingPositions;

while {count _positions1 == 0} do {
  _house1 = selectRandom _houses;
  _positions1 = [_house1] call BIS_fnc_buildingPositions;
};
while {count _positions2 == 0} do {
  _house2 = selectRandom _houses;
  _positions2 = [_house2] call BIS_fnc_buildingPositions;
};

_pos1max = count _positions1;
_pos2max = count _positions2;

_journal1 = _rescuegroup createUnit ["C_journalist_F", _guardpos, [], 2, "NONE"];
_journal2 = _rescuegroup createUnit ["C_journalist_F", _guardpos, [], 2, "NONE"];

_journal1 setPosATL (_house1 buildingpos (_pos1max -1)); 
_journal2 setPosATL (_house2 buildingpos (_pos2max -1)); 

[_journal1, true] call ACE_captives_fnc_setSurrendered;
[_journal2, true] call ACE_captives_fnc_setSurrendered;

[_guard] call CHAB_fnc_spawn_city_ins;

_trg = createTrigger ["EmptyDetector", _guardpos,true];
_trg setTriggerArea [600, 600, 0, false];
_trg setTriggerActivation ["GUER", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "", ""];
[_guard,10,1,1] call CHAB_fnc_spawn_ins;
[] call CHAB_fnc_enemycount;

waitUntil 
{
	sleep 10;
	triggerActivated _trg
};
waitUntil {
  sleep 2;
  _journal1 distance (getPos dropoffpoint) < 10 || !alive _journal1
};
waitUntil {
  sleep 2;
  _journal2 distance (getPos dropoffpoint) < 10 || !alive _journal2
};

waitUntil {
  sleep 2;
  _guard distance (getPos dropoffpoint) < 10 || !alive _guard
};

if(!alive _guard) then { "The task is completed but the leader is dead." remoteExec ["hint"];};
if(alive _guard && alive _journal1 && alive _journal2)
then
{
	[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
	OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
}
else
{
	[_current_tasknumber, "FAILED",true] call BIS_fnc_taskSetState;
};
[_base] call CHAB_fnc_endmission;
deleteVehicle _journal1;
deleteVehicle _journal2;
deleteVehicle _guard;
deleteVehicle _trg;