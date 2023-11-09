params ["_tierType", "_className"];

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

	case "DRONE" : {
	
		{
		
			_index = _x find (toUpper _className);
			
			if (_index != -1) exitWith {
				_tier = _foreachIndex;
			};
			
		} foreach OPCB_econ_TierList_DRONE;
		
	};
	
		case "SEA" : {
	
		{
		
			_index = _x find (toUpper _className);
			
			if (_index != -1) exitWith {
				_tier = _foreachIndex;
			};
			
		} foreach OPCB_econ_TierList_SEA;
		
	};
	default { 
		hintc "ERROR in code. Tier type not recognized!";
		diag_log "ERROR in code. Tier type not recognized!";
	};

};

_tier
