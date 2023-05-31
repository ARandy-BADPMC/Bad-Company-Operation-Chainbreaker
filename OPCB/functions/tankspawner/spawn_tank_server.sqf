params ["_vehicle","_isAttack"];
_staticType = ["rhs_Metis_9k115_2_vmf","rhs_Kornet_9M133_2_vmf","RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D","B_Mortar_01_F","B_Static_Designator_01_F"];

if (_isAttack == 1) then {
 	
	_helicopter = _vehicle createVehicle ([9767.66,9978.72,0]);
	_helicopter setdir 0;
	
	private _cargoIndex = -1;
	_vehicle = toUpper _vehicle;
	{
		if ((_x select 0) == _vehicle) exitWith {
			_cargoIndex = _foreachIndex;
		};
	} foreach OPCB_econ_vehicleCargoSpaces;
	
	if (_cargoIndex != -1) then {
		[_helicopter, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
	};
	
	_helicopter call Hz_pers_API_addVehicle;
	
	_helicopter addMPEventHandler ["MPKilled",{
		if (isServer) then {
			MaxTanks = MaxTanks - 1;
			publicVariable "MaxTanks";
		};
	}];
	
	[_helicopter] call BADCO_fnc_skinApplier;
	
	if (_helicopter isKindOf "Tank") then {
			[_helicopter, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
	} else {
		if (_helicopter isKindOf "Car") then {
			[_helicopter, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
		};	
	};
	
	[_helicopter] remoteExec ["CHAB_fnc_tank_restriction",0,true];

} else {
	if (_vehicle in _staticType) then {
	_helicopter = _vehicle createVehicle ([9767.66,9978.72,0]);
	_helicopter setdir 0;
	
	_helicopter addMPEventHandler ["MPKilled",
	{
		if (isServer) then {
			MaxStatic = MaxStatic - 1;
			publicVariable "MaxStatic";
		};
	}];

	} else  {
		_helicopter = _vehicle createVehicle ([9767.66,9978.72,0]);	
		_helicopter setdir 0;
		
		private _cargoIndex = -1;
		_vehicle = toUpper _vehicle;
		{
			if ((_x select 0) == _vehicle) exitWith {
				_cargoIndex = _foreachIndex;
			};
		} foreach OPCB_econ_vehicleCargoSpaces;
		
		if (_cargoIndex != -1) then {
			[_helicopter, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
		};
		
		_helicopter call Hz_pers_API_addVehicle;

		_helicopter addMPEventHandler ["MPKilled",
		{
			if (isServer) then {
				MaxAPC = MaxAPC - 1;
				publicVariable "MaxAPC";
			};
		}];
		[_helicopter] call BADCO_fnc_skinApplier;
		
		if (_helicopter isKindOf "Tank") then {
				[_helicopter, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
		} else {
			if (_helicopter isKindOf "Car") then {
				[_helicopter, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
			};	
		};
		
	};
};