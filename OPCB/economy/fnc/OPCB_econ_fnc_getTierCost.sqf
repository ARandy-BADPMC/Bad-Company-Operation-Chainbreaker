params ["_tierType", "_tier"];

private _cost = 0;

switch (_tierType) do {

	case "INF" : {
		
		_cost = switch (_tier) do {
		
			case 9: {80};
			case 8: {140};
			case 7: {200};
			case 6: {240};
			case 5: {260};
			case 4: {320};
			case 3: {360};
			case 2: {420};
			case 1: {480};
			case 0: {540};
			
		};
		
	};
	
	case "ENG" : {
		
		_cost = switch (_tier) do {
		
			case 9: {180};
			case 8: {240};
			case 7: {300};
			case 6: {380};
			case 5: {460};
			case 4: {560};
			case 3: {660};
			case 2: {740};
			case 1: {840};
			case 0: {940};
			
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
			case 7: {100};
			case 6: {30};
			case 5: {40};
			case 4: {50};
			case 3: {50};
			case 2: {50};
			case 1: {100};
			case 0: {200};
			
		};
		
	};
	
	case "SEA" : {
		
		_cost = switch (_tier) do {
		
			case 9: {5};
			case 8: {30};
			case 7: {60};
			case 6: {100};
			case 5: {140};
			case 4: {180};
			case 3: {200};
			case 2: {240};
			case 1: {260};
			case 0: {300};
			
		};
		
	};
	
	case "STAT" : {
		
		_cost = switch (_tier) do {
		
			case 9: {15};
			case 8: {20};
			case 7: {25};
			case 6: {30};
			case 5: {35};
			case 4: {45};
			case 3: {55};
			case 2: {75};
			case 1: {120};
			case 0: {500};
			
		};
		
	};

	default {
		hintc "ERROR in code. Tier type not recognized!";
		diag_log "ERROR in code. Tier type not recognized!";
	};

};

_cost