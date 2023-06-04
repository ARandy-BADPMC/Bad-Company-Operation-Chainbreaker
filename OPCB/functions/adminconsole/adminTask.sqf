disableSerialization;
createDialog "CHAB_adminTask";

waitUntil {
	!isNull (findDisplay 9904)
};

_ctrl = (findDisplay 9904) displayCtrl 1500;

#include "..\..\data\tasks.sqf";

{
	_ctrl lbAdd (_x select 0);
} forEach _tasks;