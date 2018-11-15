_unitar = _this select 0;	
	_village = _this select 1;
	//_can = canSuspend;

	//copyToClipboard str _can; 
	private "_close";

	_unit = _unitar select 0;
	_gep = vehicle _unit;

	while {alive _unit} do {
		_players = allUnits select {isPlayer _x};
	  	{
		  	_playerInRange = (getPosATL _x) inRangeOfArtillery [[_gep], (getArtilleryAmmo [_gep] select 0)];
		  	//_player = [_unit] call jey_fnc_nearest;
			_daytime = daytime;
			//copyToClipboard str _daytime;
			if (_daytime >= 20 || _daytime <= 5) then 
			{
				if ( _playerInRange )// && _player distance _unit <2000
		       	exitWith{
			       	_markpos = [getPos _x, random 500, random 359] call BIS_fnc_relPos;
			       	_gep commandArtilleryFire [_markpos,getArtilleryAmmo [_gep] select 1,1];
		       	};  
			}
			else
			{
				if ( _playerInRange )// && _player distance _unit <2000
		       	exitWith{
			       	_markpos = [getPos _x, random 500, random 359] call BIS_fnc_relPos;
			       	_gep commandArtilleryFire [_markpos,getArtilleryAmmo [_gep] select 0,2];
		       	};
			}
			   
	  	} forEach _players;

	  	sleep random 350;
	};
