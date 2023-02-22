disableSerialization;
	_ctrl = (findDisplay 9900) displayCtrl 1500;
	_loadouts = (findDisplay 9900) displayCtrl 1561;

    lbClear _loadouts;
	_heli = lbCurSel _ctrl;
	private ["_heli_loadouts"];
	if(_heli != -1) then 
	{
		_name = _ctrl lbData _heli;
		_index = Helicopter_loadouts find _name; 
		
		if (_index == -1) exitWith {
			_loadouts lbAdd "Default";
		};
		
		_heli_loadouts = Helicopter_loadouts select (_index +1);
		for "_i" from 0 to count _heli_loadouts -1 step 2 do {
			_loadout_name = _heli_loadouts select _i;
			_loadouts lbAdd _loadout_name;
		};

	}
	else
	{
		hint "Select a vehicle first";
	};