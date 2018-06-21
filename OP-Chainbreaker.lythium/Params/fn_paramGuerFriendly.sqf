/*
	Author: Karel Moricky

	Description:
	Set relationship between Independents and remaining sides

	Parameter(s):
	NUMBER - side relation
		-1: Nobody
		0: OPFOR
		1: BLUFOR
		2: Everybody

	Returns:
	BOOL
*/

private ["_tickets","_east","_west"];
_status = [_this,0,-1,[0]] call bis_fnc_param;

_east = 0;
_west = 0;

switch _status do {
	case 0: {_east = 1;};
	case 1: {_west = 1;};
	case 2: {_east = 1; _west = 1;};
};

east setfriend [resistance,_east];
resistance setfriend [east,_east];
west setfriend [resistance,_west];
resistance setfriend [west,_west];

true