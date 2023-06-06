params [["_minEnemyPercentage", 33 , [0]]];

if(_minEnemyPercentage > 100) then {
	_minEnemyPercentage = 100;
};


_countUnits = {

	private _enemies = 0;
	{
		{
			_enemies = _enemies + 1;
		} forEach units _x select { alive _x && {lifeState _x != "INCAPACITATED"} };
	} forEach EnemyGroups;
	_enemies
};

hint str ["[] call (_this select 0)", _countUnits] call BIS_fnc_codePerformance;

private _enemysum = [] call _countUnits;

private _currentEnemies = _enemysum;

private _requiredSum = _enemysum * (_minEnemyPercentage * 0.01);

while {
	_currentEnemies > _requiredSum
} do {
	sleep 5;
	_currentEnemies = [] call _countUnits;
};