#include "..\..\defines.sqf"

// set up captured markers
private _mkrVar = "";
{
	_mkrVar = format["%1cleared", _x];	
	missionNamespace setVariable [_mkrVar, true];
	publicVariable _mkrVar;
} foreach Hz_pers_var_insurgencyClearedMarkers;

// calculate current tier
OPCB_econ_currentTier = (ceil (10 - ((1 min ((count Hz_pers_var_insurgencyClearedMarkers) / ins_halfMarkerCount))*10))) - 1;
publicVariable "OPCB_econ_currentTier";

#ifdef ENABLE_TIERED_UNITS
  call updateTieredUnits;
#endif

// setup bought fobs
{
	fob_pos = markerPos _x;
	[west, fob_pos] remoteExecCall ["BIS_fnc_addRespawnPosition", 0, true];	
} foreach Hz_pers_var_boughtFobs;


