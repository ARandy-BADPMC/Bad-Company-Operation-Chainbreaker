#include "..\..\..\tiers\tiered_lythium.sqf"
#include "..\..\..\tiers\tiered_sara.sqf"
#include "..\..\..\tiers\tiered_sara_dbe1.sqf"

clearHouses = {
    private ["_house","_cleared","_houses","_gMkr"];
	
    _gMkr  = str(player call getGridPos);				
	if (markerColor _gMkr == "ColorRed") then {	
		_houses = [getPosATL player, 8, 3, false] call findHouses;
		if (count _houses > 0) then {
			_house = _houses select 0;
			_cleared = _house getVariable "cleared";
			if (isNil "_cleared") then {
				if (nearestEastMen(getPosATL _house, 10, true, "count") == 0) then {
					_house setVariable ["cleared", true];
				};
			};
		};
	};
};

vclisFull = { 
	if (_this isKindOf "man" || _this isKindOf "building") exitWith { false };
	if (_this emptyPositions "Driver" > 0) exitWith { false }; 
	if (_this emptyPositions "Gunner" > 0)exitWith  { false }; 
	if (_this emptyPositions "Commander" > 0) exitWith { false }; 
	if (_this emptyPositions "Cargo" > 0) exitWith { false }; 
	true
};

moveInVehicle = {
    
    if (_this emptyPositions "Driver" 		> 0) exitWith { player moveInDriver _this; }; 
    if (_this emptyPositions "Gunner" 		> 0) exitWith { player moveInGunner _this; }; 
    if (_this emptyPositions "Commander" > 0) exitWith { player moveInCommander _this; }; 
    if (_this emptyPositions "Cargo" 		> 0) exitWith { player moveInCargo _this;};
		player setpos (getpos _this);
};  

updateTier = {
	_completionRatio = (count Hz_pers_var_insurgencyClearedMarkers) / ins_allMarkerCount * 100;
	_worldTiers = tieredUnits get toLower worldName;

	_infantryTiers = _worldTiers get "infantry_tiers";
	_infantryNumberTiers = count _infantryTiers;
	_insurgentsTier = ceil(_completionRatio / 100 * _infantryNumberTiers) min _infantryNumberTiers;
	if (_insurgentsTier == 0) then {
		_insurgentsTier = 1;
	};
	eastInfClasses = _infantryTiers get _insurgentsTier;

	_vehicleCrewTiers = _worldTiers get "vehicle_crew_tiers";
	_vehicleNumberTiers = count _vehicleCrewTiers;
	_insurgentsTier = ceil(completionRatio / 100 * _vehicleNumberTiers) min _vehicleNumberTiers;
	if (_insurgentsTier == 0) then {
		_insurgentsTier = 1;
	};
	vclCrewClass = _vehicleCrewTiers get _insurgentsTier;

	_staticCrewTiers = _worldTiers get "static_crew_tiers";
	_StaticCrewNumberTiers = count _staticCrewTiers;
	_insurgentsTier = ceil(_completionRatio / 100 * _StaticCrewNumberTiers) min _StaticCrewNumberTiers;
	if (_insurgentsTier == 0) then {
		_insurgentsTier = 1;
	};
	staticClass = _staticCrewTiers get _insurgentsTier;

	_vehicleTiers = _worldTiers get "vehicle_tiers";
	_vehicleNumberTiers = count _vehicleTiers;
	_insurgentsTier = ceil(_completionRatio / 100 * _vehicleNumberTiers) min _vehicleNumberTiers;
	if (_insurgentsTier == 0) then {
		_insurgentsTier = 1;
	};
	eastVclClasses = _vehicleTiers get _insurgentsTier;
};