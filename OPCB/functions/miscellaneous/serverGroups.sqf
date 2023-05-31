_group = _this select 0;
if(_group isEqualType []) then{
	{
		EnemyGroups pushBack _x;
	} forEach _group;
}
else{
	EnemyGroups pushBack _group;
};