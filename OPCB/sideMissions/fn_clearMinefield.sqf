private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];
private _selectedArea = [random [0, worldSize / 2, worldSize], random [0, worldSize / 2, worldSize]];
private _selectedRoad = [_selectedArea, worldSize / 2] call BIS_fnc_nearestRoad;
private _taskMarker = getpos _selectedRoad;

private _flower = createVehicle ["Land_FlowerPot_01_F", [_taskMarker select 0, _taskMarker select 1, 0], [], 5, "NONE"];

{
	_flower setVariable _x
} forEach [
	["axisA", "70"],
	["axisB", "70"],
	["minesCount", "10"],
	["minesType", ["rhs_mine_TM43", "rhs_mine_glasmine43_bz"]],
	["shape", "rectangle"]
];

private _mines = [_flower] call SM_fnc_minefield;

deleteVehicle _flower;

private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];

[_taskId, west, ["Opposition has laid Mines nearby. Clear it.","Operation Free Movement"], _taskMarker,"AUTOASSIGNED",10,true,true,"mine",true] call BIS_fnc_setTask;

waitUntil { 
	sleep 10;

	({ mineActive _x } count _mines) == 0
};

[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;