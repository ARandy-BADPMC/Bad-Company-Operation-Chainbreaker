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