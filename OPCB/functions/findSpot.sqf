params ["_radius", ["_basePos", markerPos "base_marker"], ["_maxRange", 0]];

if(_radius > 200) exitWith{};

private _taskSpot = [0,0,0];
private _list = [];
private _suitableSpots = [];
private ["_step","_prevStep","_spot","_heading", "_suitable"];

private _iter = ((ceil (worldSize/500)) - 5) max 10;
private _minDistance = 2000;

if(_maxRange == 0) then {
	_maxRange = worldSize / 2;
	_minDistance = 100;
};

for "_i" from 1 to _iter do {
    
    _suitable = [0,0,0];    
    private _infiniteCounter = 0;
    while {count _suitable == 3 || {surfaceIsWater _suitable} || {_infiniteCounter > 1000}} do {
        
        _midPos = [worldSize / 2, worldSize / 2];
        _range = random worldSize / 2;
        private _rndPos = _midPos getPos[random [_minDistance, _range, _maxRange] ,random 360];
        _suitable = [_midPos, 0, _maxRange - _range, 1, 0, 0.3, 0, ["base_marker"]] call BIS_fnc_findSafePos;
        _infiniteCounter = _infiniteCounter + 1;
    };
    if(_infiniteCounter < 1000) then {
        _suitableSpots pushBack _suitable;
    };

};
_taskSpot = selectRandom _suitableSpots;
	
_list = nearestTerrainObjects [_taskSpot,[], _radius,false];

{
	_x hideObjectGlobal true;
} forEach _list;

[_taskSpot select 0, _taskSpot select 1, 0]