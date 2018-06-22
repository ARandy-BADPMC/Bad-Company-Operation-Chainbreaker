
params ["_vehicle","_isAttack"];
if (_isAttack == 1) then 
{
 	
	_helicopter = _vehicle createVehicle ([12026.2,18120.9,0.0807495]);
	_helicopter setdir 312.769;
	
	_helicopter addMPEventHandler ["MPKilled",{ missionNamespace setVariable ["MaxTanks",0]; }];
	
	[_helicopter] call skinapplier;
	[_helicopter] remoteExec ["CHAB_fnc_tank_restriction",0,true];

} else 
{
	_helicopter = _vehicle createVehicle ([12026.2,18120.9,0.0807495]);
	_helicopter setdir 312.769;

	
	_helicopter addMPEventHandler ["MPKilled",
	{
		_current_helis = missionNamespace getVariable ["MaxAPC",1];
		_current_helis = _current_helis -1;
		missionNamespace setVariable ["MaxAPC",_current_helis];
	}];
	[_helicopter] call skinapplier;
};