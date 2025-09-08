disableSerialization;
_tank = (findDisplay 9901) displayCtrl 1500;
_tankselect = lbCurSel _tank;
_tankpos = markerPos "tank_spawner";

if(_tankselect != -1) then  {	

	_vehicle = _tank lbData _tankselect;

	_nObjects = nearestObjects [_tankpos, ["LandVehicle", "Thing", "Static", "Ship", "Air", "Man"], 7];
	
	if (count _nObjects <= 1) then {

		if ((toUpper _vehicle) in OPCB_econ_vehicleGroundAttackTypes) then {
			if (MaxTanks == 0) then {
			
				_tier = ["ENG", _vehicle] call OPCB_econ_fnc_getVehicleTier;
				_cost = ["ENG", _tier] call OPCB_econ_fnc_getTierCost;				
				// just in case
				if (_tier == -1) then {
					_tier = ["INF", _vehicle] call OPCB_econ_fnc_getVehicleTier;
					_cost = ["INF", _tier] call OPCB_econ_fnc_getTierCost;
				};
				
				if (OPCB_econ_credits < _cost) exitWith {
					hint "You don't have enough credits to buy this vehicle!";
				};
				
				OPCB_econ_credits = OPCB_econ_credits - _cost;
				publicVariable "OPCB_econ_credits";
				
				hint "Vehicle delivered";

				MaxTanks = MaxTanks + 1;
				publicVariable "MaxTanks";

				VehicleSpawnerHistory pushBack [name player, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName"), _cost];
				publicVariable "VehicleSpawnerHistory";

				[_vehicle, true] remoteExec ["CHAB_fnc_spawn_tank_server",2];

			} else {
				hint "There is already a tank/SPG in game";
			};

		} else {
			if (MaxAPC != 12) then {	
				_tier = ["INF", _vehicle] call OPCB_econ_fnc_getVehicleTier;
				_cost = ["INF", _tier] call OPCB_econ_fnc_getTierCost;				
				// just in case
				if (_tier == -1) then {
					_tier = ["ENG", _vehicle] call OPCB_econ_fnc_getVehicleTier;
					_cost = ["ENG", _tier] call OPCB_econ_fnc_getTierCost;
				};
				
				if (OPCB_econ_credits < _cost) exitWith {
					hint "You don't have enough credits to buy this vehicle!";
				};
				
				OPCB_econ_credits = OPCB_econ_credits - _cost;
				publicVariable "OPCB_econ_credits";
				
				hint "Vehicle delivered";

				MaxAPC = MaxAPC +1;
				publicVariable "MaxAPC";

				VehicleSpawnerHistory pushBack [name player, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName"), _cost];
				publicVariable "VehicleSpawnerHistory";
				[_vehicle, false] remoteExec ["CHAB_fnc_spawn_tank_server",2];

			} else {
				hint "12 vehicles are already in game. Recover or destroy existing ones.";
			};
			
		};
	  	
	} else {
		hint "Spawn position is not empty";
	};
}
else {
	hint "Select a vehicle first";
};
