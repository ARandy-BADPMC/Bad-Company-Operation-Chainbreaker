disableSerialization;
createDialog "CHAB_adminTask";

waitUntil {
	!isNull (findDisplay 9904)
};

_ctrl = (findDisplay 9904) displayCtrl 1500;

#include "..\..\data\tasks.sqf";
#include "..\..\data\pmc_tasks.sqf";

{
	_ctrl lbAdd _x;
	_ctrl lbSetData [(lbSize _ctrl) - 1, "STANDARD"];
} forEach (keys _tasks);

{
	_ctrl lbAdd _x;
	_ctrl lbSetData [(lbSize _ctrl) - 1, "PMC"];
} forEach (keys _pmcTasks);
