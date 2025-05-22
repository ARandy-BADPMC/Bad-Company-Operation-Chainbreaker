private _axis = worldSize / 2;
private _center = [_axis, _axis , 0];

private _taskId = format ["SM_TaskNumber_%1", SM_TaskNumber];
[_taskId, west, [
	"Our logistics performance has been substandard as of late, and friendly units in the field are urgently requesting resupply to maintain operational effectiveness.",
	"Operation Slow Resupply"
], _center, "AUTOASSIGNED", 10, true, true, "meet", true] call BIS_fnc_setTask;

private _noSupplyPoints = random [1, 2, 3];
private _comps = [];
private _trucks = [];

for "_i" from 1 to _noSupplyPoints do {
	private _base = [85] call CHAB_fnc_findSpot;
	private _comp = ["fob4", _base, [0,0,0], random 360, true, true] call LARs_fnc_spawnComp;
	_comps pushBack _comp;

	private _taskIdIter = format ["SM_TaskNumber_%1_%2", SM_TaskNumber, _i];
	[_taskIdIter, west, ["Military FOB", "Deliver FOB supplies"], _base, "AUTOASSIGNED", 10, true, true, format ["talk%1", _i], true] call BIS_fnc_setTask;

	private _container = createVehicle ["rhsusf_m113d_usarmy_unarmed", getPos dropoffpoint1, [], 30, "NONE"];
	[_container, 5000] call ace_cargo_fnc_setSize;
	clearItemCargoGlobal _container;
	_trucks pushBack _container;

	[_taskIdIter, _base] spawn {
	params ["_taskIdIter", "_basePos"];
	waitUntil {
		sleep 10;
		private _truck = nearestObject [_basePos, "rhsusf_m113d_usarmy_unarmed"];
		!isNull _truck && _truck distance2D _basePos < 30
	};

	private _truck = nearestObject [_basePos, "rhsusf_m113d_usarmy_unarmed"];

	[_taskIdIter, "SUCCEEDED", true] call BIS_fnc_taskSetState;

		sleep 2; 

		
		if (!isNull _truck) then {
			_truck lock true;
			{
				if (isPlayer _x) then {
					moveOut _x;
				};
			} forEach crew _truck;
		};
	};
};

waitUntil {
	sleep 10;
	private _canFinish = false;
	for "_i" from 1 to _noSupplyPoints do {
		private _taskIdIter = format ["SM_TaskNumber_%1_%2", SM_TaskNumber, _i];
		if ((_taskIdIter call BIS_fnc_taskState) != "SUCCEEDED") exitWith {
			_canFinish = false;
		};
		_canFinish = true;
	};
	_canFinish
};

[_taskId, "SUCCEEDED", true] call BIS_fnc_taskSetState;

[_comps, _trucks] spawn {
	params ["_comps", "_trucks"];
	sleep 120;

	{
		[_x] call LARs_fnc_deleteComp;
	} forEach _comps;

	{
		deleteVehicle _x;
	} forEach _trucks;
};