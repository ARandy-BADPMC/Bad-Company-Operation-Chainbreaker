disableSerialization;
	createDialog "CHAB_adminTask";

	waitUntil {
	  !isNull (findDisplay 9904)
	};

	_ctrl = (findDisplay 9904) displayCtrl 1500;
	_tasks = [
	"Eliminate",
	"Technology",
	"Destroy",
	"Annihilate and Destroy",
	"Secure",
	"Capture",
	"Exterminate",
	"Neutralize",
	"Neutralize2",
	"Attack",
	"Clear out",
	"Resupply",
	"IDAP",
	"Retrieve",
	"Minefield"
	];
	{
		_ctrl lbAdd _x;
	} forEach _tasks;