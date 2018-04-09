/*
	Author: Karel Moricky

	Description:
	Set side mission time

	Parameter(s):
	NUMBER - time (in seconds)

	Returns:
	BOOL
*/

private ["_countdown"];
_countdown = [_this,0,-1,[0]] call bis_fnc_param;
if (_countdown >= 0) then {
	_countdown spawn {
		waituntil {time > 0};
		estimatedtimeleft _this;
	};
};
true