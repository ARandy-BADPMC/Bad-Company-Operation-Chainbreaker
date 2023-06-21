params ["_vehicle","_isAttack"];
_staticType = ["rhs_Metis_9k115_2_vmf","rhs_Kornet_9M133_2_vmf","RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D","B_Mortar_01_F","B_Static_Designator_01_F"];
_tankpos = getMarkerPos "tank_spawner";

_tank = createVehicle [_vehicle, _tankpos, [], 0 , "CAN_COLLIDE"];
_tank setdir (markerDir "tank_spawner");

if (_isAttack == 1) then {
	private _cargoIndex = -1;
	_vehicle = toUpper _vehicle;
	{
		if ((_x select 0) == _vehicle) exitWith {
			_cargoIndex = _foreachIndex;
		};
	} foreach OPCB_econ_vehicleCargoSpaces;
	
	if (_cargoIndex != -1) then {
		[_tank, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
	};
	
	_tank call Hz_pers_API_addVehicle;
	
	_tank addMPEventHandler ["MPKilled",{
		if(isServer) then {
			MaxTanks = MaxTanks - 1;
			publicVariable "MaxTanks";
		};
	}];
	
	[_tank] call BADCO_fnc_skinApplier;
	
	if (_tank isKindOf "Tank") then {
			[_tank, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
	} else {
		if (_tank isKindOf "Car") then {
			[_tank, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
		};	
	};
	
	[_tank] remoteExec ["CHAB_fnc_tank_restriction",0,true];

} else {
	if (_vehicle in _staticType) then {
	
		_tank addMPEventHandler ["MPKilled",
		{
			if(isServer) then {

				MaxStatic = MaxStatic - 1;
				publicVariable "MaxStatic";
			};
		}];

	} else  {
		
		private _cargoIndex = -1;
		_vehicle = toUpper _vehicle;
		{
			if ((_x select 0) == _vehicle) exitWith {
				_cargoIndex = _foreachIndex;
			};
		} foreach OPCB_econ_vehicleCargoSpaces;
		
		if (_cargoIndex != -1) then {
			[_tank, (OPCB_econ_vehicleCargoSpaces select _cargoIndex) select 1] call ace_cargo_fnc_setSize;
		};
		
		_tank call Hz_pers_API_addVehicle;

		_tank addMPEventHandler ["MPKilled",
		{
			if(isServer) then {
				MaxAPC = MaxAPC - 1;
				publicVariable "MaxAPC";
			};
		}];
		[_tank] call BADCO_fnc_skinApplier;
		
		if (_tank isKindOf "Tank") then {
				[_tank, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
		} else {
			if (_tank isKindOf "Car") then {
				[_tank, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
			};	
		};
		
	};
};