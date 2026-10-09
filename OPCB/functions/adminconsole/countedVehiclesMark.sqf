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

private _vehicle = objectFromNetId _netId;
if (isNull _vehicle || {!alive _vehicle}) exitWith {
	hint "Selected vehicle is no longer alive";
};

private _markerName = format ["CHAB_countedVehicleMarker_%1", _netId];

private _marker = createMarkerLocal [_markerName, getPosATL _vehicle];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_dot";
_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerTextLocal getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");

private _markers = uiNamespace getVariable ["CHAB_countedVehicleMarkers", []];
_markers pushBackUnique _markerName;
uiNamespace setVariable ["CHAB_countedVehicleMarkers", _markers];

openMap true;
[] call CHAB_fnc_countedVehiclesEnableMapDelete;
hint "Vehicle location marked on map";
