disableSerialization;
	_ctrl = (findDisplay 9904) displayCtrl 1500;
	_unit = lbCurSel _ctrl;
	if(_unit != -1) then 
	{
		_name = _ctrl lbText _unit;
		//copyToClipboard str [_name];
		[_name] remoteExec ['CHAB_fnc_mission_selector',2];
	}
	else
	{
		hint "Select a task first!";
	}