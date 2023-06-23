private _hasZeus = (allCurators findIf { getAssignedCuratorUnit _x == player}) != -1;

if(!_hasZeus) then {
	hint "Fetching Zeus for you in a second.";
	[player] remoteExec ["CHAB_fnc_zeus_server",2];
} else {
	hint "You are not allowed to use this function yet.";
};