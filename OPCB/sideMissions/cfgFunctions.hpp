class SM
{
	tag = "SM";
	
	// Initialization functions. These should only run once on startup.
	class Init
	{
		class SMInit
		{
			file = "sideMissions\SMInit.sqf";
			postInit = 1;
		};
		class SMInitData
		{
			file = "sideMissions\initData.sqf";
			postInit = 1;
		};
	};
	// Generic functions
	class Functions 
	{
		file = "sideMissions";
		
		// call SM_fnc_randomCrate;
		class randomCrate {};
		class openCrate {};
	};
};