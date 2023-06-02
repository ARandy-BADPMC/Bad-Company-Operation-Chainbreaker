_number = count playableUnits;

switch (true) do { 
	case (_number > 2 && _number < 5) : {  
		1.5
	}; 
	case (_number > 4 && _number < 7) : {
		1.7
	}; 
	case (_number > 6 && _number < 9) : {
		1.9
	}; 
	case (_number > 8) : {
		2.0
	}; 
	default {  
		1
	}; 
};