class CHB_EnemyLoadouts
{
	tag = "CHB_EnemyLoadouts";
	
	// Initialization functions. These should only run once on startup.
	class Init
	{
		class EnemyLoadoutsInitData
		{
			file = "enemyLoadouts\EnemyLoadoutsInitData.sqf";
			postInit = 1;
		};
	};
	// Generic functions
	class Functions 
	{
		file = "enemyLoadouts";
		
		// call CHB_EnemyLoadouts_fnc_selectLoadout;
		class selectLoadout {};
	};
};