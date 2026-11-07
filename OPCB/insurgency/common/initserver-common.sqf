#include "defines.sqf"
#include "functions.sqf"
#include "server\defines.sqf"
#include "server\cleanup\functions.sqf"
#include "server\AI\functions.sqf"
#include "server\AI\initUPS.sqf"

#ifdef ENABLE_TIERED_UNITS

  updateTieredUnits = {
    if (isNil "Hz_pers_var_insurgencyClearedMarkers" or isNil "ins_allMarkerCount") then 
    {
      completionRatio = 0;
    }
    else 
    {
      completionRatio = (count Hz_pers_var_insurgencyClearedMarkers) / ins_allMarkerCount * 100;
    };
    private _worldTiers = tieredUnits get toLower worldName;

    private _infantryTiers = _worldTiers get "infantry_tiers";
    private _infantryNumberTiers = count _infantryTiers;
    private _insurgentsTier = ceil(completionRatio / 80 * _infantryNumberTiers) min _infantryNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
      currentInfTier = _insurgentsTier;
      eastInfClasses = _infantryTiers get _insurgentsTier;
      publicVariable "eastInfClasses";
    };    
    if (_insurgentsTier != currentInfTier) then {
      currentInfTier = _insurgentsTier;
      eastInfClasses = _infantryTiers get _insurgentsTier;
      publicVariable "eastInfClasses";
    };

    private _vehicleCrewTiers = _worldTiers get "vehicle_crew_tiers";
    private _vehicleNumberTiers = count _vehicleCrewTiers;
    _insurgentsTier = ceil(completionRatio / 95 * _vehicleNumberTiers) min _vehicleNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
      currentVCrewTier = _insurgentsTier;
      vclCrewClass = _vehicleCrewTiers get _insurgentsTier;
    };    
    if (_insurgentsTier != currentVCrewTier) then {
      currentVCrewTier = _insurgentsTier;
      vclCrewClass = _vehicleCrewTiers get _insurgentsTier;
    };
        
    private _staticCrewTiers = _worldTiers get "static_crew_tiers";
    private _StaticCrewNumberTiers = count _staticCrewTiers;
    _insurgentsTier = ceil(completionRatio / 80 * _StaticCrewNumberTiers) min _StaticCrewNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
      currentSCrewTier = _insurgentsTier;
      staticClass = _staticCrewTiers get _insurgentsTier;
    };
    if (_insurgentsTier != currentSCrewTier) then {
      currentSCrewTier = _insurgentsTier;
      staticClass = _staticCrewTiers get _insurgentsTier;
    };
    
    private _vehicleTiers = _worldTiers get "vehicle_tiers";
    private _vehicleNumberTiers = count _vehicleTiers;
    _insurgentsTier = ceil(completionRatio / 80 * _vehicleNumberTiers) min _vehicleNumberTiers;
    if (_insurgentsTier == 0) then {
      _insurgentsTier = 1;
      currentVehTier = _insurgentsTier;
      eastVclClasses = _vehicleTiers get _insurgentsTier;
    };
    if (_insurgentsTier != currentVehTier) then {
      currentVehTier = _insurgentsTier;
      eastVclClasses = _vehicleTiers get _insurgentsTier;
    };    
    
  };
  
#endif

serverHandleGridCaptured = {
  if (!isServer || {!isRemoteExecuted} || {!(_this isEqualType "")}) exitWith {};
  private _gridMarker = _this;
  private _callerIndex = allPlayers findIf {owner _x == remoteExecutedOwner && {isPlayer _x} && {!(_x isKindOf "HeadlessClient_F")}};
  if (_callerIndex < 0 || {isNil "ins_gridCaptureMarkers"}) exitWith {};
  private _caller = allPlayers select _callerIndex;
  if (!alive _caller || {vehicle _caller != _caller}) exitWith {};
  private _gridPos = _caller call getGridPos;
  if (_gridMarker != str _gridPos || {!(_gridMarker in ins_gridCaptureMarkers)}) exitWith {};
  #ifdef ENABLE_PERSISTENCY
    if !(missionNamespace getVariable ["Hz_pers_serverInitialised", false]) exitWith {};
    if (_gridMarker in Hz_pers_var_insurgencyClearedMarkers) exitWith {};
  #endif
  private _markerVariable = format ["%1cleared", _gridMarker];
  if (missionNamespace getVariable [_markerVariable, false]) exitWith {};
  private _playersInGrid = {
    isPlayer _x && {alive _x} && {!(_x isKindOf "HeadlessClient_F")} && {(_x call getGridPos) isEqualTo _gridPos}
  } count allPlayers;
  if (_playersInGrid < (2 max playersNeeded) || {nearestEastMen(_gridPos,70,true,"count") > 0}) exitWith {};

  if (markerShape _gridMarker == "") then {
    createMarkerLocal [_gridMarker, _gridPos];
    _gridMarker setMarkerShapeLocal "RECTANGLE";
    _gridMarker setMarkerTypeLocal "SOLID";
    _gridMarker setMarkerSizeLocal [50,50];
    _gridMarker setMarkerAlphaLocal 0.2;
  };
  _gridMarker setMarkerColor "ColorGreen";
  missionNamespace setVariable [_markerVariable, true];
  publicVariable _markerVariable;

  if (serverTime - (missionNamespace getVariable ["OPCB_civLastHarmAt", -1e6]) >= 600) then {
    [2] call CHAB_fnc_civRelationChange;
  };

    #ifdef ENABLE_PERSISTENCY

      Hz_pers_var_insurgencyClearedMarkers pushBackUnique _gridMarker;
      
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
private _baseMarkerSize = getMarkerSize "base_marker" select 0;

_markerPositions = [];
ins_gridCaptureMarkers = [];
{
	_pos = _x call getGridPos;
	_mkr = str _pos;
	if ((_x distance _base) > 750) then {_markerPositions pushBackUnique _mkr;};
	if ((_x distance _base) > _baseMarkerSize) then {ins_gridCaptureMarkers pushBackUnique _mkr;};
} forEach _houses;

ins_allMarkerCount = count _markerPositions;
// it's actually 55% for reasons...
ins_halfMarkerCount = round (ins_allMarkerCount*0.55);

#ifdef ENABLE_TIERED_UNITS
  call updateTieredUnits;
#endif


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
    ((count playableUnits) > 0) || {!isMultiplayer}
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
