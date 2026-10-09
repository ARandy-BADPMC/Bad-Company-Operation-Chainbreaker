disableSerialization;
params [["_mode", "local"]];

private _display = findDisplay 9912;
if (isNull _display) exitWith {};

private _ctrl = _display displayCtrl 1400;
if (isNull _ctrl) exitWith {};

private _code = ctrlText _ctrl;
if (_code == "") exitWith {
	hint "Paste code first";
};

uiNamespace setVariable ["CHAB_executeCodeLast", _code];

switch (_mode) do {
	case "local": {
		call compile _code;
		hint "Code executed locally";
	};
	case "server": {
		[_code] remoteExec ["CHAB_fnc_executeCodePayload", 2];
		hint "Code sent to server";
	};
	case "global": {
		[_code] remoteExec ["CHAB_fnc_executeCodePayload", 0];
		hint "Code sent globally";
	};
	case "globalJip": {
		[_code] remoteExec ["CHAB_fnc_executeCodePayload", 0, true];
		hint "Code sent globally with JIP";
	};
	default {
		hint format ["Unknown execute mode: %1", _mode];
	};
};
