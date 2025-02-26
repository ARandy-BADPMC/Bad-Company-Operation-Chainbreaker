params ["_flowerPot"];
_taskcomp = "samsite";
private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];
private _sams = ["O_SAM_System_04_F"];
private _targetPos = [_comp] call CHAB_fnc_findFlowerPots;
_base = [_radius] call CHAB_fnc_findSpot;
_radius = 100;

private _taskMarker = locationPosition _base;

private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];

[_taskId,west,["Recon has found an enemy SAM site that is currently interdicting our air capabilities. The task is simple: destroy the missile launcher.","Operation Free Skies"], _taskMarker,"AUTOASSIGNED",10,true,true,"scout",true] call BIS_fnc_setTask;

private _sam = createVehicle [selectRandom _sams, [_taskMarker select 0, _taskMarker select 1, 0], [], 100, "NONE"];

waitUntil { 
	sleep 10;

	!alive _sam
};
