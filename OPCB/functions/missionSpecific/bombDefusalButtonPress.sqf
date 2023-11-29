disableSerialization;
params ["_number"];
private _display = findDisplay 74816;

{
	private _digit = _display displayCtrl _x;
	private _text = ctrlText _digit;
	if(count _text == 0) exitWith {
		_digit ctrlSetText (str _number);
	};
	
} forEach [1000,1001,1002,1003];
