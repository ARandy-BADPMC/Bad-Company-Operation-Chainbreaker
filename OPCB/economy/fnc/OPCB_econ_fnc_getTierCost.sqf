params ["_tierType", "_tier"];

if (!(_tierType in ["INF", "ENG", "AIR"])) exitWith {
	hintc "ERROR in code. Tier type must be either INF, ENG or AIR!";
	diag_log "ERROR in code. Tier type must be either INF, ENG or AIR!";
};

private _cost = 0;

switch (_tierType) do {

	case "INF" : {
		
		_cost = switch (_tier) do {
		
			case 9: {20};
			case 8: {40};
			case 7: {60};
			case 6: {80};
			case 5: {100};
			case 4: {120};
			case 3: {160};
			case 2: {180};
			case 1: {200};
			case 0: {220};
			
		};
		
	};
	
	case "ENG" : {
		
		_cost = switch (_tier) do {
		
			case 9: {30};
			case 8: {60};
			case 7: {90};
			case 6: {120};
			case 5: {150};
			case 4: {180};
			case 3: {240};
			case 2: {270};
			case 1: {300};
			case 0: {330};
			
		};
		
	};
	
	case "AIR" : {
		
		_cost = switch (_tier) do {
		
			case 9: {40};
			case 8: {80};
			case 7: {120};
			case 6: {160};
			case 5: {200};
			case 4: {240};
			case 3: {320};
			case 2: {360};
			case 1: {400};
			case 0: {440};
			
		};
		
	};

};

_cost