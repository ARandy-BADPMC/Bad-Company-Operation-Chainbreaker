gridPath = {
    private ["_gMkr", "_mkrVar"];
    
    if (vehicle player != player) exitWith {};
	_gMkr  = str(player call getGridPos);
	if isNil "_gMkr" exitWith {};
	if (markerColor _gMkr == "ColorGreen") exitWith {};
	if (nearestEastMen(call compile _gMkr,70,true,"count") > 0 
		|| nearestPlayers(call compile _gMkr,140,true,"count") < playersNeeded) exitWith {};
	_gMkr setMarkerColor "ColorGreen";
	
	_mkrVar = format["%1cleared", _gMkr];	
	missionNamespace setVariable [_mkrVar, true];
	publicVariable _mkrVar;
	
	#ifdef ENABLE_PERSISTENCY
		insurgencyMarkerUpdate = _gMkr;
		publicVariableServer "insurgencyMarkerUpdate";
	#endif
	
};
