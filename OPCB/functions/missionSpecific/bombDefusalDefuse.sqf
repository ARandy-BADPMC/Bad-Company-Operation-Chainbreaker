disableSerialization;
private _display = findDisplay 74816;
private _digits = "";
{
	private _digit = _display displayCtrl _x;
	private _text = ctrlText _digit;
	_digits = _digits + _text; 
	
} forEach [1000,1001,1002,1003];

[_digits] remoteExecCall ["CHAB_fnc_bombDefusalDefuse_server", 2, false];

closeDialog 0;
