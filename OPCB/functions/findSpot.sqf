
_howBig = _this select 0;

if (_howBig < 500) then {
	missionNamespace setVariable["task_underway",true];

	_center = missionNamespace getVariable ["World_center",[9994.91,10463.9,0]];
	_suitable = globalWaterPos;
	private ["_step","_prevStep","_spot","_heading"];
	_list = _suitable;

	while {surfaceIsWater _suitable || count _list > 0 || (_suitable select 0)<=100 || (_suitable select 1) >= 13000} do {
		_spot = [nil, ["water"],{(_this distance officer_jeff) >2000}] call BIS_fnc_randomPos;
		_suitable = [_spot, 0, 500, 20, 0, 0.7, 0,[],[globalWaterPos,globalWaterPos]] call BIS_fnc_findSafePos;
		if (count _suitable == 3) then {
			_suitable = [_suitable select 0,_suitable select 1];
		};
		_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], _howBig,false];

	};

	missionNamespace setVariable ["task_spot",_suitable];
}
else
{
	missionNamespace setVariable ["task_spot",[0,0,0]];
};
