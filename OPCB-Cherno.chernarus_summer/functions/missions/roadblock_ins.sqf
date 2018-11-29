
	private ["_guard","_block","_relpos","_spawnComp","_road","_connectedroads","_connection","_direction","_roadblock","_group","_taskisrunning"];
	_guard = _this select 0;

		_roadblocks = 4;
		_insurgent = ["roadblock_ins","roadblock_ins2"];
		_posHelp = [90,180,270,359];
		_groups = ["IRG_InfSquad","IRG_InfSquad_Weapons","IRG_InfTeam_AT","IRG_SniperTeam_M","IRG_InfSentry","IRG_InfTeam_MG"];
		_spawnComp = [];

		for "_i" from 0 to _roadblocks - 1 do 
		{
			_block = selectRandom _insurgent;
			_relpos = (getPos _guard) getPos[random 800,_posHelp select _i ];
			_road = [ _relpos,800] call BIS_fnc_nearestRoad;
			if (!isNull _road) then {
			 	_connectedroads = roadsConnectedTo _road;
				_connection = _connectedroads select 0;
				_direction = [_road, _connection] call BIS_fnc_DirTo;

				_roadblock = [_block,getpos _road, [0,0,0], _direction, true, true ] call LARs_fnc_spawnComp;
				_spawnComp pushBack _roadblock;

				_group = [getpos _road, resistance,(configfile >> "CfgGroups" >> "Indep" >> "rhs_faction_insurgents" >> "Infantry" >> selectRandom _groups)] call BIS_fnc_spawnGroup;
				[_group,150] call CHAB_fnc_shk_patrol;
				_servergroups = missionNamespace getVariable ["enemy_groups",[]];
				_servergroups pushBack _group;
				missionNamespace setVariable ["enemy_groups",_servergroups];
				sleep 1;
			};
		};
	_spawnComp
