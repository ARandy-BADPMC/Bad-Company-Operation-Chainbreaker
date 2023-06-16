disableSerialization;

_vehiclelist = (findDisplay 9909) displayCtrl 1500;
_heli = lbCurSel _vehiclelist;

_vehicle = _vehiclelist lbData _heli;

_tankpos = markerPos "tank_spawner";

_nObjects = nearestObjects [_tankpos, [], 7];

if (count _nObjects == 0) then {

	_tier = ["DRONE", _vehicle] call OPCB_econ_fnc_getVehicleTier;
	_cost = ["DRONE", _tier] call OPCB_econ_fnc_getTierCost;

	if (OPCB_econ_credits < _cost) exitWith {
		hint "You don't have enough credits to buy this vehicle!";
	};
	OPCB_econ_credits = OPCB_econ_credits - _cost;
	publicVariable "OPCB_econ_credits";

	_drone = _vehicle createVehicle (_tankpos);	
	_drone setdir 40;
	
	hint "Drone delivered";
	
} else {
	hint "Spawn position is not empty";
};

