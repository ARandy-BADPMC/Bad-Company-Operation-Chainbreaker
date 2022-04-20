
_marker = _this select 0;
_isClose = 1;
_players = [];

waitUntil 
{
	sleep 10;
	_players = [];
	{
	  if( (isplayer _x) && (_x distance _marker ) < 800)
	  	then
	  	{
	  	_isClose = _isClose +1;
	  	_players pushback _x;
	 	} else {_isClose = _isClose -1}
	} forEach playableUnits;
  _isClose <= 0 || count _players == 0
};

/*_groups = missionNamespace getVariable ["enemy_groups",[]];
{
	{
		if (vehicle _x != _x) then {
			(vehicle _x) setDamage 1;
		};
	  deletevehicle _x;
	} forEach units _x;
	deleteGroup _x;
} forEach _groups;*/

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
