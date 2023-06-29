#include "..\..\data\developers.sqf";

private _hasZeus = (allCurators findIf { getAssignedCuratorUnit _x == player}) != -1;

if(!_hasZeus) then {
	hint "Fetching Zeus for you in a second.";

	player addMPEventHandler ["Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		{
			_playerUid = _x getVariable ["ZeusUser"];
			if(!isNil "_playerUid" && getPlayerUID player == _playerUid) exitWith {
				player assignCurator _zeus;
			};
		} forEach allCurators;
	}];
	[player] remoteExecCall ["CHAB_fnc_zeus_server",2];
} else {
	hint "You are not allowed to use this function yet.";
};