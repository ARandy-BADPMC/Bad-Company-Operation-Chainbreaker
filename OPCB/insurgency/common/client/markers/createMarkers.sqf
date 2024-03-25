#ifdef ENABLE_PERSISTENCY
	waitUntil {
		sleep 2;
		!isNil "Hz_pers_serverInitialised" && {Hz_pers_serverInitialised}
	};
#endif

private ["_mkr","_var","_pos","_houses"];

_houses = [CENTERPOS,AORADIUS, 3, true] call findHouses;
_base = markerpos "base_marker";
ins_gridMarkers = [];
{
	_pos = _x call getGridPos;
	_mkr = str _pos;
	if (getMarkerPos _mkr select 0 == 0) then {
		_mkr = createMarkerLocal[_mkr, _pos]; 
		_mkr setMarkerShapeLocal "RECTANGLE"; 
		_mkr setMarkerTypeLocal "SOLID";		
		_mkr setMarkerSizeLocal [50,50]; 
		_mkr setMarkerAlphaLocal 0.2; 
	};
	_var = missionNamespace getVariable format["%1cleared", _mkr];	
	if isNil "_var" then {
		_mkr setMarkerColorLocal "ColorRed";		
	} else {
		_mkr setMarkerColorLocal "ColorGreen";
	};
	
	ins_gridMarkers pushBack _mkr;
	
} forEach (_houses select {(_x distance _base) > 1250});