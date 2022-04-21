#include "defines.sqf"
#include "functions.sqf"
#include "server\defines.sqf"
#include "server\cleanup\functions.sqf"
#include "server\AI\functions.sqf"
#include "server\AI\initUPS.sqf"

call compile preprocessFileLineNumbers "insurgency\common\server\AI\paradrop\init.sqf";

// Hunter: check if Pops4 has something similar or if this would break any Pops functionality
[] spawn {

	while {true} do {
	
		sleep 600;
		
		{
			if ((local _x) && {({alive _x} count crew _x) > 0}) then {
				_x setFuel 1;
				_x setVehicleAmmo 1;
			};
		} foreach vehicles;
		
	};

};


cleanupVics = [];

[] spawn { call spawnAIGuns; };
[] spawn { call spawnAIVehicles; };

#include "server\mainLoop.sqf"