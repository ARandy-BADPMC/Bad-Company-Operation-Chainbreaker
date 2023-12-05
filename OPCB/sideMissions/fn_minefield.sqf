params ["_flowerPot"];

private _minesType = _flowerPot getVariable "minesType";
private _minesCnt = parseNumber (_flowerPot getVariable "minesCount");
private _axisA = parseNumber (_flowerPot getVariable "axisA");
private _axisB = parseNumber (_flowerPot getVariable "axisB");
private _dir = direction _flowerPot;
private _shape = _flowerPot getVariable "shape";

private _h = 0;

private _minesToReturn = [];

if (_minesType == "UnderwaterMine") then {_h = -2};

_getPos = {};

if (_shape == "rectangle") then {
	_getPos = {
		_pos = [0,0,0];
		_coef = 1; if (random 1 >= 0.5) then {_coef = -1};
		_hpos = [_flowerPot, (random _axisB) * _coef, _dir] call BIS_fnc_relPos;
		_coef = 1; if (random 1 >= 0.5) then {_coef = -1};
		_pos = [_hpos, (random _axisA) * _coef, _dir + 90] call BIS_fnc_relPos;
		[_pos select 0, _pos select 1, _h];
	};
} else {
	_getPos = {
		_dir2 = random 360;
		_dir3 = _dir2 - _dir;
		_line1 = sqrt (((_axisA^2) * (_axisB^2)) / ((_axisB^2) + ((_axisA^2) * ((1/(tan _dir3))^2))));
		_line2 = _line1 * (1/(tan _dir3));
		_line = sqrt ((_line1^2) + (_line2)^2);
		_pos = [_flowerPot, random _line, _dir2] call BIS_fnc_relPos;
		[_pos select 0, _pos select 1, _h];
	};
};

for [{_x = 0}, {_x < _minesCnt}, {_x = _x + 1}] do
{
	_pos = call _getPos;
	if (_minesType == "UnderwaterMineAB") then {
		_pos = [_pos select 0, _pos select 1, getTerrainHeightASL _pos];
	};

	_mine = createMine [_minesType, _pos, [], 0];
	_mine setDir (random(360));
	{
		_x revealMine _mine
	} forEach [EAST, RESISTANCE];

	// _minePos = getPosWorld _mine;
	// _mkrID = format["m %1",_minePos];
	// _mkr = createMarker[_mkrID, _minePos];
	// _mkr setMarkerShape "ICON";
	// _mkr setMarkerType "mil_dot";
	// _mkr setMarkerBrush "Solid";
	// _mkr setMarkerAlpha 1;
	// _mkr setMarkerColor "ColorEast";

	_minesToReturn pushBack _mine;

};

_minesToReturn