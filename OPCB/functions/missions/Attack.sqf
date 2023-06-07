private _reward = 40;
params ["_current_tasknumber"];

_city = selectRandom Cities;
_citypos = locationPosition _city;

CityMarker setMarkerPos _citypos;

[_current_tasknumber ,west,["The area has been overrun by OPFOR. Re-capture it.","Re-capture",CityMarker],_citypos,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;
_guardgroup = createGroup [east,true];
_guard = _guardgroup createUnit [OPCB_unitTypes_inf_commander, _citypos, [], 2, "NONE"];
_guardpos = getPos _guard;

[_guard] call CHAB_fnc_spawn_city_rus;

[_guard,10,2,2] call CHAB_fnc_spawn_rus;

deleteVehicle _guard;

[] call CHAB_fnc_enemycount;

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
[_citypos] call CHAB_fnc_endmission;
