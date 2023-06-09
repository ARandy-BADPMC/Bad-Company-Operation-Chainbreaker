RHSDecalsOff = true;
call compileFinal preprocessFileLineNumbers "economy\init.sqf";
[] execVM "insurgency\init.sqf";
["Initialize"] call BIS_fnc_dynamicGroups;