#include "../../../tieredUnits.sqf"

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
	completionRatio = (count Hz_pers_var_insurgencyClearedMarkers) / ins_allMarkerCount * 100;
	worldTiers = tieredUnits get toLower worldName;

	infantryTiers = worldTiers get "infantry_tiers";
	infantryNumberTiers = count infantryTiers;
	insurgentsTier = ceil(completionRatio / 100 * infantryNumberTiers);
	if (insurgentsTier == 0) then {
		insurgentsTier = 1;
	};
	eastInfClasses = infantryTiers get insurgentsTier;

	vehicleCrewTiers = worldTiers get "vehicle_crew_tiers";
	vehicleNumberTiers = count vehicleCrewTiers;
	insurgentsTier = ceil(completionRatio / 100 * vehicleNumberTiers);
	if (insurgentsTier == 0) then {
		insurgentsTier = 1;
	};
	vclCrewClass = vehicleCrewTiers get insurgentsTier;

	staticCrewTiers = worldTiers get "static_crew_tiers";
	StaticCrewNumberTiers = count staticCrewTiers;
	insurgentsTier = ceil(completionRatio / 100 * StaticCrewNumberTiers);
	if (insurgentsTier == 0) then {
		insurgentsTier = 1;
	};
	staticClass = staticCrewTiers get insurgentsTier;

	vehicleTiers = worldTiers get "vehicle_tiers";
	vehicleNumberTiers = count vehicleTiers;
	insurgentsTier = ceil(completionRatio / 100 * vehicleNumberTiers);
	if (insurgentsTier == 0) then {
		insurgentsTier = 1;
	};
	eastVclClasses = vehicleTiers get insurgentsTier;
};