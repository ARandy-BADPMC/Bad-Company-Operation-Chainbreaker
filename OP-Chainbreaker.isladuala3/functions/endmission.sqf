jey_endmission = {

_marker = _this select 0;
_isClose = 1;
_players = [];

waitUntil 
{
	sleep 10;
	_players = [];
	{
	  if( (isplayer _x) && (_x distance _marker ) < 600)
	  	then
	  	{
	  	_isClose = _isClose +1;
	  	_players pushback _x;
	 	} else {_isClose = _isClose -1}
	} forEach playableUnits;
  _isClose <= 0 || count _players == 0
};

{
if(_x isKindOf "Car" || _x isKindOf "Air" || _x isKindOf "Tank") then {_x setDamage 1;} else{deleteVehicle _x;};


} forEach nearestObjects [_marker, ["all"], 250];

_groups = allgroups;
{
  if(side _x == east || side _x == resistance || side _x == civilian) then
  	{
  		_delgroup = _x;
  		{
  		  deletevehicle _x;
  		} forEach units _delgroup;
  	};
} forEach _groups;

{
	if (count (units _x) == 0) then {
		deleteGroup _x;
	};
} foreach allGroups;

};