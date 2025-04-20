
private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];
private _towers = ["land_mobileradar_01_radar_f"];
private _selectedHill = selectRandom (nearestLocations [_center, ["Hill", "ViewPoint"], _axis]);
private _selectedArea = selectRandom (nearestLocations [_center, ["Airport", "NameCity", "NameCityCapital", "NameVillage", "NameLocal"], _axis]);

private _taskMarker = locationPosition _selectedHill;

private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];

[_taskId,west,["Enemy forces have set up a GPS jammer, disrupting our communications and navigation. Your mission is to locate and destroy the jammer, clearing the way for further operations. Expect light to moderate resistance and stay sharp during the approach.","Operation Clear View"], [(_taskMarker select 0) + random 1000, (_taskMarker select 1) + random 1000],"AUTOASSIGNED",10,true,true,"scout",true] call BIS_fnc_setTask;


private _tower = createVehicle [selectRandom _towers, [_taskMarker select 0, _taskMarker select 1, 0], [], 100, "NONE"];

_markerstr = createMarker ["GPSBlackout", locationPosition _selectedArea];
_markerstr setMarkerShape "ELLIPSE";
_markerstr setMarkerSize [3000, 3000];
"GPSBlackout" setMarkerColor "ColorBlack";
"GPSBlackout" setMarkerBrush "SolidFull";
"GPSBlackout" setMarkerAlpha 1;

waitUntil { 
	sleep 10;
	!alive _tower
};

deleteMarker "GPSBlackout";