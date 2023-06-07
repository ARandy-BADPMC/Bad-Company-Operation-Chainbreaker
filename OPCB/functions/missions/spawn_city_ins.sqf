params ["_centerobj"];

_houses = nearestObjects [_centerobj, ["house"], 500] select { count ( _x buildingPos -1 ) > 4 };

_defendergroup = creategroup [east,true];

for "_i" from 0 to count _houses -1 do {
	_item = _houses select _i;
	_chance = floor (random 5);

	if(_chance == 1) then
	{
		_positions = _item buildingPos -1;
		if(count _positions >2) then {
			_pos = selectrandom _positions;
			_unit =	 _defendergroup createUnit [selectrandom OPCB_unitTypes_inf_ins, _pos, [], 1, "NONE"];
			_unit disableAI "PATH";
			_unit setunitpos "UP";
			sleep 0.3;
		};
	};
};

[_defendergroup] call CHAB_fnc_serverGroups;



