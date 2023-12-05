
private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];
private _towers = ["Land_Communication_F"];
private _selectedHill = selectRandom (nearestLocations [_center, ["Hill"], _axis]);

private _taskMarker = locationPosition _selectedHill;

private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];

[_taskId,west,["Radio Tower disrupting local communications. Take it down","Operation Free Channels"], _taskMarker,"AUTOASSIGNED",10,true,true,"scout",true] call BIS_fnc_setTask;

private _tower = createVehicle [selectRandom _towers, [_taskMarker select 0, _taskMarker select 1, 0], [], 100, "NONE"];

waitUntil { 
	sleep 10;

	!alive _tower
};
