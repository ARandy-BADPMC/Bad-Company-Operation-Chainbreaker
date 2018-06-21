
	disableSerialization;
	_ctrl = (findDisplay 9999) displayCtrl 1500;
	_unit = lbCurSel _ctrl;
	if(_unit != -1) then 
	{
		_name = _ctrl lbText _unit;
		_array = _name splitString ":";
		_select = _array select 3;
		[_select] remoteExec ["CHAB_fnc_kick_server",2];
		_ctrl lbDelete _unit;
	}
	else
	{
		hint "Select a player first!";
	}
