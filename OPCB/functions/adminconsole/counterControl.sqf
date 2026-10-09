disableSerialization;
createDialog "CHAB_counterControl";

waitUntil {
	!isNull (findDisplay 9910)
};

private _display = findDisplay 9910;
[_display] call CHAB_fnc_counterControlRefresh;

private _token = diag_tickTime;
uiNamespace setVariable ["CHAB_counterControlToken", _token];

[_display, _token] spawn {
	disableSerialization;
	params ["_display", "_token"];

	while {
		!isNull _display
		&& {(uiNamespace getVariable ["CHAB_counterControlToken", -1]) isEqualTo _token}
	} do {
		[_display] call CHAB_fnc_counterControlRefresh;
		sleep 1;
	};
};
