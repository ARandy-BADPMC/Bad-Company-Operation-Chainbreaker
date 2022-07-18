gridPath = {
    private ["_gMkr"];
    
    if (vehicle player != player) exitWith {};
	_gMkr  = str(player call getGridPos);
	if isNil "_gMkr" exitWith {};
	if (markerColor _gMkr == "ColorGreen") exitWith {};
	if (nearestEastMen(call compile _gMkr,70,true,"count") > 0 
		|| nearestPlayers(call compile _gMkr,140,true,"count") < playersNeeded) exitWith {};
	_gMkr setMarkerColor "ColorGreen";
	missionNamespace setVariable [format["%1cleared", _gMkr], true];
	publicVariable format["%1cleared", _gMkr];
};
