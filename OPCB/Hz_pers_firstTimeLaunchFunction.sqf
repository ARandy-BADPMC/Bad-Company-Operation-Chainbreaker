#include "\x\Hz\Hz_mod_persistency\parsing_descriptors.txt"

["OPCB_econ_credits",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["CrateCount",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxTanks",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxAttackHelis",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxTransHelis",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxAPC",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["MaxBoats",SINGLE_VARIABLE,true] call Hz_pers_API_addMissionVariable;
["VehicleSpawnerHistory",2,true] call Hz_pers_API_addMissionVariable;


["Hz_pers_var_insurgencyClearedMarkers",ONE_D_ARRAY,false] call Hz_pers_API_addMissionVariable;