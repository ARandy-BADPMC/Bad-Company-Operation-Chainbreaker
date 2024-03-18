private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];
private _selectedForest = selectRandom (nearestLocations [_center, ["VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard"], _axis]);

private _taskMarker = locationPosition _selectedForest;

private _flower = createVehicle ["Land_FlowerPot_01_F", [_taskMarker select 0, _taskMarker select 1, 0], [], 5, "NONE"];

{
	_flower setVariable _x
} forEach [
	["axisA", "100"],
	["axisB", "100"],
	["minesCount", "10"],
	["minesType", "rhs_mine_TM43"],
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

