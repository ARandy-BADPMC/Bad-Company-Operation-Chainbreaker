/*
	Author: Karel Moricky

	Description:
	Set overcast

	Parameter(s):
	NUMBER - overcast

	Returns:
	NUMBER - overcast
*/

private ["_overcast"];
_overcast = [_this,0,overcast,[0]] call bis_fnc_param;
[_overcast * 0.01] call bis_fnc_setOvercast;
_overcast