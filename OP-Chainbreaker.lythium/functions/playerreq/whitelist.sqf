_player = _this select 0;
_soldier = _player;
_playerid = getPlayerUID _player;
if(_playerid in SOAR) then {

	hint "Welcome to the Whitelist Club!";
	heli_jeff addAction ["<t color='#FF0000'>Aircraft Spawner</t>","[] spawn CHAB_fnc_spawn_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
	heli_jeff addAction ["<t color='#FF0000'>I want my Aircraft removed!</t>","[] spawn CHAB_fnc_remover_heli;",nil, 1, false, true, "", "true", 10, false,""];   //HELISPAWNER
} 
else 
{
	["epicFail",false,2] call BIS_fnc_endMission;		
};	