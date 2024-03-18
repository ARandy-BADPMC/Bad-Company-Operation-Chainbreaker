params ["_group"];

if(_group isEqualType []) then {
	EnemyGroups append _group;
}
else {
	EnemyGroups pushBack _group;
};