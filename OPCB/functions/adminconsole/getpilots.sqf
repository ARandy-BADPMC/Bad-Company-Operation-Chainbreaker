private ["_unitname"];
	_names = [];

	{
		if(typeOf _x == "rhsusf_army_ocp_helipilot" || typeOf _x == "rhsusf_airforce_jetpilot") then
			{
				_unitname = name _x;
    			_names pushBack _unitname;
			};
	} forEach allUnits;

	hint format ["The current pilots : %1",_names];