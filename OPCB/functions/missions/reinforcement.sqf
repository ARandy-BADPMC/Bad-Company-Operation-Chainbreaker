_object = _this select 0;

_classes = ["rhsgref_cdf_reg_Mi17Sh"];

_j = 100;
_numbers = ceil (random 3);

for "_i" from 0 to _numbers do {
	_groupNumber = [[_j,_j,100],random 360,selectrandom _classes,resistance] call BIS_fnc_spawnVehicle;
	_j = _j+100;

	[_groupNumber select 2, getPos _object, random 800] call bis_fnc_taskPatrol;
	[_groupNumber select 2, 0] setWaypointSpeed "FULL";

	(_groupNumber select 0) setSkill 0.9;
	[_groupNumber select 2] call CHAB_fnc_serverGroups;
};

