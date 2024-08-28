params ["_tierType", "_tier"];

private _cost = 0;

switch (_tierType) do {

	case "INF" : {
		
		_cost = switch (_tier) do {
		
			case 9: {30};
			case 8: {60};
			case 7: {90};
			case 6: {110};
			case 5: {130};
			case 4: {150};
			case 3: {170};
			case 2: {190};
			case 1: {210};
			case 0: {230};
			
		};
		
	};
	
	case "ENG" : {
		
		_cost = switch (_tier) do {
		
			case 9: {40};
			case 8: {70};
			case 7: {110};
			case 6: {150};
			case 5: {190};
			case 4: {240};
			case 3: {290};
			case 2: {330};
			case 1: {380};
			case 0: {420};
			
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