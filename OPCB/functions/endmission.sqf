params ["_marker"];

waitUntil 
{
	sleep 10;
  	allPlayers findIf { _x  distance _marker < 1000 } == -1 || {count allPlayers == 0}
};

{
	{
		if (vehicle _x != _x) then {
			(vehicle _x) setDamage 1;
		};
		deletevehicle _x;
	} forEach units _x;
	deleteGroup _x;
} forEach EnemyGroups;

EnemyGroups = [];