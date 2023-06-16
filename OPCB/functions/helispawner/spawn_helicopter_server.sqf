params ["_vehicle","_pylons","_isAttack"];
private "_helicopter";
_helicopter = createVehicle [_vehicle, getMarkerPos "aircraft_spawner", [], 0 , "CAN_COLLIDE"];
_helicopter setdir (markerDir "aircraft_spawner");

if (_isAttack == 1) then {	
	if (_vehicle == "B_UAV_02_dynamicLoadout_f") then {
		createVehicleCrew _helicopter;
	};
	
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
	
	[_helicopter] call BADCO_fnc_skinApplier;
	
	_pylonPaths = (configProperties [configFile >> "CfgVehicles" >> typeOf _helicopter >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
	{ _helicopter removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _helicopter;
	{ _helicopter setPylonLoadOut [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;

	_helicopter addMPEventHandler ["MPKilled",{ 
		if(isServer) then {
			MaxAttackHelis = MaxAttackHelis - 1;
			publicVariable "MaxAttackHelis";
		};
	}];

	[_helicopter,_isAttack] remoteExec ["CHAB_fnc_helicopter_restriction",0,true];
		
} else {
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
	
	[_helicopter] call BADCO_fnc_skinApplier;
	
	_helicopter addEventHandler ["MPKilled",
	{
		MaxTransHelis = MaxTransHelis - 1;
		publicVariable "MaxTransHelis";
	}];

	if (typeOf _helicopter == "RHS_UH60M_MEV_d") then {
	  _helicopter setVariable ["ace_medical_medicClass",1];
	};
	[_helicopter, _isAttack] remoteExec ["CHAB_fnc_helicopter_restriction",0,true];
	
};