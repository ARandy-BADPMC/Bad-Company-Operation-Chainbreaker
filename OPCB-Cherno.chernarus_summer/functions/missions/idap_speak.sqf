_civilian = _this select 0;

_village = _this select 3 select 0;
_arts = _this select 3 select 1;
_done = false;
{

  if (alive _x) exitWith {
	    _direction = [ _civilian, _x ] call BIS_fnc_dirTo;
	  hint format ["I think the shots are coming from %1 degrees",_direction];
	  _done = true;
  };
} forEach _arts;

if (!_done) then {
  hint "The Village seems quite now.";
};
/*
if (count _a != 0) then {
	_direction = [ _civilian, _enemy ] call BIS_fnc_dirTo;
  hint format ["I think the shots are coming from %1 degrees",_direction];
} else
{
	hint "The Village seems quite now.";
};*/

removeAllActions _civilian; 