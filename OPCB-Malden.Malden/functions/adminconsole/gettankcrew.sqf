private ["_unitname"];
	_names = [];

	{
		if(typeOf _x == "rhsusf_army_ocp_engineer") then
			{
				_unitname = name _x;
    			_names pushBack _unitname;
			};
	} forEach allUnits;

	hint format ["The current engineers : %1",_names];