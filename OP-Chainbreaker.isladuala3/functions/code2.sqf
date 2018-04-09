_civ = _this select 0;
	_crateHouse = _this select 3 select 0;

	_questioned = _civ getVariable "isQuestioned";
	if(_questioned == "no")
	then
	{
		_civ setVariable ["isQuestioned", "yes", true];
		_answers = ["IDK","IDC","YES","MAYBE","IDU"];
		_answer = _answers call BIS_fnc_selectRandom;
		switch (_answer) do { 
			case "IDK" : 
			{  
				_directions = "North";
				_direction = [ _civ, _crateHouse ] call BIS_fnc_dirTo;
				_direction = floor _direction;
				if (_direction >= 315 || _direction <= 45) then {
				  _directions = "North";
				};
				if (_direction >= 46 && _direction <= 135)  then {
				  _directions = "East";
				};
				if (_direction >= 136 && _direction <= 210)   then {
				  _directions = "South";
				};
				if (_direction >= 211 && _direction <= 314)    then {
				  _directions = "West";
				};
				hint format ["I don't know anything about it. Maybe go and check %1",_directions];
			}; 
			case "IDC" : {  hint "I don't care about your business, leave me alone!"; }; 
			case "YES" : { 
							_distance = _civ distance _crateHouse;
							_distance = floor _distance;
							_direction = [ _civ, _crateHouse ] call BIS_fnc_dirTo;
							_direction = floor _direction;
			 hint format ["Yes. My neighbour told me about it yesterday, it's only %1 meters straight %2 degrees.",_distance,_direction];

			}; 
			case "MAYBE" : {  hint "I am *hickup* too drunk to talk *hickup*"; }; 
			case "IDU" : {  hint "This person doesn't seem to understand you" }; 
		};
	} 
	else
	{
		hint "This person has already been questioned";
	};