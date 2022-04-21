
	private["_pos"];

	_guard = _this select 0;
	_CivClasses = ["C_man_p_beggar_F_afro","C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_fugitive_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro","C_man_shorts_4_F_afro"];
	_crateHouse = 0;
	_taskItems = [];
	_pos = 0;
	_defendergroup = createGroup [civilian,true];
	[_defendergroup] call CHAB_fnc_serverGroups;

	_houses = nearestObjects [_guard, ["house"], 400] select { count ( _x buildingPos -1 ) > 2 };
	//Make sure we have atleast one valid house
	if ( count _houses > 0 ) then {
		//Select random house
		_crateHouse = selectRandom _houses;
		//Select random house position
		_pos = selectRandom ( _crateHouse buildingPos -1 );
		//Spawn crate at house position
		_crate = createVehicle ["ACE_Box_82mm_Mo_Combo",_pos, [], 0, "CAN_COLLIDE"];
		_taskItems pushBack _crate;
	};

	_isFugitive = 0;
	_theFugitive = 0;

	for "_i" from 0 to count _houses -1 do {
		_item = _houses select _i;
		_chance = floor (random 6);
		if(_chance == 1 || _houses select (count _houses -1) == _item) then
		{
			_positions = [_item] call BIS_fnc_buildingPositions;
			_pos = selectRandom _positions;
			_unit =	 _defendergroup createUnit [selectrandom _CivClasses, _pos, [], 1, "NONE"];
			_unit disableAI "MOVE";
			_unit setunitpos "UP";

			_fugitivechance = floor random 10;
			if( (_fugitivechance == 1 || _houses select (count _houses -1) == _item) && _isFugitive == 0) then{
				_unit setVariable ["isFugitive", "yes", true];
				_unit setVariable ["isQuestionedFugitive", "no", true];
				_unit setVariable ["isQuestioned", "no", true];
				_theFugitive = _unit;
				_isFugitive = 1;
				_taskItems pushBack _unit;
				[_unit,["<t color='#FF0000'>Do you know who stole the crate?</t>", "functions\retrieve_help1.sqf", [_theFugitive], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
 				[_unit,["<t color='#FF0000'>Do you know where is the crate?</t>", "functions\retrieve_help2.sqf", [_crateHouse], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
			};

		};
	};


	for "_i" from 0 to count _houses -1 do {
		_item = _houses select _i;
		_chance = floor (random 6);
		if(_chance == 1 || _houses select (count _houses -1) == _item) then
		{
			_positions = [_item] call BIS_fnc_buildingPositions;
			_pos = selectRandom _positions;
			_unit =	 _defendergroup createUnit [selectrandom _CivClasses, _pos, [], 1, "NONE"];
			_unit disableAI "MOVE";
			_unit setunitpos "UP";

			[_unit,["<t color='#FF0000'>Do you know who stole the crate?</t>", "functions\retrieve_help1.sqf", [_theFugitive], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
			[_unit,["<t color='#FF0000'>Do you know where is the crate?</t>", "functions\retrieve_help2.sqf", [_crateHouse], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
			_unit setVariable ["isQuestioned", "no", true];
			_unit setVariable ["isQuestionedFugitive", "no", true];
			_unit setVariable ["isFugitive", "no", true];
			sleep 0.5;
		};
	};
	_taskItems
