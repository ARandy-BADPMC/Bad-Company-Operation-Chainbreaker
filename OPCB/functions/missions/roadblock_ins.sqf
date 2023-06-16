params ["_centerPosition"];
if!(_centerPosition isEqualType []) then {
	_centerPosition = getPos _centerPosition;
};

private ["_block","_relpos","_spawnComp","_road","_connectedroads","_connection","_direction","_roadblock","_group","_taskisrunning"];

_roadblocks = 4;
_insurgent = ["roadblock_ins","roadblock_ins2"];
_posHelp = [90,180,270,359];
_spawnComp = [];

for "_i" from 0 to _roadblocks - 1 do 
{
	_block = selectRandom _insurgent;
	_relpos = _centerPosition getPos[random 800,_posHelp select _i ];
	_road = [ _relpos,800] call BIS_fnc_nearestRoad;
	if (!(isNull _road)) then {
	 	_connectedroads = roadsConnectedTo _road;
	 	if (!(isNil {_connectedroads select 0})) then {
		 	_connection = _connectedroads select 0;
			_direction = [_road, _connection] call BIS_fnc_DirTo;

			_roadblock = [_block,getpos _road, [0,0,0], _direction, true, true ] call LARs_fnc_spawnComp;
			_spawnComp pushBack _roadblock;

			_group = [getpos _road, east,selectRandom OPCB_InfantryGroups_Insurgents] call BIS_fnc_spawnGroup;
			[_group,150] call CHAB_fnc_shk_patrol;
			[_group] call CHAB_fnc_serverGroups;
			sleep 1;
	 	};
	};
};
_spawnComp