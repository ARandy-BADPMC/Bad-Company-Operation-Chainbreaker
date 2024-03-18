params ["_current_tasknumber", "_reward"];

_city = selectRandom Cities;
_citypos = locationPosition _city;
CityMarker setMarkerPos _citypos;

[_current_tasknumber ,west,["Insurgent forces have stolen an ammo crate from a nearby FOB, jeopardizing the security and operational capabilities of friendly forces. Our mission is to recover the stolen ammo crate, ensuring its safe return, and capture the fugitive to disrupt enemy operations and gather valuable intelligence. The primary objective of this operation is to recover the stolen ammo crate and apprehend the fugitive responsible. By successfully completing this mission, we aim to restore the operational capabilities of friendly forces, disrupt enemy activities, and gather valuable intelligence to enhance future operations.","Operation Secure and Recover",CityMarker],_citypos,"ASSIGNED",10,true,true,"listen",true] call BIS_fnc_setTask;


_taskItems = [_citypos] call CHAB_fnc_retrieve_create;
[_citypos,resistance] call CHAB_fnc_enemySpawner;

_container = _taskItems select 0;
_fugitive = _taskItems select 1;

waitUntil {
  sleep 5;
  !alive _fugitive && { _container distance (getpos dropoffpoint) < 10}
};

[_current_tasknumber, "SUCCEEDED",true] call BIS_fnc_taskSetState;
OPCB_econ_credits = OPCB_econ_credits + _reward;
publicVariable "OPCB_econ_credits";
    
(format ["You earned %1 C for successfully completing the mission!", _reward]) remoteExec ["hint"];
[_citypos] call CHAB_fnc_endmission;

[_container, _fugitive] spawn {
  params ["_container","_fugitive"];
  sleep 60;
  deleteVehicle _container;
  deleteVehicle _fugitive;
};