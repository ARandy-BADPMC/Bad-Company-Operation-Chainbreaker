_enemysum = 0;

_groups = EnemyGroups;
{
	{
		_enemysum = _enemysum +1;
	} forEach units _x;
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
