#include "unitTypes.sqf"

// number of dynamically spawned AI units per player
maxAIPerPlayer = 4;

// min number of players needed to capture a grid
playersNeeded = 2;

// number of map patrol vehicles that will spawn
eastVehicleNum = 5;

aiVehicleRespawnTime = 1800;

ins_AIspawnMaxRange = switch (toLower worldName) do {
	case "zargabad" : {700};
	case "sara" : {1000};
	case "takistan" : {1200};
	default {1000};
};

ins_AIspawnMinRange = 100;
