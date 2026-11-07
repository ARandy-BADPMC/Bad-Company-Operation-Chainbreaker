params [["_vehicle", ""], ["_spawnMarker", ""]];
disableSerialization;

if (_vehicle == "") then {
	private _list = (findDisplay 9901) displayCtrl 1500;
	private _selection = lbCurSel _list;
	if (_selection >= 0) then { _vehicle = _list lbData _selection; };
};
if (_vehicle == "") exitWith { hint "Select a vehicle first"; };
if (_spawnMarker == "") exitWith {
	["ground", [_vehicle], "tank_spawner"] call CHAB_fnc_shopSpawnLocationOpen;
};

[_vehicle, _spawnMarker] remoteExecCall ["CHAB_fnc_spawn_tank_server", 2];
