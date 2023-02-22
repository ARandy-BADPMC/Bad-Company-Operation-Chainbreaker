params ["_tierType", "_className"];

if (!(_tierType in ["INF", "ENG", "AIR"])) exitWith {
	hintc "ERROR in code. Tier type must be either INF, ENG or AIR!";
	diag_log "ERROR in code. Tier type must be either INF, ENG or AIR!";
};

// return -1 if vehicle doesn't belong to any tier
private _tier = -1;

switch (_tierType) do {

	case "INF" : {
	
		{
		
			_index = _x find (toUpper _className);
			
			if (_index != -1) exitWith {
				_tier = _foreachIndex;
			};
			
		} foreach OPCB_econ_TierList_INF;
		
	};
	
	case "ENG" : {
	
		{
		
			_index = _x find (toUpper _className);
			
			if (_index != -1) exitWith {
				_tier = _foreachIndex;
			};
			
		} foreach OPCB_econ_TierList_ENG;
		
	};
	
	case "AIR" : {
	
		{
		
			_index = _x find (toUpper _className);
			
			if (_index != -1) exitWith {
				_tier = _foreachIndex;
			};
			
		} foreach OPCB_econ_TierList_AIR;
		
	};

};

_tier
