if (isServer) then {
	
	// tier count is 0-based in code so it goes from 9 to 0! (T10 = 9, T1 = 0)
	OPCB_econ_currentTier = 9;
	publicVariable "OPCB_econ_currentTier";	
	OPCB_econ_credits = 40;
	publicVariable "OPCB_econ_credits";
	
	OPCB_econ_initDone = true;

};

call compile preprocessFileLineNumbers "economy\vehicleCargoSpaces.sqf";
call compile preprocessFileLineNumbers "economy\vehicleAttackTypes.sqf";
call compile preprocessFileLineNumbers "economy\crateCargoSizes.sqf";

if (!isDedicated) then {

	waitUntil {
		sleep 1;
		!isNil "OPCB_econ_credits"
	};
	
	call compile preprocessFileLineNumbers "economy\tierList_INF.sqf";
	call compile preprocessFileLineNumbers "economy\tierList_ENG.sqf";
	call compile preprocessFileLineNumbers "economy\tierList_AIR.sqf";
	
	OPCB_econ_vehicleTypes_INF = [];
	{
		{
			OPCB_econ_vehicleTypes_INF pushBack _x;
		} foreach _x;
	} foreach OPCB_econ_TierList_INF;
	
	OPCB_econ_vehicleTypes_ENG = [];
	{
		{
			OPCB_econ_vehicleTypes_ENG pushBack _x;
		} foreach _x;
	} foreach OPCB_econ_TierList_ENG;
	
	OPCB_econ_vehicleTypes_AIR = [];
	{
		{
			OPCB_econ_vehicleTypes_AIR pushBack _x;
		} foreach _x;
	} foreach OPCB_econ_TierList_AIR;
	
	OPCB_econ_crateTypes = [];
	{
		OPCB_econ_crateTypes pushBack (_x select 0);
	} foreach OPCB_econ_vehicleCargoSizes;
	
	OPCB_econ_fnc_getTierCost = compile preprocessFileLineNumbers "economy\fnc\OPCB_econ_fnc_getTierCost.sqf";
	OPCB_econ_fnc_getVehicleTier = compile preprocessFileLineNumbers "economy\fnc\OPCB_econ_fnc_getVehicleTier.sqf";
	
	OPCB_crateSpawner_openDialog = compile preprocessFileLineNumbers "economy\fnc\OPCB_crateSpawner_openDialog.sqf";
	OPCB_crateSpawner_fnc_spawnCrate = compile preprocessFileLineNumbers "economy\fnc\OPCB_crateSpawner_fnc_spawnCrate.sqf";
	
	OPCB_econ_initDone = true;

};