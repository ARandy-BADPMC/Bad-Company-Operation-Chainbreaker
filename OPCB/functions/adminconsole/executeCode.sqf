disableSerialization;
createDialog "CHAB_executeCode";

waitUntil {
	!isNull (findDisplay 9912)
};

private _display = findDisplay 9912;
private _ctrl = _display displayCtrl 1400;
if (!isNull _ctrl) then {
	_ctrl ctrlSetText (uiNamespace getVariable ["CHAB_executeCodeLast", ""]);
};

[_display] call CHAB_fnc_executeCodePresetsLoad;
