private ["_PGroup","_WCTime","_BCTime", "_mkr","_var","_pos","_houses", "_markerPositions"];

//_PGroup     		= group pilotController;
_WCTime     		= time;
_BCTime                 = time;

// get marker count

_houses = [CENTERPOS,AORADIUS, 3, true] call findHouses;
_base = markerpos "base_marker";

_markerPositions = [];
{
	_pos = _x call getGridPos;
	_mkr = str _pos;
	
	_markerPositions pushBackUnique _mkr;
	
} forEach (_houses select {(_x distance _base) > 750});

// it's actually 55%...
ins_halfMarkerCount = round ((count _markerPositions)*0.55);

while { true } do { 
	call aiDespawn;
	call quickCleanup;	
	call longCleanup;	
	sleep 20;
}; 