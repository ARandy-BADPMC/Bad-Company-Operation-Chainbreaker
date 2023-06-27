private _suitableSpot = [10] call CHAB_fnc_findSpot;

private _crate = (selectRandom SM_Containers) createVehicle _suitableSpot;
[_crate, 40] call ace_cargo_fnc_setSize;

private _taskMarker = _suitableSpot getPos [random 1500, random 360];
private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];

[_taskId,west,["Random Crate Shipment lost somewhere. If you find it and recover it, you might be able to open it. ","Operation Random Crate"],
_taskMarker,"AUTOASSIGNED",10,true,true,"container",true] call BIS_fnc_setTask;

[_suitableSpot,resistance,10, 0, 3, 0, false] call CHAB_fnc_enemySpawner;

[_crate,["<t color='#FF0000'>Open present</t>","[_this select 0] remoteExec ['SM_fnc_openCrate',2];",nil, 1, true, true, "", "_target distance2D (getPos dropoffpoint) < 10", 5]] remoteExecCall ["addAction", 0, true];
