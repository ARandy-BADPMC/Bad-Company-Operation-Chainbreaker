params ["_unit"];

private _randomLoadout = selectRandom CHB_EnemyLoadouts_AvailableLoadouts; 

_unit call _randomLoadout;