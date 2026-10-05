params ["_vehicle", "_isAttack", ["_spawnMarker", "tank_spawner"]];
private _tankpos = markerPos _spawnMarker;

{
	if (!alive _x) then { deleteVehicle _x; };
} forEach (nearestObjects [_tankpos, ["LandVehicle"], 7]);

_tank = createVehicle [_vehicle, _tankpos, [], 0 , "CAN_COLLIDE"];
_tank setDir (markerDir _spawnMarker);

if (_isAttack ) then {
	[_tank, "Tank"] call CHAB_fnc_shopSlotTrack;
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
	[_tank, "APC"] call CHAB_fnc_shopSlotTrack;
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

	[_tank] call BADCO_fnc_skinApplier;
	
	if (_tank isKindOf "Tank") then {
			[_tank, 2, "ACE_Track", true] call ace_repair_fnc_addSpareParts;
	} else {
		if (_tank isKindOf "Car") then {
			[_tank, 2, "ACE_Wheel", true] call ace_repair_fnc_addSpareParts;
		};	
	};
	
};