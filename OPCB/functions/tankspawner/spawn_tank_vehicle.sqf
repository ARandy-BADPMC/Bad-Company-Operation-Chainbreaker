
disableSerialization;
_tank = (findDisplay 9901) displayCtrl 1500;
_tankselect = lbCurSel _tank;
if(_tankselect != -1) then  
{	
	_vehicle = _tank lbData _tankselect;

	_nObjects= nearestObjects [[9767.66,9978.72,0], ["all"], 7];

	//remoteExec ["CHAB_fnc_setServerVariables",2];
	_maxtanks = missionNamespace getVariable ["MaxTanks",1];
	_maxAPC = missionNamespace getVariable ["MaxAPC",1];
	_maxStatics = missionNamespace getVariable ["MaxStatic",1];
	_attackType = ["B_MBT_01_TUSK_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F","rhsusf_m1a1aimd_usarmy","rhsusf_m1a2sep1tuskiid_usarmy","I_MBT_03_cannon_F","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","B_MBT_01_arty_F","rhsusf_m109d_usarmy","I_MBT_03_cannon_F","rhs_bmp2d_msv","O_APC_Wheeled_02_rcws_F","B_AFV_Wheeled_01_up_cannon_F","B_AFV_Wheeled_01_cannon_F","I_LT_01_AA_F","I_LT_01_cannon_F","I_LT_01_scout_F","rhs_t72bb_tv","rhsusf_M142_usarmy_D","Burnes_FV4034_02","Burnes_FV4034_01","O_T_APC_Tracked_02_cannon_ghex_F"];
	_staticType = ["rhs_Metis_9k115_2_vmf","rhs_Kornet_9M133_2_vmf","RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D","B_Mortar_01_F","B_Static_Designator_01_F"];
	
	if (count _nObjects == 0) then {

		if (_vehicle in _attackType) then 
		{
		  if (_maxtanks == 0) then
		  {
		  	missionNamespace setVariable ["MaxTanks",_maxtanks +1,true];
		    [_vehicle,1] remoteExec ["CHAB_fnc_spawn_tank_server",2];

		  } else {hint "There is already a tank/SPG in game";};

		} else 
		{
		
		if (_vehicle in _staticType) then 
		
		{
		  if (_maxStatics != 5) then 
		  {
			_maxStatics = _maxStatics + 1;
			missionNamespace setVariable ["MaxStatic",_maxStatics,true];
			[_vehicle,0] remoteExec ["CHAB_fnc_spawn_tank_server",2]; 
			
		  } else {hint "5 statics are already in game";};
		} else
		{		
		  if (_maxAPC != 5) then
		  {
		  	_maxAPC = _maxAPC + 1;
		  	missionNamespace setVariable ["MaxAPC",_maxAPC,true];
		    [_vehicle,0] remoteExec ["CHAB_fnc_spawn_tank_server",2];

		  } else{hint "5 APCs are already in game";};
		};
		};
	  	
	} else {hint "Spawn position is not empty";};
}
else
{
	hint "Select a vehicle first";
};
