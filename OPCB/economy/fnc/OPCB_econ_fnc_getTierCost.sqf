params ["_tierType", "_tier"];

private _cost = 0;

switch (_tierType) do {

	case "INF" : {
		
		_cost = switch (_tier) do {
		
			case 9: {60};
			case 8: {120};
			case 7: {180};
			case 6: {220};
			case 5: {240};
			case 4: {260};
			case 3: {280};
			case 2: {300};
			case 1: {320};
			case 0: {340};
			
		};
		
	};
	
	case "ENG" : {
		
		_cost = switch (_tier) do {
		
			case 9: {80};
			case 8: {140};
			case 7: {220};
			case 6: {300};
			case 5: {380};
			case 4: {480};
			case 3: {580};
			case 2: {660};
			case 1: {760};
			case 0: {840};
			
		};
		
	};
	
	case "AIR" : {
		
		_cost = switch (_tier) do {
		
			case 9: {60};
			case 8: {230};
			case 7: {310};
			case 6: {390};
			case 5: {490};
			case 4: {590};
			case 3: {690};
			case 2: {800};
			case 1: {1000};
			case 0: {1300};
			
		};
		
	};

	case "DRONE" : {
		
		_cost = switch (_tier) do {
		
			case 9: {5};
			case 8: {10};
			case 7: {15};
			case 6: {20};
			case 5: {20};
			case 4: {20};
			case 3: {20};
			case 2: {20};
			case 1: {20};
			case 0: {20};
			
		};
		
	};
	
	case "SEA" : {
		
		_cost = switch (_tier) do {
		
			case 9: {5};
			case 8: {15};
			case 7: {20};
			case 6: {25};
			case 5: {40};
			case 4: {200};
			case 3: {200};
			case 2: {200};
			case 1: {200};
			case 0: {200};
			
		};
		
	};
	
	case "STAT" : {
		
		_cost = switch (_tier) do {
		
			case 9: {5};
			case 8: {10};
			case 7: {15};
			case 6: {20};
			case 5: {25};
			case 4: {35};
			case 3: {45};
			case 2: {65};
			case 1: {80};
			case 0: {100};
			
		};
		
	};

	default {
		hintc "ERROR in code. Tier type not recognized!";
		diag_log "ERROR in code. Tier type not recognized!";
	};

};

_cost