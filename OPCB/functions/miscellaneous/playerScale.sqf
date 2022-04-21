_number = 0;

{
  _number = _number+1;
} forEach allPlayers;
_rate = 1;

switch (true) do { 
	case (_number > 2 && _number < 5) : {  _rate = 1.5 }; 
	case (_number > 4 && _number < 7) : {  _rate = 1.7 }; 
	case (_number > 6 && _number < 9) : {  _rate = 1.9 }; 
	case (_number > 8) : {  _rate = 2.0 }; 
	default {  _rate = 1; }; 
};

_rate