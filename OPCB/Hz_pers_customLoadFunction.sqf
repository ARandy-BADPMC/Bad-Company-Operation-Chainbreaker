private ["_mkrVar", "_cargoIndex", "_vehType", "_vehicle"];

{
	_mkrVar = format["%1cleared", _x];	
	missionNamespace setVariable [_mkrVar, true];
	publicVariable _mkrVar;
} foreach Hz_pers_var_insurgencyClearedMarkers;

// calculate current tier
OPCB_econ_currentTier = (ceil (10 - ((1 min ((count Hz_pers_var_insurgencyClearedMarkers) / ins_halfMarkerCount))*10))) - 1;
publicVariable "OPCB_econ_currentTier";

// vehicle inits
{
	
	_vehType = toUpper _x;
	_vehicle = Hz_pers_network_vehicles select _foreachIndex;
	
	// ACE cargo size
	_cargoIndex = -1;
	{
		if ((_x select 0) == _vehType) exitWith {
			_cargoIndex = _foreachIndex;
		};
	} foreach OPCB_econ_vehicleCargoSpaces;
	
	if (_cargoIndex != -1) then {
		[_vehicle, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
	};
	
	[_vehicle] call BADCO_fnc_skinApplier;
	
	// vehicle restrictions and other misc. stuff
	if (_vehType isKindOf "Air") then {
	
		if (_vehType == "B_UAV_02_DYNAMICLOADOUT_F") then {
			createVehicleCrew _vehicle;
		};
	
		_isAttack = _vehType in OPCB_econ_vehicleAirAttackTypes;
		
		if (_isAttack) then {
			MaxAttackHelis = MaxAttackHelis + 1;
			publicVariable "MaxAttackHelis";

			_vehicle addEventHandler ["Killed",{ 
				MaxAttackHelis = MaxAttackHelis - 1;
				publicVariable "MaxAttackHelis";
			}];
				
		} else {
			MaxTransHelis = MaxTransHelis + 1;
			publicVariable "MaxTransHelis";

			_vehicle addEventHandler ["Killed",
			{
				MaxTransHelis = MaxTransHelis - 1;
				publicVariable "MaxTransHelis";
			}];

			if (_vehType == "RHS_UH60M_MEV_D") then {
				_vehicle setVariable ["ace_medical_medicClass",1];
			};
			
		};
		
		[_vehicle, _isAttack] remoteExec ["CHAB_fnc_helicopter_restriction",0,true];
	
	} else {
		
		_isAttack = _vehType in OPCB_econ_vehicleGroundAttackTypes;
		
		if (_isAttack) then {
			MaxTanks = MaxTanks + 1;
			publicVariable "MaxTanks";
			
			_vehicle addEventHandler ["Killed",{
				MaxTanks = MaxTanks - 1;
				publicVariable "MaxTanks";
			}];
		
		[_vehicle] remoteExec ["CHAB_fnc_tank_restriction",0,true];
		
		} else {
		
			MaxAPC = MaxAPC + 1;
			publicVariable "MaxAPC";
		
			_vehicle addEventHandler ["Killed",{
				MaxAPC = MaxAPC - 1;
				publicVariable "MaxAPC";
			}];
		
		};
		
	};	
	
} foreach Hz_pers_saveVar_vehicles_type;

// crate inits
{

	_crateType = toUpper _x;
	_crate = Hz_pers_network_crates select _foreachIndex;
	
	_cargoRequirement = 0;
	{
		if ((_x select 0) == _crateType) exitWith {
			_cargoRequirement = _x select 1;
		};
	} foreach OPCB_econ_vehicleCargoSizes;
	
	[_crate, _cargoRequirement] call ace_cargo_fnc_setSize;
	
} foreach Hz_pers_saveVar_crates_type;