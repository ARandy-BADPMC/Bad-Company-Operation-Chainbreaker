BADCO_role_check = 
{
	_unit = _this select 0;
	_role = _this select 1;
	_vehicle = _this select 2;
	_unitType = typeOf _unit;
	_attack = _unit getVariable ["SOAR",0];
	_attackVehicle = count getPylonMagazines _vehicle;

	if ((typeof _vehicle ==  "NonSteerable_Parachute_F") || (typeof _vehicle == "Steerable_Parachute_F")) exitWith {}; 
	
	if (_role == "Driver") then 
	{
		if (_vehicle isKindOf "Plane") then 
		{
			if (_unitType != "rhsusf_airforce_jetpilot") then 
			{
				_vehicle engineOn false;
				moveOut _unit;
				if (true) exitWith {hint "You must be a jet pilot to fly this"};				
			};
			
		};
		if (_vehicle isKindOf "Helicopter") then 
		{		
			if (_unitType != "rhsusf_army_ocp_helipilot") then
			{
				_vehicle engineOn false;
				moveOut _unit;			
				if (true) exitWith {hint "You must be a helicopter pilot to fly this"};
			};
			if (_attackVehicle != 0 && _attack == 0) then 
			{
				_vehicle engineOn false;
				moveOut _unit;
				if (true) exitWith {hint "You must be whitelisted to fly this"};				
			};
		};
		if (_vehicle isKindOf "Tank") then 
		{
			if (_unitType != "rhsusf_army_ocp_engineer") then 
			{
				_vehicle engineOn false;
				moveOut _unit;
				if (true) exitWith {hint "You must be an engineer to drive this"};
			};			
		};
	};
};