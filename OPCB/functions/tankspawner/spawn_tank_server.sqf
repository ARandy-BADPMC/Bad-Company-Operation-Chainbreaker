params ["_vehicle","_isAttack"];
_staticType = ["rhs_Metis_9k115_2_vmf","rhs_Kornet_9M133_2_vmf","RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D","B_Mortar_01_F","B_Static_Designator_01_F"];

if (_isAttack == 1) then 
{
 	
	_helicopter = _vehicle createVehicle ([9767.66,9978.72,0]);
	_helicopter setdir 0;
	
	_helicopter addMPEventHandler ["MPKilled",{ 
		_maxtanks = missionNamespace getVariable ["MaxTanks",0];
		missionNamespace setVariable ["MaxTanks",_maxtanks -1,true];
	}];
	
	[_helicopter] call skinapplier;
	[_helicopter] remoteExec ["CHAB_fnc_tank_restriction",0,true];

} else {if (_vehicle in _staticType) then 
	
	{
	_helicopter = _vehicle createVehicle ([9767.66,9978.72,0]);
	_helicopter setdir 0;
	
	_helicopter addMPEventHandler ["MPKilled",
	{
		_current_helis = missionNamespace getVariable ["MaxStatic",1];
		_current_helis = _current_helis -1;
		missionNamespace setVariable ["MaxStatic",_current_helis,true];
	}];

} else  
{
	_helicopter = _vehicle createVehicle ([9767.66,9978.72,0]);
	_helicopter setdir 0;

	_helicopter addMPEventHandler ["MPKilled",
	{
		_current_helis = missionNamespace getVariable ["MaxAPC",1];
		_current_helis = _current_helis -1;
		missionNamespace setVariable ["MaxAPC",_current_helis,true];
	}];
	[_helicopter] call skinapplier;
};
};