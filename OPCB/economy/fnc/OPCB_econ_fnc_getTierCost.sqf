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
			case 4: {280};
			case 3: {300};
			case 2: {320};
			case 1: {340};
			case 0: {360};
			
		};
		
	};
	
	case "ENG" : {
		
		_cost = switch (_tier) do {
		
			case 9: {120};
			case 8: {160};
			case 7: {240};
			case 6: {320};
			case 5: {400};
			case 4: {500};
			case 3: {600};
			case 2: {680};
			case 1: {780};
			case 0: {860};
			
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