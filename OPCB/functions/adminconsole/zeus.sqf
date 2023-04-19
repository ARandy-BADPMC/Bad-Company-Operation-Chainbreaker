_zeus = ["76561198142692277","76561198117073327", "76561198048254349", "76561199005382007"]; //76561198142692277 -Alex. K.,  76561198117073327 - A.Randy, 76561198048254349 - jeyR, 76561199005382007 - W.Frost
_haszeus = false;
{
	if ((getAssignedCuratorUnit _x) == player) exitWith {
	  _haszeus = true;
	};
} forEach allCurators;

if((getPlayerUID player) in _zeus && !_haszeus) then {
	hint "Fetching Zeus for you in a second.";
	[player] remoteExec ["CHAB_fnc_zeus_server",2];
} else {
	hint "You are not allowed to use this function yet";
};