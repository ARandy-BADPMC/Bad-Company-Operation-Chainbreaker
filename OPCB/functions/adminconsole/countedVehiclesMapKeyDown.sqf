params ["_display", "_key"];

if (_key != 211) exitWith { false };

private _mapCtrl = _display displayCtrl 51;
if (isNull _mapCtrl) exitWith { false };

private _mouseOver = ctrlMapMouseOver _mapCtrl;
if ((count _mouseOver) < 2) exitWith { false };

private _markerName = _mouseOver select 1;
private _markers = uiNamespace getVariable ["CHAB_countedVehicleMarkers", []];

if !(_markerName in _markers) exitWith { false };

deleteMarkerLocal _markerName;
uiNamespace setVariable ["CHAB_countedVehicleMarkers", _markers - [_markerName]];
hint "Vehicle marker removed";

true
