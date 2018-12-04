
	/*_StartEnemies = 0;

	{
		if (side _x == east || side _x == resistance) then {
			_y = _x;
		  {
		    _StartEnemies = _StartEnemies + 1;
		  } forEach units _y;
		};
	} forEach allgroups;*/
	_enemysum = 0;

	_groups = missionNamespace getVariable ["enemy_groups",[]];
	{
		{
		  _enemysum = _enemysum +1;
		} forEach units _x;
		//deleteGroup _x;
	} forEach _groups;


	_enemies = 9999;
	while {
		_enemies > (_enemysum / 3)
		
	} do {
		sleep 10;
		_enemies = 0;
		{
			{
			  _enemies = _enemies +1;
			} forEach units _x;
		} forEach _groups;
	};
	/*waitUntil {
	sleep 10;_enemies = 0;
	 	{
			if (side _x == east || side _x == resistance) then {
				_y = _x;
			  {
			    _enemies = _enemies + 1;
			  } forEach units _y;
			};
		} forEach allgroups;
	
	  
	};*/

	/*_groups = [];
	{
	  if (side _x == east || side _x == resistance) then {
	    _groups pushback _x;
	  };
	} forEach allgroups;*/

	with missionNamespace do
	{
		{
			{
				if (vehicle _x != _x) then {
					(vehicle _x) setDamage 1;
				};
			  deletevehicle _x;
			} forEach units _x;
			deleteGroup _x;
		} forEach enemy_groups;
		enemy_groups = [];
	};
	//missionNamespace setVariable ["enemy_groups",[]];
