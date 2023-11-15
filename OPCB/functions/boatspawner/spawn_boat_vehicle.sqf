disableSerialization;
_boat = (findDisplay 9901) displayCtrl 1500;
_boatselect = lbCurSel _boat;
_boatpos = getPos boat_spawner;

if(_boatselect != -1) then  {	

	_vehicle = _boat lbData _boatselect;

	_nObjects = nearestObjects [_boatpos, ["LandVehicle", "Thing", "Static", "Ship", "Air", "Man"], 7];
	
	if (count _nObjects <= 1) then {
			
		if (MaxBoats != 12) then {	
				
			_tier = ["SEA", _vehicle] call OPCB_econ_fnc_getVehicleTier;
			_cost = ["SEA", _tier] call OPCB_econ_fnc_getTierCost;				
			
			if (OPCB_econ_credits < _cost) exitWith {
				hint "You don't have enough credits to buy this vehicle!";
			};
			
			OPCB_econ_credits = OPCB_econ_credits - _cost;
			publicVariable "OPCB_econ_credits";
			
			hint "Vehicle delivered";

			MaxBoats = MaxBoats +1;
			publicVariable "MaxAPC";
			[_vehicle] remoteExec ["CHAB_fnc_spawn_boat_server",2];

		} else {
			hint "12 vehicles are already in game. Recover or destroy existing ones.";
		};
	} else {
		hint "Spawn position is not empty";
	};
}
else {
	hint "Select a vehicle first";
};
