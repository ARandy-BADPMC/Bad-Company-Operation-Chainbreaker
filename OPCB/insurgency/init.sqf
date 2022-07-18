#include "params.sqf"
#include "defines.sqf"

if (isServer) then {

	execVM "insurgency\init-server.sqf";
	
};

if (!isDedicated) then {

	execVM "insurgency\init-client.sqf";

}; 