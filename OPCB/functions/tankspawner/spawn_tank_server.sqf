params ["_vehicle","_isAttack"];
_staticType = ["rhs_Metis_9k115_2_vmf","rhs_Kornet_9M133_2_vmf","RHS_Stinger_AA_pod_D","RHS_M2StaticMG_D","RHS_M2StaticMG_MiniTripod_D","RHS_TOW_TriPod_D","RHS_MK19_TriPod_D","B_Mortar_01_F","B_Static_Designator_01_F"];
_tankpos = markerPos "tank_spawner";

if (_isAttack == 1) then 
{
 	
	_helicopter = _vehicle createVehicle (_tankpos);
	_helicopter setdir 40;
	
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
		if (local (_this select 0)) then {
			_maxtanks = missionNamespace getVariable ["MaxTanks",0];
			missionNamespace setVariable ["MaxTanks",_maxtanks -1,true];
		};
	}];
	
	[_helicopter] call skinapplier;
	
	if (_helicopter isKindOf "Tank") then {
			[_helicopter, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
	} else {
		if (_helicopter isKindOf "Car") then {
			[_helicopter, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
		};	
	};
	
	[_helicopter] remoteExec ["CHAB_fnc_tank_restriction",0,true];

} else {if (_vehicle in _staticType) then 
	
	{
	_helicopter = _vehicle createVehicle (_tankpos);
	_helicopter setdir 40;
	
	_helicopter addMPEventHandler ["MPKilled",
	{
		if (local (_this select 0)) then {
			_current_helis = missionNamespace getVariable ["MaxStatic",1];
			_current_helis = _current_helis -1;
			missionNamespace setVariable ["MaxStatic",_current_helis,true];
		};
	}];

} else  
{
	_helicopter = _vehicle createVehicle (_tankpos);	
	_helicopter setdir 40;
	
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
		if (local (_this select 0)) then {
			_current_helis = missionNamespace getVariable ["MaxAPC",1];
			_current_helis = _current_helis -1;
			missionNamespace setVariable ["MaxAPC",_current_helis,true];
		};
	}];
	[_helicopter] call skinapplier;
	
	if (_helicopter isKindOf "Tank") then {
			[_helicopter, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
	} else {
		if (_helicopter isKindOf "Car") then {
			[_helicopter, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
		};	
	};
	
};
};