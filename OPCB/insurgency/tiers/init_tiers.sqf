// init vars
tieredUnits = createHashMap;
currentInfTier = 1;
currentVCrewTier = 1;
currentSCrewTier = 1;
currentVehTier = 1;

// get hashmap for current world
call compile preprocessFileLineNumbers ("insurgency\tiers\tiered_" +(toLower worldName)+".sqf");
