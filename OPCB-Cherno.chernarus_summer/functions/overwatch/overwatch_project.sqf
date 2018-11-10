disableSerialization;
_ctrl = (findDisplay 9958) displayCtrl 1500;
_unit = lbCurSel _ctrl;
if(_unit != -1) then 
{
	_box = (findDisplay 9958) displayCtrl 2100;
	_screen = lbCurSel _box;
	if(_screen != -1) then 
	{
		_uid = _ctrl lbData _unit;
		_text = _box lbText _screen;
		[player,_uid,_text] call CHAB_fnc_overwatch_show; 
	}
	else
	{
		hint "You have to select a Screen!";
	};
}
else
{
	hint "Select a player first!";
}