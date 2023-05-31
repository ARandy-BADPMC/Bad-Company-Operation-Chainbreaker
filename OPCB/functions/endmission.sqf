params ["_marker"];
_isClose = 1;
private _players = [];

waitUntil 
{
	sleep 10;
	_players = [];
	{
		if ( (isplayer _x) && (_x distance _marker ) < 800) then {
		_isClose = _isClose + 1;
		_players pushback _x;
		} else {
			_isClose = _isClose -1;
		}
	} forEach playableUnits;
  	_isClose <= 0 || count _players == 0
};

{
	{
		if (vehicle _x != _x) then {
			(vehicle _x) setDamage 1;
		};
		deletevehicle _x;
	} forEach units _x;
	deleteGroup _x;
} forEach EnemyGroups;

EnemyGroups = [];
