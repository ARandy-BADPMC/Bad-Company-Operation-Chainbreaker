params ["_village", "_artgroups"];

#include "..\..\data\civClasses.sqf";

_houses = nearestObjects [_village, ["house"], 400] select { count ( _x buildingPos -1 ) > 2 };

if (count _houses < 10) then {
  for "_i" from 0 to count _houses -1 do {
  	_item = _houses select _i;
  	_road = (getPos _item) nearRoads 300;
  	_closest = 0;

  	for "_j" from 0 to count _road -1 do {
  		_roadseg = _road select _j;
  		_first = _road select _closest;
  		if (_roadseg distance _item < _first distance _item) then {
  		  _closest = _j;
  		};
  	};

  	_segment = _road select _closest;
  	_group = createGroup [civilian,true];
	[_group] call CHAB_fnc_serverGroups;
  	_civilian = _group createUnit [selectRandom _civClasses, getPos _segment, [], 2, "NONE"];

  	[_group, getPos _segment, 100] call bis_fnc_taskPatrol;
	[_civilian,["<t color='#FF0000'>Do you know where the shells are coming from? </t>", "functions\missions\idap_speak.sqf", [_village,_artgroups], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
  
  };
}
else {
	for "_i" from 0 to count _houses -1 do {
		_item = _houses select _i;

		_chance = floor random 5;

		if (_chance == 2) then {
		  	_road = (getPos _item) nearRoads 300;
			_closest = 0;

		  	for "_j" from 0 to count _road -1 do {
		  		_roadseg = _road select _j;
		  		_first = _road select _closest;
		  		if (_roadseg distance _item < _first distance _item) then {
		  		  _closest = _j;
		  		};
		  	};


		  	_segment = _road select _closest;
		  	_group = createGroup [civilian,true];
		  	
			[_group] call CHAB_fnc_serverGroups;
		  	_civilian = _group createUnit [selectRandom _civClasses, getPos _segment, [], 2, "NONE"];

		  	[_group, getPos _segment, 100] call bis_fnc_taskPatrol;
			[_civilian,["<t color='#FF0000'>Do you know where the shells are coming from? </t>", "functions\missions\idap_speak.sqf", [_village,_artgroups], 1.5, true, true, "", "alive _target", 6, false, ""]] remoteexeccall ["addaction",0,true];
		};
	};
};

