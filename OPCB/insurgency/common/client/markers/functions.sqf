gridPath = {
	if (isNull player || {!alive player} || {vehicle player != player}) exitWith {};
	private _gridPos = player call getGridPos;
	private _gridMarker = str _gridPos;
	if (missionNamespace getVariable [format ["%1cleared", _gridMarker], false]) exitWith {
		if (markerColor _gridMarker == "ColorRed") then {_gridMarker setMarkerColorLocal "ColorGreen";};
	};
	if (markerColor _gridMarker != "ColorRed") exitWith {};
	private _playersInGrid = {
		isPlayer _x && {alive _x} && {!(_x isKindOf "HeadlessClient_F")} && {(_x call getGridPos) isEqualTo _gridPos}
	} count allPlayers;
	if (_playersInGrid < (2 max playersNeeded) || {nearestEastMen(_gridPos,70,true,"count") > 0}) exitWith {};
	_gridMarker remoteExecCall ["serverHandleGridCaptured", 2, false];
};
