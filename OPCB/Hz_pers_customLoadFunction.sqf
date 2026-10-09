#include "\x\Hz\Hz_mod_persistency\parsing_descriptors.txt"

["OPCB_econ_credits",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["CrateCount",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxTanks",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxAttackHelis",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxTransHelis",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxAPC",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxBoats",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["centerOfGridRetakingStr",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["ShopVehicleCount",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["Hz_pers_var_insurgencyClearedMarkers",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;
["Hz_pers_var_boughtFobs",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;
["OPCB_civRelation",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;

private ["_cargoIndex", "_vehType", "_vehicle"];

#include "insurgency\common\server\persistencyCustomLoadFunction.sqf"

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
			_vehicle addMPEventHandler ["MPKilled",{ 
				if(isServer) then {
					MaxAttackHelis = MaxAttackHelis - 1;
					publicVariable "MaxAttackHelis";
				};
			}];
				
		} else {
			_vehicle addMPEventHandler ["MPKilled",
			{
				if(isServer) then {
					MaxTransHelis = MaxTransHelis - 1;
					publicVariable "MaxTransHelis";
				};
			}];

			if (_vehType == "RHS_UH60M_MEV_D") then {
				_vehicle setVariable ["ace_medical_medicClass",1];
			};
			
		};
		
		[_vehicle, _isAttack] remoteExec ["CHAB_fnc_helicopter_restriction",0,true];
	
	} else {
		
		_isAttack = _vehType in OPCB_econ_vehicleGroundAttackTypes;
		_shopSlot = _vehicle getVariable ["OPCB_shopSlot", ""];
		if (_shopSlot in ["Tank", "APC", "Vehicle"]) then {
			[_vehicle, _shopSlot] call CHAB_fnc_shopSlotTrack;
		};
		
		if (_isAttack) then {
			if !(_shopSlot == "Tank") then {
				_vehicle addMPEventHandler ["MPKilled",{
					if(isServer) then {
						MaxTanks = MaxTanks - 1;
						publicVariable "MaxTanks";
					};
				}];
			};
		
			[_vehicle] remoteExec ["CHAB_fnc_tank_restriction",0,true];
		
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

call CHAB_fnc_civRelationsUpdatePressure;
