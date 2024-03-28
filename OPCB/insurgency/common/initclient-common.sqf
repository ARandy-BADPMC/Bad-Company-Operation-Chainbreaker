// \initclient-common.sqf

#include "defines.sqf"
#include "functions.sqf"
#include "client\defines.sqf"
#include "client\variables.sqf"
#include "client\AI\functions.sqf"
#include "client\misc\functions.sqf"
#include "client\markers\functions.sqf"
#include "client\markers\createMarkers.sqf"

// Move these to main init if they are still needed
onMapSingleClick "_shift";
enableSentences false;

#include "client\mainLoop.sqf"

// if world has tiered units, update them
if (keys tieredUnits find worldName > -1) then {
	remoteExecCall ["updateTier"];
}