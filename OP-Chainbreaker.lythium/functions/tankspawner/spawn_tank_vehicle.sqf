
disableSerialization;
_tank = (findDisplay 9901) displayCtrl 1500;
_tankselect = lbCurSel _tank;
if(_tankselect != -1) then  
{	
	_vehicle = _tank lbData _tankselect;

	_nObjects= nearestObjects [[12026.2,18120.9,0.0807495], ["all"], 7];

	_maxtanks = missionNamespace getVariable ["MaxTanks",0];
	_maxAPC = missionNamespace getVariable ["MaxAPC",0];
	_attackType = ["B_MBT_01_TUSK_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F","rhsusf_m1a1aimd_usarmy","rhsusf_m1a2sep1tuskiid_usarmy","I_MBT_03_cannon_F","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","B_MBT_01_arty_F","rhsusf_m109d_usarmy","I_MBT_03_cannon_F","rhs_bmp2d_msv","O_APC_Wheeled_02_rcws_F","B_AFV_Wheeled_01_up_cannon_F","B_AFV_Wheeled_01_cannon_F","I_LT_01_AA_F","I_LT_01_cannon_F","I_LT_01_scout_F"];

	if (count _nObjects == 0) then {

		if (_vehicle in _attackType) then 
		{
		  if (_maxtanks == 0) then
		  {
		  	_maxtanks = 1;
		  	missionNamespace setVariable ["MaxTanks",1];
		    [_vehicle,1] remoteExec ["CHAB_fnc_spawn_tank_server",2];

		  } else {hint "There is already a tank/SPG in game";};

		} else 
		{
		  if (_maxAPC != 5) then
		  {
		  	_maxAPC = _maxAPC + 1;
		  	missionNamespace setVariable ["MaxAPC",_maxAPC];
		    [_vehicle,0] remoteExec ["CHAB_fnc_spawn_tank_server",2];

		  } else{hint "5 APCs are already in game";};
		};

	  	
	} else {hint "Spawn position is not empty";};
}
else
{
	hint "Select a vehicle first";
};
