//global params

AI_skill_general = 0.6;
AI_skill_aimingAccuracy = 0.15;
AI_skill_aimingShake = 0.15;
AI_skill_aimingSpeed = 0.65;
AI_skill_reloadSpeed = 0.3;
AI_skill_commanding = 1;
AI_skill_courage = 1;
AI_skill_spotDistance = 1;
AI_skill_spotTime = 1;


AI_setSkill = {

	if (local _this) then {

		_this setskill AI_skill_general;
		_this setskill ["aimingAccuracy",AI_skill_aimingAccuracy];
		_this setskill ["aimingShake",AI_skill_aimingShake];
		_this setskill ["aimingSpeed",AI_skill_aimingSpeed];
		_this setskill ["reloadSpeed",AI_skill_reloadSpeed];
		_this setskill ["commanding",AI_skill_commanding];
		_this setskill ["courage",AI_skill_courage];
		_this setskill ["spotDistance",AI_skill_spotDistance];
		_this setskill ["spotTime",AI_skill_spotTime];
	
	};

};