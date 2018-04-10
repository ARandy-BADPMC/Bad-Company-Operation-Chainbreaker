jey_roadblock_ins = 
{
	private ["_guard","_block","_relpos","_road","_connectedroads","_connection","_direction","_roadblock","_group"];
	_guard = _this select 0;

	if (side _guard == resistance) then
	{
		_roadblocks = 4;
		_insurgent = ["roadblock_ins","roadblock_ins2"];
		_posHelp = [90,180,270,359];
		_groups = ["IRG_InfSquad","IRG_InfSquad_Weapons","IRG_InfTeam_AT","IRG_SniperTeam_M","IRG_InfSentry","IRG_InfTeam_MG"];
		_spawnComp = [];

		for "_i" from 0 to _roadblocks - 1 do 
		{
			_block = selectRandom _insurgent;
			_relpos = [_guard, 800, _posHelp select _i] call BIS_fnc_relPos;
			_road = [ _relpos,5000] call BIS_fnc_nearestRoad;
			_connectedroads = roadsConnectedTo _road;
			_connection = _connectedroads select 0;
			_direction = [_road, _connection] call BIS_fnc_DirTo;

			_roadblock = [_block,getpos _road, [0,0,0], _direction, true, true ] call LARs_fnc_spawnComp;
			_spawnComp pushBack _roadblock;

			_group = [getpos _road, resistance,(configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "Infantry" >> selectRandom _groups)] call BIS_fnc_spawnGroup;
			[_group,150] execVM "functions\shk_patrol.sqf";
			sleep 2;

		};

		waitUntil {
			sleep 10;
			_taskisrunning = missionNamespace getVariable ["running_task",1];
			_taskisrunning == 0
		};

		{
		  [ _x ] call LARs_fnc_deleteComp;
		} forEach _spawnComp;

	};
};