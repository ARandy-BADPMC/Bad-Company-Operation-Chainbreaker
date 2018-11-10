disableSerialization;
_ctrl = (findDisplay 9903) displayCtrl 1500;

_veh = lbCurSel _ctrl;
if(_veh != -1) then 
{
	_vehicle = _ctrl lbData _veh;
	{
	  _asd = _x getVariable ["vehicleSerial","TIN"];
	  if (_asd == _vehicle) then {
	    	_x setPos [0,0,0];
			_x setDamage 1;
	  };
	} forEach vehicles;
_ctrl lbDelete _veh;
	
}
else
{
	hint "Select a vehicle first";
};