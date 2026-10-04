params [["_crateType", ""], ["_spawnMarker", ""]];
if (_crateType == "") then {
	private _ctrl = (findDisplay 74815) displayCtrl 1500;
	private _selection = lbCurSel _ctrl;
	if (_selection >= 0) then { _crateType = _ctrl lbData _selection; };
};
if (_crateType == "") exitWith { hint "Select a Utility first"; };
if (_spawnMarker == "") exitWith {
	["crate", [_crateType], "tank_spawner"] call CHAB_fnc_shopSpawnLocationOpen;
};

[_crateType, _spawnMarker] remoteExec ["OPCB_crateSpawner_fnc_spawnCrate_server", 2];
