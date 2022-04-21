_group = _this select 0;

with missionNamespace do
{
	if(_group isEqualType []) then{
		{
		  	enemy_groups pushBack _x;
		} forEach _group;
	}
	else{
		enemy_groups pushBack _group;
	};
	
};