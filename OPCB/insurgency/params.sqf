#include "unitTypes.sqf"

// number of dynamically spawned AI units per player
maxAIPerPlayer = 2.5;

// min number of players needed to capture a grid
playersNeeded = 2;

// max number of map patrol vehicles allowed to be active at the same time
eastVehicleNum = 6;

patrolSpawnDelay = 1200;

ins_AIspawnMaxRange = switch (toLower worldName) do {
	case "zargabad" : {700};
	case "sara"	: {1000};
	case "takistan" : {1200};
	case "lythium"	: {1000};
	default {1000};
};

ins_AIspawnMinRange = 250;
