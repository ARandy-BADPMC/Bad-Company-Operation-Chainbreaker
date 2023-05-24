private _reward = 60;
params ["_base","_current_tasknumber"];
_city = selectRandom Cities;
private ["_crate"];
_citypos = locationPosition _city;
CityMarker setMarkerPos _citypos;

[_current_tasknumber ,west,["Insurgent forces have stolen an ammo crate from a nearby FOB. Retrieve the Ammo crate and find out who is the fugitive.","Retrieve",CityMarker],getMarkerPos CityMarker,"ASSIGNED",10,true,true,"listen",true] call BIS_fnc_setTask;

_guardgroup = createGroup [civilian,true];
_guard = _guardgroup createUnit [OPCB_unitTypes_inf_ins_TL, getMarkerPos CityMarker, [], 2, "NONE"];
_guardpos = getpos _guard;
_taskItems = [_guard] call CHAB_fnc_retrieve_create;
[_guard,5,0,0] call CHAB_fnc_spawn_ins;

_container = _taskItems select 0;
_fugitive = _taskItems select 1;

_guard setDamage 1;

waitUntil {
  sleep 10;
  _crate = nearestObjects [  getpos dropoffpoint, ["ACE_Box_82mm_Mo_Combo"], 100];
  !alive _fugitive && (count _crate >0)
};

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
[_base] call CHAB_fnc_endmission;
deleteVehicle (_crate select 0);