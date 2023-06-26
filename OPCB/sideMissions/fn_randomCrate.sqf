//todo

private _suitableSpot = [10] call CHAB_fnc_findSpot;

private _crate = (selectRandom SM_Containers) createVehicle _suitableSpot;

private _taskMarker = _suitableSpot getPos [random 1500, random 360];
private _taskId = format ["SM_TaskNumber_%1",SM_TaskNumber];

[_taskId,west,["Random Crate Shipment lost somewhere. If you find it and recover it, you might be able to open it. ","Operation Random Crate"],
_taskMarker,"AUTOASSIGNED",10,true,true,"container",true] call BIS_fnc_setTask;

[_suitableSpot,resistance,10, 0, 3, 0, false] call CHAB_fnc_enemySpawner;

OpenPresent = {
	params ["_crate"];
	_vehicles = ["RHSUSF_M1151_MK19_V2_USARMY_D", "RHSUSF_M1240A1_M240_USARMY_D", "RHSUSF_M1078A1P2_B_M2_D_FMTV_USARMY", "RHSUSF_M1232_MC_MK19_USMC_D", "RHSUSF_M1085A1P2_B_D_MEDICAL_FMTV_USARMY"];
	_chosen = selectRandom _vehicles;

	_cratePos = getPos _crate;
	deleteVehicle _crate;

	_tank = createVehicle [_chosen, _cratePos, [], 0 , "CAN_COLLIDE"];

	_tank call Hz_pers_API_addVehicle;

	_tank addMPEventHandler ["MPKilled",
	{
		if(isServer) then {
			MaxAPC = MaxAPC - 1;
			publicVariable "MaxAPC";
		};
	}];
	[_tank] call BADCO_fnc_skinApplier;
	
};


[_crate,["<t color='#FF0000'>Open present</t>","[_this select 0] remoteExec ['OpenPresent',2];",nil, 1, true, true, "", "_target distance2D (getPos dropoffpoint) < 10", 3]] remoteExecCall ["addAction", 0, true];
