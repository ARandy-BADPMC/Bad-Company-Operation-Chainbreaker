// used by cleanup timers
private ["_WCTime","_BCTime"];
_WCTime     		= time;
_BCTime                 = time;

// AI rearm & refuel
[] spawn {

	scriptName "ins_AIresupply";

	while {true} do {
	
		sleep 600;
		
		{
			if ((local _x) && {canMove _x} && ((side _x) in [resistance, east]) && {({(alive _x) && {(lifeState _x) != "INCAPACITATED"}} count crew _x) > 0} && {(_x isKindOf "LandVehicle") || {_x isKindOf "Air"} || {_x isKindOf "Ship"} || {_x isKindOf "StaticWeapon"}}) then {
				_x setFuel 1;
				_x setVehicleAmmo 1;
			};
			sleep 0.1;
		} foreach vehicles;
		
	};

};

scriptName "ins_cleanup";

while { true } do {

	call aiDespawn;
	call quickCleanup;	
	call longCleanup;	
	sleep 20;
}; 