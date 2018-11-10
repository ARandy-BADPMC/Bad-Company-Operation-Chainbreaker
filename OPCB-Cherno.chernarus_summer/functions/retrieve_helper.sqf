
	params["_civ","_house","_crateHouse","_theFugitive"];
	
	_civ addAction ["<t color='#FF0000'>Do you know where is the crate?</t>", {

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
	}, [_crateHouse], 1.5, true, true, "", "alive _target", 6, false, ""];




	//who stole the crate? 
	_civ addAction ["<t color='#FF0000'>Do you know who stole the crate?</t>", {

	_civ = _this select 0;
	_theFugitive = _this select 3 select 0;

	_questionedFugitive = _civ getVariable "isQuestionedFugitive";
	_isFugitive = _civ getVariable "isFugitive";

	if(_isFugitive == "yes") then
	{
		hint "YOU WON'T GET ME ALIVE";
		_enemySide = createGroup resistance;
		removeAllWeapons _civ;
		[_civ] joinSilent grpNull;
		[_civ] joinSilent _enemySide;

		_civ addVest "V_TacVest_blk_POLICE";
		_civ addWeapon "hgun_ACPC2_F";
		_civ addMagazineCargo ["9Rnd_45ACP_Mag",1];
		_civ enableAI "MOVE";
		_civ action ['SwitchWeapon', _civ, _civ, 0];
		_enemySide setCombatMode "COMBAT";
	}
	else
	{
		if (_questionedFugitive == "no") then
		{
			_civ setVariable ["isQuestionedFugitive", "yes", true];
		 	_fugitiveAnswers = ["IDK","IDC","NO","YES","IDU"];
			_fugiAnswer = _fugitiveAnswers call BIS_fnc_selectRandom;

			switch (_fugiAnswer) do 
			{ 
				case "IDK" : {  hint "I don't know what you are talking about"; }; 
				case "IDC" : {  hint "I don't care about your business, leave me alone!"; }; 
				case "NO" : { 

				_distanceFugi = _civ distance _theFugitive;
				_distanceFugi = floor _distanceFugi;
				hint format ["I have heard whispers, I think he is closer than %1 meters",_distanceFugi]; 

				}; 
				case "YES" : { 

					_distance = _civ distance _theFugitive;	
					_distance = floor _distance;
					_direction = [ _civ, _theFugitive ] call BIS_fnc_dirTo;
					_direction = floor _direction;
					hint format ["There is a guy %1 meters away to %2 degrees, now shoo little boy.",_distance,_direction];
				 }; 
				case "IDU" : {  hint "This person doesn't seem to understand you"; }; 
			};
		} else {hint "This person has already been questioned";};
		
	};

	}, [_theFugitive], 1.5, true, true, "", "alive _target", 6, false, ""];


 [_civ,["<t color='#FF0000'>Do you know who stole the crate?</t>", "functions\code.sqf", [_theFugitive], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
 [_civ,["<t color='#FF0000'>Do you know where is the crate?</t>", "functions\code2.sqf", [_crateHouse], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
