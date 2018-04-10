jey_enemycount =
{
	_StartEnemies = 0;

	{
		if (side _x == east || side _x == resistance) then {
			_y = _x;
		  {
		    _StartEnemies = _StartEnemies + 1;
		  } forEach units _y;
		};
	} forEach allgroups;

	_enemies = 0;

	waitUntil {
	sleep 10;_enemies = 0;
	 	{
			if (side _x == east || side _x == resistance) then {
				_y = _x;
			  {
			    _enemies = _enemies + 1;
			  } forEach units _y;
			};
		} forEach allgroups;
	
	  _enemies < (_StartEnemies / 3)
	};

	_groups = [];
	{
	  if (side _x == east || side _x == resistance) then {
	    _groups pushback _x;
	  };
	} forEach allgroups;

	{
		_units = units _x;
		for "_i" from 0 to count _units -1 do {
			_item = _units select _i;
			_item setdamage 1;
		};
	} forEach _groups;
};