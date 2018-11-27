
	_centerobj = _this select 0;

	_houses = nearestObjects [_centerobj, ["house"], 500] select { count ( _x buildingPos -1 ) > 2 };
	_InfPool= ["rhs_vdv_des_at","rhs_vdv_des_junior_sergeant","rhs_vdv_des_sergeant","rhs_vdv_des_marksman","rhs_vdv_des_RShG2","rhs_vdv_des_LAT","rhs_vdv_des_grenadier","rhs_vdv_des_rifleman","rhs_vdv_des_medic","rhs_vdv_des_officer_armored","rhs_vdv_des_machinegunner_assistant","rhs_vdv_des_arifleman","rhs_vdv_des_machinegunner","rhs_vdv_des_aa","rhs_vdv_des_engineer","rhs_vdv_des_strelok_rpg_assist","rhs_vdv_des_grenadier_rpg","rhs_vdv_des_efreitor"];

	_defendergroup = creategroup east;

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



