params ["_player"];

_zeusActive = false;

{
	if (!alive (getAssignedCuratorUnit _x)) exitWith {
		_player assignCurator _x;
		_zeusActive = true;
	};
} forEach units ZeusGroup;

if (!_zeusActive) then {
	_myCurObject = ZeusGroup createunit ["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];
	_myCurObject addCuratorAddons activatedAddons;
	_player assignCurator _myCurObject;
};