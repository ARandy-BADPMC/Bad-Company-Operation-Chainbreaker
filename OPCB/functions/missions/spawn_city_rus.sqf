
	_centerobj = _this select 0;

	_houses = nearestObjects [_centerobj, ["house"], 500] select { count ( _x buildingPos -1 ) > 2 };

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
				_unit =	 _defendergroup createUnit [selectrandom OPCB_unitTypes_inf, _pos, [], 1, "NONE"];
				_unit disableAI "MOVE";
				_unit setunitpos "UP";
				sleep 0.3;
			};
		};
	};
	
	[_defendergroup] call CHAB_fnc_serverGroups;



