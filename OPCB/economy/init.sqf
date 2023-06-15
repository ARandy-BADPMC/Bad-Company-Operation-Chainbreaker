OPCB_econ_initDone = false;

#include "vehicleCargoSpaces.sqf";
#include "vehicleAttackTypes.sqf";
#include "crateCargoSizes.sqf";
#include "tierList_INF.sqf";
#include "tierList_ENG.sqf";
#include "tierList_AIR.sqf";

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

OPCB_econ_fnc_getTierCost = compileFinal preprocessFileLineNumbers "economy\fnc\OPCB_econ_fnc_getTierCost.sqf";
OPCB_econ_fnc_getVehicleTier = compileFinal preprocessFileLineNumbers "economy\fnc\OPCB_econ_fnc_getVehicleTier.sqf";

OPCB_crateSpawner_openDialog = compileFinal preprocessFileLineNumbers "economy\fnc\OPCB_crateSpawner_openDialog.sqf";
OPCB_crateSpawner_fnc_spawnCrate = compileFinal preprocessFileLineNumbers "economy\fnc\OPCB_crateSpawner_fnc_spawnCrate.sqf";

OPCB_econ_initDone = true;