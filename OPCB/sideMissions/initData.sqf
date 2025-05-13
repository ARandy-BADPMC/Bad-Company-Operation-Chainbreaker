if(hasInterface && !isServer) exitWith{};

SM_TaskActive = false;
SM_TaskNumber = 0;

SM_Rewards = createHashMapFromArray [ 
	["scoutTerrain", [60, {[] spawn SM_fnc_scoutTerrain}]],
	["deliverSupplies", [60, {[] spawn SM_fnc_deliverSupplies}]],
	["clearMinefield", [60, {[] spawn SM_fnc_clearMinefield}]],
	["GPSJam", [80, {[] spawn SM_fnc_GPSJam}]],
	["deadload", [60, {[] spawn SM_fnc_deadload}]],
	["RecovertheWhispers", [80, {[] spawn SM_fnc_RecovertheWhispers}]],
	["Pitfall", [80, {[] spawn SM_fnc_Pitfall}]]

];