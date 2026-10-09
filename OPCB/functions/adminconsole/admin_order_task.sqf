disableSerialization;
_ctrl = (findDisplay 9904) displayCtrl 1500;
_unit = lbCurSel _ctrl;
if(_unit != -1) then 
{
	_name = _ctrl lbText _unit;
	_type = _ctrl lbData _unit;
	
	_isPMC = _type == "PMC";
	if (_isPMC) then {
		[_name] remoteExec ['CHAB_fnc_pmc_mission_selector',2];
	} else {
		[_name] remoteExec ['CHAB_fnc_mission_selector',2];
	};
}
else
{
	hint "Select a task first!";
};
