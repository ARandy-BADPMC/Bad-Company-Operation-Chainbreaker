
	disableSerialization;
	createDialog "jey_adminconsole_dialog";

	waitUntil {
	  !isNull (findDisplay 9999)
	};

	_ctrl = (findDisplay 9999) displayCtrl 1500;

	{
		_id = getPlayerUID _x;
		_row = format ["name: %1 : Id: %2",(name _x),_id];
		_ctrl lbAdd _row;
	} forEach allPlayers;
	
