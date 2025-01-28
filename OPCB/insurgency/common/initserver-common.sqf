#include "defines.sqf"
#include "functions.sqf"
#include "server\defines.sqf"
#include "server\cleanup\functions.sqf"
#include "server\AI\functions.sqf"
#include "server\AI\initUPS.sqf"

#ifdef ENABLE_TIERED_UNITS

  updateTieredUnits = {
  
    private _completionRatio = (count Hz_pers_var_insurgencyClearedMarkers) / ins_allMarkerCount * 100;
    private _worldTiers = tieredUnits get toLower worldName;

    private _infantryTiers = _worldTiers get "infantry_tiers";
    private _infantryNumberTiers = count _infantryTiers;
    private _insurgentsTier = ceil(_completionRatio / 80 * _infantryNumberTiers) min _infantryNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
    };    
    if (_insurgentsTier != currentInfTier) then {
      currentInfTier = _insurgentsTier;
      eastInfClasses = _infantryTiers get _insurgentsTier;
      publicVariable "eastInfClasses";
    };

    private _vehicleCrewTiers = _worldTiers get "vehicle_crew_tiers";
    private _vehicleNumberTiers = count _vehicleCrewTiers;
    _insurgentsTier = ceil(_completionRatio /  * _vehicleNumberTiers) min _vehicleNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
    };    
    if (_insurgentsTier != currentVCrewTier) then {
      currentVCrewTier = _insurgentsTier;
      vclCrewClass = _vehicleCrewTiers get _insurgentsTier;
    };
        
    private _staticCrewTiers = _worldTiers get "static_crew_tiers";
    private _StaticCrewNumberTiers = count _staticCrewTiers;
    _insurgentsTier = ceil(_completionRatio / 80 * _StaticCrewNumberTiers) min _StaticCrewNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
    };
    if (_insurgentsTier != currentSCrewTier) then {
      currentSCrewTier = _insurgentsTier;
      staticClass = _staticCrewTiers get _insurgentsTier;
    };
    
    private _vehicleTiers = _worldTiers get "vehicle_tiers";
    private _vehicleNumberTiers = count _vehicleTiers;
    _insurgentsTier = ceil(_completionRatio / 80 * _vehicleNumberTiers) min _vehicleNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
    };
    if (_insurgentsTier != currentVehTier) then {
      currentVehTier = _insurgentsTier;
      eastVclClasses = _vehicleTiers get _insurgentsTier;
    };    
    
  };
  
#endif

serverHandleGridCaptured = {

    #ifdef ENABLE_PERSISTENCY

      Hz_pers_var_insurgencyClearedMarkers pushBackUnique _this;
      
      // check if we progressed a tier and update
      _newTier = (ceil (10 - ((1 min ((count Hz_pers_var_insurgencyClearedMarkers) / ins_halfMarkerCount))*10))) - 1;
      if (_newTier != OPCB_econ_currentTier) then {
        OPCB_econ_currentTier = _newTier;
        publicVariable "OPCB_econ_currentTier";
      };
     
    #endif

    #ifdef ENABLE_TIERED_UNITS
      call updateTieredUnits;
    #endif
    
};

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

  #ifdef ENABLE_TIERED_UNITS
      #ifdef ENABLE_PERSISTENCY
        waitUntil {
          sleep 2;
          !isNil "Hz_pers_serverInitialised" && {Hz_pers_serverInitialised}
        };
      #endif
  #endif

  call spawnAIVehicles; 

};

#include "server\mainLoop.sqf"