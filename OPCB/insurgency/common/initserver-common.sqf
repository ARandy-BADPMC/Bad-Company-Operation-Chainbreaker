#include "defines.sqf"
#include "functions.sqf"
#include "server\defines.sqf"
#include "server\cleanup\functions.sqf"
#include "server\AI\functions.sqf"
#include "server\AI\initUPS.sqf"

#ifdef ENABLE_PERSISTENCY

	insurgencyMarkerUpdate = {
	
			Hz_pers_var_insurgencyClearedMarkers pushBackUnique _this;
			
			// check if we progressed a tier and update
			_newTier = (ceil (10 - ((1 min ((count Hz_pers_var_insurgencyClearedMarkers) / ins_halfMarkerCount))*10))) - 1;
			if (_newTier != OPCB_econ_currentTier) then {
				OPCB_econ_currentTier = _newTier;
				publicVariable "OPCB_econ_currentTier";
			};
			
	};

#endif

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


call compileFinal preprocessFileLineNumbers "insurgency\common\server\AI\paradrop\init.sqf";

cleanupVics = [];

[] spawn {

	scriptName "ins_roofGunSpawner";

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

[] spawn {

	scriptName "ins_vehiclePatrolsHandler";
	
	waitUntil {
		sleep 10;
		((count playableUnits) > 1) || {!isMultiplayer}
	};

	call spawnAIVehicles; 

};

#include "server\mainLoop.sqf"