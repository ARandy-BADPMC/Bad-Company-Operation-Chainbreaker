
disableSerialization;
createDialog "jey_remover_tank";

waitUntil {
  !isNull (findDisplay 9903)
};
_ctrl = (findDisplay 9903) displayCtrl 1500;
_nearestVeh = [];
_i = 0;
	_nearestVeh = nearestObjects [[9767.66,9978.72,0], ["LandVehicle"], 50];
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
	
