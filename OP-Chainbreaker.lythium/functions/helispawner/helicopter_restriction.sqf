	_vehicle = _this select 0;
	_attackType = ["RHS_UH60M_ESSS_d","RHS_MELB_AH6M","I_Heli_light_03_dynamicLoadout_F","RHS_UH1Y_d","B_Plane_Fighter_01_F","B_Plane_CAS_01_dynamicLoadout_F","B_Heli_Attack_01_dynamicLoadout_F","RHS_AH1Z","RHS_A10","RHS_AH64D","I_Plane_Fighter_04_F","O_Heli_Light_02_dynamicLoadout_F","B_UAV_02_dynamicLoadout_f"];

	if (typeOf _vehicle == "B_UAV_02_dynamicLoadout_f") 
	then {
	_vehicle addEventHandler ["GetIn",{_this call CHAB_fnc_checkdronepilot}]
	} 
	
	else
	
	{
	if( typeOf _vehicle in _attackType)
		then {
		_vehicle addEventHandler ["GetIn",{_this call CHAB_fnc_checkjetpilot}];
	}
	else
	{
		_vehicle addEventHandler ["GetIn",{_this call CHAB_fnc_checkpilot}];
		_vehicle addEventHandler ["Engine",{_this call CHAB_fnc_checkengine}];
	};
	
	};