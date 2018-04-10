_player = _this select 0;

disableSerialization;
createDialog "overwatch";

waitUntil {
  !isNull (findDisplay 9958)
};

_ctrl = (findDisplay 9958) displayCtrl 2100;

_screens = ["Screen 1","Screen 2","Screen 3","Screen 4","Screen 5","Screen 6"];
{
	_ctrl lbAdd _x;
} forEach _screens;

_list = (findDisplay 9958) displayCtrl 1500;
_i = 0;
{
	_list lbAdd (name _x);
	_list lbSetData [_i,getPlayerUID _x];
	_i = _i +1;
} forEach allPlayers;

[_player] remoteExec ["CHAB_fnc_overwatch_watch",2,false];