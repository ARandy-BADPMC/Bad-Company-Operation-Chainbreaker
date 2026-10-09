disableSerialization;
params ["_display"];

if (isNull _display) exitWith {};

private _list = _display displayCtrl 1501;
if (isNull _list) exitWith {};

private _presets = [
	["Change credits value", "// Change 1500 to the credit value you want before running" + toString [10] + "OPCB_econ_credits = 1500;" + toString [10] + "publicVariable ""OPCB_econ_credits"";"],
	["Set current server tier", "// Change 0 to the tier you want before running" + toString [10] + "OPCB_econ_currentTier = 0;" + toString [10] + "publicVariable ""OPCB_econ_currentTier"";" + toString [10] + "call updateTieredUnits;"]
];

uiNamespace setVariable ["CHAB_executeCodePresets", _presets];

lbClear _list;
{
	_list lbAdd (_x select 0);
} forEach _presets;
