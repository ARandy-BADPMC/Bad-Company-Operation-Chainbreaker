params ["_createdVehicle"];

_createdVehicle enableWeaponDisassembly false;
[_createdVehicle, false] remoteExec ["ace_dragging_fnc_setDraggable", 0, true]; 
[_createdVehicle, false] remoteExec ["ace_dragging_fnc_setCarryable", 0, true]; 
_createdVehicle setVariable ["ace_csw_assemblyMode", 0, true];