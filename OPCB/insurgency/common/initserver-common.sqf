#include "defines.sqf"
#include "functions.sqf"
#include "server\defines.sqf"
#include "server\cleanup\functions.sqf"
#include "server\AI\functions.sqf"
#include "server\AI\initUPS.sqf"


// get marker count
private ["_mkr","_pos","_houses", "_markerPositions"];

_houses = [CENTERPOS,AORADIUS, 3, true] call findHouses;
_base = markerpos "base_marker";

_markerPositions = [];
{
	_pos = _x call getGridPos;
	_mkr = str _pos;
	
	_markerPositions pushBackUnique _mkr;
	
} forEach (_houses select {(_x distance _base) > 750});

ins_allMarkerCount = count _markerPositions;
// it's actually 55% for reasons...
ins_halfMarkerCount = round (ins_allMarkerCount*0.55);


call compile preprocessFileLineNumbers "insurgency\common\server\AI\paradrop\init.sqf";

// AI rearm & refuel
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

[] spawn {

	#ifdef ENABLE_PERSISTENCY
		waitUntil {
			sleep 2;
			!isNil "Hz_pers_serverInitialised" && {Hz_pers_serverInitialised}
		};
				
		// reaches minimum distance in between (70 m) when 70% of all grids cleared
		private _gunsDistanceInBetween = 70 max (70 + (round ((staticWepDistances - 70)*(1 - (1 min ((count Hz_pers_var_insurgencyClearedMarkers) / (ins_allMarkerCount*0.7)))))));
		[_gunsDistanceInBetween] call spawnAIGuns;
	#else
		[staticWepDistances] call spawnAIGuns;
	#endif

};
[] spawn { call spawnAIVehicles; };

#include "server\mainLoop.sqf"