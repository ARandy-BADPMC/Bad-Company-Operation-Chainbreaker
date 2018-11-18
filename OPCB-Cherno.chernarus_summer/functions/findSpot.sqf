_howBig = _this select 0;
missionNamespace setVariable["task_underway",true];

_center = missionNamespace getVariable ["World_center",[5840,5700,0]];
_suitable = [0,0,0];
private ["_step","_prevStep","_spot","_heading"];
_list = _suitable;

while {surfaceIsWater _suitable || count _list > 0 || (_suitable select 0)<=100 || (_suitable select 1) >= 13000} do {
	_spot = [nil, ["water"],{(_this distance officer_jeff) >2000}] call BIS_fnc_randomPos;
	_suitable = [_spot, 0, 500, 20, 0, 0.7, 0] call BIS_fnc_findSafePos;
	if (count _suitable == 3) then {
	  _suitable = [_suitable select 0,_suitable select 1];
	};
	_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], _howBig,false];
};


/*
while { surfaceIsWater _suitable || count _list > 0 || (_suitable select 0)<=100} do {

	_spot = [nil, ["water"],{_this distance officer_jeff >1000}] call BIS_fnc_randomPos;
	_suitable = [_spot, 0, 500, 20, 0, 0.7, 0] call BIS_fnc_findSafePos;
	_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], _howBig,false];


	_spot = getPos officer_jeff;
	while {_spot distance officer_jeff < 1000 || surfaceIsWater _spot} do {
		_heading = (time random[0, 360])*360;
		  _prevStep = _center getPos[ (time random[0, 1500])*2000, _heading];
		  for "_i" from 0 to 2 do {
		  	_step = _prevStep getPos[ (time random[0, 1500])*2000, _heading];
		  	_prevStep = _step;
		  };
	  	//_spot = [_step select 0,_step select 1,0];
	  	_spot = _step;
	};
	_suitable = [_spot, 0, 300, 20, 0, 0.7, 0] call BIS_fnc_findSafePos;
	if (count _suitable == 3) then {
	  _suitable = [_suitable select 0,_suitable select 1];
	};
	diag_log format [">>>>>>>>>>>> %1 ",_suitable];
	_list = nearestTerrainObjects [_suitable,["TREE","BUILDING","RUIN","ROCK","HOUSE"], _howBig,false];
	//diag_log format [">>>>>>>>>>>>>>%1  %2 %3  ", _suitable,count _list, _spot];
	sleep 1;
};*/
_marker1 = createMarker ["Marker"+ str _suitable,_suitable];
_marker1 setMarkerType "hd_objective";

missionNamespace setVariable ["task_spot",_suitable];