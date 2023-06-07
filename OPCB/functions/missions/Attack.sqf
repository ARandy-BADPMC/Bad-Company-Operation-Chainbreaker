private _reward = 40;
params ["_current_tasknumber"];

_city = selectRandom Cities;
_citypos = locationPosition _city;

CityMarker setMarkerPos _citypos;

[_current_tasknumber ,west,["The area has fallen under the control of OPFOR, jeopardizing the safety and stability of the region. Our mission is to reclaim the area, neutralize the enemy forces, and restore order to prevent further harm to the local population. The primary objective of this operation is to re-capture the area overrun by OPFOR and re-establish control. By swiftly neutralizing the enemy forces and restoring stability, we aim to create a secure environment that allows for the safe return of the local population and the resumption of normal activities.","Operation Victory Reclaim",CityMarker],_citypos,"ASSIGNED",10,true,true,"attack",true] call BIS_fnc_setTask;
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
