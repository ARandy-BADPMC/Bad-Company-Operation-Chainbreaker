private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];

private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];
[_taskId, west, ["Civilian population is in need of supplies. Deliver some to the nearby FOBs.","Operation Free Supplies"], _center,"AUTOASSIGNED",10,true,true,"meet",true] call BIS_fnc_setTask;

private _noSupplyPoints = random [1, 2, 3];
private _comps = [];
private _trucks = [];

for "_i" from 1 to _noSupplyPoints do { 

	private _base = [85] call CHAB_fnc_findSpot;
	private _comp = ["peacekeeper", _base, [0,0,0], random 360, true, true ] call LARs_fnc_spawnComp;
	_comps pushBack _comp;

	private _taskIdIter = format ["SM_TaskNumber_%1_%2",SM_TaskNumber, _i];
	[_taskIdIter, west, ["Civilian FOB","Deliver FOB supplies"], _base,"AUTOASSIGNED",10,true,true,format ["talk%1", _i],true] call BIS_fnc_setTask;

	private _container = createVehicle ["LOP_IA_HEMTT_Ammo_D", getpos dropoffpoint, [], 30, "NONE"];
	[_container, 5000] call ace_cargo_fnc_setSize;
	clearItemCargoGlobal _container;
	_trucks pushBack _container;

	[_taskIdIter, _base] spawn {
		params ["_taskId", "_basePos"];
		waitUntil {
			sleep 10;

			private _truck = nearestObject [_basePos, "LOP_IA_HEMTT_Ammo_D"];

			!isNull _truck
		};

		[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;
	};
}; 

waitUntil { 
	sleep 10;

	private _canFinish = false;
	for "_i" from 1 to _noSupplyPoints do { 
		private _taskIdIter = format ["SM_TaskNumber_%1_%2",SM_TaskNumber, _i];

		if( (_taskIdIter call BIS_fnc_taskState) != "SUCCEEDED" ) exitWith {
			_canFinish = false;
		};
		_canFinish = true;
	};

	_canFinish
};

[_comps, _trucks] spawn {
	params ["_comps", "_trucks"];
	sleep 120;

	{
		[ _x ] call LARs_fnc_deleteComp;
	} forEach _comps;
	{
		deleteVehicle _x;
	} forEach _trucks;
};

