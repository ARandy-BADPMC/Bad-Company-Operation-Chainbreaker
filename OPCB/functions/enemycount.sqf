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
		private _group = _x;
		{
			private _unit = _x;
			if (alive _unit) then {
				_enemies = _enemies +1;
			};
		} forEach units _x;
	} forEach _groups;
};
