params ["_veh"];

_veh setVariable ["CHB_CanDespawn", false, false];

[_veh] spawn {
	params ["_veh"];
	waitUntil {
		sleep 60;
		if(isNull _veh) exitWith {
			true
		};
		_var = _veh getVariable "CHB_CanDespawn";
		isNil '_var' || {_var} || {!IsATaskRunning}
	};

	waitUntil {
		sleep 60;
		playableUnits findIf { _x  distance2D _veh < 1500 } == -1
	};

	deleteVehicle _veh;
};


//check if vehicle is destroyed
_veh addEventHandler ["Killed",{
	params ["_unit"];
	_unit setVariable ["CHB_CanDespawn", true, false];
}];


//check when no more crewmembers are alive
{
	_x addEventHandler ["Killed",{
		params ["_killed"];
		if (({alive _x && {lifeState _x != "INCAPACITATED"} } count units _killed) isEqualTo 0) then {
			_killed setVariable ["CHB_CanDespawn", true, false];
		};
	}];
} forEach crew _veh;

//check if vehicle is still mobile
_veh addEventHandler ["Engine",{
	params ["_veh", "_engineState"];
	if (!_engineState && {alive _veh} && {!canMove _veh}) then {
		_veh setVariable ["CHB_CanDespawn", true, false];
	};
}];

//check if vehicle has been abandoned
_veh addEventHandler ["GetOut",{
	params ["_veh"];
	[_veh] spawn {
		params ["_veh"];
		sleep 5;
		if (!isNull _veh && {(count crew _veh) == 0}) then {
			_veh setVariable ["CHB_CanDespawn", true, false];
		};
	};

}];