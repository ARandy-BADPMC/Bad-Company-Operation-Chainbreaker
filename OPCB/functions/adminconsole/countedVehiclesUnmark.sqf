disableSerialization;

private _display = findDisplay 9911;
if (isNull _display) exitWith {};

private _list = _display displayCtrl 1500;
if (isNull _list) exitWith {};

private _selection = lbCurSel _list;
if (_selection < 0) exitWith {
	hint "Select a vehicle first";
};

private _netId = _list lbData _selection;
if (_netId == "") exitWith {
	hint "No tracked vehicle data for this row";
};

private _markerName = format ["CHAB_countedVehicleMarker_%1", _netId];
deleteMarkerLocal _markerName;

private _markers = uiNamespace getVariable ["CHAB_countedVehicleMarkers", []];
uiNamespace setVariable ["CHAB_countedVehicleMarkers", _markers - [_markerName]];

hint "Vehicle marker removed";
