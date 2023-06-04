params ["_minEnemyPercentage"];

if(isNil "_minEnemyPercentage") then {
	_minEnemyPercentage = 33;
};

if(_minEnemyPercentage > 100) then {
	_minEnemyPercentage = 100;
};

_enemysum = 0;

{
	{
		_enemysum = _enemysum +1;
	} forEach units _x select { damage _x < 0.8 };
} forEach EnemyGroups;

_currentEnemies = _enemysum;

_requiredSum = _enemysum * (_minEnemyPercentage * 0.01);

while {
	_currentEnemies > _requiredSum
} do {
	sleep 5;
	_currentEnemies = 0;
	{
		{
			_currentEnemies = _currentEnemies +1;
		} forEach units _x select { alive _x };
	} forEach EnemyGroups;
};