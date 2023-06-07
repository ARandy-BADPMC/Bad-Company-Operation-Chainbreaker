params ["_unitar", "_village"];
private "_close";

_unit = _unitar select 0;
_gep = vehicle _unit;

while {alive _unit} do {
  	{
		_daytime = daytime;

		private ["_markpos", "_ammo", "_playerInRange"];

		_ammo = ((getArtilleryAmmo [_gep]) select 0);

		if (_daytime >= 20 || {_daytime <= 5}) then {
		    _markpos = (getPos _x) getPos [random 300,random 360];
	  		_playerInRange = _markpos inRangeOfArtillery [[_gep], _ammo];
		}
		else {
			_markpos = (getPos _x) getPos [random 100,random 360];
	  		_playerInRange = _markpos inRangeOfArtillery [[_gep], _ammo];
		};

		if ( _playerInRange ) exitWith {
			_gep commandArtilleryFire [_markpos, _ammo, 1];
		};  
		   
  	} forEach playableUnits;

  	sleep random 350;
};
