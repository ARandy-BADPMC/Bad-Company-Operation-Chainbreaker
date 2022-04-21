params ["_base","_current_tasknumber"];
_cities = missionNamespace getVariable["Cities",0];
_city = selectRandom _cities;
_citypos = locationPosition _city;
_citymarker = missionNamespace getVariable ["citymarker",_citypos];
_citymarker setMarkerPos _citypos;
[_current_tasknumber ,west,["The area has been overrun by OPFOR. Re-capture it.","Re-capture",_citymarker],getMarkerPos _citymarker,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;
_guardgroup = createGroup [east,true];
_guard = _guardgroup createUnit ["rhs_msv_emr_officer_armored", getMarkerPos _citymarker, [], 2, "NONE"];
_guardpos = getPos _guard;
[_guard] call CHAB_fnc_spawn_city_rus;
_trg = createTrigger ["EmptyDetector", _guardpos,true];
_trg setTriggerArea [450, 450, 0, false];
_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
_trg setTriggerStatements ["this", "", ""];
[_guard,10,2,2] call CHAB_fnc_spawn_rus;

[] call CHAB_fnc_enemycount;
waitUntil {
	sleep 10;
	triggerActivated _trg
};
[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
[_base] call CHAB_fnc_endmission;

deleteVehicle _trg;
