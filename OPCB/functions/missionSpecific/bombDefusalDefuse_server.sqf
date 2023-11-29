params ["_code"];

if(count BombTaskDigits == 0 || {BombTaskDigits == _code}) exitWith {
	BombTaskDigits = "";
};

BombTaskDigits = "FAILED";