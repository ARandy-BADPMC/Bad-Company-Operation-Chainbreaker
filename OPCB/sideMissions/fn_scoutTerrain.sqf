
private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];
private _towers = ["Land_Communication_F"];
private _selectedHill = selectRandom (nearestLocations [_center, ["Hill", "ViewPoint"], _axis]);

private _taskMarker = locationPosition _selectedHill;
private _hiddenTerrain = nearestTerrainObjects [_taskMarker, ["TREE", "SMALL TREE", "BUSH"], 60, false];
{
	_x hideObjectGlobal true;
} forEach _hiddenTerrain;

private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];

[_taskId,west,["Radio Tower disrupting local communications. Take it down","Operation Free Channels"], _taskMarker,"AUTOASSIGNED",10,true,true,"scout",true] call BIS_fnc_setTask;

private _tower = createVehicle [selectRandom _towers, [_taskMarker select 0, _taskMarker select 1, 0], [], 100, "NONE"];

if (isNull _tower) exitWith {
	{ _x hideObjectGlobal false; } forEach _hiddenTerrain;
	[_taskId, "FAILED", true] call BIS_fnc_taskSetState;
};

waitUntil { 
	sleep 10;

	isNull _tower || {damage _tower >= 1}
};

[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;

sleep 60;
{
	_x hideObjectGlobal false;
} forEach _hiddenTerrain;
deleteVehicle _tower;