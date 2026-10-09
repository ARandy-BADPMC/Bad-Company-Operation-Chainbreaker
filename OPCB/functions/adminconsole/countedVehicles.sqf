disableSerialization;
createDialog "CHAB_countedVehicles";

waitUntil {
	!isNull (findDisplay 9911)
};

private _display = findDisplay 9911;
[_display] call CHAB_fnc_countedVehiclesRefresh;

private _token = diag_tickTime;
uiNamespace setVariable ["CHAB_countedVehiclesToken", _token];

[_display, _token] spawn {
	disableSerialization;
	params ["_display", "_token"];

	while {
		!isNull _display
		&& {(uiNamespace getVariable ["CHAB_countedVehiclesToken", -1]) isEqualTo _token}
	} do {
		[_display] call CHAB_fnc_countedVehiclesRefresh;
		sleep 1;
	};
};
