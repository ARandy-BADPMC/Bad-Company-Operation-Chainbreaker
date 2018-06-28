	_vehicle = _this select 0;
	_isAttack = _this select 1;

	if (typeOf _vehicle == "B_UAV_02_dynamicLoadout_f") 
	then 
	{
	_vehicle addEventHandler ["GetIn",{_this call CHAB_fnc_checkdronepilot}]
	}; 

	if(_isAttack == 1 && typeof _vehicle != "B_UAV_02_dynamicLoadout_f")
		then 
	{
		_vehicle addEventHandler ["GetIn",{_this call CHAB_fnc_checkjetpilot}];
	}
	else
	{
		if (typeof _vehicle != "B_UAV_02_dynamicLoadout_f") then 
		{
		_vehicle addEventHandler ["GetIn",{_this call CHAB_fnc_checkpilot}];
		_vehicle addEventHandler ["Engine",{_this call CHAB_fnc_checkengine}];
		};
	};
