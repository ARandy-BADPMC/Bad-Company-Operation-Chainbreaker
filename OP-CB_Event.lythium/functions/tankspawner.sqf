jey_spawn_tank =
{
		disableSerialization;
		createDialog "jey_tankspawner";

		waitUntil {
		  !isNull (findDisplay 9901)
		};
		_tanks = [
		"B_APC_Wheeled_01_cannon_F",
		"B_APC_Tracked_01_AA_F",
		"rhs_bmp2d_msv",
		"I_MRAP_03_hmg_F",
		"I_MRAP_03_gmg_F",
		"I_APC_tracked_03_cannon_F",
		"O_MRAP_02_F",
		"O_MRAP_02_gmg_F",
		"O_MRAP_02_hmg_F",
		"I_MBT_03_cannon_F",
		"B_MRAP_01_F",
		"B_MRAP_01_gmg_F",
		"B_MRAP_01_hmg_F",
		"B_MBT_01_arty_F",
		"rhsusf_m113d_usarmy_supply",
		"rhsusf_m113d_usarmy",
		"rhsusf_m113d_usarmy_M240",
		"rhsusf_m113d_usarmy_medical",
		"rhsusf_m113d_usarmy_MK19",
		"rhsusf_m113d_usarmy_unarmed",
		"rhsusf_m1a1aimd_usarmy",
		"rhsusf_m1a1aim_tuski_d",
		"rhsusf_m1a2sep1d_usarmy",
		"rhsusf_m1a2sep1tuskid_usarmy",
		"rhsusf_m1a2sep1tuskiid_usarmy",
		"rhsusf_m109d_usarmy",
		"rhsusf_M1220_usarmy_d",
		"rhsusf_M1220_M153_M2_usarmy_d",
		"rhsusf_M1220_M2_usarmy_d",
		"rhsusf_M1220_MK19_usarmy_d",
		"rhsusf_M1230_M2_usarmy_d",
		"rhsusf_M1230_MK19_usarmy_d",
		"rhsusf_M1232_usarmy_d",
		"rhsusf_M1232_M2_usarmy_d",
		"rhsusf_M1232_MK19_usarmy_d",
		"rhsusf_M1237_M2_usarmy_d",
		"rhsusf_M1237_MK19_usarmy_d",
		"rhsusf_M1117_D",
		"RHS_M2A2",
		"RHS_M2A2_BUSKI",
		"RHS_M2A3",
		"RHS_M2A3_BUSKI",
		"RHS_M2A3_BUSKIII",
		"RHS_M6",
		"B_MBT_01_TUSK_F",
		"B_MBT_01_cannon_F",
		"B_APC_Tracked_01_rcws_F",
		"B_APC_Tracked_01_CRV_F",
		"O_APC_Wheeled_02_rcws_F",
		"I_APC_Wheeled_03_cannon_F",
		"rhsusf_rg33_usmc_d",
		"rhsusf_rg33_m2_usmc_d"
		];

		_ctrl = (findDisplay 9901) displayCtrl 1500;

		_i = 0;
		{
			_text = getText (configFile >> "CfgVehicles" >> _x >> "displayName");
			_ctrl lbAdd _text;
			_ctrl lbSetData [_i,_x];
			_i = _i +1;
		} forEach _tanks;
		
};
jey_spawn_tank_vehicle =
{
	disableSerialization;
	_tank = (findDisplay 9901) displayCtrl 1500;
	_tankselect = lbCurSel _tank;
	if(_tankselect != -1) then  
	{	
		_vehicle = _tank lbData _tankselect;

		_nObjects= nearestObjects [[4166.478,2144.868,0], ["all"], 7];

		_maxtanks = missionNamespace getVariable ["MaxTanks",0];
		_maxAPC = missionNamespace getVariable ["MaxAPC",0];
		_attackType = ["B_MBT_01_TUSK_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F","rhsusf_m1a1aimd_usarmy","rhsusf_m1a2sep1tuskiid_usarmy","I_MBT_03_cannon_F","rhsusf_m1a1aim_tuski_d","rhsusf_m1a2sep1d_usarmy","rhsusf_m1a2sep1tuskid_usarmy","B_MBT_01_arty_F","rhsusf_m109d_usarmy","I_MBT_03_cannon_F","rhs_bmp2d_msv","O_APC_Wheeled_02_rcws_F"];

		if (count _nObjects == 1) then {

			if (_vehicle in _attackType) then 
			{
			  if (_maxtanks == 0) then
			  {
			  	_maxtanks = 1;
			  	missionNamespace setVariable ["MaxTanks",1];
			    [_vehicle,1] remoteExec ["jey_spawn_tank_server",2];

			  } else {hint "There is already a tank/SPG in game";};

			} else 
			{
			  if (_maxAPC != 5) then
			  {
			  	_maxAPC = _maxAPC + 1;
			  	missionNamespace setVariable ["MaxAPC",_maxAPC];
			    [_vehicle,0] remoteExec ["jey_spawn_tank_server",2];

			  } else{hint "5 APCs are already in game";};
			};

		  	
		} else {hint "Spawn position is not empty";};
	}
	else
	{
		hint "Select a vehicle first";
	};
};
jey_spawn_tank_server =
{
	params ["_vehicle","_isAttack"];
	if (_isAttack == 1) then 
	{
	 	
		_helicopter = _vehicle createVehicle ([4166.478,2144.868,0]);

		_helicopter addMPEventHandler ["MPKilled",{ missionNamespace setVariable ["MaxTanks",0]; }];
		
		[_helicopter] call skinapplier;
		[_helicopter] remoteExec ["jey_tank_restriction",0,true];

	} else 
	{
		_helicopter = _vehicle createVehicle ([4166.478,2144.868,0]);

		_helicopter addMPEventHandler ["MPKilled",
		{
			_current_helis = missionNamespace getVariable ["MaxAPC",1];
			_current_helis = _current_helis -1;
			missionNamespace setVariable ["MaxAPC",_current_helis];
		}];
		[_helicopter] call skinapplier;
		//[_helicopter] remoteExec ["jey_tank_restriction",0,true];
	};
		

};
jey_tank_restriction =
{
	_vehicle = _this select 0;
	
	_vehicle addEventHandler ["GetIn",{_this call checkdriver}];
	_vehicle addEventHandler ["Engine",{_this call checktankengine}];
};

jey_remover_tank =
{
	disableSerialization;
	createDialog "jey_remover_tank";

	waitUntil {
	  !isNull (findDisplay 9903)
	};
	_ctrl = (findDisplay 9903) displayCtrl 1500;
	_nearestVeh = [];
	_i = 0;
  	_nearestVeh = nearestObjects [[4166,2157.08,0], ["Car","Tank"], 50];
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
		
};
jey_deletebutton_tank =
{
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
};