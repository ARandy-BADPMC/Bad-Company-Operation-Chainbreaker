disableSerialization;
_tank = (findDisplay 74817) displayCtrl 1500;
_tankselect = lbCurSel _tank;
_tankpos = markerPos "tank_spawner";

if(_tankselect != -1) then  {	

	_vehicle = _tank lbData _tankselect;

	_nObjects = nearestObjects [_tankpos, ["LandVehicle", "Thing", "Static", "Ship", "Air", "Man"], 7];
	
	if (count _nObjects <= 1) then {
		[_vehicle,0] remoteExec ["CHAB_fnc_spawn_static_server", 2]; 
	  	
	} else {
		hint "Spawn position is not empty";
	};
}
else {
	hint "Select a vehicle first";
};
