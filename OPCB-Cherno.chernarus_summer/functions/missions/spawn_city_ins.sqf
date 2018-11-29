
	_centerobj = _this select 0;

	_houses = nearestObjects [_centerobj, ["house"], 500] select { count ( _x buildingPos -1 ) > 2 };
	_InfPool= ["rhs_g_medic_F","rhs_g_Soldier_TL_F","rhs_g_Soldier_SL_F","rhs_g_Soldier_M_F","rhs_g_Soldier_lite_F","rhs_g_Soldier_LAT_F","rhs_g_Soldier_GL_F","rhs_g_Soldier_F3","rhs_g_Soldier_F2","rhs_g_Soldier_F","rhs_g_Soldier_exp_F","rhs_g_Soldier_AT_F","rhs_g_Soldier_AR_F","rhs_g_Soldier_AAT_F","rhs_g_Soldier_AAR_F","rhs_g_Soldier_AA_F"];

	_defendergroup = creategroup [resistance,true];

	for "_i" from 0 to count _houses -1 do {
		_item = _houses select _i;
		_chance = floor (random 5);

		if(_chance == 1) then
		{
			_positions = [_item] call BIS_fnc_buildingPositions;
			if(count _positions >2)
			then
			{
				_pos = selectrandom _positions;
				_unit =	 _defendergroup createUnit [selectrandom _InfPool, _pos, [], 1, "NONE"];
				_unit disableAI "MOVE";
				_unit setunitpos "UP";
				sleep 0.3;
			};
		};
	};
	_servergroups = missionNamespace getVariable ["enemy_groups",[]];
			_servergroups pushBack _defendergroup;
			missionNamespace setVariable ["enemy_groups",_servergroups];



