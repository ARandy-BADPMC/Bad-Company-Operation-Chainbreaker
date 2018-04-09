_civilian = _this select 0;

_village = _this select 3 select 0;

_arti = allUnits select { side _x == resistance};

_enemy = _arti select 0;

if (count _arti != 0) then {
	_direction = [ _civilian, _enemy ] call BIS_fnc_dirTo;
  hint format ["I think the shots are coming from %1 degrees",_direction];
} else
{
	hint "The Village seems quite now.";
};

removeAllActions _civilian; 