_player = _this select 0;

/*
waitUntil {
  sleep 1;
  _istherezeus = missionNamespace getVariable["zeus_enabled",1];
  !alive _player || _istherezeus == 0
};
remoteExec ["CHAB_fnc_zeus_out_server",2];*/
_done = false;

_group = missionNamespace getVariable "Zeus_group";

{
	if (!alive (getAssignedCuratorUnit _x)) exitWith {
		_player assignCurator _x;
		_done = true;
	};
} forEach units _group;

if (!_done) then {
	_myCurObject = _group createunit ["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];
	_myCurObject addCuratorAddons activatedAddons;
	_player assignCurator _myCurObject;
};


/*
{
	if (isNull (getAssignedCuratorUnit _x) ) then {
	deleteVehicle _x;
	};
} forEach allCurators;*/