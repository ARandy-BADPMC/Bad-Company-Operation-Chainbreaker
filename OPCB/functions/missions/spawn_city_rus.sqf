params ["_centerobj"];

_houses = nearestObjects [_centerobj, ["house"], 500] select { count ( _x buildingPos -1 ) > 2 };

_defendergroup = creategroup east;

_count = count _houses;
if (_count == 0) exitWith {
	[_defendergroup] call CHAB_fnc_serverGroups;
};

for "_i" from 0 to _count -1 do {
	_item = _houses select _i;
	_chance = floor (random 5);

	if(_chance == 1) then {
		_positions = _item buildingPos -1;
		if (count _positions >2) then {
			_pos = selectrandom _positions;
			_unit =	 _defendergroup createUnit [selectrandom OPCB_unitTypes_inf, _pos, [], 1, "NONE"];
			_unit disableAI "MOVE";
			_unit setunitpos "UP";
			sleep 0.3;
		};
	};
};

[_defendergroup] call CHAB_fnc_serverGroups;