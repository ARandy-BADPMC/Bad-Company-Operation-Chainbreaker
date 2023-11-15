_ctrl = (findDisplay 74815) displayCtrl 1500;
_select = lbCurSel _ctrl;
if (_select != -1) exitWith { 
	_crateType = _ctrl lbData _select;
	[_crateType] remoteExec ["OPCB_crateSpawner_fnc_spawnCrate_server",2];
};
hint "Select a Utility first";
