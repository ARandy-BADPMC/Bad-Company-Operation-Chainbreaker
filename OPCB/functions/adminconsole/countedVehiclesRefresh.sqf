disableSerialization;
params ["_display"];

if (isNull _display) exitWith {};

private _summary = _display displayCtrl 1100;
private _list = _display displayCtrl 1500;
if (isNull _summary || {isNull _list}) exitWith {};

private _trackedVehicles = vehicles select {
	alive _x
	&& {_x getVariable ["OPCB_shopSlot", ""] in ["Tank", "APC", "Vehicle"]}
	&& {!(_x getVariable ["OPCB_shopSlotReleased", false])}
};

_summary ctrlSetStructuredText parseText format [
	"<t size='1.05'>Currently counted vehicles: %1</t>",
	count _trackedVehicles
];

lbClear _list;

if (_trackedVehicles isEqualTo []) exitWith {
	_list lbAdd "No vehicles are currently being counted.";
};

{
	private _slot = _x getVariable ["OPCB_shopSlot", ""];
	private _name = getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName");
	private _row = format ["%1 | %2", _slot, _name];
	private _rowIndex = _list lbAdd _row;
	_list lbSetData [_rowIndex, netId _x];
} forEach _trackedVehicles;
