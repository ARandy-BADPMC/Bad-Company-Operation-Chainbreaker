disableSerialization;
_tank = (findDisplay 74817) displayCtrl 1500;
_tankselect = lbCurSel _tank;
_tankpos = markerPos "tank_spawner";

if(_tankselect != -1) then  {	

	_vehicle = _tank lbData _tankselect;

	_nObjects = nearestObjects [_tankpos, ["LandVehicle", "Thing", "Static", "Ship", "Air", "Man"], 7];
	
	if (count _nObjects <= 1) then {

		_tier = ["STAT", _vehicle] call OPCB_econ_fnc_getVehicleTier;
		_cost = ["STAT", _tier] call OPCB_econ_fnc_getTierCost;				
		
		if (OPCB_econ_credits < _cost) exitWith {
			hint "You don't have enough credits to buy this vehicle!";
		};

		OPCB_econ_credits = OPCB_econ_credits - _cost;
		publicVariable "OPCB_econ_credits";
		
		hint "Static delivered";

		VehicleSpawnerHistory pushBack [name player, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName"), _cost];
		publicVariable "VehicleSpawnerHistory";

		[_vehicle] remoteExec ["CHAB_fnc_spawn_static_server", 2]; 
	  	
	} else {
		hint "Spawn position is not empty";
	};
}
else {
	hint "Select a vehicle first";
};
