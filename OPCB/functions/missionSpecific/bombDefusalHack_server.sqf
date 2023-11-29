params ["_terminal"];

private _callerRE = remoteExecutedOwner;

private _formatted = format ["The code should be %1", BombTaskDigits];

_formatted remoteExecCall ["hint", _callerRE];

deleteVehicle _terminal;