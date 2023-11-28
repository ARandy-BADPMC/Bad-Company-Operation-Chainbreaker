params ["_code"];

hint _code;

if(BombTaskDigits == _code) exitWith {
	BombTaskDigits = "";
};

BombTaskDigits = "FAILED";