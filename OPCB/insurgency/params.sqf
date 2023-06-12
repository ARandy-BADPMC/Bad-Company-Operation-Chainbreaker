#include "unitTypes.sqf"

// number of dynamically spawned AI units per player
maxAIPerPlayer = 4;

// min number of players needed to capture a grid
playersNeeded = 2;

// max number of map patrol vehicles allowed to be active at the same time
eastVehicleNum = 5;

patrolSpawnDelay = 1200;

ins_AIspawnMaxRange = switch (toLower worldName) do {
	case "zargabad" : {700};
	case "sara" : {1000};
	case "takistan" : {1200};
	default {1000};
};

ins_AIspawnMinRange = 100;
