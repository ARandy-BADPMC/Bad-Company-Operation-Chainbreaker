_ember = _this select 3 select 0;

	[_ember] joinSilent grpNull;
	_nearestplayer = [_ember] call CHAB_fnc_nearest;
	[_ember] join (group _nearestplayer);