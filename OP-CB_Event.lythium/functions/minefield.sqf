jey_minefield = {
	_unit = _this select 0;
	_civ = ["C_man_p_beggar_F_afro","C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_fugitive_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro","C_man_shorts_4_F_afro"];
	_houses = nearestObjects [_unit, ["house"], 700] select { count ( _x buildingPos -1 ) > 2 };
	
	_mines = ["ACE_IEDUrbanSmall_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanBig_Range","ACE_IEDLandBig_Range"];
	_maxcivs = 0;
	for "_i" from 0 to count _houses -1 do {
		_item = _houses select _i;

		_chance = floor random 6;

		if (_chance == 2) then {
		  	_road = (getPos _item) nearRoads 300;
			_closest = 0;
			if (count _road > 1) then {
			  for "_j" from 0 to count _road -1 do {
			  		_roadseg = _road select _j;
			  		_first = _road select _closest;
			  		if (_roadseg distance _item < _first distance _item) then {
			  		  _closest = _j;
			  		};
			  	};
				_group = createGroup civilian;
			  	_segment = _road select _closest;
			  	if (_maxcivs < 26) then {
			  		_civilian = _group createUnit [selectRandom _civ, getPos _segment, [], 2, "NONE"];
			  	};
			  	_maxcivs = _maxcivs +1;

			  	[_group, getPos _segment, 100] call bis_fnc_taskPatrol;
			};
		};
	};

	_minetobe = ceil random 7;
	_return = [];
	for "_i" from 0 to _minetobe do {
		_item = selectRandom _houses;

		_road = (getPos _item) nearRoads 300;
		_closest = 0;
		if (count _road > 1) then {
		  for "_j" from 0 to count _road -1 do {
		  		_roadseg = _road select _j;
		  		_first = _road select _closest;
		  		if (_roadseg distance _item < _first distance _item) then {
		  		  _closest = _j;
		  		};
		  	};
		  	_segment = _road select _closest;
		  	_mine = createMine [selectRandom _mines, getPos _segment, [], 3];
		  	_return pushBack _mine;
		};
	};

	_return
	
};