/*
	Author: Karel Moricky

	Description:
	Set time of the day

	Parameter(s):
	NUMBER - hour

	Returns:
	ARRAY - date
*/

private ["_hour","_date"];
_hour = [_this,0,daytime,[0]] call bis_fnc_param;
_date = date;
_date set [3,_hour];
_date set [4,0];
[_date] call bis_fnc_setDate;
_date