private _planes = ["C_Plane_Civil_01_F"];
while {true} do {
	if(count allPlayers > 0) then {
		[west, "HQ"] sideChat "Ambient FlyBy started!";
		private _playerPos = getPosATL (selectRandom allPlayers);

		[[0,0],_playerPos getPos [5000, ([0,0] getDir _playerPos)], 50, "NORMAL", selectRandom _planes, west] call BIS_fnc_ambientFlyby;

	};
	sleep random [600, 1200, 1800];
};