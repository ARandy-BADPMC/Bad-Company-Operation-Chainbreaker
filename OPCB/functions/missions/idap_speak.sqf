params ["_civilian"];

_village = _this select 3 select 0;
_arts = _this select 3 select 1;
_done = false;
{
  if ( count (units _x) > 0) exitWith {
	_direction = [ _civilian, (units _x) select 0 ] call BIS_fnc_dirTo;
	hint format ["I think the shots are coming from %1 degrees",_direction];
	_done = true;
  };
} forEach _arts;

if (!_done) then {
  hint "The Village seems quite now.";
};

removeAllActions _civilian; 