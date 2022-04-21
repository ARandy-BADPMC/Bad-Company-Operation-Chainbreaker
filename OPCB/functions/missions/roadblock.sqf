private ["_guard","_block","_relpos","_road","_connectedroads","_connection","_direction","_roadblock","_group"];
_guard = _this select 0;

_roadblocks = 4;
_insurgent = ["roadblock_rus","roadblock_rus2"];
_posHelp = [90,180,270,359];
_groups = ["rhs_group_rus_vdv_des_infantry_chq","rhs_group_rus_vdv_des_infantry_fireteam","rhs_group_rus_vdv_des_infantry_MANEUVER","rhs_group_rus_vdv_des_infantry_section_AA","rhs_group_rus_vdv_des_infantry_section_AT","rhs_group_rus_vdv_des_infantry_section_marksman","rhs_group_rus_vdv_des_infantry_section_mg","rhs_group_rus_vdv_des_infantry_squad","rhs_group_rus_vdv_des_infantry_squad_2mg","rhs_group_rus_vdv_des_infantry_squad_mg_sniper","rhs_group_rus_vdv_des_infantry_squad_sniper"];
_spawnComp = [];

for "_i" from 0 to _roadblocks - 1 do 
{
	_block = selectRandom _insurgent;
	_relpos = (getPos _guard) getPos[random 800,_posHelp select _i ];
	_road = [ _relpos,800] call BIS_fnc_nearestRoad;
	if (!(isNull _road)) then {
		_connectedroads = roadsConnectedTo _road;
		if (!(isNil {_connectedroads select 0})) then {
			_connection = _connectedroads select 0;
			_direction = [_road, _connection] call BIS_fnc_DirTo;

			_roadblock = [_block,getpos _road, [0,0,0], _direction, true, true ] call LARs_fnc_spawnComp;
			_spawnComp pushBack _roadblock;

			_group = [getpos _road, east,(configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry" >> selectRandom _groups)] call BIS_fnc_spawnGroup;
			[_group,150] call CHAB_fnc_shk_patrol;
			[_group] call CHAB_fnc_serverGroups;
			sleep 1;
		};
	};
};
_spawnComp