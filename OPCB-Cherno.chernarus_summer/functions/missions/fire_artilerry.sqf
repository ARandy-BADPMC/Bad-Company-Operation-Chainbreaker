_unitar = _this select 0;	
_village = _this select 1;
private "_close";

_unit = _unitar select 0;
_gep = vehicle _unit;

while {alive _unit} do {
	_players = allUnits select {isPlayer _x};
  	{
	  	_playerInRange = (getPosATL _x) inRangeOfArtillery [[_gep], (getArtilleryAmmo [_gep] select 0)];
		_daytime = daytime;
		if (_daytime >= 20 || _daytime <= 5) then 
		{
			if ( _playerInRange )
	       	exitWith{
		       	_markpos = (getPos _x) getPos[random 300,random 360];
		       	_gep commandArtilleryFire [_markpos,getArtilleryAmmo [_gep] select 1,1];
	       	};  
		}
		else
		{
			if ( _playerInRange )
	       	exitWith{
		       	
		       	_markpos = (getPos _x) getPos[random 100,random 360];
		       	_gep commandArtilleryFire [_markpos,getArtilleryAmmo [_gep] select 0,2];
	       	};
		}
		   
  	} forEach _players;

  	sleep random 350;
};
