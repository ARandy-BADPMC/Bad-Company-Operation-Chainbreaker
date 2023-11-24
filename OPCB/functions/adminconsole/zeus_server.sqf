params ["_player"];

private _zeusGroup = createGroup sideLogic;

_zeusGroup deleteGroupWhenEmpty true;

private _zeus = _zeusGroup createunit ["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];
_zeus addCuratorAddons activatedAddons;
_player assignCurator _zeus;
_zeus setVariable ["ZeusUser",getPlayerUID _player,true ];