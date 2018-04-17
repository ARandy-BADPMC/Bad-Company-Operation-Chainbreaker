disableSerialization;
	createDialog "jey_remover";

	waitUntil {
	  !isNull (findDisplay 9902)
	};
	_ctrl = (findDisplay 9902) displayCtrl 1500;
	_nearestVeh = [];
	_helipos = getPos heli_spawnpos;
	_i = 0;
  	_nearestVeh = nearestObjects [_helipos, ["Air"], 50];
  	{	
  		_asd = _x getVariable ["vehicleSerial","TIN"];
  		if (_asd == "TIN") then {
  		  _x setVariable ["vehicleSerial",str _x];
  		};
  	 	_text = getText (configFile >> "CfgVehicles" >> typeof _x >> "displayName");
		_ctrl lbAdd _text;
		_ctrl lbSetData [_i,str _x];
		_i = _i +1;
  	} forEach _nearestVeh;