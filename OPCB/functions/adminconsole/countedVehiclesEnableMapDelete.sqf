if (!hasInterface) exitWith {};

[] spawn {
	waitUntil {
		sleep 0.1;
		visibleMap && {!isNull (findDisplay 12)}
	};

	private _display = findDisplay 12;
	if (isNull _display) exitWith {};

	if (isNil {_display getVariable "CHAB_countedVehicleDeleteEH"}) then {
		private _eh = _display displayAddEventHandler ["KeyDown", "_this call CHAB_fnc_countedVehiclesMapKeyDown"];
		_display setVariable ["CHAB_countedVehicleDeleteEH", _eh];
	};
};
