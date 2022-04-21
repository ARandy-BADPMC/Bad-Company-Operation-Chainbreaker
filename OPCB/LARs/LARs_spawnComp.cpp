class LARs_spawnComp {
	tag = "LARs";
	class Compositions {
		file = "LARs\functions";
		class createComp{};
		class spawnComp{};
	};
	class Compositions_debug
	{
		file = "LARs\functions\debug";
		class drawBounds{};
	};
	class Compositions_utilities
	{
		file = "LARs\functions\Utilities";
		class deleteComp{};
		class getCompObjects{};
		class getCompItem{};
		class getItemComp{};
	};
};