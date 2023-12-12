if(hasInterface && !isServer) exitWith{};

SM_TaskActive = false;
SM_TaskNumber = 0;

SM_Rewards = createHashMapFromArray [ 
	["scoutTerrain", [60, {[] spawn SM_fnc_scoutTerrain}]],
	["deliverSupplies", [60, {[] spawn SM_fnc_deliverSupplies}]],
	["clearMinefield", [60, {[] spawn SM_fnc_clearMinefield}]]
];