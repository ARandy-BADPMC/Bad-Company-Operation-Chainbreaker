_object = _this select 0;
private ["_guard","_block","_relpos","_road","_connectedroads","_connection","_direction","_roadblock","_group"];
_roads = (getPos _object nearRoads 200);

_posHelp = [90,180,270,359];
_spawnComp = [];
for "_i" from 0 to 3 do 
{
	_block = "Single_DSHKM_Bunker";
	_relpos = (getPos _object) getPos[random 200,_posHelp select _i ];
	_road = [ _relpos,200] call BIS_fnc_nearestRoad;
	if (!(isNull _road)) then {
		_connectedroads = roadsConnectedTo _road;
		if (!(isNil {_connectedroads select 0})) then {
			_connection = _connectedroads select 0;
			_direction = [_road, _connection] call BIS_fnc_DirTo;

			_roadblock = [_block,getpos _road, [0,0,0], _direction, true, true ] call LARs_fnc_spawnComp;
			_spawnComp pushBack _roadblock;
		};
	};
};
_spawnComp