disableSerialization;
params ["_ctrl", "_index"];

if (isNull _ctrl || {_index < 0}) exitWith {};

private _display = ctrlParent _ctrl;
if (isNull _display) exitWith {};

private _edit = _display displayCtrl 1400;
if (isNull _edit) exitWith {};

private _presets = uiNamespace getVariable ["CHAB_executeCodePresets", []];
if (_index >= count _presets) exitWith {};

private _code = (_presets select _index) select 1;
_edit ctrlSetText _code;
