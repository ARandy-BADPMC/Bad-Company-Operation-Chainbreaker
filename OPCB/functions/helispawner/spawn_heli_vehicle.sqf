disableSerialization;
_loadouts = (findDisplay 9900) displayCtrl 1561;
_loadout = lbCurSel _loadouts;
if(_loadout != -1) then  {	
	_vehiclelist = (findDisplay 9900) displayCtrl 1500;
	_heli = lbCurSel _vehiclelist;

	_vehicle = _vehiclelist lbData _heli;
	_loadout_type = _loadouts lbText _loadout;
	_index = Helicopter_loadouts find _vehicle;
	
	_pylons = [];
	if (_index != -1) then {
		_loadoutska = Helicopter_loadouts select (_index +1); //array
		_pylons_number = _loadoutska find _loadout_type;

		_pylons = _loadoutska select (_pylons_number +1);	
	};
	
	_nObjects= nearestObjects [markerPos "aircraft_spawner", ["LandVehicle", "Thing", "Static", "Ship", "Air", "Man"], 7];
	
	if (count _nObjects == 0) then {

		if ((toUpper _vehicle) in OPCB_econ_vehicleAirAttackTypes) then {
		  if (MaxAttackHelis != 2) then {
				
			_tier = ["AIR", _vehicle] call OPCB_econ_fnc_getVehicleTier;
			_cost = ["AIR", _tier] call OPCB_econ_fnc_getTierCost;
			
			if (OPCB_econ_credits < _cost) exitWith {
				hint "You don't have enough credits to buy this vehicle!";
			};
			
			OPCB_econ_credits = OPCB_econ_credits - _cost;
			publicVariable "OPCB_econ_credits";
			
			hint "Vehicle delivered";

			MaxAttackHelis = MaxAttackHelis + 1;
			publicVariable "MaxAttackHelis"; 
			
		    [_vehicle,_pylons,1] remoteExec ["CHAB_fnc_spawn_helicopter_server",2];

		  } else {
				hint "There are already 2 attack helicopters in game";
			};

		} else {
		  if (MaxTransHelis != 3) then {
			
			_tier = ["AIR", _vehicle] call OPCB_econ_fnc_getVehicleTier;
			_cost = ["AIR", _tier] call OPCB_econ_fnc_getTierCost;
			
			if (OPCB_econ_credits < _cost) exitWith {
				hint "You don't have enough credits to buy this vehicle!";
			};
			
			OPCB_econ_credits = OPCB_econ_credits - _cost;
			publicVariable "OPCB_econ_credits";
			
			hint "Vehicle delivered";
			
			MaxTransHelis = MaxTransHelis + 1;
			publicVariable "MaxTransHelis";
		    [_vehicle,_pylons,0] remoteExec ["CHAB_fnc_spawn_helicopter_server",2];

		  } else {
				hint "3 Transport helicopters are already in game.";
			};
		};
	  	
	} else {
		hint "Spawn position is not empty";
	};
}
else {
	hint "Select a loadout first";
};
